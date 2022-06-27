@isTest
private class PDFContractFromOppControllerTest {
    private static final Integer OBJECT_NUMBER = 1;

    @TestSetup static void testSetup(){
        List<Opportunity> testOpportunities = TestDataFactory.createOpportunities(OBJECT_NUMBER);
        insert testOpportunities;

        List<Account> testAccounts = TestDataFactory.createAccounts(OBJECT_NUMBER);
        insert testAccounts;

        List<Contract> testContracts = TestDataFactory.createContracts(testAccounts.size(), testAccounts);
        insert testContracts;

        List<Contact> testContacts = TestDataFactory.createContacts(OBJECT_NUMBER);
        insert testContacts;

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        List<User> testUsers = TestDataFactory.createUsers(OBJECT_NUMBER, p.Id);
        insert testUsers;
        
        testContracts.get(0).CompanySignedId = testUsers.get(0).Id;
        testContracts.get(0).CustomerSignedId = testContacts.get(0).Id;
        update testContracts;
        
        testOpportunities.get(0).ContractId = testContracts.get(0).Id;
        update testOpportunities;
    }

    @isTest static void testController(){
        Test.StartTest(); 
            Opportunity testOpportunity = [SELECT Id, ContractId FROM Opportunity LIMIT 1];
            ApexPages.StandardController sc = new ApexPages.StandardController(testOpportunity);
            PageReference pageRef = Page.PDFContractFromOpp;
            PDFContractFromOppController controller = new PDFContractFromOppController(sc);
            Test.setCurrentPage(pageRef);
        Test.StopTest();
        System.assertNotEquals(pageRef, null);
    }
}
