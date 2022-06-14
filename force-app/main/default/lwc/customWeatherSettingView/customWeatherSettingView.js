import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getWeatherSettings from '@salesforce/apex/CustomWeatherSettingViewController.getWeatherSettings';
import addWeatherSettings from '@salesforce/apex/CustomWeatherSettingViewController.addWeatherSettings';
import editWeatherSettings from '@salesforce/apex/CustomWeatherSettingViewController.editWeatherSettings';
import { loadStyle } from 'lightning/platformResourceLoader';
import stylesCustomWeatherSettingsView from '@salesforce/resourceUrl/stylesCustomWeatherSettingsView';

export default class CustomWeatherSettingView extends LightningElement {
    settingsId;
    city;
    language;
    exists = false;

    handleChangeCity(event){
        this.city = event.detail.value;
    }

    handleChangeLanguage(event){
        this.language = event.detail.value;
    }

    connectedCallback(){
        loadStyle(this, stylesCustomWeatherSettingsView);
        getWeatherSettings().then(result => {
            if(result.length > 0){
                this.exists = true;
                this.city = result[0].CityName__c;
                this.language = result[0].Language__c;
                this.settingsId = result[0].Id;
            }
        });
    }

    isInputValid() {
        let isValid = true;
        let inputFields = this.template.querySelectorAll('.validate');
        inputFields.forEach(inputField => {
            if(!inputField.checkValidity()) {
                inputField.reportValidity();
                isValid = false;
            }
        });
        return isValid;
    }

    addWeatherSettingsClick() {
        if(this.isInputValid()){
            addWeatherSettings({city: this.city, language: this.language})
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Setting successfully added!',
                        variant: 'success'
                    })
                );
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error on creating record',
                        message: error,
                        variant: 'error'
                    })
                );
            });
        }
    }

    editWeatherSettingsClick() {
        if(this.isInputValid()){
            editWeatherSettings({city: this.city, language: this.language, weatherId: this.settingsId})
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Setting successfully edited!',
                        variant: 'success'
                    })
                );
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error on editing record',
                        message: error,
                        variant: 'error'
                    })
                );
            });
        }
    }
}