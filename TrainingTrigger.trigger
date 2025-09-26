trigger TrainingTrigger on Training__c (after insert, after update) {
    if(Trigger.isAfter & Trigger.isInsert){
        TrainingTriggerHandler.afterInsert(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        TrainingTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
}