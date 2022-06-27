import { LightningElement } from 'lwc';
import getWeather from '@salesforce/apex/CustomWeatherViewController.getWeather';
import { labels } from 'c/labelUtility';

export default class CustomWeatherView extends LightningElement {
    label = labels;
    data = [];
    columns = [
        {label: this.label.city, fieldName:'CityName', cellAttributes: { iconName: { fieldName: 'cityIcon' }}},
        {label: this.label.date, fieldName:'Date'},
        {label: this.label.temperature, fieldName:'Temperature'},
        {label: this.label.feelsLike, fieldName:'FeelsLike'},
        {label: this.label.pressure, fieldName:'Pressure'},
        {label: this.label.windSpeed, fieldName:'WindSpeed'},
        {label: this.label.humidity, fieldName:'Humidity'},
        {label: this.label.location, fieldName:'Location', type:'location'},
        {label: this.label.description, fieldName:'Description'}
    ];
    
    connectedCallback(){
        this.populateWeatherRecords();
    }

    populateWeatherRecords(){
        getWeather().then(result => {
            this.data = result.map(weather => {
                return {
                    CityName: weather.CityName__c,
                    Temperature: weather.Temperature__c,
                    FeelsLike: weather.TempFeelsLike__c,
                    Pressure: weather.Pressure__c,
                    WindSpeed: weather.WindSpeed__c,
                    Humidity: weather.Humidity__c,
                    Location: weather.Location__c,
                    Description: weather.WeatherDescription__c,
                    Date: weather.Date__c,
                    cityIcon: 'utility:world'
                }
            })
        }).catch(error => {
            console.error(error);
        });
    }
}