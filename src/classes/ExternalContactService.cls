global class ExternalContactService {
    
    public static final String GET_SECURITY_TOKEN_URL = 'https://login.salesforce.com/services/oauth2/token';
    public static final String GRANT_TYPE = 'password';
    public static final String CLIENT_ID_TOKEN = '3MVG9HxRZv05HarSc6AQ3WxfCE56G2Ri5t3UUn6vwTdREfPC50RqQeFGJ40Rbs6Lrzc3PJE4v6zHjqBaTXjTi';
	public static final String CLIENT_SECRET_TOKEN = '409030871250304375';
    public static final String USER_NAME_TOKEN = 'apexspeciali@trailhead.com';
    public static final String USER_PASSWORD_TOKEN = 'auf253100vbnc45GZFsAwR08ER510LEsnXS6Jzsa';
    
    public static final String APEX_SPECIALIST_URL = 'https://eu11.salesforce.com/services/data/v40.0/sobjects/Contact/';
    public static final String CLIENT_ID = '3MVG9HxRZv05HarTXOE6U.75VlxQN7o_Wq4QJoelLDkkjX8Fk5YsWpPs_fFZ_Ba3Fj3Gkpk7XEBK2qU9uvoOZ';
    public static final String CLIENT_SECRET = '4617137027380055078';
    public static final String USER_NAME = 'apexspeciali@trailhead.com';
    public static final String USER_PASSWORD = 'auf253100vbnc45';
    
    public static String idForUpdate;
    
    public String tempFirstName { get; set; }
    public String tempSavedBody { get; set; }    
   
    public static String getSecurityToken() {
            
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setMethod('POST');
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setBody('grant_type=password&client_id=' + CLIENT_ID_TOKEN + 
                        '&client_secret=' + CLIENT_SECRET_TOKEN + 
                        '&username=' + USER_NAME_TOKEN +
                        '&password=' + USER_PASSWORD_TOKEN);
        request.setEndpoint(GET_SECURITY_TOKEN_URL);
        HttpResponse response = h.send(request);
        
        AccessTokenDTO tokenDTO = 
            (AccessTokenDTO) JSON.deserialize(response.getBody(), AccessTokenDTO.class );
        
        return tokenDTO.access_token;
    }

    
    private class AccessTokenDTO {
        public String access_token;
    }
        
    public static void syncContact(Id cctId) {
        
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        Http http = new Http();
        
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('POST');
        request.setEndpoint(APEX_SPECIALIST_URL);            
        String header = 
            'Authorization: ' + request.getHeader('Authorization') 
            + 'Content-Type:' + request.getHeader('Content-Type');
        
        Contact cont = 
            [SELECT Id,
             FirstName, LastName 
             FROM Contact 
             WHERE Id = :cctId];
        
        request.setBody(
            '{"FirstName":"' + cont.FirstName 
            + '","LastName":"' + cont.LastName + '"}'
        );
        
        HttpRequest__c savedHttpRequest = new HttpRequest__c(
            Name = 'Pavlo',
            header__c = header,
            method__c = request.getMethod(),
            endPoint__c = request.getEndpoint(),
            body__c = request.getBody()
        );
        
        insert savedHttpRequest;
        idForUpdate = savedHttpRequest.Id;
    }              
    
 
    public static void syncContactGeneral(Id cctId) {
        syncContact(cctId);
    }

}