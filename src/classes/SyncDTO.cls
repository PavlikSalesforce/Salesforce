public class SyncDTO extends SyncDTOAbstract {
    
        
        private String contactId;
        private String firstName;
        private String lastName;
        
            public String toMap(String firstName, String lastName) {
                
                Map<String, String> parameters = new Map<String, String>();
                
                parameters.put('FirstName', firstName);
                parameters.put('LastName', lastName);
                
                return JSON.serialize(parameters);
            }
            
        
        public String toMap(String contactId, String firstName, String lastName) {
            
            Map<String, String> parameters = new Map<String, String>();
            
            parameters.put('contactId', contactId);
            parameters.put('firstName', firstName);
            parameters.put('lastName', lastName);
            
            return JSON.serialize(parameters);
        }
    }