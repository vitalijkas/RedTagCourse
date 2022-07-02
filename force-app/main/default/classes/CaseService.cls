public with sharing class CaseService {
    @testVisible private static List<Case_Event__e> listCaseEvents = new List<Case_Event__e>();

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

    public class EventPublishException extends Exception{}
}