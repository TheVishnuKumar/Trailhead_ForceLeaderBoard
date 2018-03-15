/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class Session{
    
    public static void create(user__c usrObj){
        Cookie username = ApexPages.currentPage().getCookies().get('username');
        Cookie password = ApexPages.currentPage().getCookies().get('password');
    
        username = new Cookie('username', usrObj.username__c ,null,-1,false);
        password = new Cookie('password', usrObj.password__c ,null,-1,false);
        
        ApexPages.currentPage().setCookies(new Cookie[]{username});
        ApexPages.currentPage().setCookies(new Cookie[]{password});
    }
    
    public static UserWrapper getSession(){
        Cookie username = ApexPages.currentPage().getCookies().get('username');
        Cookie password = ApexPages.currentPage().getCookies().get('password');
        UserWrapper uw;
        
        if( username!=null && password != null ){
            uw = new UserWrapper();
            uw.username = username.getValue();
            uw.password = password.getValue();
        }
        
        return uw;
    }
    
    public static void destroy(){
        Cookie username = ApexPages.currentPage().getCookies().get('username');
        Cookie password = ApexPages.currentPage().getCookies().get('password');
    
        username = new Cookie('username', null ,null,-1,false);
        password = new Cookie('password', null ,null,-1,false);
        
        ApexPages.currentPage().setCookies(new Cookie[]{username});
        ApexPages.currentPage().setCookies(new Cookie[]{password});
    }
    
    public class UserWrapper{
        public string username;
        public string password;
    }
}