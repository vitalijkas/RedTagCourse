import { LightningElement, api } from 'lwc';
import getContacts from '@salesforce/apex/GetContactsController.getContacts'


export default class CustomContactsView extends LightningElement {
    @api label;
    data = [];
    columns = [
        {label: 'First Name', fieldName:'ContactUrl', type: 'url', 
        typeAttributes: {
             label: {
                fieldName: 'FirstName'}},
                target: '_blank'},
        {label: 'Last Name', fieldName:'LastName'},
        {label: 'Email', fieldName:'Email', type: 'email'}
    ];

    async connectedCallback(){   
        getContacts().then(result => {
            this.data = result.map(cont => {
                return {
                    FirstName: cont.FirstName,
                    ContactUrl: `/${cont.Id}`,
                    LastName: cont.LastName,
                    Email: cont.Email
                }
            })
        }).catch(error => {
            console.error(error);
        });
        console.log('shoenge');
    }
}