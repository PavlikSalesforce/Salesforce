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
        for(Contact contact: [SELECT id ,Name, Age__c, Adult__c,
                                  (SELECT id, Status FROM Cases)
                                   FROM Contact WHERE id in:contactIdsSet]) {
            
            List<Case> caseList = contact.Cases;
            if(caseList.size() > 0) {
                
                for(Integer i = 0; i < caseList.size(); i++) {
                    
                    if(caseList.get(i).Status == 'Completed') {
                        System.debug('Before JobSharing.manualShare()');
                        
                        for(Integer j = 0; j < userList.size(); j++) {
                            JobSharing.manualShare(contact.Id, userList.get(j).Id, 'Read');
                        }
                        
                    } 
                    
                        if(caseList.size() > 3) {
                            System.debug('More than 3 cases');
                            for(Integer j = 0; j < userList.size(); j++) {
                                JobSharing.manualShare(contact.Id, userList.get(j).Id, 'Edit');
                            }
                        }
                    
                        if(caseList.get(i).Status == 'Completed' && contact.Age__c > 18) {
                            contact.Adult__c = true;
                        } else {
                            contact.Adult__c = false;
                        }
                    }
                
            } else {
                contact.Adult__c = false;
            }
            
            contactListToUpdate.add(contact);
        }
    
        try{
            update contactListToUpdate;
        } catch(DMLException e) {
            System.debug('An unexpected error has occurred ' + e.getMessage());
        }
    
}