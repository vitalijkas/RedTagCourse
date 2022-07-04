global class UpdateWeatherScheduled Implements Schedulable {
    
    global void execute(SchedulableContext sc){
        WeatherService.updateWeather();
    }

}
