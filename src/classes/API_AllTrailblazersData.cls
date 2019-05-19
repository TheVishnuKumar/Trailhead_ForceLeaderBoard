/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
@RestResource(urlMapping='/trailblazers/*')
global class API_AllTrailblazersData {

    @HttpGet
    global static void getTrailblazers() {
        try{
            RestResponse res = RestContext.response;
            res.addHeader('Access-Control-Allow-Origin', '*');
            res.addHeader('Content-Type', 'application/json');
                        
            String apiKey = RestContext.request.params.get('ApiKey');
            String SortBy = RestContext.request.params.get('SortBy');
            
            list<TrailblazerWrapper> trailblazers = new list<TrailblazerWrapper>();
            
            string query = 'select Name__c ,Title__c ,Last_Earned_Badges__c,Weekly_Earned__c,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c, Website_Name__c,Website_URL__c,Website_Description__c,'+
                           'Certification_URL__c ,Weekly_Goal__c,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from user__c where name__c != null AND active__c = true order by '+sortBy +' DESC NULLS LAST,Badges__c desc NULLS LAST  limit 1000';
            
            LeaderBoard_Settings__c lbSettings = [select id, Last_Reset_Date__c from LeaderBoard_Settings__c limit 1];


            for( user__c usr : Database.query(query) ){
                TrailblazerWrapper tbw = new TrailblazerWrapper(usr);
                Date d = lbSettings.Last_Reset_Date__c;
                tbw.Last_Reset = DateTime.newInstance(d.year(),d.month(),d.day()).format('dd-MM-yyyy');
                trailblazers.add( tbw );
            }
            
            res.responseBody = Blob.valueOf(JSON.serialize(trailblazers));
        }
        catch(Exception e){
            //return null;
        }
    }
    
    global class TrailblazerWrapper{        
        global decimal AchievedWeeklyGoal{get;set;}
        global string Name;
        global string Title;
        global Decimal Badges;
        global Decimal Points;
        global Decimal Certifications;
        global Decimal Weekly_Earned;
        global string Rank;
        global string Profile_Image;
        global string Trailhead_URL;
        global string Certification_URL;
        global string Facebook;
        global string Linkedin;
        global string Twitter;
        global string Website_Name;
        global string Website_URL;
        global string Last_Reset;
        global Decimal Weekly_Goal;
        
        public TrailblazerWrapper(user__c usrObj){
            
            Name = usrObj.name__c;
            Title = usrObj.title__c;
            Badges = usrObj.Badges__c;
            Points = usrObj.Points__c;
            Certifications = usrObj.Certifications__c;
            Rank = usrObj.Rank__c;
            Profile_Image = usrObj.Profile_URL__c;
            Trailhead_URL = usrObj.Trailhead_URL__c;
            Certification_URL = usrObj.Certification_URL__c;
            Facebook = usrObj.Facebook__c;
            Linkedin = usrObj.Linkedin__c;
            Twitter = usrObj.Twitter__c;
            Weekly_Earned = usrObj.Weekly_Earned__c;
            Website_Name = usrObj.Website_Name__c;
            Website_URL = usrObj.Website_URL__c;
            Weekly_Goal = usrObj.Weekly_Goal__c;
            
            if( usrObj.Weekly_Goal__c != null && usrObj.Weekly_Goal__c != 0 && usrObj.Weekly_Earned__c != null ){
                AchievedWeeklyGoal =  ((usrObj.Weekly_Earned__c/usrObj.Weekly_Goal__c)*100).setScale(2) ;
                
                if( AchievedWeeklyGoal > 100 ){
                    AchievedWeeklyGoal = 100;
                }
            }
        }
    }
}