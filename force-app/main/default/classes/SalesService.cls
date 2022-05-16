public with sharing class SalesService {
    public static void checkCapacity(List<Sales__c> listNewSales, Map<Id, Sales__c> mapOldSales){
        Map<Id, List<Sales__c>> mapSalesByOpportunity = new Map<Id, List<Sales__c>>();
        for(Sales__c sale: listNewSales){
            if(mapOldSales != null && sale.Opportunity__c == mapOldSales.get(sale.Id).Opportunity__c){
                continue;
            }
            if(!mapSalesByOpportunity.containskey(sale.Opportunity__c)){
                mapSalesByOpportunity.put(sale.Opportunity__c, new List<Sales__c>());
            }
            mapSalesByOpportunity.get(sale.Opportunity__c).add(sale);   
        }
        List<Opportunity> listOpportunities = [
            SELECT Id, CurrentSalesItemsNumber__c, Sales_Items_Capacity__c 
            FROM Opportunity
            WHERE Id IN:mapSalesByOpportunity.keySet()
        ];
        for(Opportunity opp: listOpportunities){
            if(opp.CurrentSalesItemsNumber__c == opp.Sales_Items_Capacity__c ||
               opp.CurrentSalesItemsNumber__c + mapSalesByOpportunity.get(opp.Id).size() > opp.Sales_Items_Capacity__c
            ){
                mapSalesByOpportunity.get(opp.Id)[0].addError('Capacity is full');
            }
        }
    }
}
