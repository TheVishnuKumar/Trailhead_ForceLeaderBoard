/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class HeaderComponent{
    public user__c usrObj{get;set;}

    public HeaderComponent(){
        init();
    }
    
    public void init(){
        Session.UserWrapper uw = Session.getSession();
        usrObj = new user__c();
        
        if( uw != null ){
            list<user__c> lstUser = [select username__c,password__c,name__c from user__c where username__c =: uw.username ];
            
            if( !lstUser.isEmpty() ){
                if( lstUser[0].password__c == uw.password ){
                    usrObj = lstUser[0];
                }
            }
        }
    }
}