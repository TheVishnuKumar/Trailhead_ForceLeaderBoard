public class TweetUtil {
    public static final String[] SIGNATURE_KEYS = new String[]
        {'oauth_consumer_key', 
        'oauth_nonce', 
        'oauth_signature_method', 
        'oauth_timestamp', 
        'oauth_token', 
        'oauth_version', 
        'status'};
        
    public static final String[] OAUTH_KEYS = new String[]
        {'oauth_consumer_key',
        'oauth_nonce',
        'oauth_signature',
        'oauth_signature_method',
        'oauth_timestamp',
        'oauth_token',
        'oauth_version'};

    public String algorithmName {
        get {
            if(algorithmName == null)
                return 'hmacSHA1';
            return algorithmName;
        } 
        set;}
    public String oauth_signature_method {
        get {
            if(oauth_signature_method == null)
                return 'HMAC-SHA1';
            return oauth_signature_method;
        }
        set;}
    public String oauth_version {
        get {
            if(oauth_version == null)
                oauth_version = '1.0';
            return oauth_version;
        } 
        set;}          
    public String http_method {get; set;}
    public String base_url {get; set;}
    public String status {get; set;}
    public String oauth_consumer_key {get; set;}
    public String oauth_consumer_secret {get; set;}
    public String oauth_token {get; set;}
    public String oauth_token_secret {get; set;}
    
    public String oauth_nonce {get; private set;}
    public String oauth_signature {get; private set;}
    public String oauth_timestamp {
        get {
            if(oauth_timestamp == null)
                oauth_timestamp = String.valueOf(DateTime.now().getTime()/1000);
            return oauth_timestamp;
        }
        private set;}
    
    private map<String, String> signaturePairs {get; set;}
    private String parameterString {get; set;}
    private String signatureBaseString {get; set;}
    private String signingKey {get; set;}
    private String oauth_header {get; set;}
    private String http_body {get; set;}
    
    public TweetUtil() {}
    
    public TweetUtil(String oauth_consumer_key, String oauth_consumer_secret, String oauth_token, String oauth_token_secret) {
        this.oauth_consumer_key = oauth_consumer_key;
        this.oauth_consumer_secret = oauth_consumer_secret;
        this.oauth_token = oauth_token;
        this.oauth_token_secret = oauth_token_secret;
        system.debug('**** Created successfully');
    }
    
    public Boolean sendTweet(String status, map<String, String> additionalParams) {
        if(this.oauth_consumer_key == null ||
           this.oauth_consumer_secret == null ||
           this.oauth_token == null || 
           this.oauth_token_secret == null)
            return false;
        
        this.http_method = 'POST';
        this.base_url = 'https://api.twitter.com/1.1/statuses/update.json';
        this.status = status;
        generateNonce();
        initializeSignatureKeyValuePairs(additionalParams);
        generateOauthSignature();
        generateOauthHeader();
        generateHttpBody(additionalParams);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod(this.http_method);
        req.setEndpoint(this.base_url);
        req.setBody(this.http_body);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Content-Length', String.valueOf(req.getBody().length()));
        req.setHeader('Authorization', this.oauth_header);

        try {
            HttpResponse res = h.send(req);
            system.debug('**** Response: ');
            system.debug(res);
            system.debug(res.getBody());
            
            if(res.getStatusCode() == 200)
                return true;
            else 
                return false;
        } catch (CalloutException e) {
            return false;
        }
    }
    
    private void generateNonce() {
        String validChars = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        Integer len = validChars.length();
        String randomString = '';
        
        for(Integer i=0; i<32; i++) {
            Integer rInt = Integer.valueOf(Math.rint(Math.random()*(len-1)));
            randomString += validChars.substring(rInt, rInt+1);
        }
        this.oauth_nonce = randomString;
    }
    
    private void initializeSignatureKeyValuePairs(map<String, String> additionalParams) {
        this.signaturePairs = new map<String, String>();
        this.signaturePairs.put('status', this.status);
        this.signaturePairs.put('oauth_consumer_key', this.oauth_consumer_key);
        this.signaturePairs.put('oauth_nonce', this.oauth_nonce);
        this.signaturePairs.put('oauth_signature_method', this.oauth_signature_method);
        this.signaturePairs.put('oauth_timestamp', this.oauth_timestamp);
        this.signaturePairs.put('oauth_token', this.oauth_token);
        this.signaturePairs.put('oauth_version', this.oauth_version);
        if(additionalParams != null && additionalParams.keySet().size() > 0) {
            for(String key : additionalParams.keySet()) {
                if(!this.signaturePairs.containsKey(key) && additionalParams.get(key) != null) {
                    //system.debug('**** adding key: ' + key + ' and value: ' + additionalParams.get(key));
                    this.signaturePairs.put(key, additionalParams.get(key));
                    SIGNATURE_KEYS.add(key);
                }
            }
        }
        SIGNATURE_KEYS.sort();  //The keys have to be sorted when generating the signature
    }
    
    private void generateOauthSignature() {
        this.parameterString = createParameterString();
        this.signatureBaseString = createSignatureBaseString();
        this.signingKey = createSigningKey();
        this.oauth_signature = createOauthSignature();
    }
    
    private String createParameterString() {
        String paramString = '';
        system.debug(json.serializepretty(signaturePairs));
        for(String key : SIGNATURE_KEYS) {
            paramString += StringUtil.percentEncode(key);
            paramString += '=';
            paramString += StringUtil.percentEncode(signaturePairs.get(key));
            paramString += '&';
        }
        paramString = removeLastNLetters(paramString, 1);
        system.debug('**** Parameter String');
        system.debug(paramString);
        return paramString;
    }
    
    private String createSignatureBaseString() {
        String sigBase = '';
        sigBase += this.http_method.toUpperCase() ;
        sigBase += '&';
        sigBase += StringUtil.percentEncode(this.base_url);
        sigBase += '&';
        sigBase += StringUtil.percentEncode(this.parameterString);
        system.debug('**** Signature Base String');
        system.debug(sigBase);
        return sigBase;
    }
    
    private String createSigningKey() {
        String signKey = StringUtil.percentEncode(this.oauth_consumer_secret);
        signKey += '&';
        signKey += StringUtil.percentEncode(this.oauth_token_secret);
        system.debug('**** Signing Key');
        system.debug(signKey);
        return signKey;
    }
    
    private String createOauthSignature() {
        Blob mac = Crypto.generateMac(this.algorithmName, Blob.valueOf(this.signatureBaseString), Blob.valueOf(this.signingKey)); 
        string hashedValue = EncodingUtil.convertToHex(mac);
        String oauthSig = EncodingUtil.base64Encode(mac);
        system.debug('**** Hashed Value');
        system.debug(hashedValue);
        system.debug('**** Oauth Signature');
        system.debug(oauthSig);
        return oauthSig;  
    }
    
    private void generateOauthHeader() {
        map<String, String> oauthParams = new map<String, String>();
        oauthParams.put('oauth_consumer_key', this.oauth_consumer_key);
        oauthParams.put('oauth_nonce', this.oauth_nonce);
        oauthParams.put('oauth_signature', this.oauth_signature);
        oauthParams.put('oauth_signature_method', this.oauth_signature_method);
        oauthParams.put('oauth_timestamp', this.oauth_timestamp);
        oauthParams.put('oauth_version', this.oauth_version);
        oauthParams.put('oauth_token', this.oauth_token);
        String header = 'OAuth ';
        for(String key : OAUTH_KEYS) {
            header += StringUtil.percentEncode(key);
            header += '="';
            header += StringUtil.percentEncode(oauthParams.get(key));
            header += '", ';
        }
        this.oauth_header = removeLastNLetters(header, 2);
        system.debug('**** Oauth Header');
        system.debug(this.oauth_header);
    }
    
    private void generateHttpBody(map<String, String> additionalParams) {
        String httpBody = 'status='+EncodingUtil.urlEncode(this.status, 'UTF-8');
        if(additionalParams != null && additionalParams.keySet() != null) {
            for(String key : additionalParams.keySet()) {
                if(additionalParams.get(key) != null) {
                    httpBody += '&';
                    httpBody += EncodingUtil.urlEncode(key, 'UTF-8');
                    httpBody += '=';
                    httpBody += EncodingUtil.urlEncode(additionalParams.get(key), 'UTF-8');
                }
            }
        }
        this.http_body = httpBody.replace('*', '%2A'); //for some reason, '*' breaks twitter
        system.debug('**** Request Body: ');
        system.debug(this.http_body);
    }
    
    private static String removeLastNLetters(String source, Integer numToRemove) {
        return source.subString(0, source.length()-numToRemove);
    }
}

