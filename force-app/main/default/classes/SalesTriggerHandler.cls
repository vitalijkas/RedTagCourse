public with sharing class SalesTriggerHandler extends TriggerHandler{
    public override void beforeInsert(){
        SalesService.checkCapacity(Trigger.new, (Map<Id, Sales__c>) Trigger.oldMap);
    }
    public override void beforeUpdate(){
        SalesService.checkCapacity(Trigger.new, (Map<Id, Sales__c>) Trigger.oldMap);
    }
}