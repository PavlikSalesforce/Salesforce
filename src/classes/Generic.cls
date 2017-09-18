public class Generic {
    
    public void genericMethod (String someObject, List<String> fields, List<String> values, String dmlOperation){  
               
        if(dmlOperation.equalsIgnoreCase('insert')) {
            
	    Map<String, Schema.SObjectType> m_objects = Schema.getGlobalDescribe();
		sObject n = m_objects.get(someObject).newSObject();
            
            for(Integer i = 0; i < fields.size() && i < values.size(); i++) {
	    		n.put(fields.get(i), values.get(i));                
            }
            
		insert n;            
     
        }       
    }	
}