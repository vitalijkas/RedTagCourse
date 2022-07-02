import { subscribe, onError } from 'lightning/empApi';
import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import userId from '@salesforce/user/Id';


export default class CaseEventSubscription extends LightningElement {
    @api recordId;
    channelName = '/event/Case_Event__e';
    
    connectedCallback() {
        this.registerErrorListener();
        this.subscribeOnCaseEvent();
    }

    async subscribeOnCaseEvent() {
        await subscribe(this.channelName, -1, (result) => {
            const response = JSON.parse(JSON.stringify(result));
            if (response.data.payload.Case_Id__c === this.recordId &&
                response.data.payload.User_Id__c !== userId) {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Case is picked',
                            message: 'This case was already picked up by another agent.',
                            variant: 'warning'
                        })
                    );
                }
        });
    }

    registerErrorListener() {
        onError((error) => {
            console.log('Received error from server: ', JSON.stringify(error));
        });
    }
}