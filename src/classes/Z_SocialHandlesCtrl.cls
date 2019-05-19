Public Class Z_SocialHandlesCtrl{
    public string twitterNames{get;set;}
    
    public void getAllTwitter(){
        twitterNames = '';
        fillString( filldata([select id, Twitter__c  from User__c where Twitter__c  != null ]) );
    }
    
    public void top5(){
        set<string> setOfnm = filldata([select id, Twitter__c  from User__c where Twitter__c  != null AND name__c != null order by Badges__c desc,Points__c  desc,Certifications__c desc limit 5 ]);
        setOfnm.addAll( filldata([select id, Twitter__c  from User__c where Twitter__c  != null AND name__c != null order by Points__c  desc,Badges__c desc,Certifications__c desc limit 5]) );
        setOfnm.addAll( filldata([select id, Twitter__c  from User__c where Twitter__c  != null AND name__c != null AND Certifications__c > 0 order by Certifications__c desc, Badges__c desc ,Points__c desc  limit 5]) );
        setOfnm.addAll( filldata([select id, Twitter__c  from User__c where Twitter__c  != null AND name__c != null AND Weekly_Earned__c > 0 order by Weekly_Earned__c desc, Badges__c desc ,Points__c desc  limit 5]) );

        fillString(setOfnm);
    }
    
    private set<string> filldata( list<User__c> lstUser ){        
        set<string> setOfName = new set<string>();
        for( user__c u : lstUser ){
            string tw = u.Twitter__c;
            string tname = tw.substring(tw.indexOf('.com/')+5,tw.length());
            setOfName.add('@'+tname);
        }
        return setOfName; 
    }
    
    private void fillString( set<string> setOfName ){
        string temp = '';
        for( string tname : setOfName ){
            temp += tname+' ';
            
            if( temp.length() > 260 ){
                twitterNames += temp + '\n\n';
                temp = '';
            } 
        }
        
        if( temp != '' ){
            twitterNames += temp + '\n\n';
        }
    }
}