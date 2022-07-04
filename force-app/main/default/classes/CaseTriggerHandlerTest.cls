@isTest
public class CaseTriggerHandlerTest {
    private static final Integer OBJECT_NUMBER = 1;
    
    @TestSetup static void testSetup(){
        List<Case> testCases = TestDataFactory.createCases(OBJECT_NUMBER);
        insert testCases;
    }

    @isTest static void publishCaseEvent() {
        Case testCase = [SELECT Id FROM Case LIMIT 1];
        
        Test.startTest();
            testCase.Status = 'In Progress';
            update testCase;
        Test.stopTest();

        System.assertEquals(1, CaseService.listCaseEvents.size());
    }
}