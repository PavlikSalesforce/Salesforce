trigger More5Cont_Completed on Contact (after insert, after update, after delete, after undelete) {
    
    Set<Id> accountIdsSet = new Set<Id>();
    List<Account> accountListToUpdate = new List<Account>();
    List<Contact> verifyAgeContactList = new List<Contact>();
    
        if(Trigger.IsAfter){
            if(Trigger.IsInsert || Trigger.IsUndelete){
                for(Contact c : Trigger.new){
                    
                    if(c.AccountId != null){   
                        accountIdsSet.add(c.AccountId); 
                    }
                    
                }
            }
        
            if(Trigger.IsDelete){
                for(Contact c : Trigger.Old){
                    
                    if(c.AccountId != null){   
                        accountIdsSet.add(c.AccountId); 
                    }
                    
                }
            }
        
        if(Trigger.IsUpdate){
            for(Contact c : Trigger.New){
                
                if(Trigger.isUpdate && Trigger.oldMap.get(c.ID).Age__c != c.Age__c) {
                    
                    verifyAgeContactList = [SELECT Age__c FROM Contact WHERE iD = :c.Id];
                }
                
                if(c.AccountId != null){   
                    accountIdsSet.add(c.AccountId); 
                }
            }
        }
        
    }
    
        for(Integer i = 0; i < verifyAgeContactList.size(); i++) {
            
            if(verifyAgeContactList.get(i).Age__c < 19) {
                
                verifyAgeContactList.get(i).Adult__c = false;
                
            } else {
                
                verifyAgeContactList.get(i).Adult__c = true;
                
            }
        }
    
            try{
                update verifyAgeContactList;
            }catch( DMLException e ) {
                System.debug('An unexpected error has occurred ' + e.getMessage());
            }
    
      
    List<Contact> tempContactList = new List<Contact>();
    
    for(Account acc : [SELECT id, Name,
                       (SELECT id, Name, Adult__c, Age__c
                        FROM Contacts WHERE Age__c > 18)
                        FROM Account WHERE id in:accountIdsSet]){
        
        List<Contact> contactList = acc.Contacts;
        
        for(Integer i = 0; i < contactList.size(); i++) {
            
            if(contactList.get(i).Adult__c == true) {
                
                tempContactList.add(contactList.get(i));
                
                    if(tempContactList.size() > 5) {
                        acc.Status__c = 'Completed';
                    } else if (tempContactList.size() <= 5) {
                        acc.Status__c = 'Draft';
                    }
            }
        }
        
        accountListToUpdate.add(acc);  
        
    }
    
        try{
            update accountListToUpdate;
        }catch(DMLException e) {
            System.debug('An unexpected error has occurred ' + e.getMessage());
        }
    }