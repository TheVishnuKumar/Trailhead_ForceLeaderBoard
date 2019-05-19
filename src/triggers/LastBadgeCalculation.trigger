trigger LastBadgeCalculation on User__c (Before Update) {
    if( Trigger.isUpdate && Trigger.isBefore ){
        for( User__c usr : Trigger.New ){
            if( usr.Last_Earned_Badges__c == null ){
                usr.Last_Earned_Badges__c = usr.Badges__c;
            }
        }
    }
}