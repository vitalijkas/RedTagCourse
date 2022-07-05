public with sharing class CaseService {
    @testVisible private static List<Case_Event__e> listCaseEvents = new List<Case_Event__e>();
    @testVisible private static List<New_Case_Record__e> listCaseCreateEvents = new List<New_Case_Record__e>();

    public static void sendEventsOnCaseChange(List<Case> listCasesNew, Map<Id, Case> mapCasesOld){
        for (Case newCase : listCasesNew) {

            if (newCase.Status != mapCasesOld.get(newCase.Id).Status && newCase.Status == 'In Progress') {
                Case_Event__e newCaseEvent = new Case_Event__e();
                newCaseEvent.Case_Id__c = newCase.Id;
                newCaseEvent.User_Id__c = UserInfo.getUserId();
                listCaseEvents.add(newCaseEvent);
            }
        }
        
        List<Database.SaveResult> eventPublishResults = Eventbus.publish(listCaseEvents);

        for (Database.SaveResult saveRes : eventPublishResults) {

            if (!saveRes.isSuccess()){
                throw new EventPublishException('Event publish errors. Error - ' + saveRes.getErrors());
            }
        }
    }

    public static void sendEventOnCaseCreate(List<Case> listCasesNew) {
        for (Case newCase : listCasesNew) {
            New_Case_Record__e newCaseEvent = new New_Case_Record__e();
            newCaseEvent.Case_Branch_Number__c = newCase.Branch_Number__c;
            listCaseCreateEvents.add(newCaseEvent);
        }
        
        List<Database.SaveResult> eventPublishResults = Eventbus.publish(listCaseCreateEvents);

        for (Database.SaveResult saveRes : eventPublishResults) {

            if (!saveRes.isSuccess()){
                throw new EventPublishException('Event publish errors. Error - ' + saveRes.getErrors());
            }
        }
    }

    public class EventPublishException extends Exception{}
}