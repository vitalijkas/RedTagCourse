public with sharing class ContractService {
    
    public static void contractValidation(List<Contract> newContractsList, Map<Id, Contract> oldContractsMap){
        Set<Id> setContractIds = new Set<Id>();
        for(Contract ct : newContractsList){
            if(oldContractsMap.get(ct.Id).Status != ct.Status && ct.Status == 'Activated'){
                setContractIds.add(ct.Id);
            }
        }
        if(setContractIds.isEmpty()){
            return;
        }
        
        List<ContentDocumentLink> documentLinks = [
            SELECT ContentDocumentId, LinkedEntityId 
            FROM ContentDocumentLink 
            WHERE LinkedEntityId IN :setContractIds];
        Map<Id, Id> mapContractIdsByDocumentId = new Map<Id, Id>();
        for(ContentDocumentLink documentLink : documentLinks){
            if(!mapContractIdsByDocumentId.containskey(documentLink.ContentDocumentId)){
                mapContractIdsByDocumentId.put(documentLink.ContentDocumentId, documentLink.LinkedEntityId);
            }
        }
        
        List<ContentVersion> contentVersion = [
            SELECT Id, Document_Type__c, ContentDocumentId
            FROM ContentVersion 
            WHERE ContentDocumentId IN :mapContractIdsByDocumentId.keyset() AND IsLatest = true AND Document_Type__c = 'Contract'];
        Map<Id, Boolean> mapContractsValidated = new Map<Id, Boolean>();
        for(ContentVersion cv : contentVersion){
            if(mapContractIdsByDocumentId.containskey(cv.ContentDocumentId)){
                if(!mapContractsValidated.containskey(mapContractIdsByDocumentId.get(cv.ContentDocumentId))){
                    mapContractsValidated.put(mapContractIdsByDocumentId.get(cv.ContentDocumentId), true);
                }
            }
        }
        
        for(Contract ct : newContractsList){
            if(setContractIds.contains(ct.Id) && !mapContractsValidated.containskey(ct.Id)){
                ct.Id.addError('You didnt add Document or Document Type is not Contract!');
            }
        }
    }
}