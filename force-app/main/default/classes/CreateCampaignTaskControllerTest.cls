@isTest
private class CreateCampaignTaskControllerTest {
    private static final Integer OBJECT_NUMBER = 2;

    @TestSetup static void testSetup(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        List<User> testUsers = TestDataFactory.createUsers(OBJECT_NUMBER, p.Id);
        insert testUsers;
        List<Campaign> testCampaigns = TestDataFactory.createCampaigns(OBJECT_NUMBER);
        insert testCampaigns;
    }
    
    @isTest static void getPickListValuesTest(){
        List<String> pickListValuesList = CreateCampaignTaskController.getSubjectPicklistValues();
        
        System.assert(pickListValuesList.size()>0);
    }

    @isTest static void insertTaskTest(){
        User testUser = [SELECT Id FROM User LIMIT 1];
        Campaign testCampaign = [SELECT Id FROM Campaign LIMIT 1];

        String subject = 'Email';
        String activityDate = String.valueOf(Date.today());
        String description = 'TestDescription';
        Id campaignId = testCampaign.Id;
        Id userId = testUser.Id;

        Test.StartTest();
        Task testTask = CreateCampaignTaskController.saveTask(subject, activityDate, description, campaignId, userId);
        Test.StopTest();
        
        System.assertEquals(1, [SELECT count() FROM Task WHERE Id =: testTask.Id]);
    }
}
