public virtual class GetSecurityTokenClass {
    
        public static final String GET_SECURITY_TOKEN_URL = 'https://login.salesforce.com/services/oauth2/token';
    	public static final String CLIENT_ID_TOKEN = '3MVG9HxRZv05HarSc6AQ3WxfCE56G2Ri5t3UUn6vwTdREfPC50RqQeFGJ40Rbs6Lrzc3PJE4v6zHjqBaTXjTi';
		public static final String CLIENT_SECRET_TOKEN = '409030871250304375';
    	public static final String USER_NAME_TOKEN = 'apexspeciali@trailhead.com';
    	public static final String USER_PASSWORD_TOKEN = 'auf253100vbnc45GZFsAwR08ER510LEsnXS6Jzsa';
    
        public static HttpResponse getSecurityToken() {
            
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setMethod('POST');
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setBody('grant_type=password&client_id=' + CLIENT_ID_TOKEN + 
                        '&client_secret=' + CLIENT_SECRET_TOKEN + 
                        '&username=' + USER_NAME_TOKEN +
                        '&password=' + USER_PASSWORD_TOKEN);
        request.setEndpoint(GET_SECURITY_TOKEN_URL);
        HttpResponse response = http.send(request);
                   
        return response;
    }
    
        private class AccessTokenDTO {
        	public String access_token;
    }

}