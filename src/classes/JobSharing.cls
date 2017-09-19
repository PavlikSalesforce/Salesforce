public class JobSharing {
    
    public static boolean manualShare(List<Contact> recordId, Id userOrGroupId, String accessLevel){
        
        List<Contact> contactList = [SELECT Id FROM Contact WHERE Id IN : recordId];
        
        ContactShare jobShr  = new ContactShare();
        
            for(Contact c : contactList) {
                
                jobShr.ContactId = c.ID;
                
                jobShr.UserOrGroupId = userOrGroupId;
                
                jobShr.ContactAccessLevel = accessLevel;
                
                jobShr.RowCause = Schema.ContactShare.RowCause.Manual;
                
            }
        
        Database.SaveResult sr = Database.insert(jobShr,false);
        
            if(sr.isSuccess()){
                return true;
            }
            else {
                Database.Error err = sr.getErrors()[0];
                
                    if(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  
                       err.getMessage().contains('AccessLevel')){
                           return true;
                       }
                    else{
                        return false;
                    }
            }
    }
}