public with sharing class ContractTriggerHandler extends TriggerHandler{

    public override void beforeUpdate(){
        ContractService.contractValidation(Trigger.new, (Map<Id, Contract>) Trigger.oldMap);
    }
}
