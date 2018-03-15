/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class TrailheadReceiver{
    static string NAME_START_TAG = '<h1 data-test-user-name="true" data-reactid="2">';
    static string NAME_END_TAG = '</h1>';
    
    static string TITLE_START_TAG = '<h2 data-test-user-work-info="true" data-reactid="3">';
    static string TITLE_END_TAG = '</h2>';

    static string BADGE_START_TAG = '<div class=\'user-information__achievements-data\' data-test-badges-count>';
    static string BADGE_END_TAG = '</div>';
    
    static string POINTS_START_TAG = '<div class=\'user-information__achievements-data\' data-test-points-count>';
    static string POINTS_END_TAG = '</div>';
    
    static string PROFILEURL_START_TAG = '<img class="user-information__avatar-img" src="';
    static string PROFILEURL_END_TAG = '" alt="';
    
    static string RANK_START_TAG = '/assets/ranks/';
    static string RANK_END_TAG = '-';
        
    public string name;
    public string title;
    public integer Badges;
    public integer Points;
    public string profileUrl;
    public string rank;
    public integer statusCode;
    
    public TrailheadReceiver( string endpoint ){
        doTrailheadCall(endpoint);
    }
    
    private void doTrailheadCall(string endpoint){
        HttpResponse response = APIHelper.genericGetCall(endpoint);
        statusCode = response.getStatusCode();
        
        if( statusCode == 200 ){
            string body = response.getBody();
            name = getName(body);
            title = getTitle(body);
            Badges = getBadges(body);
            Points = getPoints(body);
            profileUrl = getProfileUrl(body);
            rank = getRank(body);
            if( profileUrl.contains('astro-vatar') ){
                profileUrl = 'https://developer.salesforce.com/resource/images/trailhead/offers/Astro+with+badge.png';
            }
        }
    }
    
    private string getName(string response){
        integer StIndex = response.indexOf(NAME_START_TAG); 
        if( StIndex != -1 ){
            return response.subString( StIndex+NAME_START_TAG.length() , response.indexOf( NAME_END_TAG, StIndex+NAME_START_TAG.length()+1) );
        }
        return '';
    }
    
    private string getTitle(string response){
        integer StIndex = response.indexOf(TITLE_START_TAG); 
        if( StIndex != -1 ){
            integer endIndex = response.indexOf( TITLE_END_TAG, StIndex+TITLE_START_TAG.length()+1);
            if( endIndex != -1 ){
                return response.subString( StIndex+TITLE_START_TAG.length() , endIndex );
            }
        }
        return '';
    }
    
    private integer getBadges(string response){
        integer StIndex = response.indexOf(BADGE_START_TAG); 
        if( StIndex != -1 ){
            return integer.valueOf( response.subString( StIndex+BADGE_START_TAG.length() , response.indexOf( BADGE_END_TAG, StIndex+BADGE_START_TAG.length()+1) ).normalizeSpace() );
        }
        return 0;
    }
    
    private integer getPoints(string response){
        integer StIndex = response.indexOf(POINTS_START_TAG); 
        if( StIndex != -1 ){
            system.debug('==='+response.subString( StIndex+POINTS_START_TAG.length() , response.indexOf( POINTS_END_TAG, StIndex+POINTS_START_TAG.length()+1) ).replaceAll(',','')+'===');
            return integer.valueOf( response.subString( StIndex+POINTS_START_TAG.length() , response.indexOf( POINTS_END_TAG, StIndex+POINTS_START_TAG.length()+1) ).replaceAll(',','').normalizeSpace() );
        }
        return 0;
    }
    
    private string getProfileUrl(string response){
        integer StIndex = response.indexOf(PROFILEURL_START_TAG); 
        if( StIndex != -1 ){
            integer endIndex = response.indexOf( PROFILEURL_END_TAG, StIndex+PROFILEURL_START_TAG.length()+1);
            if( endIndex != -1 ){
                return response.subString( StIndex+PROFILEURL_START_TAG.length() , endIndex );
            }
        }
        return '';
    }
    
    private string getRank(string response){
        integer StIndex = response.indexOf(RANK_START_TAG); 
        if( StIndex != -1 ){
            return response.subString( StIndex+RANK_START_TAG.length() , response.indexOf( RANK_END_TAG, StIndex+RANK_START_TAG.length()+1) );
        }
        return '';
    }
}