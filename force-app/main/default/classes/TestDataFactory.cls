@isTest
public class TestDataFactory {
    @TestVisible private static Integer DEFAULT_SALES_ITEMS_CAPACITY = 3;

    public static List<Account> createAccounts(Integer numOfAccounts){
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0; i<numOfAccounts; i++){
            Account acc = new Account();
            acc.Name = 'OkAccount' + i;
            acc.Account_level__c='Neutral';
            testAccounts.add(acc);
        }
        return testAccounts;
    }

    public static List<Opportunity> createOpportunities(Integer numOfOpportunities){
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for(Integer i=0; i<numOfOpportunities; i++){
            Opportunity opp = new Opportunity();
            opp.Name='OkOpportunity' + i;
            opp.StageName='Prospecting';
            opp.CloseDate=Date.today();
            opp.Sales_Items_Capacity__c=DEFAULT_SALES_ITEMS_CAPACITY;
            testOpportunities.add(opp);
        }
        return testOpportunities;
    }

    public static List<Sales__c> createSales(Integer numOfSales, Id salesOwnerId){
        List<Sales__c> testSales = new List<Sales__c>();
        for(Integer i=0; i<numOfSales; i++){
            Sales__c sale = new Sales__c();
            sale.Name='OkSales' + i;
            sale.Opportunity__c=salesOwnerId;
            testSales.add(sale);
        }
        return testSales;
    }
}