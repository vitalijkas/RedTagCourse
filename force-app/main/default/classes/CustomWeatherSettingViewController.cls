public with sharing class CustomWeatherSettingViewController {
    
    @AuraEnabled
    public static List<Weather_Setting__c> getWeatherSettings(){
        return [SELECT Id, CityName__c, Language__c FROM Weather_Setting__c];
    }

    @AuraEnabled
    public static Weather_Setting__c addWeatherSettings(String city, String language){
        Weather_Setting__c weatherSetting = new Weather_Setting__c();
        weatherSetting.Name = 'Weather setting for ' + city;
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
        weatherSetting.Name = 'Weather setting for ' + city;

        update weatherSetting;
        return weatherSetting;
    }
}
