@isTest
private class SumOfContactsTest {
    
    
    @testSetup static void setup() {
        
        Account testAccount = new Account (Name = 'TestSetup');
        insert testAccount;
        
        List<Contact> contacts = new List<Contact>{};
            
            for(Integer i = 0; i < 100; i++){
                contacts.add(new Contact(
                    LastName = 'Test Contact ' + i, 
                    AccountId = testAccount.Id, 
                    Amount__c = i * 100
                ));
            }
        
        insert contacts;       
    }
    
    
    static testmethod void verifySumOfPrequalifiedAmount() {
        
        Account testAccount = [SELECT Name FROM Account WHERE Name = 'TestSetup'];
        
        List<Account> insertedAccounts = [SELECT SumOfPrequalifiedAmount__c, NumberOfContacts__c  
                                          FROM Account 
                                          WHERE Id = :testAccount.Id];
        
        for(Account account: insertedAccounts){
            System.assertEquals(100, account.NumberOfContacts__c);
            System.assertEquals(495000, account.SumOfPrequalifiedAmount__c);
        }
    }
    
    
    static testmethod void verifySumOfContactsDelete() {
        
        Account testAccount = [SELECT Name FROM Account WHERE Name = 'TestSetup'];
        
        List<Account> insertedAccounts = [SELECT SumOfPrequalifiedAmount__c, NumberOfContacts__c  
                                          FROM Account 
                                          WHERE Id = :testAccount.Id];
        
        List<Contact> contacts = [SELECT LastName FROM Contact WHERE AccountId =:testAccount.Id];
        
        for(Account account: insertedAccounts){
            System.assertEquals(100, account.NumberOfContacts__c);
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
            System.assertEquals(null, account.NumberOfContacts__c);
            System.assertEquals(null, account.SumOfPrequalifiedAmount__c);
        }
        
    }
    
    static testmethod void verifySumOfContactsUpdate() {
        
        Account testAccount = [SELECT Name FROM Account WHERE Name = 'TestSetup'];
        
        List<Contact> contacts = [SELECT LastName FROM Contact WHERE AccountId =:testAccount.Id];
        
        
        List<Account> insertedAccounts = [SELECT SumOfPrequalifiedAmount__c, NumberOfContacts__c  
                                          FROM Account 
                                          WHERE Id = :testAccount.Id];
        
        for(Account account: insertedAccounts){
            System.assertEquals(100, account.NumberOfContacts__c);
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
            System.assertEquals(100, account.NumberOfContacts__c);
            System.assertEquals(5000, account.SumOfPrequalifiedAmount__c);
        }
        
    }
    
    static testmethod void contactWithEmptyAmountField() {
        
        Account testAccount = new Account (Name = 'Test');
        
            try{
                insert testAccount;  
            } catch(DMLException e) {
                System.debug('An unexpected error occurred ' + e.getMessage());
            }
        
        List<Contact> contacts = new List<Contact>{};
            
            for(Integer i = 0; i < 100; i++){
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
                
                System.assertEquals(100, account.NumberOfContacts__c);
                System.assertEquals(0, account.SumOfPrequalifiedAmount__c);
            }
        
    }
    
}