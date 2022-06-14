import { LightningElement, api } from 'lwc';
import getWeather from '@salesforce/apex/CustomWeatherViewController.getWeather';
import { loadStyle } from 'lightning/platformResourceLoader';
import stylesCustomWeatherView from '@salesforce/resourceUrl/stylesCustomWeatherView';

export default class CustomWeatherView extends LightningElement {
    @api label;
    data = [];
    columns = [
        {label: 'City', fieldName:'CityName', cellAttributes: { iconName: { fieldName: 'cityIcon' }}},
        {label: 'Date', fieldName:'Date', cellAttributes: { class: 'column-styled'}},
        {label: 'Temperature', fieldName:'Temperature', cellAttributes: { class: 'column-styled'}},
        {label: 'Feels like', fieldName:'FeelsLike', cellAttributes: { class: 'column-styled'}},
        {label: 'Pressure', fieldName:'Pressure', cellAttributes: { class: 'column-styled'}},
        {label: 'Wind speed', fieldName:'WindSpeed', cellAttributes: { class: 'column-styled'}},
        {label: 'Humidity', fieldName:'Humidity', cellAttributes: { class: 'column-styled'}},
        {label: 'Location', fieldName:'Location', type:'Location', cellAttributes: { class: 'column-styled'}},
        {label: 'Description', fieldName:'Description', cellAttributes: { class: 'column-styled'}}

    ]

    async connectedCallback(){
        loadStyle(this, stylesCustomWeatherView);
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