/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
@RestResource(urlMapping='/GetUserId/*')
global class API_GetUserId {

    @HttpGet
    global static void getTrailblazerId() {
        RestResponse res = RestContext.response;
        
        try{          
            res.addHeader('Access-Control-Allow-Origin', '*');
            res.addHeader('Content-Type', 'application/json');
                        
            String username = RestContext.request.params.get('username');
            String password = RestContext.request.params.get('password');
            
            UserWrapper uw = new UserWrapper();
            
            try{
                list<user__c> lstUser = [select username__c,password__c,active__c from user__c where username__c =: username ];
                
                if( !lstUser.isEmpty() ){
                    if( lstUser[0].password__c == password ){
                        uw.message = 'Logged in successfully.';
                        uw.userId = lstUser[0].id;
                    }
                    else{
                        uw.message = 'Password is incorrect.';
                    }
                }
                else{
                    User__c newUser = new User__c();
                    newUser.username__c = username;
                    newUser.password__c = password;
                    insert newUser;
                    
                    uw.message = 'Welcome to the Trailhead and Certification board!!!!';
                    uw.userId = newUser.id;
                }
            }
            catch(Exception e){
                uw.message = 'Error: '+e.getMessage();
            }
            res.responseBody = Blob.valueOf(JSON.serialize(uw));
        }
        catch(Exception e){
            UserWrapper uw = new UserWrapper();
            uw.message = 'Error: '+e.getMessage();
            res.responseBody = Blob.valueOf(JSON.serialize(uw));
        }
    }
    
    global class UserWrapper{        
        global string UserId{get;set;}
        global string message;
    }
}