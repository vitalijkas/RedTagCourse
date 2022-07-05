import { LightningElement, track } from 'lwc';
import { subscribe, onError } from 'lightning/empApi';
import getCases from '@salesforce/apex/CustomCaseViewController.getCases';
import updateCase from '@salesforce/apex/CustomCaseViewController.updateCase';
import getUserBranchNumber from '@salesforce/apex/CustomCaseViewController.getUserBranchNumber';
import soundNotification from '@salesforce/resourceUrl/NotificationSound';
import userId from '@salesforce/user/Id';


export default class CustomCaseView extends LightningElement {
    @track data = [];
    @track caseId = '';
    channelName = '/event/New_Case_Record__e';
    columnSize = 'width: 100%';
    currentUserBranchNumber = '';
    isSelected = false;
    spinner = false;

    columns = [
        {label: 'Case Number', fieldName: 'caseUrl', type: 'url', 
        typeAttributes: {
            label: {
               fieldName: 'caseNumber'}},
               target: '_blank'},
        {label: 'Created Date', fieldName: 'createdDate', type: 'date'},
        {label: 'Status', fieldName: 'caseStatus'},
    ];

    connectedCallback() {
        this.populateCaseRecords();
        this.registerErrorListener();
        this.subscribeOnCaseEvent();
    }

    populateCaseRecords() {
        if (this.currentUserBranchNumber === '') {
            getUserBranchNumber({ currentUserId: userId }).then(result => {
                this.currentUserBranchNumber = result;
                this.getCaseRecords();
            }).catch(error => {
                console.log('Error on getting user branch number: ', error);
            });
        } else {
            this.getCaseRecords();
        }
    }

    getCaseRecords() {
        getCases({branchNumber: this.currentUserBranchNumber}).then(result => {
            this.data = result.map(caseRecord => {
                return {
                    caseNumber: caseRecord.CaseNumber,
                    caseUrl: `/${caseRecord.Id}`,
                    createdDate: caseRecord.CreatedDate,
                    caseStatus: caseRecord.Status
                }
            })
        }).catch(error => {
            console.error('Error on populating Case records! Error -> ' + error);
        });
    }

    async subscribeOnCaseEvent() {
        await subscribe(this.channelName, -1, (result) => {
            const response = JSON.parse(JSON.stringify(result));
            if (response.data.payload.Case_Branch_Number__c === this.currentUserBranchNumber) {
                this.soundNotification();
                this.populateCaseRecords();
            }
        });
    }

    soundNotification() {
        let sound = new Audio(soundNotification);
        sound.load();
        sound.play();
    }

    getSelectedRow(event) {
        this.columnSize = 'width: 50%';
        this.caseId = event.detail.selectedRows[0].caseUrl.split('/')[1];
        if (event.detail.selectedRows[0].caseStatus !== 'In Progress') {
            this.isSelected = false;
            this.spinner = true;
            updateCase({ caseId: this.caseId })
            .then(() => {
                this.spinner = false;
                this.isSelected = true;
                this.updateStatusOnDataTable(event.detail.selectedRows[0].caseNumber);
            })
            .catch((e) => {
                console.error(e)
            });
        } else {
            this.isSelected = true;
        }
    }

    updateStatusOnDataTable(caseNumber) {
        this.data.forEach(function(caseData, index){
            if (caseData.caseNumber === caseNumber) {
                this[index].caseStatus = 'In Progress';
            }
        }, this.data);
    }

    closeDetails() {
        this.columnSize = 'width: 100%';
        this.isSelected = false;
        this.caseId = '';
    }

    registerErrorListener() {
        onError((error) => {
            console.log('Received error from server: ', JSON.stringify(error));
        });
    }
}