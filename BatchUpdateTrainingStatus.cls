public with sharing class BatchUpdateTrainingStatus implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        
        Date pre7Days = Date.today().addDays(-7);
        
        return Database.getQueryLocator([
            SELECT Id FROM Training__c 
            WHERE Status__c = 'In Progress'
            AND Course_Date__c < :pre7Days
        ]);

    }

    public void execute(Database.BatchableContext BC, List<Training__c> scope) {
        for(Training__c item : scope){
            item.Status__c = 'Completed';
        }
        if(!scope.isEmpty()){
            update scope;
        }
    }

    public void finish(Database.BatchableContext BC) {}
}