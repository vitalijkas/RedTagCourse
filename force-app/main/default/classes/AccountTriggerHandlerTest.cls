@isTest

private class AccountTriggerHandlerTest{

    private static final Integer ACCOUNT_NUMBER = 5;
    @TestSetup
    static void cteateAccounts(){
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0;i<ACCOUNT_NUMBER;i++){
            testAccounts.add(new Account(Name='OkAccount'+i));
        }
        insert testAccounts;
    }

    @isTest static void testCreateOpportunity(){
        Test.StartTest();
            List<Account> accounts = [SELECT Id, Name FROM Account];
            System.assertEquals(ACCOUNT_NUMBER, accounts.size());
            List<Opportunity> opps = [SELECT Id, Name, StageName, CloseDate, Account.Name FROM Opportunity];
            System.debug(opps.size());
            System.assertEquals(ACCOUNT_NUMBER, opps.size());
            for(Opportunity op: opps){
                System.assertEquals(op.Name, op.Account.Name + Date.today().month() + Date.today().year());
                System.assertEquals(op.StageName, 'Prospecting');
                System.assertEquals(op.CloseDate, Date.today()+90);
            }
        Test.StopTest();
    }

    @isTest static void testUpdateOpportunity(){
        Account account = [SELECT Id, Name FROM Account LIMIT 1];
        account.Name = 'OkAccountUpdated0';

        Test.StartTest();
        update account;
        Test.StopTest();

        List<Opportunity> opps = [SELECT Id, Name, AccountId FROM Opportunity WHERE Account.Id =:account.Id];

        for(Opportunity op: opps){
            System.assertEquals(op.Name.contains(account.Name), true, 'Opportunity name should contain Account name');
        }

    }

    @isTest static void testDeleteOpportunity(){
        Account account = [SELECT Id, Name FROM Account LIMIT 1];
        List<Opportunity> op = [SELECT Id, Name, Account.Name, Account.Owner.Name, Account.Owner.Email FROM Opportunity WHERE AccountId =:account.Id];
        System.assertEquals(op.size(), 1);

        Test.StartTest();
            delete account;
        Test.StopTest();

        System.assertEquals(0, [SELECT count() FROM Opportunity WHERE AccountId =:account.Id], 'Oppotrnutity should be deleted');
        System.assertEquals(1, Limits.getEmailInvocations(), 'Email should be sent');
    }
}