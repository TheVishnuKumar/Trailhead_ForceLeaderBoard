/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class HomeController{
    public list<UserWrapper> lstTopBadgeUsers{get;set;}
    public list<UserWrapper> lstTopPointsUsers{get;set;}
    public list<UserWrapper> lstTopCertUsers{get;set;}
    public list<UserWrapper> lstTopCertWeekly{get;set;}
    public integer totalActiveUsers{get;set;}

    public HomeController(){
        totalActiveUsers = 0;
        init();
    }
    
    private void init(){
        lstTopBadgeUsers = new list<UserWrapper>();
        lstTopPointsUsers = new list<UserWrapper>();
        lstTopCertUsers = new list<UserWrapper>();
        lstTopCertWeekly = new list<UserWrapper>();
         
        for( user__c usr : [Select Name__c ,Weekly_Goal__c,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,Weekly_Earned__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null AND active__c = true order by Badges__c desc Nulls last,Points__c  desc,Certifications__c desc limit 5] ){
            lstTopBadgeUsers.add( new UserWrapper(usr) );
        }
        
        for( user__c usr : [Select Name__c ,Weekly_Goal__c,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,Weekly_Earned__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null AND active__c = true  order by Points__c  desc  Nulls last,Badges__c desc,Certifications__c desc limit 5] ){
            lstTopPointsUsers.add( new UserWrapper(usr) );
        }
        
        for( user__c usr : [Select Name__c ,Weekly_Goal__c,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,Weekly_Earned__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null AND active__c = true  AND Certifications__c > 0 order by Certifications__c desc, Badges__c desc ,Points__c desc  limit 5] ){
            lstTopCertUsers.add( new UserWrapper(usr) );
        }
        
        for( user__c usr : [Select Name__c ,Weekly_Goal__c,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,Weekly_Earned__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null AND active__c = true  order by Weekly_Earned__c desc Nulls last, Badges__c desc Nulls last ,Points__c desc  limit 5] ){
            lstTopCertWeekly.add( new UserWrapper(usr) );
        }
    }
    

    
    public class UserWrapper{
        public user__c usrObj{get;set;}
        public decimal achievedWeeklyGoal{get;set;}
        
        public UserWrapper(user__c usrObj){
            this.usrObj = usrObj;
            
            if( usrObj.Weekly_Goal__c != null && usrObj.Weekly_Goal__c != 0 && usrObj.Weekly_Earned__c != null ){
                achievedWeeklyGoal =  (usrObj.Weekly_Earned__c/usrObj.Weekly_Goal__c)*100 ;
            }
        }
    }
}