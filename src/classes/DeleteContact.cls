public class DeleteContact implements HttpRequestResponseInterface {
    
    public static final String APEX_SPECIALIST_URL = 'https://eu11.salesforce.com/services/data/v40.0/sobjects/Contact/';
    
    public DeleteContact () {}
    
    public HttpRequest__c getRequestObject( Id objectId ) {
        Contact cont = 
            [SELECT Id,
             sync_id__c
             FROM Contact 
             WHERE Id = :objectId];
        
        
        SyncDTO createContact = new SyncDTO();        
        
        httpRequestDelete = new HttpRequest__c(
            method__c = 'DELETE',
            ClassNameHandler__c = 'DeleteContact',
            contact_id__c = cont.id,
            endPoint__c = APEX_SPECIALIST_URL + cont.sync_id__c
        );
        
        try{
            insert httpRequestDelete;
        } catch(Exception e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        
        return httpRequestDelete;
    }
    
    HttpRequest__c httpRequestDelete;
    
    public HttpResponse performRequest (HttpRequest__c httpRequestDelete) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        response = GetSecurityTokenClass.getSecurityToken();
        
        AccessTokenDTO tokenDTO = 
            (AccessTokenDTO) JSON.deserialize(response.getBody(), AccessTokenDTO.class );
        
        request.setHeader('Authorization',
                          'Bearer ' + tokenDTO.access_token);
        request.setHeader('Content-Type',
                          'application/json');
        request.setMethod('DELETE');
        request.setEndpoint(httpRequestDelete.endpoint__c);
        
        response = http.send(request);       
        
        return response;  
    } 
    
    public void processResponse(HttpResponse someHttpResponse, Id contactId) { 
        
        if(isSuccessStatus(someHttpResponse.getStatusCode())) {
            
            HttpRequest__c httpRequest = [SELECT Id, Synchronized__c FROM HttpRequest__c WHERE contact_id__c = :contactId];
            httpRequest.Synchronized__c = true;
            
            try{
                update httpRequest;
            } catch(DMLException e) {
                System.debug('An unexpected error has occurred: ' + e.getMessage());              
            }
            
        } else {
            System.debug('Start Batch');          
        }
        
    }       
    
    private Boolean isSuccessStatus( Integer statusNumber ){
        return 
            statusNumber >= 200
            ||
            statusNumber <= 204;
    }
        
    private class AccessIdDTO {
        public String id;
    }
    private class AccessTokenDTO {
        public String access_token;
    }
    
}