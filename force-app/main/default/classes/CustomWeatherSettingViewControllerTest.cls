@isTest
private class CustomWeatherSettingViewControllerTest {
    private static final Integer WEATHER_SETTINGS_NUMBER = 1;
    private static final Integer WEATHERS_NUMBER = 1;

    @TestSetup
    static void testSetup(){
        List<Weather_Setting__c> testWeatherSettings = TestDataFactory.createWeatherSetting(WEATHER_SETTINGS_NUMBER, 'London', 'US');
        insert testWeatherSettings;
    }

    @isTest static void getWeatherSettingsTest(){
        List<Weather_Setting__c> testWeatherSettings = CustomWeatherSettingViewController.getWeatherSettings();
        System.assertEquals(testWeatherSettings.size(), WEATHER_SETTINGS_NUMBER);
    }

    @isTest static void addWeatherSettingsTest(){
        Test.StartTest();
            Weather_Setting__c testWeatherSetting = CustomWeatherSettingViewController.addWeatherSettings('London', 'US');
        Test.StopTest();

        List<Weather_Setting__c> testWeatherSettings = [SELECT Id FROM Weather_Setting__c WHERE Id =: testWeatherSetting.Id];
        System.assertEquals(1, testWeatherSettings.size());
    }

    @isTest static void editWeatherSettingsTest(){
        List<Weather_Setting__c> testWeatherSettings = [SELECT Id FROM Weather_Setting__c];
    
        Test.StartTest();
            Weather_Setting__c testWeatherSetting = CustomWeatherSettingViewController.editWeatherSettings('New name', 'New language', testWeatherSettings.get(0).Id);
        Test.StopTest();

        Weather_Setting__c updatedWeatherSettings = [SELECT Id, Name, CityName__c, Language__c FROM Weather_Setting__c WHERE Id =: testWeatherSetting.Id];

        System.assertEquals(updatedWeatherSettings.Name, 'Weather setting for New name');
        System.assertEquals(updatedWeatherSettings.CityName__c, 'New name');
        System.assertEquals(updatedWeatherSettings.Language__c, 'New language');
    }
}
