global class FutureMethod {
    
    public static String idTemp='';
    
    @future(callout = true)
    public static void createNewHttpRequest(String httpRequestID) {
        HttpRequest__c httpRequest = 
            [SELECT 
             method__c,
             endPoint__c,
             body__c,
             Synchronized__c
             FROM HttpRequest__c 
             WHERE Id = :httpRequestID];
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        request.setHeader('Authorization',
                          'Bearer ' + ExternalContactService.getSecurityToken());
        request.setHeader('Content-Type',
                          'application/json');
        
        request.setMethod(httpRequest.method__c);
        request.setEndpoint(httpRequest.endPoint__c);
        request.setBody(httpRequest.body__c);
        System.debug('httpRequest.body__c = ' + httpRequest.body__c);
        
        response = http.send(request);

        AccessIdDTO idDTO = 
            (AccessIdDTO) JSON.deserialize(response.getBody(),
                                           AccessIdDTO.class);
        System.debug('idDTO = ' + idDTO);
                
        httpRequest.sync_id__c = idDTO.id;
              
        idTemp = httpRequest.sync_id__c;
        
        System.debug('httpRequest.sync_id__c = ' + httpRequest.sync_id__c);
       
        if(response.getStatusCode() == 201) {
            
            httpRequest.Synchronized__c = true;
            
            String hour = String.valueOf(Datetime.now().hour());
			String min = String.valueOf(Datetime.now().minute() + 5);
            String ss = String.valueOf(Datetime.now().second());

			String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';

			ExternalContactBatchSchedule s = new ExternalContactBatchSchedule();
            System.schedule('Job Started At ' + String.valueOf(Datetime.now()), nextFireTime, s);
                                    
        } else {
            httpRequest.Synchronized__c = false;
        }
    } 
    
    @future(callout = true)
    public static void updateExternalObjectMatchId() {

                HttpRequest__c httpRequest = 
            [SELECT 
             method__c,
             endPoint__c,
             body__c,
             Synchronized__c,
             sync_id__c
             FROM HttpRequest__c
             WHERE sync_id__c =
             :idTemp LIMIT 1];
        System.debug('httpRequest = ' + httpRequest);
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        request.setHeader('Authorization',
                          'Bearer ' + ExternalContactService.getSecurityToken());
        request.setHeader('Content-Type',
                          'application/json');
                
        request.setMethod(httpRequest.method__c);
        request.setEndpoint(httpRequest.endPoint__c);
        request.setBody(httpRequest.body__c);
        request.setBody(idTemp);
        
        response = http.send(request);
        System.debug('UPDATED!!!');

    }
 
    public class AccessIdDTO {
        public String id { get; set; }
        
        public AccessIdDTO () {
           
        }
        
        public AccessIdDTO (String id) {
            this.id = id;
        }
}
    

}