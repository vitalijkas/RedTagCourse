public with sharing class CustomCaseViewController {
    
    @AuraEnabled
    public static List<Case> getCases(String branchNumber) {
        List<Case> listCases = [
            SELECT 
                Id, 
                CaseNumber,
                Status, 
                CreatedDate 
                FROM Case WHERE Branch_Number__c = :branchNumber
                ORDER BY CreatedDate DESC];
        return listCases;
    }

    @AuraEnabled
    public static void updateCase(Id caseId){
        Case caseRecord = [SELECT Id, Status FROM Case WHERE Id = :caseId];
        caseRecord.Status = 'In Progress';
        update caseRecord;
    }

    @AuraEnabled
    public static String getUserBranchNumber(Id currentUserId) {
        User userRecord = [SELECT Id, Branch_Number__c FROM User WHERE Id =: currentUserId];
        String branchNumber = userRecord.Branch_Number__c;
        return branchNumber;
    }
}
