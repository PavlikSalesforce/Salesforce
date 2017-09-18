public class JobSharing {
    
    public static boolean manualShare(Id recordId, Id userOrGroupId, String accessLevel){
        
        ContactShare jobShr  = new ContactShare();
        
            jobShr.ContactId = recordId;
            
            jobShr.UserOrGroupId = userOrGroupId;
            
            jobShr.ContactAccessLevel = accessLevel;
            
            jobShr.RowCause = Schema.ContactShare.RowCause.Manual;
        
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