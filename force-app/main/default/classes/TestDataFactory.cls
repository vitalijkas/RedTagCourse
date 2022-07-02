@isTest
public class TestDataFactory {
    @TestVisible private static Integer DEFAULT_SALES_ITEMS_CAPACITY = 3;
    
    public static List<User> createUsers(Integer numOfUsers, Id profileId) {
        List<User> testUsers = new List<User>();
        for (Integer i=0; i<numOfUsers; i++) {
            User userRecord = new User();
            userRecord.Alias = 'standt';
            userRecord.Email = 'testuserx' + i + '@testorg.com';
            userRecord.EmailEncodingKey = 'UTF-8';
            userRecord.LastName = 'Test';
            userRecord.LanguageLocaleKey = 'en_US';
            userRecord.LocaleSidKey='en_US';
            userRecord.ProfileId = profileId;
            userRecord.TimeZoneSidKey='America/Los_Angeles';
            userRecord.UserName='testuserx' + i + '@testorg.com';
            testUsers.add(userRecord);
        }
        return testUsers;
    }

    public static List<Campaign> createCampaigns(Integer numOfCampaigns) {
        List<Campaign> testCampaigns = new List<Campaign>();
        for (Integer i=0; i<numOfCampaigns; i++) {
            Campaign campaignRecord = new Campaign();
            campaignRecord.Name = 'TestCampaign' + i;
            testCampaigns.add(campaignRecord);
        }
        return testCampaigns;
    }

    public static List<Account> createAccounts(Integer numOfAccounts) {
        List<Account> testAccounts = new List<Account>();
        for (Integer i=0; i<numOfAccounts; i++) {
            Account accountRecord = new Account();
            accountRecord.Name = 'OkAccount' + i;
            accountRecord.Account_level__c='Neutral';
            testAccounts.add(accountRecord);
        }
        return testAccounts;
    }

    public static List<Contract> createContracts(Integer numOfContracts, List<Account> testAccounts) {
        List<Contract> testContracts = new List<Contract>();
        for (Integer i=0;i<numOfContracts;i++) {
            Contract contractRecord = new Contract();
            contractRecord.AccountId = testAccounts[i].Id;
            contractRecord.ContractTerm = 12;
            contractRecord.Status = 'Draft';
            contractRecord.StartDate = Date.today();
            testContracts.add(contractRecord);
        }
        return testContracts;
    }

    public static ContentVersion createContentVersion() {
        ContentVersion contentVersion = new ContentVersion();
        Blob body = Blob.valueof('lala');
        contentVersion.ContentLocation = 'S';
        contentVersion.PathOnClient = 'Document.txt';
        contentVersion.Title = 'Document';
        contentVersion.VersionData = body;
        contentVersion.Document_Type__c = 'Contract';
        return contentVersion;
    }

    public static ContentDocumentLink createContentDocumentLink(Id accountId, Id contentDocumentId) {
        ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
        contentDocumentLink.ContentDocumentId = contentDocumentId;
        contentDocumentLink.LinkedEntityId = accountId;
        contentDocumentLink.ShareType = 'I';
        contentDocumentLink.Visibility = 'AllUsers';
        return contentDocumentLink;
    }

    public static List<Opportunity> createOpportunities(Integer numOfOpportunities) {
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for (Integer i=0; i<numOfOpportunities; i++) {
            Opportunity opportunityRecord = new Opportunity();
            opportunityRecord.Name='OkOpportunity' + i;
            opportunityRecord.StageName='Prospecting';
            opportunityRecord.CloseDate=Date.today();
            opportunityRecord.Sales_Items_Capacity__c=DEFAULT_SALES_ITEMS_CAPACITY;
            testOpportunities.add(opportunityRecord);
        }
        return testOpportunities;
    }

    public static List<Sales__c> createSales(Integer numOfSales, Id salesOwnerId){
        List<Sales__c> testSales = new List<Sales__c>();
        for(Integer i=0; i<numOfSales; i++){
            Sales__c salesRecord = new Sales__c();
            salesRecord.Name='OkSales' + i;
            salesRecord.Opportunity__c=salesOwnerId;
            testSales.add(salesRecord);
        }
        return testSales;
    }

    public static List<Case> createCases(Integer numOfCases) {
        List<Case> testCases = new List<Case>();
        for (Integer i=0; i<numOfCases; i++) {
            Case caseRecord = new Case();
            caseRecord.Status = 'New';
            caseRecord.Origin = 'Email';
            testCases.add(caseRecord);
        }
        return testCases;
    }
}