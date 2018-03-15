/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class PageMessage{
    public static final string ERROR = 'error';
    public static final string WARNING= 'warning';
    public static final string INFO = 'info';
    
    public static list<MessageWrapper> pageMsgs{get;set;}
    
    public static void addMessage(string errType , string msg){
        if( pageMsgs == null ){
            pageMsgs = new list<MessageWrapper>();
        }
        pageMsgs.add( new MessageWrapper( msg , errType ) ); 
    }
    
    public class MessageWrapper{
        public string message{get;set;}
        public string messageType{get;set;}
        
        public MessageWrapper( string message, string messageType ){
            this.message = message;
            this.messageType = messageType;
        }
    }
}