trigger ContactSyncGeneralTrigger on Contact (after insert, after update, before update, before delete) {
        
        
    if(Trigger.isInsert) {

        for(Contact c : Trigger.new) {

            SyncService.process( 
                new CreateContact(),
                c.Id                
            );

        }
    }      

 
    if(Trigger.isUpdate) {
       
        for(Contact c : Trigger.new) {
           
            Contact beforeUpdate = System.Trigger.oldMap.get(c.Id);
            
            if(beforeUpdate.FirstName != c.FirstName 
                ||
               beforeUpdate.LastName != c.LastName
            ){

                SyncService.process( 
                    new UpdateContact(),
                    c.Id 
                ); 
            }
        } 
    }


    if(Trigger.isDelete) {
        
        for(Contact c : Trigger.old) {

            SyncService.process( 
                new DeleteContact(),
                c.Id 
            ); 

        }
    } 
}