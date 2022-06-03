@isTest
public class TestDataFactory {
    
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
