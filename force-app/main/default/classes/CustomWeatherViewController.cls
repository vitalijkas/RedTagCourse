public with sharing class CustomWeatherViewController {
    
    @AuraEnabled
    public static List<Weather__c> getWeather(){
        List<Weather__c> weatherList = [
            SELECT Id, 
                CityName__c, 
                Date__c, 
                Humidity__c, 
                Location__c, 
                Pressure__c, 
                TempFeelsLike__c, 
                Temperature__c, 
                WeatherDescription__c, 
                WindSpeed__c 
            FROM Weather__c];
        return weatherList;
    }
}
