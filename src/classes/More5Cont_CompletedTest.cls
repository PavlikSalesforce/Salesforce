@isTest
private class More5Cont_CompletedTest {
    
    static testMethod void verifyAccountStatusOverwritten(){
        
        Account testAccount = new Account (Name = 'Test');
        insert testAccount;
        
        List<Contact> contacts = new List<Contact>{};
            
            for(Integer i = 0; i < 150; i++){
                Contact c = new Contact(LastName = 'Test Account ' + i, Birthdate = Date.ValueOf('1968-09-21'), AccountId = testAccount.Id);
                contacts.add(c);
            }
        
        test.startTest();
        
        	insert contacts; 
        
        test.stopTest();
        
        	List<Case> caseTestList = new List<Case>();
        
                for(Integer i = 0; i < contacts.size(); i++) {
                    Case testCase = new Case(
                        ContactId = contacts.get(i).Id,
                        Status = 'Completed',
                        Origin = 'Phone');
                    caseTestList.add(testCase);
                }
        
        	insert caseTestList;
        
        
        List<Account> insertedAccounts = [SELECT  Status__c 
                                          FROM Account 
                                          WHERE Id = :testAccount.Id];
        System.debug('insertedAccounts = ' + insertedAccounts);
        
        for(Integer i = 0; i <  insertedAccounts.size(); i++){
            System.assertEquals('Completed', insertedAccounts.get(i).Status__c);
        }
    }
    
    static testMethod void verifyAccountStatusOverwrittenDelete(){
        
        Account testAccount = new Account (Name = 'Test');
        insert testAccount;
        
        List<Contact> contacts = new List<Contact>{};
            
            for(Integer i = 0; i < 200; i++){
                Contact c = new Contact(LastName = 'Test Account ' + i, AccountId = testAccount.Id);
                contacts.add(c);
            }
        
        test.startTest();
        
        	insert contacts; 
        
        test.stopTest();
        
        List<Case> caseTestList = new List<Case>();
        
        for(Integer i = 0; i < contacts.size(); i++) {
            Case testCase = new Case(
                ContactId = contacts.get(i).Id,
                Status = 'Completed',
                Origin = 'Phone');
            caseTestList.add(testCase);
        }
        
        	insert caseTestList;        
        
        List<Contact> contactsToDelete = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId = :testAccount.Id];
        
        	delete caseTestList;
        	delete contactsToDelete;
        
        List<Account> insertedAccounts = [SELECT  Status__c 
                                          FROM Account 
                                          WHERE Id = :testAccount.Id];
            
            for(Integer i = 0; i <  insertedAccounts.size(); i++){
                System.assertEquals(null, insertedAccounts.get(i).Status__c);
            }
        
    }
    
    static testMethod void verifyAccountStatusOverwrittenLess18(){
                
        List<Contact> contacts = new List<Contact>{};
            
            for(Integer i = 0; i < 200; i++){
                Contact c = new Contact(LastName = 'Test Contact ' + i, Birthdate = Date.ValueOf('1990-09-21'));
                contacts.add(c);
            }
        
        test.startTest();
        
        	insert contacts; 
        
        test.stopTest();
        
        List<Contact> tempContactList = [SELECT Age__c FROM Contact WHERE Id = :contacts.get(0).Id];
        
        for(Integer i = 0; i < tempContactList.size(); i++) {
            System.assertEquals(false, contacts.get(i).Adult__c);
        }
        
            for(Integer i = 0; i < tempContactList.size(); i++) {
        
        if(tempContactList.get(i).Age__c < 19) {
            tempContactList.get(i).Adult__c = false;
        } else {
            tempContactList.get(i).Adult__c = true;
        }
    }
        
        Contact c = new Contact(LastName = 'Test', Birthdate = Date.ValueOf('1990-09-21'));
        insert c;
        
            Case testCase = new Case(
                ContactId = c.Id,
                Status = 'Completed',
                Origin = 'Phone');
        
	    insert testCase;
        
        Contact testContact = [SELECT Id, Adult__c FROM Contact WHERE Id = :testCase.ContactId];
        testContact.Birthdate = Date.ValueOf('1995-09-21');
        
        	update testContact;
        
        Contact contact = [SELECT Id, Adult__c FROM Contact WHERE Id = :testContact.Id];
        System.assertEquals(true, contact.Adult__c);
        
        Contact testContactFalse = [SELECT Id, Adult__c FROM Contact WHERE Id = :testCase.ContactId];
        testContactFalse.Birthdate = Date.ValueOf('2005-09-21');
        
        	update testContactFalse;
        
        Contact contactFalse = [SELECT Id, Adult__c FROM Contact WHERE Id = :testContactFalse.Id];
        System.assertEquals(false, contactFalse.Adult__c);
 
    }
}