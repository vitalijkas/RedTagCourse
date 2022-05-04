public with sharing class AccountTriggerHandler {
    public static void run(){
        if(Trigger.isAfter && Trigger.isInsert){
            AccountService.createOpportunities(Trigger.new);
        }
        if(Trigger.isAfter && Trigger.isUpdate){
            AccountService.updateOpportunities((List<Account>) Trigger.new, (Map<Id, Account>) Trigger.oldMap);
        }
        if(Trigger.isBefore && Trigger.isDelete){
            AccountService.deleteOpportunities((Map<Id, Account>) Trigger.oldMap);
        }
    }
    
}