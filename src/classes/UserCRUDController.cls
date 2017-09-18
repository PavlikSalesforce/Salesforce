public class UserCRUDController {
 
    public String firstName { get; set; }
    public String secondName { get; set; }
    
   /* public PageReference registerUser() {
        PageReference newPage = new PageReference('/');
        newPage.setRedirect(true);
        insert new CustomContact__c (FirstName__c = firstName, LastName__c = secondName);
        return null;
    } */

    
	public List<ContactWrapper> contactWrapper {
        get{
            if ( contactWrapper == null ){
                contactWrapper = new List<ContactWrapper>();
            	
                List<CustomContact__c> contacts = 
                    [SELECT Id, Name, FirstName__c, LastName__c
                     FROM CustomContact__c
                     ORDER BY FirstName__c];
                
                for ( CustomContact__c ccont : contacts ){
                    contactWrapper.add( new ContactWrapper( ccont ) );
                }  
                
            }
        	return contactWrapper;
        }
        private set;
    }
    
    
    public PageReference registerUser() {
   
        insert new CustomContact__c (
            FirstName__c = firstName, 
            LastName__c = secondName
        );
            
        return null;
    }

    public Boolean getHasContactAccessed(){
        return CustomContact__c.getSObjectType().getDescribe().isAccessible();
    }
    
    
    public Id recordIdToDelete{get;set;}
    
    public void deleteRecord(){
        delete new CustomContact__c(
            Id = recordIdToDelete
        );
        
        contactWrapper = null;
    }

    
    public class ContactWrapper{
        
        public String firstName {get;set;}
        public String lastName {get;set;}
        public Id recordId {get;set;}
        
        public ContactWrapper( CustomContact__c cont ){
            this.firstName = cont.FirstName__c;
            this.lastName = cont.LastName__c;
            this.recordId = cont.Id;
        }  
        
    }  
}