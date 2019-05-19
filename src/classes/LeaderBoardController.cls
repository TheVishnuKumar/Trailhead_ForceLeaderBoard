/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class LeaderBoardController{
    public list<UserWrapper> lstUsers{get;set;}
    public string sortBy{get;set;}
    public LeaderBoard_Settings__c lbSettings{get;set;}
    
    public LeaderBoardController(){
        sortBy = 'Weekly_Earned__c';
        doSearch();
    }
    
    private void init(){
        lstUsers = new list<UserWrapper>();
        string query = 'select Name__c ,Title__c ,Last_Earned_Badges__c,Weekly_Earned__c,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c, Website_Name__c,Website_URL__c,Website_Description__c,'+
                       'Certification_URL__c ,Weekly_Goal__c,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from user__c where name__c != null AND active__c = true order by '+sortBy +' DESC NULLS LAST,Badges__c desc NULLS LAST  limit 1000';
                       
        for( user__c usr : Database.query(query) ){
        
            lstUsers.add( new UserWrapper(usr) );
        }
        
        lbSettings = [select id, Last_Reset_Date__c from LeaderBoard_Settings__c limit 1];
    }
    
    public void doSearch(){
        init();
    }
    
    public class UserWrapper{
        public user__c usrObj{get;set;}
        public decimal achievedWeeklyGoal{get;set;}
        
        public UserWrapper(user__c usrObj){
            this.usrObj = usrObj;
            
            if( usrObj.Weekly_Goal__c != null && usrObj.Weekly_Goal__c != 0 && usrObj.Weekly_Earned__c != null ){
                AchievedWeeklyGoal =  ((usrObj.Weekly_Earned__c/usrObj.Weekly_Goal__c)*100).setScale(2) ;
            }
        }
    }
}