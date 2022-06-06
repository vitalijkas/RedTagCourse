@isTest
private class ContractTriggerHanlderTest {
    private static final Integer OBJECT_NUMBER = 2;

    @TestSetup static void testSetup(){
        List<Account> testAccounts = TestDataFactory.createAccounts(OBJECT_NUMBER);
        insert testAccounts;
        List<Contract> testContracts = TestDataFactory.createContracts(testAccounts.size(), testAccounts);
        insert testContracts;
        
        ContentVersion testContentVersion = TestDataFactory.createContentVersion();
        insert testContentVersion;
        ContentVersion testContentVersionDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: testContentVersion.Id];
        ContentDocumentLink testContentDocumentLink = TestDataFactory.createContentDocumentLink(testContracts.get(0).Id, testContentVersionDocumentId.ContentDocumentId);
        insert testContentDocumentLink;
    }

    @isTest static void validationWithCorrectDataTest(){ 
        Contract testContract = [SELECT Id, Status FROM Contract LIMIT 1];
        testContract.Status = 'Activated';

        Test.StartTest();
            update testContract;
        Test.StopTest();

        Contract ct = [SELECT Id, Status FROM Contract WHERE Id =: testContract.Id];

        System.assert(ct.Status.contains('Activated'));
    }

    @isTest static void validationWithIncorrectDataTest(){
        Contract testContract = [SELECT Id, Status FROM Contract LIMIT 1];
        ContentDocumentLink testContentDocumentLink = [
            SELECT ContentDocumentId 
            FROM ContentDocumentLink 
            WHERE LinkedEntityId =: testContract.Id];
        ContentVersion testContentVersion = [
            SELECT Document_Type__c
            FROM ContentVersion 
            WHERE ContentDocumentId =: testContentDocumentLink.ContentDocumentId];
        
        testContentVersion.Document_Type__c = 'Invoice';
        update testContentVersion;

        testContract.Status = 'Activated';
        try{
            update testContract;
        }catch(DMLException unexpectedException){
            System.assertEquals(unexpectedException.getDmlMessage(0), 'You didnt add Document or Document Type is not Contract!');
        }
    }

    @isTest static void validationWithoutFileTest(){
        List<Contract> testContracts = [SELECT Id, Status FROM Contract LIMIT 2];

        for(Contract ct : testContracts){
            ct.Status = 'Activated';
        }
        
        try{
            update testContracts;
        }catch(DMLException unexpectedException){
            System.assertEquals(unexpectedException.getDmlMessage(0), 'You didnt add Document or Document Type is not Contract!');
        }
    }
}
