@isTest
private class SumOfContactsTest {
    
    static testmethod void verifySumOfPrequalifiedAmount() {
        
        Account testAccount = new Account (Name = 'Test');
        insert testAccount;
        
        List<Contact> contacts = new List<Contact>{};
            
            
            for(Integer i = 1; i <= 10; i++){
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
            System.assertEquals(10, account.NumberOfContacts__c);
            System.assertEquals(5500, account.SumOfPrequalifiedAmount__c);
        }
    }
    
    

    //insert 100 contacts


    //update 100 contacts


    //insert contact with empty Amount__c field


    //delete 

}