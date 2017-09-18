public class CalloutClass {
    
    public static final String GET_SECURITY_TOKEN_URL = 'https://login.salesforce.com/services/oauth2/token';
    
    
    public static HttpResponse getInfoFromExternalService() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(GET_SECURITY_TOKEN_URL);
        req.setMethod('POST');
        Http h = new Http();
        HttpResponse res = h.send(req);
        return res;
    }
}