trigger WithoutEducation on Account (after insert, after update, before insert) {
    
    if(Trigger.isInsert) {
    
    for(Account acct : Trigger.New) {
        List<Contact> ct = new List <Contact>();
        if(acct.Industry == 'Education') {
          /*  acct.addError('Education Industry is not allowed'); */
        } else if (acct.Name == '16') {
            ct.add (new Contact(
                         FirstName = 'Account16',
                         LastName = 'Email',
                         AccountId = acct.id,
                         Fax=acct.Fax,
                         MailingStreet = acct.BillingStreet,
                         MailingCity = acct.BillingCity,
                         MailingState = acct.BillingState,
                         MailingPostalCode = acct.BillingPostalCode,
                         MailingCountry = acct.BillingCountry,
                         Phone = acct.Phone
                        )
                    );
            }
          insert ct;
        }
    }
}