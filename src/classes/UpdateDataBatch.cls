/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
global class UpdateDataBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Schedulable{
    
    global void execute(SchedulableContext SC) {
        database.executebatch(new UpdateDataBatch(), 1);
    }


    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator( [select Name__c ,Title__c ,Profile_URL__c ,Badges__c ,Points__c, Trailblazer_ID__c ,
                                        Trailhead_URL__c ,Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,name, Rank__c  from user__c where active__c = true  AND Trailhead_URL__c!=null ] );
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        try{
        UpdateDataHelper pdh = new UpdateDataHelper((user__c)scope[0]);
        }
        catch(Exception e){}
    }
    
    global void finish(Database.BatchableContext BC){
        Utility.startUpdateDataBatch(10);
    }
}