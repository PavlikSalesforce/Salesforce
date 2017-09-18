trigger ContactDeleteTrigger on Contact (before delete, after delete) {
       
    if(Trigger.isDelete) {
            for(Contact c : [SELECT Id, FirstName, LastName FROM Contact 
            WHERE Id IN: Trigger.old]) {
        FutureMethod.deleteExternalObjectMatchId(c.FirstName, c.LastName);
        }        
    }
}