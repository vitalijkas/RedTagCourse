public with sharing class CaseTriggerHandler extends TriggerHandler{
    
    public override void afterUpdate() {
        CaseService.sendEventsOnCaseChange((List<Case>) Trigger.new, (Map<Id, Case>) Trigger.oldMap);
    }
}