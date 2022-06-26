@isTest
private class CustomWeatherViewControllerTest {
    private static final Integer WEATHERS_NUMBER = 1;

    @TestSetup
    static void testSetup(){
        List<Weather__c> testWeathersList = TestDataFactory.createWeathers(WEATHERS_NUMBER, 'London');
        insert testWeathersList;
    }

    @isTest static void getWeatherTest(){
        List<Weather__c> testWeathersList = CustomWeatherViewController.getWeather();
        System.assertEquals(WEATHERS_NUMBER, testWeathersList.size());
    }
}