/*
//The following is an example of generating the sample oauth signature
String sigBS = 'POST&https%3A%2F%2Fapi.twitter.com%2F1%2Fstatuses%2Fupdate.json&include_entities%3D';
sigBS += 'true%26oauth_consumer_key%3Dxvz1evFS4wEEPTGEFPHBog%26oauth_nonce%3DkYjzVBB8Y0ZFabxSWbWovY';
sigBS += '3uYSQ2pTgmZeNu2VS4cg%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1318622958%';
sigBS += '26oauth_token%3D370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb%26oauth_version%3D1.0%';
sigBS += '26status%3DHello%2520Ladies%2520%252B%2520Gentlemen%252C%2520a%2520signed%2520OAuth%2520r';
sigBS += 'equest%2521';
String signKey = 'kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw&LswwdoUaIvS8ltyTt5jkRh4J50vUPVVHtR2YPi5kE';
Blob testMac = Crypto.generateMac('hmacSHA1', Blob.valueOf(sigBS), Blob.valueOf(signKey));
//this is the hex representation
//Should be: B6 79 C0 AF 18 F4 E9 C5 87 AB 8E 20 0A CD 4E 48 A9 3F 8C B6
String testHex = EncodingUtil.convertToHex(testMac);  
system.debug(testHex);

//this is the actual oauth signature
//Should be: tnnArxj06cWHq44gCs1OSKk/jLY=
String testSignature = EncodingUtil.base64Encode(testMac);  
system.debug(testSignature);

//percent encoded oauth signature
//Should be: tnnArxj06cWHq44gCs1OSKk%2FjLY%3D
String testSignaturePercentEncoded = StringUtil.percentEncode(testSignature);
system.debug(testSignaturePercentEncoded);  
*/