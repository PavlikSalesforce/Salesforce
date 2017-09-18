@isTest
private class SumOfContactsTest {
    
    static testmethod void verifySumOfPrequalifiedAmount() {
        
        Account testAccount = new Account (Name = 'Test');
        insert testAccount;
        
        List<Contact> contacts = new List<Contact>{};
            
            
            for(Integer i = 0; i < 200; i++){
                Contact c = new Contact(LastName = 'Test Account ' + i, AccountId = testAccount.Id, Amount__c = i * 100);
                contacts.add(c);
            }
        
        test.startTest();
        
        insert contacts; 
        
        test.stopTest();
        
        List<Account> insertedAccounts = [SELECT SumOfPrequalifiedAmount__c, NumberOfContacts__c  
                                          FROM Account 
                                          WHERE Id = :testAccount.Id];
        
        for(Account account: insertedAccounts){
            System.assertEquals(200, account.NumberOfContacts__c);
            System.assertEquals(1990000, account.SumOfPrequalifiedAmount__c);
        }
    }
    
    
    static testmethod void verifySumOfContactsDelete() {
        Account testAccount = new Account (Name = 'Test');
        insert testAccount;
        
        List<Contact> contacts = new List<Contact>{};
            
            
            for(Integer i = 0; i < 200; i++){
                Contact c = new Contact(LastName = 'Test Account ' + i, AccountId = testAccount.Id, Amount__c = i * 100);
                contacts.add(c);
            }
        
        test.startTest();
        
        	insert contacts; 
        
        test.stopTest();
        
        List<Account> insertedAccounts = [SELECT SumOfPrequalifiedAmount__c, NumberOfContacts__c  
                                          FROM Account 
                                          WHERE Id = :testAccount.Id];
        
        for(Account account: insertedAccounts){
            System.assertEquals(200, account.NumberOfContacts__c);
        }
        
        List<Contact> contactsToDelete = [SELECT LastName FROM Contact WHERE ID In :contacts];
        
        for(Contact c: contactsToDelete) {
            c.Amount__c = 50;
            c.LastName = 'TestName';
        }
        
        	delete contactsToDelete;
        
        List<Account> insertedAccountsAfterUpdateContact = [SELECT NumberOfContacts__c, SumOfPrequalifiedAmount__c  
                                                            FROM Account 
                                                            WHERE Id = :testAccount.Id];
        
        for(Account account: insertedAccountsAfterUpdateContact){
            System.assertEquals(0, account.NumberOfContacts__c);
            System.assertEquals(0, account.SumOfPrequalifiedAmount__c);
        }
        
    }
    
    static testmethod void verifySumOfContactsUpdate() {
        
        Account testAccount = new Account (Name = 'Test');
        insert testAccount;
        
        List<Contact> contacts = new List<Contact>{};
            
            
            for(Integer i = 0; i < 200; i++){
                Contact c = new Contact(LastName = 'Test Account ' + i, AccountId = testAccount.Id, Amount__c = i * 100);
                contacts.add(c);
            }
        
        test.startTest();
        
        insert contacts; 
        
        test.stopTest();
        
        List<Account> insertedAccounts = [SELECT SumOfPrequalifiedAmount__c, NumberOfContacts__c  
                                          FROM Account 
                                          WHERE Id = :testAccount.Id];
        
        for(Account account: insertedAccounts){
            System.assertEquals(200, account.NumberOfContacts__c);
        }
        
        List<Contact> contactsToUpdate = [SELECT LastName FROM Contact WHERE ID In :contacts];
        for(Contact c: contactsToUpdate) {
            c.Amount__c = 50;
            c.LastName = 'TestName';
        }
        
        update contactsToUpdate;
        
        List<Account> insertedAccountsAfterUpdateContact = [SELECT NumberOfContacts__c, SumOfPrequalifiedAmount__c  
                                                            FROM Account 
                                                            WHERE Id = :testAccount.Id];
        
        for(Account account: insertedAccountsAfterUpdateContact){
            System.assertEquals(200, account.NumberOfContacts__c);
            System.assertEquals(10000, account.SumOfPrequalifiedAmount__c);
        }
        
    }
    
    static testmethod void contactWithEmptyAmountField() {
        
        Account testAccount = new Account (Name = 'Test');
        insert testAccount;
        
        List<Contact> contacts = new List<Contact>{};
            
            
            for(Integer i = 0; i < 200; i++){
                Contact c = new Contact(LastName = 'Test Account ' + i, AccountId = testAccount.Id);
                contacts.add(c);
            }
        
        Test.startTest();
        
        	insert contacts; 
        
        Test.stopTest();
        
        List<Account> insertedAccounts = [SELECT SumOfPrequalifiedAmount__c, NumberOfContacts__c  
                                          FROM Account 
                                          WHERE Id = :testAccount.Id];
        
        for(Account account: insertedAccounts){
            
            System.assertEquals(200, account.NumberOfContacts__c);
            System.assertEquals(0, account.SumOfPrequalifiedAmount__c);
        }
        
    }
    
    
    //insert 100 contacts
    
    
    //update 100 contacts
    
    
    //insert contact with empty Amount__c field
    
    
    //delete 
    
}