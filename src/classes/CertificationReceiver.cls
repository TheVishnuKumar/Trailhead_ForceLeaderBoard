/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class CertificationReceiver{
    static string CERT_START_TAG = '<div class="ver-search-results-line">';
    static string CERT_END_TAG = '</div>';
    
    public list<CertificationWrapper> lstCerti;
    public integer statusCode;
    
    public CertificationReceiver( string endpoint ){
        doCertificationCall(endpoint);
    }
    
    private void doCertificationCall(string endpoint){
        HttpResponse response = APIHelper.genericGetCall(endpoint);
        statusCode = response.getStatusCode();
        lstCerti = new list<CertificationWrapper>();
        
        if( statusCode == 200 ){            
            fetchCertificates(response.getBody());
        }
    }
    
    private void fetchCertificates(string response){
        integer StIndex = 0;
        while(true){
            StIndex = response.indexOf(CERT_START_TAG, StIndex+1); 
            if( StIndex != -1 ){
                string result = response.subString( StIndex+CERT_START_TAG.length() , response.indexOf( CERT_END_TAG, StIndex+CERT_START_TAG.length()+1) );
                
                string certAndDate = result.stripHtmlTags();
                list<string> lstBySpace = certAndDate.trim().split(' ');
                string name = '';
                for( integer i = 0; i <=lstBySpace.size()-4 ;i++){
                    name += lstBySpace[i] +' ';
                }
                
                lstCerti.add( new CertificationWrapper(name) );
            }
            else{
                break;
            }
        }
    }
    
    public class CertificationWrapper{
        public string name;
        
        public CertificationWrapper(string name){
            this.name = name;
        }
    }
}