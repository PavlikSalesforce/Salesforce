trigger StatusCompletedCaseTrigger on Case (after insert, after update, after delete, after undelete) {
    
    
        Set<Id> contactIdsSet = new Set<Id>();
        Set<Id> caseIdsSet = new Set<Id>();
        List<Contact> contactListToUpdate = new List<Contact>();
    
    if(Trigger.IsAfter){
        if(Trigger.IsInsert || Trigger.IsUndelete || Trigger.IsUpdate){
            for(Case c : Trigger.new){
                if(c.ContactId != null){   
                    contactIdsSet.add(c.ContactId);
                }
            }
        }
        
        if(Trigger.IsDelete){
            FOR(Case c : Trigger.Old){
                if(c.ContactId != null){   
                    contactIdsSet.add(c.ContactId); 
                }
            }
        }
    }
    
    
    List<User> userList = [SELECT Id, Name from User];
    List<Contact> contactList = new List<Contact>();
    List<Case> caseList = new List<Case>();
    
    for(Contact contact: [SELECT id, Name, Age__c, Adult__c,
                          (SELECT id, Status FROM Cases)
                          FROM Contact WHERE id in:contactIdsSet]) {
                              
                              contactList.add(contact);                           
                              caseList = contact.Cases;
                          }  
    
    if(caseList.size() > 0) {
        
        List<Contact> tempContactList = [SELECT id, Name, Age__c, Adult__c
                                         FROM Contact 
                                         WHERE Id IN :contactList];
        
        for(Integer i = 0; i < caseList.size(); i++) {
            
            if(caseList.get(i).Status == 'Completed') {
                
                for(Integer j = 0; j < userList.size(); j++) {
                    JobSharing.manualShare(tempContactList, userList.get(j).Id, 'Read');
                }
                
            } 
            
            if(caseList.size() > 3) {
                
                for(Integer j = 0; j < userList.size(); j++) {
                    JobSharing.manualShare(tempContactList, userList.get(j).Id, 'Edit');
                }
            }
            
            for(Contact contact : contactList) {
                if(caseList.get(i).Status == 'Completed' && contact.Age__c > 18) {
                    contact.Adult__c = true;
                } else {
                    contact.Adult__c = false;
                }
            }
            
        }
        
    } else {
        for(Contact contact : contactList) {
            contact.Adult__c = false;
        }
    }
        for(Contact contact : contactList) {
            contactListToUpdate.add(contact);
        }
    
            try{
                update contactListToUpdate;
            } catch(DMLException e) {
                System.debug('An unexpected error has occurred ' + e.getMessage());
            }
    
}