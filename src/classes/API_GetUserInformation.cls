/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
@RestResource(urlMapping='/GetUserInformation/*')
global class API_GetUserInformation {

    @HttpGet
    global static void getUserInformation() {
        RestResponse res = RestContext.response;
        res.addHeader('Access-Control-Allow-Origin', '*');
        res.addHeader('Content-Type', 'application/json');
        
        String uId = RestContext.request.params.get('userid');
        Trailblazer tb = new Trailblazer();
        
        list<user__c> lstUser = [select Name__c, Website_Description__c ,Website_Logo_URL__c,Weekly_Earned__c, Weekly_Goal__c ,Website_Name__c ,Website_URL__c ,Title__c ,Profile_URL__c ,Badges__c ,Points__c , Certifications__c, Username__c, Password__c,
                      Trailhead_URL__c ,Certification_URL__c , API_Usage__c ,Facebook__c ,Linkedin__c ,Twitter__c ,name, Rank__c,Trailblazer_ID__c  from user__c where id =: uId limit 1];
        
        if( lstUser.size() > 0 ){
            tb.TrailblazerID = lstUser[0].Trailblazer_ID__c;
            tb.Name = lstUser[0].name__c;
            tb.Title = lstUser[0].title__c;
            tb.Badges = lstUser[0].Badges__c;
            tb.Points = lstUser[0].Points__c;
            tb.Certifications = lstUser[0].Certifications__c;
            tb.Rank = lstUser[0].Rank__c;
            tb.Profile_Image = lstUser[0].Profile_URL__c;
            tb.Trailhead_URL = lstUser[0].Trailhead_URL__c;
            tb.Certification_URL = lstUser[0].Certification_URL__c;
            tb.Facebook = lstUser[0].Facebook__c;
            tb.Linkedin = lstUser[0].Linkedin__c;
            tb.Twitter = lstUser[0].Twitter__c;
            tb.Weekly_Earned = lstUser[0].Weekly_Earned__c;
            tb.Website_Name = lstUser[0].Website_Name__c;
            tb.Website_URL = lstUser[0].Website_URL__c;
            tb.Weekly_Goal = lstUser[0].Weekly_Goal__c;
            tb.Website_Description = lstUser[0].Website_Description__c;
            tb.Website_Logo_URL = lstUser[0].Website_Logo_URL__c;
            
            res.responseBody = Blob.valueOf(JSON.serialize(tb));
        }            
    }
    
    global class Trailblazer{
        global string TrailblazerID;
        global string Name;
        global string Title;
        global Decimal Badges;
        global Decimal Points;
        global Decimal Certifications;
        global string Rank;
        global string Profile_Image;
        global string Trailhead_URL;
        global string Certification_URL;
        global string Facebook;
        global string Linkedin;
        global string Twitter;
        global string Website_Name;
        global string Website_Description;
        global string Website_URL;
        global Decimal Weekly_Goal;
        global Decimal Weekly_Earned;
        global string Website_Logo_URL;
    }
}