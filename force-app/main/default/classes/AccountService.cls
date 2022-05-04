public with sharing class AccountService {
    
    public static void createOpportunities(List<Account> newAccs){
        List<Opportunity> opList = new List<Opportunity>();
        for(Account acc: newAccs){
            Opportunity op = new Opportunity(
                AccountId = acc.Id,
                Name = acc.Name + Date.today().month() + Date.today().year(),
                StageName = 'Prospecting',
                CloseDate = Date.today() + 90
            );
            opList.add(op);
        }
        insert opList;
    }
    public static void updateOpportunities(List<Account> newAccs, Map<Id, Account> mapOldAccs){
        Map<Id, String> mapUpdatedNamesById = new Map<Id, String>();
        for(Account acc: newAccs){
            if(acc.Name != mapOldAccs.get(acc.Id).Name){
                    mapUpdatedNamesById.put(acc.Id, acc.Name);
            }
        }
        List<Opportunity> opps = [SELECT Id, Name, AccountId, CreatedDate FROM Opportunity WHERE AccountId IN:mapUpdatedNamesById.keySet()];
        for(Opportunity op: opps){
            op.Name = mapUpdatedNamesById.get(op.AccountId) + op.CreatedDate.month() + op.CreatedDate.year();
        }
        update opps;
    }
    public static void deleteOpportunities(Map<Id, Account> mapOldAccs){
        List<Opportunity> oppToDelete = [SELECT Id, Name, AccountId, Account.Owner.Name, Account.Owner.Email FROM Opportunity WHERE AccountId IN:mapOldAccs.keySet()];
        Map<Id, User> mapOwners = new Map<Id, User>();
        Map<Id, List<Opportunity>> mapOpByAccount = new Map<Id, List<Opportunity>>();
        for(Opportunity op: oppToDelete){
            if(!mapOpByAccount.containsKey(op.AccountId)){
                mapOpByAccount.put(op.AccountId, new List<Opportunity>());
            }
            mapOpByAccount.get(op.AccountId).add(op);

            if(!mapOwners.containsKey(op.AccountId)){
                mapOwners.put(op.AccountId, op.Account.Owner);
            }
        }
        EmailTemplate emailTemplate = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'Send_Deleted_Opps_on_Account_delete'];
        List<Messaging.SingleEmailMessage> listEmails = new List<Messaging.SingleEmailMessage>();
        for(Id accountId: mapOpByAccount.keySet()){
            Integer counter = 0;
            String stringOps = '';
            String[] toAddresses = new String[] {mapOwners.get(accountId).Email}; 
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String plainBody = emailTemplate.Body;
            for(Opportunity op: mapOpByAccount.get(accountId)){
                counter += 1;
                stringOps += String.valueOf(counter) + '. ' + op.Id + ', ' + op.Name + '\n';
            }
            plainBody = plainBody.replace('{UserName}', mapOwners.get(accountId).Name);
            plainBody = plainBody.replace('{AccountName}', mapOldAccs.get(accountId).Name);
            plainBody = plainBody.replace('{oppList}', stringOps);
            email.setToAddresses(toAddresses);
            email.setSubject(emailTemplate.Subject);
            email.setPlainTextBody(plainBody);
            listEmails.add(email);
        }
        Messaging.sendEmail(listEmails);
        delete oppToDelete;
    }
}