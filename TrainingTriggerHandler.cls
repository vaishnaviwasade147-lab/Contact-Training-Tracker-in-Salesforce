public with sharing class TrainingTriggerHandler {
    
    public static void afterInsert(List<Training__c> listNew){
        Map<Id,String> mapContactIds = new Map<Id,String>();
        for(Training__c item : listNew){
            mapContactIds.put(item.Contact__c,item.Status__c);
        }
        List<Contact> listContact = [SELECT Id,Training_Status__c FROM Contact WHERE Id IN :mapContactIds.keySet()];
        for(Contact item : listContact){
            if(mapContactIds.containsKey(item.Id)){
                item.Training_Status__c = mapContactIds.get(item.Id);
            }
        }
        if(!listContact.isEmpty()){
            update listContact;
        }
    }

    public static void afterUpdate(List<Training__c> listNew, Map<Id,Training__c> mapOld){
        Map<Id,String> mapContactIds = new Map<Id,String>();
        for(Training__c item : listNew){ // Status = 'Not Started' -> 'In Progress'
            Training__c oldRecord = mapOld.get(item.Id);
            if(item.Status__c != oldRecord.Status__c){
                mapContactIds.put(item.Contact__c,item.Status__c);
            }
        }
        List<Contact> listContact = [SELECT Id,Training_Status__c FROM Contact WHERE Id IN :mapContactIds.keySet()];
        for(Contact item : listContact){
            if(mapContactIds.containsKey(item.Id)){
                item.Training_Status__c = mapContactIds.get(item.Id);
            }
        }
        if(!listContact.isEmpty()){
            update listContact;
        }
    }
    
}