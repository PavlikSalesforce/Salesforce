global class BatchContact implements Database.Batchable<sObject> {
    
    	global final String query;
    	global final String s_object;
    	global final String field;
    	global final String field_value;
    
    global BatchContact(String q, String s, String f, String v) {
        query = q;
        s_object = s;
        field = f;
        field_value = v;
    }	
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> batch) {
        for(sObject o : batch) {
            o.put(Field, field_Value);
        }
        update batch;
    }
    
    global void finish(Database.BatchableContext bc) {
        
    }
}