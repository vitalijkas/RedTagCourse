@isTest
public class TestDataFactory {
    @TestVisible private static Integer DEFAULT_SALES_ITEMS_CAPACITY = 3;
    
    public static List<Weather_Setting__c> createWeatherSetting(Integer numOfWeatherSettings, String city, String language){
        List<Weather_Setting__c> testWeatherSettings = new List<Weather_Setting__c>();
        for(Integer i=0; i<numOfWeatherSettings; i++){
            Weather_Setting__c weatherSetting = new Weather_Setting__c();
            weatherSetting.Name = 'Weather setting for ' + city;
            weatherSetting.CityName__c = city;
            weatherSetting.Language__c = language;
            testWeatherSettings.add(weatherSetting);
        }
        return testWeatherSettings;
    }

    public static List<Weather__c> createWeathers(Integer numOfWeathers, String city){
        List<Weather__c> testWeathers = new List<Weather__c>();
        for(Integer i=0; i<numOfWeathers; i++){
            Weather__c weather = new Weather__c();
            weather.Name = 'Weather setting for ' + city;
            weather.CityName__c = city;
            testWeathers.add(weather);
        }
        return testWeathers;
    }

    public static List<User> createUsers(Integer numOfUsers, Id profileId){
        List<User> testUsers = new List<User>();
        for(Integer i=0; i<numOfUsers; i++){
            User user = new User();
            user.Alias = 'standt';
            user.Email = 'testuserx' + i + '@testorg.com';
            user.EmailEncodingKey = 'UTF-8';
            user.LastName = 'Test';
            user.LanguageLocaleKey = 'en_US';
            user.LocaleSidKey='en_US';
            user.ProfileId = profileId;
            user.TimeZoneSidKey='America/Los_Angeles';
            user.UserName='testuserx' + i + '@testorg.com';
            testUsers.add(user);
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