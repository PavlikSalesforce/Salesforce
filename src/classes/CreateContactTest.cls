@isTest
public class CreateContactTest {
    
    static testMethod void verifyHttpRequestCreation(){
        
        List<Contact> contacts = new List<Contact>();
        Set<Id> contactIdSet = new Set<Id>();
        
        for(Integer i = 0; i < 50; i++){
            Contact c = new Contact(LastName = 'Test Account ' + i);
            contacts.add(c);
            contactIdSet.add(c.Id);
        }
        
        
            test.startTest();
            
                insert contacts; 
            
            test.stopTest();
        
        	List<Contact> contactList = [SELECT sync_id__c FROM Contact WHERE Id IN :contactIdSet];
        for(Contact contact : contactList) {
            System.assertEquals(contacts.get(0).sync_id__c, contact.sync_id__c);
        }
        
	}
    
}