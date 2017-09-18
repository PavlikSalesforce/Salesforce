@isTest
private class SyncUpadateUserContactTest {
    
    static testmethod void verifyIfUserWasChangedInsert() {
        
        List<Contact> contactList = new List<Contact>();
        List<User> userList = new List<User>();
        
        for(Integer i = 0; i < 40; i++){
            Contact c = new Contact(FirstName = 'Test Name ' + i, LastName = 'Test Surname ' + i);
            contactList.add(c);
        }
        
        test.startTest();
        
        	insert contactList;
        
        test.stopTest();
        
        userList = [SELECT Id, FirstName, LastName FROM User WHERE Contact_id__c = :contactList.get(0).Id];
        
        for(User u: userList) {
            System.assertEquals(u.FirstName, contactList.get(0).FirstName);
            System.assertEquals(u.LastName, contactList.get(0).LastName);
        }
        
    }
    
        static testmethod void verifyIfUserWasChangedUpdate() {
        
            List<Contact> contactList = new List<Contact>();
            List<User> userList = new List<User>(); 
                
             userList = [SELECT Id, FirstName, LastName FROM User];
             User user = new User();
                
                for(Integer i = 0; i < userList.size(); i++) {
                    userList.get(i).FirstName = 'TestExecution F' + i;
                    userList.get(i).LastName = 'TestExecution L' + i;
                }
    
            
            for(Integer i = 0; i < 40; i++){
                Contact c = new Contact(FirstName = 'Test Name ' + i, LastName = 'Test Surname ' + i);
                contactList.add(c);
            }
            
            test.startTest();
            
                update userList;
                insert contactList;
            
            test.stopTest();
            
            userList = [SELECT Id, FirstName, LastName FROM User WHERE Contact_id__c = :contactList.get(0).Id];
            
            for(User u: userList) {
                System.assertEquals(u.FirstName, contactList.get(0).FirstName);
                System.assertEquals(u.LastName, contactList.get(0).LastName);
            }
    }
    
    static testmethod void verifyIfContactWasChangedInsert() {
        
        List<Contact> contactList = new List<Contact>();
        
        Profile pf = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        for(Integer i = 0; i < 40; i++){
            Contact c = new Contact(FirstName = 'Test Name ' + i, LastName = 'Test Surname ' + i);
            contactList.add(c);
        }
        
        
        Test.startTest();
        
        	insert contactList;
        
        Test.stopTest();
        
        User usr = TestUserUtil.createTestUser(pf.Id, 'Test FirstName', 'Test LastName', contactList.get(0).Id);
        insert usr;
        usr.LastName = 'ChangedName';
        update usr;
        
        contactList = [SELECT Id, FirstName, LastName FROM Contact WHERE Id = :usr.Contact_id__c];
        
        System.assertEquals(contactList.get(0).FirstName, usr.FirstName);
        System.assertEquals(contactList.get(0).LastName, usr.LastName);
        
    }
    
    static testmethod void verifyIfContactWasChangedUpdate() {
        
        List<Contact> contactList = new List<Contact>();
        
        Profile pf = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        for(Integer i = 0; i < 40; i++){
            Contact c = new Contact(FirstName = 'Test Name ' + i, LastName = 'Test Surname ' + i);
            contactList.add(c);
        }
        
        insert contactList;
        
        for(Integer i = 0; i < contactList.size() - 1; i++ ) {
            contactList.get(i).FirstName = 'FirstName' + i;
            contactList.get(i).LastName = 'FirstName' + i;
        }
        
        User usr = TestUserUtil.createTestUser(pf.Id, 'Test FirstName', 'Test LastName', contactList.get(0).Id);
        
        Test.startTest();
        	
        	update contactList;
        	insert usr;
        
        Test.stopTest();
                
        contactList = [SELECT Id, FirstName, LastName FROM Contact WHERE Id = :usr.Contact_id__c];
        
        System.assertEquals(contactList.get(0).FirstName, usr.FirstName);
        System.assertEquals(contactList.get(0).LastName, usr.LastName);
        
    }
}