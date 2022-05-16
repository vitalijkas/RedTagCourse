trigger SalesTrigger on Sales__c (after insert, after update, after delete, after undelete, before delete, before insert, before update) {
    new SalesTriggerHandler().run();
}