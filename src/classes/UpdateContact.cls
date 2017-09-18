public class UpdateContact implements HttpRequestResponseInterface {
    
    public HttpRequest__c getRequestObject(Id  obj) {
        Contact cont = 
            [SELECT Id,
             FirstName,
             LastName,
             sync_id__c
             FROM Contact 
             WHERE Id = :obj];
        
        SyncDTO updateContact = new SyncDTO();
        
        httpRequestUpdate = new HttpRequest__c(
            method__c = 'PUT',
            ClassNameHandler__c = 'UpdateContact',
            contact_id__c = cont.id,
            endPoint__c = 'https://eu11.salesforce.com/services/apexrest/FieldContact',
            body__c = updateContact.toMap(cont.sync_id__c, cont.FirstName, cont.LastName)
        );
        
        try{
            insert httpRequestUpdate;
        } catch(DMLException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        
        return httpRequestUpdate;
        
        
    }
    
    HttpRequest__c httpRequestUpdate;
    
    //private String contact_id {
    //   get{
    //        return httpRequestUpdate.contact_id__c;
    //   }
    //  set{
    //        contact_id = value;
    //   }
    //}    
    
    public HttpResponse performRequest (HttpRequest__c httpRequestUpdate) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        response = GetSecurityTokenClass.getSecurityToken();
        
        AccessTokenDTO tokenDTO = 
            (AccessTokenDTO) JSON.deserialize(response.getBody(), AccessTokenDTO.class );
        
        request.setBody(httpRequestUpdate.body__c); 
        request.setHeader('Authorization',
                          'Bearer ' + tokenDTO.access_token);
        request.setHeader('Content-Type',
                          'application/json');
        request.setMethod('PUT');
        request.setEndpoint(httpRequestUpdate.endpoint__c);
        
        response = http.send(request);
        
        return response;  
    } 
    
    public void processResponse(HttpResponse someHttpResponse, Id contactId) {
        
        Contact contactItem = [SELECT Id,
                               SyncStatus__c
                               FROM Contact
                               WHERE Id = :contactId];
        
        if(isSuccessStatus(someHttpResponse.getStatusCode())) { 
            
            HttpRequest__c httpRequest = [SELECT Id, Synchronized__c FROM HttpRequest__c WHERE contact_id__c = :contactId];
            httpRequest.Synchronized__c = true;
            try{
                update httpRequest;   
            } catch(DMLException e) {
                System.debug('An unexpected error has occurred: ' + e.getMessage());
                
            }
            
            contactItem.SyncStatus__c = 'Completed';
            
            try{
                update contactItem;
            } catch(DMLException e) {
                System.debug('An unexpected error has occurred: ' + e.getMessage());
            }            
        }  else {
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