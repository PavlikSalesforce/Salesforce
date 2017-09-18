trigger Duplicate on Contact (after insert) {
   
    for(Contact c : Trigger.new) {
            ExternalContactService.syncContact(c.Id);
        } 
    }