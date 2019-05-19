/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class UpdateDataHelper{
    
    public UpdateDataHelper(User__c userObj){
        init(userObj);
    }
    
    private void init(User__c userObj){
        
        //Updating trailhead data
        if( string.isNotBlank( userObj.Trailhead_URL__c ) ){
            TrailheadReceiver thr = new TrailheadReceiver(userObj.Trailhead_URL__c);
            system.debug('-thr.statusCode--'+thr.statusCode);
            if( thr.statusCode == 200 ){
                userObj.Name__c = thr.name != '' ? thr.name : userObj.name;
                userObj.Title__c = thr.title != '' ? thr.title : userObj.Title__c;
                userObj.Badges__c = thr.badges != 0 ? thr.badges : userObj.Badges__c;
                userObj.Points__c = thr.points != 0 ? thr.points : userObj.Points__c;
                userObj.Profile_URL__c = thr.profileUrl != '' ? thr.profileUrl : userObj.Profile_URL__c ;
                userObj.rank__c = thr.rank;
                userObj.Trailblazer_ID__c = string.isNotBlank(userObj.Trailblazer_ID__c) ? userObj.Trailblazer_ID__c : Utility.generateRandomString(18);
            }
        }
        
        //Updating certification data
        if( String.isNotBlank(userObj.Certification_URL__c) ){
            CertificationReceiver cer = new CertificationReceiver(userObj.Certification_URL__c);
            if( cer.statusCode == 200 ){
                //Delete Existing certificates
                delete [select id, Name__c from Certification__c where user__c =: userObj.id ];
                
                //Inserting
                list<Certification__c> instCert = new list<Certification__c>();
                if( !cer.lstCerti.isEmpty() ){
                    for( CertificationReceiver.CertificationWrapper cw : cer.lstCerti ){
                        instCert.add( new Certification__c(user__c=userObj.id, name__c = cw.name ) );
                    }
                }
                
                if( !instCert.isEmpty() ){
                    insert instCert;
                }
            }
        }
        
        update userObj;
    }
}