trigger ExternalContact on Contact (after insert) {  

    for(Contact c: Trigger.new) {
        ExternalContactService.createExternalContact(c.FirstName, c.LastName);
    }      
}