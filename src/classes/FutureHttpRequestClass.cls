public class FutureHttpRequestClass {
    
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
    
    @future(callout = true)
    public static void createExternalObjectMatchId(String httpRequestID) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        HttpRequest__c httpRequest = 
            [SELECT 
             method__c,
             endPoint__c,
             body__c,
             Synchronized__c,
             contact_id__c
             FROM HttpRequest__c 
             WHERE Id = :httpRequestID];
        
        request.setHeader('Authorization',
                          'Bearer ' + GetSecurityTokenClass.getSecurityToken());
        request.setHeader('Content-Type',
                          'application/json');
        request.setMethod(httpRequest.method__c);
        request.setEndpoint(httpRequest.endPoint__c);
        request.setBody(httpRequest.body__c);
               
        response = http.send(request);
                
        AccessIdDTO idDTO = 
            (AccessIdDTO) JSON.deserialize(response.getBody(), AccessIdDTO.class);
        
        	Contact contact = [SELECT Id,
                               sync_id__c
                               FROM Contact
                               WHERE Id = :httpRequest.contact_id__c];
        	contact.sync_id__c = idDTO.id;
        
        try{
        	update contact;
        } catch(DMLException e) {
            System.debug(e.getMessage());
        }
        
        if(response.getStatusCode() == 201) {
            contact.SyncStatus__c = 'Completed';
            httpRequest.Synchronized__c = true;
        } else {
            String hour = String.valueOf(Datetime.now().hour());
			String min = String.valueOf(Datetime.now().minute() + 10);
            String ss = String.valueOf(Datetime.now().second());

			String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';

			ExternalContactBatchSchedule s = new ExternalContactBatchSchedule();
            System.schedule('Job Started At ' + String.valueOf(Datetime.now()), nextFireTime, s);
        }
    }   
         
    @future(callout = true)
    public static void updateExternalObjectMatchId(String httpRequestID) {
        
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        HttpRequestUpdate__c httpRequestUpdate = 
            [SELECT 
             endPoint__c,
             Synchronize__c,
             body__c
             FROM HttpRequestUpdate__c
             WHERE Id = :httpRequestID];
        
		request.setBody(httpRequestUpdate.body__c); 
        request.setHeader('Authorization',
                          'Bearer ' + GetSecurityTokenClass.getSecurityToken());
        request.setHeader('Content-Type',
                          'application/json');
		request.setMethod('PUT');
        request.setEndpoint('https://eu11.salesforce.com/services/apexrest/FieldContact');
        
        response = http.send(request);
        
         if(response.getStatusCode() == 201) {
            httpRequestUpdate.synchronize__c = true;
        } else {
            String hour = String.valueOf(Datetime.now().hour());
			String min = String.valueOf(Datetime.now().minute() + 10);
            String ss = String.valueOf(Datetime.now().second());

			String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';

			ExternalContactBatchUpdateSchedule s = new ExternalContactBatchUpdateSchedule();
            System.schedule('Job Started At ' + String.valueOf(Datetime.now()), nextFireTime, s);
        }
    }
    
    @future(callout = true)
    public static void deleteExternalObjectMatchId(String httpRequestID) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
                
        HttpRequestDelete__c httpRequest = 
            [SELECT 
             endPoint__c,
             body__c
             FROM HttpRequestDelete__c
             WHERE Id = :httpRequestID];
                                
        request.setHeader('Authorization',
                          'Bearer ' + GetSecurityTokenClass.getSecurityToken());
        request.setHeader('Content-Type',
                          'application/json');
        request.setMethod('DELETE');
        request.setEndpoint(httpRequest.endpoint__c);
        
        response = http.send(request);
        
        if(response.getStatusCode() == 201) {
            httpRequest.Synchronized__c = true;
        } else {
            String hour = String.valueOf(Datetime.now().hour());
			String min = String.valueOf(Datetime.now().minute() + 10);
            String ss = String.valueOf(Datetime.now().second());

			String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';

			ExternalContactBatchSchedule s = new ExternalContactBatchSchedule();
            System.schedule('Job Started At ' + String.valueOf(Datetime.now()), nextFireTime, s);
        }
    }
 
    public class AccessIdDTO {
        public String id;
	}
}