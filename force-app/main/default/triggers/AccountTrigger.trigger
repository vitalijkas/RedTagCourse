trigger AccountTrigger on Account (after insert, after update, after delete, after undelete, before delete, before insert, before update) {
    new AccountTriggerHandler().run();
}