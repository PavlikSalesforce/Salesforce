global class FutureUpdateClass {
    
    public static String idTemp = '';


   @future(callout = true)
    public static void createNewHttpRequestUpdate(String httpRequestUpdateID) {
        
        HttpRequestUpdate__c httpRequestUpdate = 
            [SELECT 
             method__c,
             endPoint__c,
             body__c,
             Synchronized__c,
             sync_id__c
             FROM httpRequestUpdate__c 
             WHERE Id = :httpRequestUpdateID];
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        
        request.setHeader('Authorization',
                          'Bearer ' + GetSecurityTokenClass.getSecurityToken());
        request.setHeader('Content-Type',
                          'application/json');
        
        request.setMethod(httpRequestUpdate.method__c);
        request.setEndpoint(httpRequestUpdate.endPoint__c);
        request.setBody(httpRequestUpdate.body__c);
        System.debug('httpRequest.body__c = ' + httpRequestUpdate.body__c);
        
        response = http.send(request);

        AccessIdDTO idDTO = 
            (AccessIdDTO) JSON.deserialize(response.getBody(),
                                           AccessIdDTO.class);
        System.debug('idDTO = ' + idDTO);
                
        httpRequestUpdate.sync_id__c = idDTO.id;
        update httpRequestUpdate;
        
        idTemp = idDTO.id;
        
        System.debug('idTemp 1 = ' + idTemp);
        
       
        if(response.getStatusCode() == 201) {
                        
            String hour = String.valueOf(Datetime.now().hour());
			String min = String.valueOf(Datetime.now().minute() + 35);
            String ss = String.valueOf(Datetime.now().second());

			String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';

			ExternalContactBatchSchedule s = new ExternalContactBatchSchedule();
            System.schedule('Job Started At ' + String.valueOf(Datetime.now()), nextFireTime, s);
                                    
        } 
    } 
    
        public class AccessIdDTO {
        public String id { get; set; }
	}

    
    
}