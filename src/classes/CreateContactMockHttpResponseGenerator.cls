global class CreateContactMockHttpResponseGenerator implements HttpCalloutMock {
    
    public static final String APEX_SPECIALIST_URL = 'https://eu11.salesforce.com/services/data/v40.0/sobjects/Contact/';
    
    
    global HTTPResponse respond(HTTPRequest req) {
        
            System.assertEquals(APEX_SPECIALIST_URL, req.getEndpoint());
            System.assertEquals('POST', req.getMethod());
            
            HttpResponse res = new HttpResponse();
            
            res.setHeader('Content-Type', 'application/json');
            
            AccessTokenDTO tokenDTO = 
                (AccessTokenDTO) JSON.deserialize(res.getBody(), AccessTokenDTO.class );
            
            req.setHeader('Authorization',
                          'Bearer ' + tokenDTO.access_token);
            req.setHeader('Content-Type',
                          'application/json');
            
            res.setStatusCode(201);
        
        return res;
    }   
    
    private class AccessTokenDTO {
        public String access_token;
    }    
}