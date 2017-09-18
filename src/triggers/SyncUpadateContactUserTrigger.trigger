trigger SyncUpadateContactUserTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    List<Contact> userIds = new List<Contact>();
    List<User> userList = new List<User>();
    
    if(Trigger.isInsert || Trigger.isUpdate){
        for( Contact contact : Trigger.New){
            
            if(Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(contact.ID).FirstName != contact.FirstName)
               || (Trigger.isUpdate && Trigger.oldMap.get(contact.ID).LastName != contact.LastName)){
                   userIds = [SELECT Id, FirstName, LastName, 
                              LastModifiedBy.ProfileId
                              FROM Contact
                              WHERE ID = :contact.Id];
                   userList = [SELECT Id, FirstName, LastName, Contact_id__c FROM User WHERE Id = :userIds.get(0).LastModifiedById];
               }
        }
    } 
    
    if(userList.size() > 0) {
        
        for(User user: userList) {
            
            if(user.FirstName != userIds.get(0).FirstName || user.LastName != userIds.get(0).LastName) {
                   
                   user.FirstName = userIds.get(0).FirstName;
                   user.LastName = userIds.get(0).LastName;
                   user.Contact_id__c = userIds.get(0).Id;
                   
               } else {
                   System.debug('Both records are identical.');
               }
        }
        
            try{
                update userList;
            } catch(DMLException e) {
                System.debug('An unexpected error occurred ' + e.getMessage());
            }
    }    
}