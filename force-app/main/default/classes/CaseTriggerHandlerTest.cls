@isTest
public class CaseTriggerHandlerTest {
    private static final Integer OBJECT_NUMBER = 1;
    
    @TestSetup static void testSetup(){
        List<Case> testCases = TestDataFactory.createCases(OBJECT_NUMBER);
        insert testCases;
    }

    @isTest static void publishCaseEventTest() {
        Case testCase = [SELECT Id FROM Case LIMIT 1];
        
        Test.startTest();
            testCase.Status = 'In Progress';
            update testCase;
        Test.stopTest();

        System.assertEquals(OBJECT_NUMBER, CaseService.listCaseEvents.size());
    }

    @isTest static void publishCaseCreateEventTest() {
        Test.startTest();
            insert TestDataFactory.createCases(OBJECT_NUMBER);
        Test.stopTest();

        System.assertEquals(OBJECT_NUMBER, CaseService.listCaseCreateEvents.size());

    }
}