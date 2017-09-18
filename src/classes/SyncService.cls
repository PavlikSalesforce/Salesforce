public class SyncService {
	
	public static void process( HttpRequestResponseInterface instance, Id objectId ){

		HttpRequest__c requestObject = 
			instance.getRequestObject( objectId );
	}


	public static HttpRequest__c getHttpRequestById( Id recordId ){
        return
            [SELECT ClassNameHandler__c,
            	method__c,
             	endPoint__c,
             	body__c,
             	contact_id__c
             FROM HttpRequest__c
             WHERE Id = :recordId];			
	}

}