trigger FutureMethodTrigger on HttpRequest__c (after insert) {
    
    if(Trigger.isInsert) {
        for(HttpRequest__c s : Trigger.new){
        	FutureMethod.createNewHttpRequest(s.Id);
            System.debug('call future method');
        }
    }
      
}