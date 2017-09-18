global class ContactBatch implements Database.Batchable<sObject> {    	

    global Integer count = 0;
    private static final String APEX_SPECIALIST_URL = 'https://eu11.salesforce.com/services/data/v40.0/sobjects/Contact/';

    public String token = ExternalContactService.getSecurityToken();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {  
        System.debug('POINT');
       	ExternalContactService externalContactService = new ExternalContactService();
        String firstName = externalContactService.tempFirstName;
        return Database.getQueryLocator(
         [SELECT FirstName, LastName FROM Contact WHERE FirstName = :firstName]);
    }

    global void execute(Database.BatchableContext bc, List<Contact> contacts){
            ExternalContactService externalContactService = new ExternalContactService();

      	 	HttpRequest request = new HttpRequest();
            HttpResponse response = new HttpResponse();
            Http http = new Http();
               	                        
        	request.setHeader('Authorization', 'Bearer ' + token);
            request.setHeader('Content-Type', 'application/json');
        	request.setMethod('POST');
        
            request.setEndpoint(APEX_SPECIALIST_URL);
            
            try {
                response = http.send(request);
                count++;
        		if(count == 5){
            		return;
        }
            } catch (System.CalloutException calloutException) {
                System.debug('Callout error: ' + calloutException);
			}
    }     

    global void finish(Database.BatchableContext bc){
    	System.debug('finish');
    }
	}