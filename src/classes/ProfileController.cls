/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class ProfileController{
    public user__c usrObj{get;set;}
    public string userId{get;set;}
    
    public ProfileController(){
        Session.UserWrapper uw = Session.getSession();
        usrObj = new user__c();
        
        if( uw != null ){
            list<user__c> lstUser = [select username__c,password__c from user__c where username__c =: uw.username ];
            
            if( !lstUser.isEmpty() ){
                if( lstUser[0].password__c == uw.password ){
                    userId = lstUser[0].id;
                    init();
                }
            }
        }
    }
    
    public void init(){
        if( string.isNotBlank(userId) ){
            usrObj = [select Name__c ,Title__c ,Profile_URL__c ,Badges__c ,Points__c , Certifications__c, Username__c, Password__c, Website_Name__c, Website_Description__c,
                      Website_URL__c, Website_Logo_URL__c,
                      Trailhead_URL__c ,Certification_URL__c , Trailblazer_ID__c ,Facebook__c ,Linkedin__c ,Twitter__c ,name, Rank__c  from user__c where id =: userId ];
        }
        else{
            usrObj = new user__c();
        }        
    }
    
    public void login(){
        try{
            list<user__c> lstUser = [select username__c,password__c from user__c where username__c =: usrObj.username__c ];
            
            if( !lstUser.isEmpty() ){
                if( lstUser[0].password__c == usrObj.password__c ){
                    userId = lstUser[0].id;
                    Session.create(usrObj);
                    PageMessage.addMessage(PageMessage.INfo, 'Logged in successfully.' );
                    init();
                }
                else{
                    PageMessage.addMessage(PageMessage.Error, 'Password is incorrect.' );
                }
            }
            else{
                insert usrObj;
                userId = usrObj.id;
                Session.create(usrObj);
                PageMessage.addMessage(PageMessage.INfo, 'Welcome to the Trailhead and Certification board!!!!' );
                init();
            }
        }
        catch(Exception e){
            PageMessage.addMessage(PageMessage.Error, e.getMessage() );
        }
    }
    
    public PageReference logout(){
        Session.destroy();
        PageReference pg = new PageReference('/apex/home');
        pg.setRedirect(true);
        return pg;
    }
    
    public void save(){
        try{
            update usrObj;
            init();
        }
        catch(Exception e){
            PageMessage.addMessage(PageMessage.Error, e.getMessage() );
        }
    }
    
    public void initRefresh(){
        try{
            UpdateDataHelper udh = new UpdateDataHelper(usrObj);
            init();
        }
        catch(Exception e){
            PageMessage.addMessage(PageMessage.Error, e.getMessage() );
        }
    }
}