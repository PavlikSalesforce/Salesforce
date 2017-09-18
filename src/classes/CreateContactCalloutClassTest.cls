@isTest
public class CreateContactCalloutClassTest {
    
    public static final String APEX_SPECIALIST_URL = 'https://eu11.salesforce.com/services/data/v40.0/sobjects/Contact/';
    
    
    @isTest static void testCallout() {
        
        Test.setMock(HttpCalloutMock.class, new CreateContactMockHttpResponseGenerator());
        
        Contact cont = new Contact(FirstName = 'FirstName', LastName = 'LastName');
        insert cont;
        
        SyncDTO createContact = new SyncDTO();      
        
        HttpRequest__c httpRequest = [SELECT method__c,
                                     ClassNameHandler__c,
                                     contact_id__c,
                                     endPoint__c,
                                     body__c
                                     FROM HttpRequest__c
                                     WHERE contact_id__c = :cont.Id];
        
     /*   HttpRequest__c httpRequest = new HttpRequest__c(
            method__c = 'POST',
            ClassNameHandler__c = 'CreateContact',
            contact_id__c = cont.id,
            endPoint__c = APEX_SPECIALIST_URL,
            body__c = createContact.toMap(cont.FirstName, cont.LastName)
        );
        
        try{
            insert httpRequest;
        } catch(Exception e) {
            System.debug(e.getMessage());
        } */
        
        CreateContact c = new CreateContact();
        
        HttpResponse res = c.performRequest(httpRequest);
        c.processResponse(res, cont.Id);
        
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        
        System.assertEquals(201, res.getStatusCode());      
        
    }
}