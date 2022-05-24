@isTest
public class TestDataFactory {

    @TestVisible private static Integer DEFAULT_SALES_ITEMS_CAPACITY = 3;
    
    public static List<Account> createAccounts(Integer numOfAccounts){
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0;i<numOfAccounts;i++){
            testAccounts.add(new Account(
                Name='OkAccount'+i,
                Account_level__c='Neutral'
            ));
        }
        return testAccounts;
    }
}
