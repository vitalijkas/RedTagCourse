trigger AccountTrigger on Account (after insert, after update, before delete) {
    AccountTriggerHandler.run();
}