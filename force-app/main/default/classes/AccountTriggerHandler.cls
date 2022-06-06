public with sharing class AccountTriggerHandler extends TriggerHandler{
 
    public override void afterInsert(){
        AccountService.createOpportunities(Trigger.new);
    }

    public override void afterUpdate(){
        AccountService.updateOpportunities((List<Account>) Trigger.new, (Map<Id, Account>) Trigger.oldMap);
    }

    public override void beforeDelete(){
        AccountService.deleteOpportunities((List<Account>) Trigger.old);
    }
    
}