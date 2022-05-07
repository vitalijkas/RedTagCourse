@isTest
public class TestDataFactory {
    public static void createAccounts(Integer numOfAccounts){
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0;i<numOfAccounts;i++){
            testAccounts.add(new Account(
                Name='OkAccount'+i,
                Account_level__c='Neutral'
            ));
        }
        insert testAccounts;
    }
}
