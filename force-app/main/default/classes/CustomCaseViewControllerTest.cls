@isTest
public  class CustomCaseViewControllerTest {
    private static final Integer OBJECT_NUMBER = 1;

    @TestSetup
    static void testSetup(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        List<User> testUsers = TestDataFactory.createUsers(OBJECT_NUMBER, p.Id);
        insert testUsers;

        List<Case> testCases = TestDataFactory.createCases(OBJECT_NUMBER);
        insert testCases;
    }

    @isTest static void getCasesTest() {
        List<Case> testCases = CustomCaseViewController.getCases('0001');

        System.assertEquals(OBJECT_NUMBER, testCases.size());
    }

    @isTest static void updateCaseTest() {
        Case testCase = [SELECT Id, Status FROM Case LIMIT 1];
        
        Test.startTest();
            CustomCaseViewController.updateCase(testCase.Id);
        Test.stopTest();

        Case testCaseUpdated = [SELECT Id, Status FROM Case LIMIT 1];
        System.assert(testCaseUpdated.Status.contains('In Progress'));
    }

    @isTest static void getUserBranchNumber() {
        User testUser = [SELECT Id, Branch_Number__c FROM User LIMIT 1];

        Test.startTest();
            String branchNumber = CustomCaseViewController.getUserBranchNumber(testUser.Id);
        Test.stopTest();

        System.assertEquals(testUser.Branch_Number__c, branchNumber);
    }
}
