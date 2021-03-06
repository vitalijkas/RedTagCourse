public with sharing class AccountService {
    
    public static void createOpportunities(List<Account> newAccountList){
        List<Opportunity> listOpportunities = new List<Opportunity>();
        for(Account acc: newAccountList){
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.Id;
            opp.Name = String.format('{0}{1}', new List<Object> {acc.Name, Datetime.now().format('yyyyMM')});
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today().addDays(90);
            listOpportunities.add(opp);
        }
        insert listOpportunities;
    }

    public static void updateOpportunities(List<Account> newAccountList, Map<Id, Account> mapOldAccounts){
        Map<Id, String> mapUpdatedNamesById = new Map<Id, String>();
        for(Account acc: newAccountList){
            if(acc.Name != mapOldAccounts.get(acc.Id).Name){
                    mapUpdatedNamesById.put(acc.Id, acc.Name);
            }
        }
        List<Opportunity> listOpportunities = [
                SELECT Id, Name, AccountId, CreatedDate 
                FROM Opportunity 
                WHERE 
                AccountId IN:mapUpdatedNamesById.keySet()
            ];

        for(Opportunity opp: listOpportunities){
            opp.Name = String.format(
                '{0}{1}{2}', 
                new List<Object> {mapUpdatedNamesById.get(opp.AccountId), opp.CreatedDate.month(), opp.CreatedDate.year()}
            );
        }
        update listOpportunities;
    }
    
    public static void deleteOpportunities(List<Account> listOldAccounts){
        List<Opportunity> oppToDelete = [
            SELECT Id, Name, AccountId, Account.Owner.Name, Account.Owner.Email 
            FROM Opportunity 
            WHERE AccountId IN:listOldAccounts
        ];
        Map<Id, User> mapOwners = new Map<Id, User>();
        Map<Id, List<String>> mapOppsToSendByAccount = new Map<Id, List<String>>();

        for(Opportunity op: oppToDelete){
            if(!mapOwners.containsKey(op.AccountId)){
                mapOwners.put(op.AccountId, op.Account.Owner);
            }

            if(!mapOppsToSendByAccount.containsKey(op.AccountId)){
                mapOppsToSendByAccount.put(op.AccountId, new List<String>());
            }
            mapOppsToSendByAccount.get(op.AccountId).add(
                String.format(
                    '{0}. {1}, {2}',  
                    new List<Object> {mapOppsToSendByAccount.get(op.AccountId).size() + 1, op.Id, op.Name}
                )
            );
        }

        EmailTemplate emailTemplate = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'Send_Deleted_Opps_on_Account_delete'];
        List<Messaging.SingleEmailMessage> listEmails = new List<Messaging.SingleEmailMessage>();
        for(Account acc: listOldAccounts){
            String[] toAddresses = new String[] {mapOwners.get(acc.Id).Email}; 
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String plainBody = emailTemplate.Body;
            plainBody = plainBody.replace('{UserName}', mapOwners.get(acc.Id).Name);
            plainBody = plainBody.replace('{AccountName}', acc.Name);
            plainBody = plainBody.replace('{opportunityList}', String.join(mapOppsToSendByAccount.get(acc.Id), '\n'));
            email.setToAddresses(toAddresses);
            email.setSubject(emailTemplate.Subject);
            email.setPlainTextBody(plainBody);
            listEmails.add(email);
        }

        Messaging.sendEmail(listEmails);
        delete oppToDelete;
    }
}