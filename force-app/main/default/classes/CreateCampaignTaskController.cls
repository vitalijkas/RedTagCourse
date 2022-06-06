public with sharing class CreateCampaignTaskController {
    
    @AuraEnabled
    public static List<String> getSubjectPicklistValues(){
        List<String> pickListValuesList = new List<String>();
		List<Schema.PicklistEntry> ple = Task.Subject.getDescribe().getPicklistValues();
		for(Schema.PicklistEntry pickListVal : ple){
			pickListValuesList.add(pickListVal.getLabel());
		}     
		return pickListValuesList;
    }

    @AuraEnabled
    public static Task saveTask(String subject, String activityDate, String description, Id campaignId, Id userId){
        Task task = new Task();
        task.Subject = subject;
        task.ActivityDate = Date.valueOf(activityDate);
        task.description = description;
        task.OwnerId = userId;
        task.WhatId = campaignId;
        insert task;
        return task;
    }
}
