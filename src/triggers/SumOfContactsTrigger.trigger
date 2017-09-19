trigger SumOfContactsTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    
    //PUT AS LESS LOGIC INTO TRIGGER HERE AS POSSIBLE. REMOVE UPDATE HERE. REMOVE ids. WHY NOT TO PUT IT INTO TriggerExecutorClass?
    
    
    Set<Id> ids = new Set<Id>();
    
        if(Trigger.isAfter){
            if(Trigger.isInsert || Trigger.isUpdate){
                for( Contact contact : Trigger.New){
                    
                    if(Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(contact.ID).Amount__c != contact.Amount__c)){
                        
                        ids.add(contact.AccountId);
                        
                    }
                    
                }
                TriggerExecutorClass.execute(ids);
            }
            
            if(Trigger.isDelete){
                
                for(Contact contact : Trigger.Old){
                    ids.add(contact.AccountId);
                } 
                
                TriggerExecutorClass.execute(ids);
            }
        }
    
}