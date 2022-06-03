import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getSubjectPicklistValues from '@salesforce/apex/CreateCampaignTaskController.getSubjectPicklistValues'
import saveTask from '@salesforce/apex/CreateCampaignTaskController.saveTask'


export default class CreateCampaignTask extends LightningElement {
    @api recordId;
    subjectValue;
    dateValue;
    description;
    userId;
    @track subjectOptions = [];
    connectedCallback(){
        getSubjectPicklistValues()
            .then((result) => {
                this.subjectOptions = result.map(x => {
                    return {label: x, value: x};
                });
            })
            .catch((error)=> {
                console.error(error);
            });
    }

    handleChangeSubject(event) {
        this.subjectValue = event.detail.value;
    }
    handleChangeDate(event){
        this.dateValue = event.detail.value;
    }
    handleChangeDescription(event){
        this.description = event.detail.value;
    }
    editChangeUserId(event){
        this.userId = event.target.value;
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
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            if (element.fieldName === 'DelegatedApproverId') {
                if (!element.value) {
                    element.reportValidity();
                    isValid = false;
                }
            }
        });
        return isValid;
    }

    addTask() {
        
        if(this.isInputValid()){
            saveTask({subject: this.subjectValue, activityDate: this.dateValue, description: this.description, campaignId: this.recordId, userId: this.userId})
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Task created',
                        variant: 'success'
                    })
                );
                this.subjectValue = '';
                this.dateValue = '';
                this.description = '';
                this.userId = '';
                this.dispatchEvent(new CustomEvent('close'));
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

}