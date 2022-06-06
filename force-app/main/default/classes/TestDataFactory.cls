@isTest
public class TestDataFactory {
    @TestVisible private static Integer DEFAULT_SALES_ITEMS_CAPACITY = 3;
    
    public static List<User> createUsers(Integer numOfUsers, Id profileId){
        List<User> testUsers = new List<User>();
        for(Integer i=0; i<numOfUsers; i++){
            User u = new User();
            u.Alias = 'standt';
            u.Email = 'testuserx' + i + '@testorg.com';
            u.EmailEncodingKey = 'UTF-8';
            u.LastName = 'Test';
            u.LanguageLocaleKey = 'en_US';
            u.LocaleSidKey='en_US';
            u.ProfileId = profileId;
            u.TimeZoneSidKey='America/Los_Angeles';
            u.UserName='testuserx' + i + '@testorg.com';
            testUsers.add(u);
        }
        return testUsers;
    }

    public static List<Campaign> createCampaigns(Integer numOfCampaigns){
        List<Campaign> testCampaigns = new List<Campaign>();
        for(Integer i=0; i<numOfCampaigns; i++){
            Campaign c = new Campaign();
            c.Name = 'TestCampaign' + i;
            testCampaigns.add(c);
        }
        return testCampaigns;
    }
}

    public static List<Account> createAccounts(Integer numOfAccounts){
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0; i<numOfAccounts; i++){
            Account acc = new Account();
            acc.Name = 'OkAccount' + i;
            acc.Account_level__c='Neutral';
            testAccounts.add(acc);
        }
        return testAccounts;
    }

    public static List<Contract> createContracts(Integer numOfContracts, List<Account> testAccounts){
        List<Contract> testContracts = new List<Contract>();
        for(Integer i=0;i<numOfContracts;i++){
            Contract ct = new Contract();
            ct.AccountId = testAccounts[i].Id;
            ct.ContractTerm = 12;
            ct.Status = 'Draft';
            ct.StartDate = Date.today();
            testContracts.add(ct);
        }
        return testContracts;
    }

    public static ContentVersion createContentVersion(){
        ContentVersion contentVersion = new ContentVersion();
        Blob body = Blob.valueof('lala');
        contentVersion.ContentLocation = 'S';
        contentVersion.PathOnClient = 'Document.txt';
        contentVersion.Title = 'Document';
        contentVersion.VersionData = body;
        contentVersion.Document_Type__c = 'Contract';
        return contentVersion;
    }

    public static ContentDocumentLink createContentDocumentLink(Id accountId, Id contentDocumentId){
        ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
        contentDocumentLink.ContentDocumentId = contentDocumentId;
        contentDocumentLink.LinkedEntityId = accountId;
        contentDocumentLink.ShareType = 'I';
        contentDocumentLink.Visibility = 'AllUsers';
        return contentDocumentLink;
    }

    public static List<Opportunity> createOpportunities(Integer numOfOpportunities){
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for(Integer i=0; i<numOfOpportunities; i++){
            Opportunity opp = new Opportunity();
            opp.Name='OkOpportunity' + i;
            opp.StageName='Prospecting';
            opp.CloseDate=Date.today();
            opp.Sales_Items_Capacity__c=DEFAULT_SALES_ITEMS_CAPACITY;
            testOpportunities.add(opp);
        }
        return testOpportunities;
    }

    public static List<Sales__c> createSales(Integer numOfSales, Id salesOwnerId){
        List<Sales__c> testSales = new List<Sales__c>();
        for(Integer i=0; i<numOfSales; i++){
            Sales__c sale = new Sales__c();
            sale.Name='OkSales' + i;
            sale.Opportunity__c=salesOwnerId;
            testSales.add(sale);
        }
        return testSales;
    }
}