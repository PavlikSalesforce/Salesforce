trigger JoinContactToCase on Case (before insert, before update) {
        
    public Map<String, Contact> contactsMap = new Map<String, Contact>();
    public Map<String, Contact> createdContacts;
    public List<String> mailsList = new List<String>();
    public List<Contact> contactToCreate = new List<Contact>();
    public List<Integer> remainderCases = new List<Integer>();
    Integer caseNumber = 0;
    
    for(Case myCase : Trigger.new) {
        if(myCase.ContactId == null && myCase.SuppliedEmail != null) {
            mailsList.add(myCase.SuppliedEmail);
        }
    }
    
    contactsMap = getContacts(MailsList);
    
    for(Case myCase : Trigger.new) {
        if(myCase.ContactId == null && myCase.SuppliedEmail != null) {
            if(contactsMap.containsKey(myCase.SuppliedEmail)) {
            myCase.ContactId = contactsMap.get(myCase.SuppliedEmail).Id;
        }
        else {
            contactToCreate.add(new Contact(Email = myCase.SuppliedEmail,
                                           LastName = myCase.SuppliedEmail));
            remainderCases.add(caseNumber);
        }
    }
    
    caseNumber++;
}
insert contactToCreate;
    
    createdContacts = getContactsByMap(contactTocreate);
    
    for(Integer theCaseNumber : remainderCases) {
        if(createdContacts.containsKey(Trigger.new[theCaseNumber].SuppliedEmail)) {
            Trigger.new[theCaseNumber].ContactId = createdContacts.get(Trigger.new[theCaseNumber].SuppliedEmail).Id;
        }
    }
    
    public Map<String, Contact> getContacts(List<String> mails) {
        return getContactsByMap([
            SELECT Id, Email FROM Contact WHERE Email IN : mails]);
    }
    
    public Map<String, Contact> getContactsByMap(List<Contact> contactsList) {
        Map<String, Contact> result = new Map<String, Contact>();
        
        for(Contact myContact : contactsList) {
            result.put(myContact.Email, myContact);
        }
        return result;
    }
}