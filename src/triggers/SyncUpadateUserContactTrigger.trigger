trigger SyncUpadateUserContactTrigger on User (after insert, after update) {
    
    List<User> userList = new List<User>();
    List<Contact> contactList = new List<Contact>();
    
        if(Trigger.isInsert || Trigger.isUpdate){
            for( User user : Trigger.New){
                
                if(Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(user.ID).FirstName != user.FirstName)
                   || (Trigger.isUpdate && Trigger.oldMap.get(user.ID).LastName != user.LastName)){
                       userList = [SELECT Id, FirstName, LastName FROM User WHERE Id = :user.Id];
                       contactList = [SELECT FirstName, LastName
                                      FROM Contact
                                      WHERE Id = :user.Contact_id__c];
                   }
            }
        }
    
    if (contactList.size() > 0) {
        
        for (Contact c : contactList) {
            
            if(c.FirstName != userList.get(0).FirstName || c.LastName != userList.get(0).LastName) {
                
                c.FirstName = userList.get(0).FirstName;
                c.LastName = userList.get(0).LastName;
                
            } else {
                System.debug('Both records are identical.');
            }
        }
        
            try{
                update contactList;
            } catch(DMLException e) {
                System.debug('An unexpected error occurred ' + e.getMessage());
            }
    }  
}