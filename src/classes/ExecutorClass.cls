global class ExecutorClass {
    
    @future(callout = true)
    public static void performObject( Id requestRecordId ){
        
        HttpRequest__c httpRequest = 
            SyncService.getHttpRequestById( requestRecordId );
        
        Type typeItem = 
            Type.forName( httpRequest.ClassNameHandler__c );
        
        HttpRequestResponseInterface instance = 
            ( HttpRequestResponseInterface ) typeItem.newInstance();
        
        HttpResponse resp = instance.performRequest( httpRequest );
        instance.processResponse(resp, httpRequest.contact_id__c);        
        
    }
}