/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class TrailblazersBlogController{
    public list<UserWrapper> lstUsers{get;set;}
    
    public TrailblazersBlogController(){
        init();
    }
    
    private void init(){
        lstUsers = new list<UserWrapper>();
        string query = 'select Name__c ,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c, Website_Name__c,Website_URL__c,Website_Description__c, Website_Logo_URL__c,'+
                       'Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from user__c where name__c != null AND Website_URL__c != null AND Website_Description__c != null AND Website_Name__c != null order by Badges__c DESC NULLS LAST limit 1000';
                       
        for( user__c usr : Database.query(query) ){
            lstUsers.add( new UserWrapper(usr) );
        }
    }

    public class UserWrapper{
        public user__c usrObj{get;set;}
        
        public UserWrapper(user__c usrObj){
            this.usrObj = usrObj;
        }
    }
}