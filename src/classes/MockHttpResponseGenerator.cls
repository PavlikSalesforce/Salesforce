@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    
    public static final String GET_SECURITY_TOKEN_URL = 'https://login.salesforce.com/services/oauth2/token';
    public static final String CLIENT_ID_TOKEN = '3MVG9HxRZv05HarSc6AQ3WxfCE56G2Ri5t3UUn6vwTdREfPC50RqQeFGJ40Rbs6Lrzc3PJE4v6zHjqBaTXjTi';
    public static final String CLIENT_SECRET_TOKEN = '409030871250304375';
    public static final String USER_NAME_TOKEN = 'apexspeciali@trailhead.com';
    public static final String USER_PASSWORD_TOKEN = 'auf253100vbnc45GZFsAwR08ER510LEsnXS6Jzsa';
    
    global HTTPResponse respond(HTTPRequest req) {
        
        System.assertEquals('https://login.salesforce.com/services/oauth2/token', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('"access_token":"SESSION_ID_REMOVED",' + 
                    '"instance_url":"https://eu11.salesforce.com",' + 
                    '"id":"https://login.salesforce.com/id/00D0Y000002I1rTUAS/0050Y000002081OQAQ",' + 
                    '"token_type":"Bearer",' + 
                    '"issued_at":"1505125983450",' + 
                    '"signature":"6H1loWSHSLDVIkqMMVUM5dgNLSS/nzSgF2tJKvBAbMc="');
        res.setStatusCode(200);
        
        return res;
    }  
    
}