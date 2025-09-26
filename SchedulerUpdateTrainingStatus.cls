public with sharing class SchedulerUpdateTrainingStatus implements Schedulable {
    public void execute(SchedulableContext sc){
        Database.executeBatch(new BatchUpdateTrainingStatus(), 200);
    }
}