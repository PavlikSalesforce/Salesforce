@isTest
private class CalloutClassTest {
    
    public static final String GET_SECURITY_TOKEN_URL = 'https://login.salesforce.com/services/oauth2/token';
    public static final String CLIENT_ID_TOKEN = '3MVG9HxRZv05HarSc6AQ3WxfCE56G2Ri5t3UUn6vwTdREfPC50RqQeFGJ40Rbs6Lrzc3PJE4v6zHjqBaTXjTi';
    public static final String CLIENT_SECRET_TOKEN = '409030871250304375';
    public static final String USER_NAME_TOKEN = 'apexspeciali@trailhead.com';
    public static final String USER_PASSWORD_TOKEN = 'auf253100vbnc45GZFsAwR08ER510LEsnXS6Jzsa';
    
    @isTest static void testCallout() {
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        HttpResponse res = GetSecurityTokenClass.getSecurityToken();
        
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '"access_token":"SESSION_ID_REMOVED",' + 
                    '"instance_url":"https://eu11.salesforce.com",' + 
                    '"id":"https://login.salesforce.com/id/00D0Y000002I1rTUAS/0050Y000002081OQAQ",' + 
                    '"token_type":"Bearer",' + 
                    '"issued_at":"1505125983450",' + 
                    '"signature":"6H1loWSHSLDVIkqMMVUM5dgNLSS/nzSgF2tJKvBAbMc="';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
}