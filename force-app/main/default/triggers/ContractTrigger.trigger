trigger ContractTrigger on Contract(after insert, after update, after delete, after undelete, before delete, before insert, before update) {
    new ContractTriggerHandler().run();
} 