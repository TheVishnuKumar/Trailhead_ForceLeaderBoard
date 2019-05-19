/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
@RestResource(urlMapping='/UpdateUserInformation/*')
global class API_UpdateUserInformation {

    @HttpPost
    global static void getUserInformation() {
        RestResponse res = RestContext.response;
        res.addHeader('Access-Control-Allow-Origin', '*');
        res.addHeader('Content-Type', 'application/json');
        
        try{
            Map<String, Object> mData = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());

            user__c u = new user__c();
            
            for( string fName : mData.keySet() ){
                if( fName == 'Id' ){
                    u.put(fName, (Id)mData.get(fName) );
                }
                else if( fName == 'Weekly_Goal__c' ){
                    u.put(fName, (Decimal)mData.get(fName) );
                }
                else{
                    u.put(fName, (String)mData.get(fName) );
                }
            }
            update u;
            res.responseBody = Blob.valueOf( JSON.serialize(mData) );
        }
        catch(Exception e){
            res.responseBody = Blob.valueOf( JSON.serialize(e.getMessage()) );
        }   
    }
}