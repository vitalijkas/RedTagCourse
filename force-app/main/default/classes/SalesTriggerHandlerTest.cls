@isTest
private class SalesTriggerHandlerTest {

    private static final Integer OBJECT_NUMBER = 3;
    @TestSetup
    static void testSetup(){
        TestDataFactory.createOpportunities(OBJECT_NUMBER, true);
    }

    @isTest static void testCreateSales(){
        List<Opportunity> listOpportunities = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity LIMIT 1];
        System.assertEquals(TestDataFactory.DEFAULT_SALES_ITEMS_CAPACITY, listOpportunities.get(0).Sales_Items_Capacity__c);
        System.assertEquals(0, listOpportunities.get(0).CurrentSalesItemsNumber__c);
        TestDataFactory.createSales(1, listOpportunities.get(0).Id, true);
        Opportunity opportunityUpdated = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity WHERE Id=:listOpportunities.get(0).Id];
        System.assertEquals(1, opportunityUpdated.CurrentSalesItemsNumber__c);
    }

    @isTest static void testCreateSales_error(){
        List<Opportunity> listOpportunities = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity LIMIT 1];
        System.assertEquals(TestDataFactory.DEFAULT_SALES_ITEMS_CAPACITY, listOpportunities.get(0).Sales_Items_Capacity__c);
        System.assertEquals(0, listOpportunities.get(0).CurrentSalesItemsNumber__c);
        try{
            TestDataFactory.createSales(4, listOpportunities.get(0).Id, true);
            System.assertEquals(1, 0, 'Expected to recieve error');
        }catch(DMLException unexpectedException){
            System.assertEquals(unexpectedException.getDmlMessage(0), 'Capacity is full');
        }
        Opportunity opportunityUpdated = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity WHERE Id=:listOpportunities.get(0).Id];
        System.assertEquals(0, opportunityUpdated.CurrentSalesItemsNumber__c);
    }

    @isTest static void testDeleteSales(){
        List<Opportunity> listOpportunities = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity LIMIT 1];
        System.assertEquals(TestDataFactory.DEFAULT_SALES_ITEMS_CAPACITY, listOpportunities.get(0).Sales_Items_Capacity__c);
        System.assertEquals(0, listOpportunities.get(0).CurrentSalesItemsNumber__c);
        List<Sales__c> listSales = TestDataFactory.createSales(1, listOpportunities.get(0).Id, true);
        Opportunity opportunityUpdated = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity WHERE Id=:listOpportunities.get(0).Id];
        System.assertEquals(1, opportunityUpdated.CurrentSalesItemsNumber__c);
        Test.StartTest();
            delete listSales;
        Test.StopTest();
        opportunityUpdated = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity WHERE Id=:listOpportunities.get(0).Id];
        System.assertEquals(0, opportunityUpdated.CurrentSalesItemsNumber__c);
    }

    @isTest static void testChangeParentOfSales(){
        List<Opportunity> listOpportunities = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity LIMIT 2];
        System.assertEquals(TestDataFactory.DEFAULT_SALES_ITEMS_CAPACITY, listOpportunities.get(0).Sales_Items_Capacity__c);
        System.assertEquals(0, listOpportunities.get(0).CurrentSalesItemsNumber__c);
        System.assertEquals(TestDataFactory.DEFAULT_SALES_ITEMS_CAPACITY, listOpportunities.get(1).Sales_Items_Capacity__c);
        System.assertEquals(0, listOpportunities.get(1).CurrentSalesItemsNumber__c);
        List<Sales__c> listSales = TestDataFactory.createSales(1, listOpportunities.get(0).Id, true);
        Opportunity opportunityUpdated = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity WHERE Id=:listOpportunities.get(0).Id];
        System.assertEquals(1, opportunityUpdated.CurrentSalesItemsNumber__c);
        listSales.get(0).Opportunity__c = listOpportunities.get(1).Id;
        Test.StartTest();
            update listSales;
        Test.StopTest();
        Opportunity opportunityOld = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity WHERE Id=:listOpportunities.get(0).Id];
        Opportunity opportunityNew = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity WHERE Id=:listOpportunities.get(1).Id];
        System.assertEquals(0, opportunityOld.CurrentSalesItemsNumber__c);
        System.assertEquals(1, opportunityNew.CurrentSalesItemsNumber__c);
    }

    @isTest static void testChangeParentOfSales_error(){
        List<Opportunity> listOpportunities = [SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c FROM Opportunity LIMIT 2];
        System.assertEquals(TestDataFactory.DEFAULT_SALES_ITEMS_CAPACITY, listOpportunities.get(0).Sales_Items_Capacity__c);
        System.assertEquals(0, listOpportunities.get(0).CurrentSalesItemsNumber__c);
        System.assertEquals(TestDataFactory.DEFAULT_SALES_ITEMS_CAPACITY, listOpportunities.get(1).Sales_Items_Capacity__c);
        System.assertEquals(0, listOpportunities.get(1).CurrentSalesItemsNumber__c);
        List<Sales__c> listSales1 = TestDataFactory.createSales(3, listOpportunities.get(0).Id, true);
        List<Sales__c> listSales2 = TestDataFactory.createSales(3, listOpportunities.get(1).Id, true);
        List<Opportunity> listOpportunitiesUpdated = [
            SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c 
            FROM Opportunity 
            WHERE Id IN:listOpportunities
        ];
        System.assertEquals(3, listOpportunitiesUpdated.get(0).CurrentSalesItemsNumber__c);
        System.assertEquals(3, listOpportunitiesUpdated.get(1).CurrentSalesItemsNumber__c);
        listSales1.get(0).Opportunity__c = listOpportunities.get(1).Id;
        try{
            Test.StartTest();
                update listSales1;
            Test.StopTest();
            System.assertEquals(1, 0, 'Expected to recieve error');
        }catch(DMLException unexpectedException){
            System.assertEquals(unexpectedException.getDmlMessage(0), 'Capacity is full');
        }
        listOpportunitiesUpdated = [
            SELECT Id,Name, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c 
            FROM Opportunity 
            WHERE Id IN:listOpportunities
        ];
        System.assertEquals(3, listOpportunitiesUpdated.get(0).CurrentSalesItemsNumber__c);
        System.assertEquals(3, listOpportunitiesUpdated.get(1).CurrentSalesItemsNumber__c);
    }
}
