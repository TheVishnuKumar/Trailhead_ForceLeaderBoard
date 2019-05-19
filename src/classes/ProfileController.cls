/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class ProfileController{
    public user__c usrObj{get;set;}
    public string userId{get;set;}
    
    public ProfileController(){
        usrObj = new user__c();
    }
    
    public void init(){
        if( string.isNotBlank(userId) ){
            usrObj = [select Name__c ,Title__c ,Profile_URL__c, active__c,Badges__c ,Points__c , Certifications__c, Username__c, Password__c, Website_Name__c, Website_Description__c,
                      Website_URL__c, Website_Logo_URL__c,
                      Trailhead_URL__c ,Certification_URL__c ,Weekly_Goal__c, Trailblazer_ID__c ,Facebook__c ,Linkedin__c ,Twitter__c ,name, Rank__c  from user__c where id =: userId ];
        }
        else{
            usrObj = new user__c();
        }        
    }
    
    public void login(){
        try{
            list<user__c> lstUser = [select username__c,password__c,active__c from user__c where username__c =: usrObj.username__c ];
            
            if( !lstUser.isEmpty() ){
                if( lstUser[0].password__c == usrObj.password__c ){
                    userId = lstUser[0].id;
                    PageMessage.addMessage(PageMessage.INfo, 'Logged in successfully.' );
                    PageMessage.addMessage(PageMessage.INfo, 'Seesion will be destroyed if you refresh the page. In this case please login again.' );
                    init();
                }
                else{
                    PageMessage.addMessage(PageMessage.Error, 'Password is incorrect.' );
                }
            }
            else{
                insert usrObj;
                userId = usrObj.id;
                PageMessage.addMessage(PageMessage.INfo, 'Welcome to the Trailhead and Certification board!!!!' );
                PageMessage.addMessage(PageMessage.INfo, 'Seesion will be destroyed if you refresh the page. In this case please login again.' );

                init();
            }
        }
        catch(Exception e){
            PageMessage.addMessage(PageMessage.Error, e.getMessage() );
        }
    }
    
    public PageReference logout(){
        PageReference pg = new PageReference('/apex/home');
        pg.setRedirect(true);
        return pg;
    }
    
    public void save(){
        try{
            usrObj.active__c =true;
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