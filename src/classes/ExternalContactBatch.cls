global class ExternalContactBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT 
            Id,
            FirstName,
            LastName,
            SyncStatus__c
            FROM Contact
            WHERE SyncStatus__c = 'In progress']
                                       );       
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> contacts) {
        
        for(Integer i = 0; i < contacts.size(); i++) {
            CreateContact createContact = new CreateContact();
            HttpRequest__c httpRequest = createContact.getRequestObject( contacts.get(i).Id );
            
                                    
                    HttpRequest__c httpRequestNew = 
                        SyncService.getHttpRequestById( httpRequest.Id );
                    
                    Type typeItem = 
                        Type.forName( httpRequestNew.ClassNameHandler__c );
                    
                    HttpRequestResponseInterface instance = 
                        (HttpRequestResponseInterface) typeItem.newInstance();
                    
                    HttpResponse resp = instance.performRequest( httpRequestNew );
                    instance.processResponse( resp, httpRequestNew.contact_id__c );  
                }
                
        
    }    
    
    global void finish(Database.BatchableContext bc){
        AsyncApexJob a = [SELECT Id, 
                          Status, 
                          NumberOfErrors, 
                          JobItemsProcessed, 
                          TotalJobItems, 
                          CreatedBy.Email
                          FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        System.abortJob(a.id);
    }
}