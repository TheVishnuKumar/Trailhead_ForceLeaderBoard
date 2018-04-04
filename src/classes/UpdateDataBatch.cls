/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
global class UpdateDataBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Schedulable{
    global Integer intervalInMinutes { get; set; }

    global UpdateDataBatch(){
        this.intervalInMinutes = 10;
    }
    
    global void execute(SchedulableContext SC) {
        UpdateDataBatch nextBatch = new UpdateDataBatch();
        nextBatch.intervalInMinutes = this.intervalInMinutes;
        database.executebatch(nextBatch, 1);
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator( [select Name__c ,Title__c ,Profile_URL__c ,Badges__c ,Points__c, Trailblazer_ID__c ,
                                        Trailhead_URL__c ,Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,name, Rank__c  from user__c where Trailhead_URL__c!=null ] );
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        UpdateDataHelper pdh = new UpdateDataHelper((user__c)scope[0]);
    }
    
    global void finish(Database.BatchableContext BC){
        Utility.startUpdateDataBatch(this.intervalInMinutes);
    }
}