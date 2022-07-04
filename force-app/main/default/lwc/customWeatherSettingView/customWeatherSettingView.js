import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getWeatherSettings from '@salesforce/apex/CustomWeatherSettingViewController.getWeatherSettings';
import addWeatherSettings from '@salesforce/apex/CustomWeatherSettingViewController.addWeatherSettings';
import editWeatherSettings from '@salesforce/apex/CustomWeatherSettingViewController.editWeatherSettings';

export default class CustomWeatherSettingView extends LightningElement {
    settingsId;
    city;
    language;
    exists = false;

    connectedCallback(){
        this.populateWeatherSettings();
    }

    handleChangeCity(event){
        this.city = event.detail.value;
    }

    handleChangeLanguage(event){
        this.language = event.detail.value;
    }

    populateWeatherSettings() {
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
                this.showToastEvent('Success', 'Setting successfully added!', 'success');
            })
            .catch((error) => {
                this.showToastEvent('Error on creating record', error, 'error');
            });
        }
    }

    editWeatherSettingsClick() {
        if(this.isInputValid()){
            editWeatherSettings({city: this.city, language: this.language, weatherId: this.settingsId})
            .then(() => {
                this.showToastEvent('Success', 'Setting successfully edited!', 'success');
            })
            .catch((error) => {
                this.showToastEvent('Error on editing record', error, 'error');
            });
        }
    }
    
    showToastMessage(title, message, variant){
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }
}