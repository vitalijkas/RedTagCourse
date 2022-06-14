@isTest
private class WeatherServiceTest {
    private static final Integer WEATHER_SETTINGS_NUMBER = 1;
    private static final Integer WEATHERS_NUMBER = 1;
    private static final String FAKE_JSON = '{\"coord\":{\"lon\":-0.1257,\"lat\":51.5085},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"brokenclouds\",\"icon\":\"04d\"}],\"base\":\"stations\",\"main\":{\"temp\":290.29,\"feels_like\":289.97,\"temp_min\":288.73,\"temp_max\":291.01,\"pressure\":1018,\"humidity\":73},\"visibility\":10000,\"wind\":{\"speed\":5.14,\"deg\":220},\"clouds\":{\"all\":75},\"dt\":1654801990,\"sys\":{\"type\":2,\"id\":2019646,\"country\":\"GB\",\"sunrise\":1654746263,\"sunset\":1654805718},\"timezone\":3600,\"id\":2643743,\"name\":\"London\",\"cod\":200}';
    private static final String FAKE_JSON_NEGATIVE = '{\"cod\":\"404\",\"message\":\"citynotfound\"}';

    @TestSetup
    static void testSetup(){
        List<Weather_Setting__c> testWeatherSettings = TestDataFactory.createWeatherSetting(WEATHER_SETTINGS_NUMBER, 'London', 'US');
        insert testWeatherSettings;

        List<Weather__c> testWeathersList = TestDataFactory.createWeathers(WEATHERS_NUMBER, 'London');
        insert testWeathersList;
    }

    private class HttpMock implements HttpCalloutMock {
        private String status;
        private String okBody;
        private Integer statusCode;
        private String errorBody;
        
        public HttpMock(String status, String okBody, String errorBody, Integer statusCode) {
             this.status = status;
             this.okBody = okBody;
             this.errorBody = errorBody;
             this.statusCode = statusCode;
         }
 
         public HttpResponse respond(HttpRequest request) {
             HttpResponse response = new HttpResponse();
             response.setStatus(status);
             response.setStatusCode(statusCode);
 
             if (response.getStatus().equals('OK') && String.isNotEmpty(okBody)) {
                 response.setBody(okBody);
             } else if (String.isNotEmpty(errorBody)) {
                 response.setBody(errorBody);
             }
             return response;
         }
     }

    @isTest static void updateWeatherTest(){
        List<Weather_Setting__c> weatherSettings = [SELECT Id, CityName__c, Language__c FROM Weather_Setting__c];
        Test.setMock(HttpCalloutMock.class, new HttpMock('OK', '', FAKE_JSON, 200));

        Test.StartTest();
            WeatherService.updateWeather();
        Test.StopTest();

        List<Weather__c> weathersAfterInsert = [
            SELECT Id, Name, CityName__c, Date__c, Humidity__c, Location__c, Pressure__c, TempFeelsLike__c, Temperature__c, WeatherDescription__c, WindSpeed__c 
            FROM Weather__c];

        System.assert(weathersAfterInsert.size() > 1);
    }

    @isTest static void updateWeatherTest_negative(){
        insert TestDataFactory.createWeatherSetting(3, 'London', 'US');
        List<Weather_Setting__c> weatherSettings = [SELECT Id, CityName__c, Language__c FROM Weather_Setting__c];

        try {
            Test.StartTest();
                WeatherService.updateWeather();
            Test.StopTest();
        } catch (Exception e) {
            System.assertEquals(e.getMessage(), 'Weather setting size is inappropriate. Size = ' + weatherSettings.size());
        }
    }

    @isTest static void updateWeatherResponseTest_negative(){
        Test.setMock(HttpCalloutMock.class, new HttpMock('Not found', '', FAKE_JSON_NEGATIVE, 404));

        try {
            Test.StartTest();
                WeatherService.updateWeather();
            Test.StopTest();
        } catch (Exception e) {
            System.assertEquals(e.getMessage(), 'Http request error. Response StatusCode = 404');
        }
    }
}
