public with sharing class WeatherService {
    
    public static void updateWeather(){
        List<Weather_Setting__c> weatherSettingsList = [SELECT Id, CityName__c, Language__c FROM Weather_Setting__c];
        if(weatherSettingsList.isEmpty() || weatherSettingsList.size() > 1){
            throw new WeatherException('Weather setting size is inappropriate. Size = ' + weatherSettingsList.size());
        }

        HttpResponse resp = WeatherApi.getWeather(weatherSettingsList[0].CityName__c);
        if(resp.getStatusCode() != 200){
            throw new WeatherException('Http request error. Response StatusCode = ' + resp.getStatusCode());
        }
        
        WeatherAPIWrappers.GetWeatherResponse respWrapper = 
            (WeatherAPIWrappers.GetWeatherResponse) System.JSON.deserialize(resp.getBody(), WeatherAPIWrappers.GetWeatherResponse.class);

        Weather__c weatherToInsert = new Weather__c();
        weatherToInsert.Name = String.format(System.Label.Weather_Name, new List<Object> {respWrapper.name});
        weatherToInsert.CityName__c = respWrapper.name;
        weatherToInsert.Humidity__c = respWrapper.main.humidity;
        weatherToInsert.Pressure__c = respWrapper.main.pressure;
        weatherToInsert.TempFeelsLike__c = respWrapper.main.feels_like;
        weatherToInsert.Temperature__c = respWrapper.main.temp;
        weatherToInsert.WeatherDescription__c = respWrapper.weather[0].description;
        weatherToInsert.WindSpeed__c = respWrapper.wind.speed;
        weatherToInsert.Location__longitude__s = respWrapper.coord.lon;
        weatherToInsert.Location__latitude__s = respWrapper.coord.lat;
        weatherToInsert.Date__c = DateTime.newInstance(respWrapper.dt*1000).date();

        insert weatherToInsert;
    }

    public class WeatherException extends Exception{}
}
