public with sharing class RESTPageCotroller {
    
    public String contactFirstName { get; set; }
    public String contactLastName { get; set; }
    public String contactEmail { get; set; }
    public String searchName { get; set; }
    public List<Contact> contacts { get; set; }
    
    ApexPages.StandardController controller;
    
    public RESTPageCotroller () {
        
    }
    
    public RESTPageCotroller(ApexPages.StandardController stdController)
    {
        controller = stdController;
    }
    
    public ApexPages.PageReference saveRecord()
    {
        Contact newContact = new Contact();
        newContact.FirstName = contactFirstName;
        newContact.LastName = contactLastName;
        newContact.Email = contactEmail;
        
        try
        {
            insert newContact;
        }
        catch(Exception e) {
            return null;
        }
        
        return controller.view();
    }
    
    private String sortOrder = 'LastName';
    
    public List<Contact> getContacts() {
        
        List<Contact> results = Database.query(
            'SELECT Id, FirstName, LastName, Email ' +
            'FROM Contact ' +
            'ORDER BY ' + sortOrder + ' ASC ' +
            'LIMIT 10'
        );
        return results;
    }
    
    public PageReference searchContacts()
    {
        contacts = [select Id,
                    FirstName, LastName, Email
                    from Contact
                    where LastName = :searchName];
        return null;
    }
    
}