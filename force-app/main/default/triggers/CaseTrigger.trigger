trigger CaseTrigger on Case (after insert, after update, after delete, after undelete, before delete, before insert, before update) {
    new CaseTriggerHandler().run();
}