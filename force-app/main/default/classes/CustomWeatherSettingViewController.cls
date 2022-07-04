public with sharing class CustomWeatherSettingViewController {
    
    @AuraEnabled
    public static List<Weather_Setting__c> getWeatherSettings(){
        List<Weather_Setting__c> weatherSettingsList = [SELECT Id, CityName__c, Language__c FROM Weather_Setting__c];
        return weatherSettingsList;
    }

    @AuraEnabled
    public static Weather_Setting__c addWeatherSettings(String city, String language){
        Weather_Setting__c weatherSetting = new Weather_Setting__c();
        weatherSetting.Name = System.Label.Weather_Settings_Name + city;
        weatherSetting.CityName__c = city;
        weatherSetting.Language__c = language;

        insert weatherSetting;
        return weatherSetting;
    }

    @AuraEnabled
    public static Weather_Setting__c editWeatherSettings(String city, String language, Id weatherId){
        Weather_Setting__c weatherSetting = [SELECT Id, Name, CityName__c, Language__c FROM Weather_Setting__c WHERE Id =: weatherId];
        weatherSetting.CityName__c = city;
        weatherSetting.Language__c = language;
        weatherSetting.Name = String.format(System.Label.Weather_Settings_Name, new List<Object> {city});

        update weatherSetting;
        return weatherSetting;
    }
}
