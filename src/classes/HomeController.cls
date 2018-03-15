/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class HomeController{
    public list<UserWrapper> lstTopBadgeUsers{get;set;}
    public list<UserWrapper> lstTopPointsUsers{get;set;}
    public list<UserWrapper> lstTopCertUsers{get;set;}
    public integer totalActiveUsers{get;set;}

    public HomeController(){
        totalActiveUsers = 0;
        init();
    }
    
    private void init(){
        lstTopBadgeUsers = new list<UserWrapper>();
        lstTopPointsUsers = new list<UserWrapper>();
        lstTopCertUsers = new list<UserWrapper>();
      
        for( user__c usr : [Select Name__c ,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null order by Badges__c desc,Points__c  desc,Certifications__c desc limit 5] ){
            lstTopBadgeUsers.add( new UserWrapper(usr) );
        }
        
        for( user__c usr : [Select Name__c ,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null order by Points__c  desc,Badges__c desc,Certifications__c desc limit 5] ){
            lstTopPointsUsers.add( new UserWrapper(usr) );
        }
        
        for( user__c usr : [Select Name__c ,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null AND Certifications__c > 0 order by Certifications__c desc, Badges__c desc ,Points__c desc  limit 5] ){
            lstTopCertUsers.add( new UserWrapper(usr) );
        }
    }
    

    
    public class UserWrapper{
        public user__c usrObj{get;set;}
        
        public UserWrapper(user__c usrObj){
            this.usrObj = usrObj;
        }
    }
}