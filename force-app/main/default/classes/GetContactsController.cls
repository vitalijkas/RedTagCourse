public with sharing class GetContactsController {
    @AuraEnabled
    public static List<Contact> getContacts(){
        return [SELECT Id, FirstName, LastName, Email FROM Contact];
    }
}