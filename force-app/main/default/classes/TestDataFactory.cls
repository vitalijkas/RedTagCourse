@isTest
public class TestDataFactory {
    @TestVisible private static Integer DEFAULT_SALES_ITEMS_CAPACITY = 3;
    public static List<Account> createAccounts(Integer numOfAccounts, Boolean doInsert){
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0;i<numOfAccounts;i++){
            testAccounts.add(new Account(
                Name='OkAccount'+i,
                Account_level__c='Neutral'
            ));
        }
        if(doInsert){
            insert testAccounts;
        }
        return testAccounts;
    }
    public static List<Opportunity> createOpportunities(Integer numOfOpportunities, Boolean doInsert){
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for(Integer i=0; i<numOfOpportunities; i++){
            testOpportunities.add(new Opportunity(
                Name='OkOpportunity'+i,
                StageName='Prospecting',
                CloseDate=Date.today(),
                Sales_Items_Capacity__c=DEFAULT_SALES_ITEMS_CAPACITY
            ));
        }
        if(doInsert){
            insert testOpportunities;
        }
        return testOpportunities;
    }
    public static List<Sales__c> createSales(Integer numOfSales, Id salesOwnerId, Boolean doInsert){
        List<Sales__c> testSales = new List<Sales__c>();
        for(Integer i=0; i<numOfSales; i++){
            testSales.add(new Sales__c(
                Name='OkSales'+i,
                Opportunity__c=salesOwnerId
            ));
        }
        if(doInsert){
            insert testSales;
        }
        return testSales;
    }
}
