trigger SumOfContactsTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    List<Account> updateAccounts = new List<Account>();
    
    if(Trigger.isInsert || Trigger.isUpdate){
        for( Contact contact : Trigger.New){
            
            if(Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(contact.ID).Amount__c != contact.Amount__c)){
                updateAccounts = TriggerExecutorClass.execute(contact.AccountId);
            }
        }
    }
    
    if(Trigger.isDelete){
        for(Contact contact : Trigger.Old){   
            updateAccounts = TriggerExecutorClass.execute(contact.AccountId);
        } 
    }
    
    If(updateAccounts.size() > 0) {
        
        try{
            update updateAccounts;                
        } catch(DMLException e) {
            System.debug('An unexpected error occurred ' + e.getMessage());
        }
    }
}