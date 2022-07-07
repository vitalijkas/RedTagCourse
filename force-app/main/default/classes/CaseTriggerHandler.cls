public with sharing class CaseTriggerHandler extends TriggerHandler{

    public override void afterInsert(){
        CaseService.sendEventOnCaseCreate(Trigger.new);
    }
    
    public override void afterUpdate() {
        CaseService.sendEventsOnCaseChange(Trigger.new, (Map<Id, Case>) Trigger.oldMap);
    }
}