@isTest
public class TestDataFactory {
    @TestVisible private static Integer DEFAULT_SALES_ITEMS_CAPACITY = 3;
    
    public static List<Weather_Setting__c> createWeatherSetting(Integer numOfWeatherSettings, String city, String language){
        List<Weather_Setting__c> testWeatherSettings = new List<Weather_Setting__c>();
        for(Integer i=0; i<numOfWeatherSettings; i++){
            Weather_Setting__c testWeatherSetting = new Weather_Setting__c();
            testWeatherSetting.Name = 'Weather setting for ' + city;
            testWeatherSetting.CityName__c = city;
            testWeatherSetting.Language__c = language;
            testWeatherSettings.add(testWeatherSetting);
        }
        return testWeatherSettings;
    }

    public static List<Weather__c> createWeathers(Integer numOfWeathers, String city){
        List<Weather__c> testWeathers = new List<Weather__c>();
        for(Integer i=0; i<numOfWeathers; i++){
            Weather__c testWeather = new Weather__c();
            testWeather.Name = 'Weather setting for ' + city;
            testWeather.CityName__c = city;
            testWeathers.add(testWeather);
        }
        return testWeathers;
    }

    public static List<User> createUsers(Integer numOfUsers, Id profileId){
        List<User> testUsers = new List<User>();
        for(Integer i=0; i<numOfUsers; i++){
            User testUser = new User();
            testUser.Alias = 'standt';
            testUser.Email = 'testuserx' + i + '@testorg.com';
            testUser.EmailEncodingKey = 'UTF-8';
            testUser.LastName = 'Test';
            testUser.LanguageLocaleKey = 'en_US';
            testUser.LocaleSidKey='en_US';
            testUser.ProfileId = profileId;
            testUser.TimeZoneSidKey='America/Los_Angeles';
            testUser.UserName='testuserx' + i + '@testorg.com';
            testUsers.add(testUser);
        }
        return testUsers;
    }

    public static List<Campaign> createCampaigns(Integer numOfCampaigns){
        List<Campaign> testCampaigns = new List<Campaign>();
        for(Integer i=0; i<numOfCampaigns; i++){
            Campaign testCampaign = new Campaign();
            testCampaign.Name = 'TestCampaign' + i;
            testCampaigns.add(testCampaign);
        }
        return testCampaigns;
    }


    public static List<Account> createAccounts(Integer numOfAccounts){
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0; i<numOfAccounts; i++){
            Account testAccount = new Account();
            testAccount.Name = 'OkAccount' + i;
            testAccount.Account_level__c='Neutral';
            testAccounts.add(testAccount);
        }
        return testAccounts;
    }

    public static List<Contract> createContracts(Integer numOfContracts, List<Account> testAccounts){
        List<Contract> testContracts = new List<Contract>();
        for(Integer i=0;i<numOfContracts;i++){
            Contract testContract = new Contract();
            testContract.AccountId = testAccounts[i].Id;
            testContract.ContractTerm = 12;
            testContract.Status = 'Draft';
            testContract.StartDate = Date.today();
            testContracts.add(testContract);
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
            Opportunity testOpportunity = new Opportunity();
            testOpportunity.Name='OkOpportunity' + i;
            testOpportunity.StageName='Prospecting';
            testOpportunity.CloseDate=Date.today();
            testOpportunity.Sales_Items_Capacity__c=DEFAULT_SALES_ITEMS_CAPACITY;
            testOpportunities.add(testOpportunity);
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