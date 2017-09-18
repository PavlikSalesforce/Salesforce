trigger CustomContactTrigger on CustomContact__c (after insert, after update, after delete) {

    if ( Trigger.isAfter ){
        
        if ( Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete ){
            
            CustomContactTriggerService service = new CustomContactTriggerService();
            
            service.recalculateAccountSum( 
                service.filterAccountIdsToRecalculateSum( Trigger.oldMap, Trigger.new ) 
            );
            
        }       
    }
    
}