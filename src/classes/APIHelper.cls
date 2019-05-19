/*
    Created By            :    Vishnu Kumar
    Website               :    http://0to1code.com/
*/
public class APIHelper{
    
    public static HttpResponse genericGetCall(string endPoint){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endPoint);
        request.setMethod('GET');
        request.setTimeout(60000);
        return http.send(request);
    } 
}