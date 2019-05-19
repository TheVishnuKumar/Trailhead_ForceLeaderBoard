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
        usrObj = new user__c();
    }
}