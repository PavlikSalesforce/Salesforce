trigger ContactSyncTrigger on HttpRequest__c (after insert) {
    
    
    for(HttpRequest__c s : Trigger.new){
        
        ExecutorClass.performObject(s.Id);
        
    } 

}