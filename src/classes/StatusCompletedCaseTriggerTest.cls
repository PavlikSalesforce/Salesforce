@isTest
private class StatusCompletedCaseTriggerTest {
    
    static testmethod void verifyAContactAdultCheckboxTrue(){
        
        Contact testContact = new Contact(
           
            LastName = 'Test Contact', 
            Birthdate = Date.ValueOf('1968-09-21'));
        
        	insert testContact;
        
        Case testCase = new Case(
            ContactId = testContact.Id,
            Status = 'Completed',
            Origin = 'Phone');
        
        	insert testCase;
        
 		System.assertEquals(true, new List<Contact>(
                                    [SELECT Id, Adult__c
                                     FROM Contact
                                     WHERE Id = :testCase.ContactId]).get(0).Adult__c);
    }	
    
    
    static testmethod void verifyAContactAdultCheckboxFalse(){
        
        Contact testContact = new Contact(
            LastName = 'Test Contact', 
            Birthdate = Date.ValueOf('2008-09-21'));
        
        	insert testContact;
        
        Case testCase = new Case(
            ContactId = testContact.Id,
            Status = 'Completed',
            Origin = 'Phone');
        
        	insert testCase;
        
        
        System.assertEquals(false, new List<Contact>([SELECT Id, Adult__c
                                                      FROM Contact
                                                      WHERE Id = :testCase.ContactId]).get(0).Adult__c);
        
    }
    
        static testmethod void verifyAContactAdultCheckboxFalseDelete(){
        
            Contact testContact = new Contact(
                LastName = 'Test Contact', 
                Birthdate = Date.ValueOf('2008-09-21'));
            
                insert testContact;
            
            Case testCase = new Case(
                ContactId = testContact.Id,
                Status = 'Completed',
                Origin = 'Phone');
            
                insert testCase;
            
            List<Case> caseList = [SELECT Id FROM Case WHERE ContactId = :testContact.Id];
                
             Test.startTest();
                
                delete caseList;
                
             Test.stopTest();
                            
            System.assertEquals(false, new List<Contact>([SELECT Id, Adult__c
                                                          FROM Contact
                                                          WHERE LastName = 'Test Contact']).get(0).Adult__c);
    }
    
}