trigger SumOfContactsTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    Set<Id> ids = new Set<Id>();
    List<Account> updateAccounts = new List<Account>();
    
    if(Trigger.isInsert || Trigger.isUpdate){
        for( Contact contact : Trigger.New){
            
            if(Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(contact.ID).Amount__c != contact.Amount__c)){
                               
                ids.add(contact.AccountId);
            }
            
        }
        updateAccounts = TriggerExecutorClass.execute(ids);
    }
    
    if(Trigger.isDelete){
        for(Contact contact : Trigger.Old){
            ids.add(contact.AccountId);
        } 
        updateAccounts = TriggerExecutorClass.execute(ids);
    }
    
    If(updateAccounts.size() > 0) {
        
        try{
            update updateAccounts;                
        } catch(DMLException e) {
            System.debug('An unexpected error occurred ' + e.getMessage());
        }
    }
}