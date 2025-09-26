public with sharing class TrainingService {
    
    @AuraEnabled(cacheable=true)
    public static List<Training__c> getTrainings(Id contactId){
        return [SELECT Id, Course_Name__c, Status__c FROM Training__c WHERE Contact__c = :contactId];
    }

    @AuraEnabled
    public static void markCompleted(Id trainingId){
        Training__c t = [SELECT Id, Status__c FROM Training__c WHERE Id = :trainingId LIMIT 1];
        t.Status__c = 'Completed';
        update t;
    }
}