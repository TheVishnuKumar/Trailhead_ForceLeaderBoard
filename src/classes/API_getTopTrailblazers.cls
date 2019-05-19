/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
@RestResource(urlMapping='/getTopTrailblazers/*')
global class API_getTopTrailblazers {

    @HttpGet
    global static void getTopTrailblazers() {
        RestResponse res = RestContext.response;
        res.addHeader('Access-Control-Allow-Origin', '*');
        res.addHeader('Content-Type', 'application/json');

        Top5Trailblazers top5 = new Top5Trailblazers();
        
        for( user__c usr : [Select Name__c ,Weekly_Goal__c,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,Weekly_Earned__c,
                        Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null AND active__c = true order by Badges__c desc Nulls last,Points__c  desc,Certifications__c desc limit 5] ){
            top5.lstTopBadgeUsers.add( new TrailblazerWrapper(usr) );
        }
        
        for( user__c usr : [Select Name__c ,Weekly_Goal__c,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,Weekly_Earned__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null AND active__c = true  order by Points__c  desc  Nulls last,Badges__c desc,Certifications__c desc limit 5] ){
            top5.lstTopPointsUsers.add( new TrailblazerWrapper(usr) );
        }
        
        for( user__c usr : [Select Name__c ,Weekly_Goal__c,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,Weekly_Earned__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null AND active__c = true  AND Certifications__c > 0 order by Certifications__c desc, Badges__c desc ,Points__c desc  limit 5] ){
            top5.lstTopCertUsers.add( new TrailblazerWrapper(usr) );
        }
        
        for( user__c usr : [Select Name__c ,Weekly_Goal__c,Title__c ,Profile_URL__c ,Badges__c ,Points__c ,Trailhead_URL__c , Certifications__c,Website_Name__c,Website_URL__c,Website_Description__c,Weekly_Earned__c,
                            Certification_URL__c ,Facebook__c ,Linkedin__c ,Twitter__c ,Rank__c,name from User__c where name__c != null AND active__c = true  order by Weekly_Earned__c desc Nulls last, Badges__c desc Nulls last ,Points__c desc  limit 5] ){
            top5.lstTopCertWeekly.add( new TrailblazerWrapper(usr) );
        }
        
        res.responseBody = Blob.valueOf(JSON.serialize(top5));
    }
    
    
    
    global class Top5Trailblazers{
        global list<TrailblazerWrapper> lstTopCertWeekly{get;set;}
        global list<TrailblazerWrapper> lstTopBadgeUsers{get;set;}
        global list<TrailblazerWrapper> lstTopPointsUsers{get;set;}
        global list<TrailblazerWrapper> lstTopCertUsers{get;set;}
        
        
        global Top5Trailblazers(){
            lstTopBadgeUsers = new list<TrailblazerWrapper>();
            lstTopPointsUsers = new list<TrailblazerWrapper>();
            lstTopCertUsers = new list<TrailblazerWrapper>();
            lstTopCertWeekly = new list<TrailblazerWrapper>();
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