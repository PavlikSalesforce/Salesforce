public class More5Cont_CompletedProcessClass {
    
    public static void verifyAgeContactListMethod(Set<Id> contactIdsSet) {
        
        List<Contact> verifyAgeContactList = new List<Contact>();
        
        if(!contactIdsSet.isEmpty()) {
            
        }
        
        for(Contact c : [SELECT Age__c FROM Contact WHERE iD In :contactIdsSet]) {
            
            if(c.Age__c < 19) {
                
                c.Adult__c = false;
                
            } else {
                
                c.Adult__c = true;
                
            }
            verifyAgeContactList.add(c);
        }
        
        try{
            update verifyAgeContactList;
        }catch( DMLException e ) {
            System.debug('An unexpected error has occurred ' + e.getMessage());
        }
    }
    
    public static void accountStatus_Completed_Draft(Set<Id> accountIdsSet) {
        
        List<Account> accountListToUpdate = new List<Account>();
        List<Contact> tempContactList = new List<Contact>();
        List<Contact> contactList = new List<Contact>();
        List<Account> accountList = new List<Account>();
        
            for(Account acc : [SELECT id, Name,
                               (SELECT id, Name, Adult__c, Age__c
                                FROM Contacts WHERE Age__c > 18)
                               FROM Account WHERE id in:accountIdsSet]){
                                   
                                   accountList.add(acc);                   
                                   contactList = acc.Contacts;
                               }
        
        for(Contact c: contactList) {
            
            if(c.Adult__c == true) {
                
                tempContactList.add(c);
                
                for(Account acc: accountList) {
                    if(tempContactList.size() > 5) {
                        acc.Status__c = 'Completed';
                    } else if (tempContactList.size() <= 5) {
                        acc.Status__c = 'Draft';
                    }
                }
                
            }
        }
        
        for(Account acc: accountList) {
            accountListToUpdate.add(acc);  
        }
        
        try{
            update accountListToUpdate;
        }catch(DMLException e) {
            System.debug('An unexpected error has occurred ' + e.getMessage());
        }
        
    }
    
}