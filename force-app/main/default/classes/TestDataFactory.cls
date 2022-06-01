@isTest
public class TestDataFactory {
    
    public static List<Account> createAccounts(Integer numOfAccounts){
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0;i<numOfAccounts;i++){
            testAccounts.add(new Account(
                Name='OkAccount'+i,
                Account_level__c='Neutral'
            ));
        }
        return testAccounts;
    }

    public static List<Contract> createContracts(Integer numOfContracts, List<Account> testAccounts){
        List<Contract> testContracts = new List<Contract>();
        for(Integer i=0;i<numOfContracts;i++){
            testContracts.add(new Contract(
                AccountId = testAccounts[i].Id,
                ContractTerm = 12,
                Status = 'Draft',
                StartDate = Date.today()
            ));
        }
        return testContracts;
    }

    public static ContentVersion createContentVersion(){
        ContentVersion contentVersion = new ContentVersion();
        Blob body = Blob.valueof('lala');
        contentVersion.ContentLocation = 'S';
        contentVersion.PathOnClient = 'Document.txt';
        contentVersion.Title = 'Document';
        contentVersion.VersionData = body;
        contentVersion.Document_Type__c = 'Contract';
        return contentVersion;
    }

    public static ContentDocumentLink createContentDocumentLink(Id accountId, Id contentDocumentId){
        ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
        contentDocumentLink.ContentDocumentId = contentDocumentId;
        contentDocumentLink.LinkedEntityId = accountId;
        contentDocumentLink.ShareType = 'I';
        contentDocumentLink.Visibility = 'AllUsers';
        return contentDocumentLink;
    }
}
