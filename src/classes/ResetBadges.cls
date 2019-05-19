/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
global class ResetBadges implements Database.Batchable<sObject>, Schedulable{
    
    global void execute(SchedulableContext SC) {
        database.executebatch(new ResetBadges(), 500);
    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator( [select Last_Earned_Badges__c, Badges__c from user__c where active__c = true  AND Trailhead_URL__c!=null ] );
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        LeaderBoard_Settings__c lbSettings = [select id, Last_Reset_Date__c from LeaderBoard_Settings__c limit 1];
        List<User__c> lstUsr = new List<User__c>();
        
        if( lbSettings.Last_Reset_Date__c.daysBetween(Date.Today())  >= 7 ){
            for( User__c usr : (List<User__c>)scope ){
                usr.Last_Earned_Badges__c = usr.Badges__c;
                lstUsr.add(usr);
            }
            lbSettings.Last_Reset_Date__c = Date.Today();
            update lbSettings;
            update lstUsr;
        }
    }
    
    global void finish(Database.BatchableContext BC){
    }
}