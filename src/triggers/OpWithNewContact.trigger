trigger OpWithNewContact on Opportunity (after insert) {
    
        Mail mail = new Mail();
            
        Contact c = new Contact();
    
            for(opportunity o : Trigger.new) {
                c.AccountId = o.AccountId;
                c.FirstName = 'Owner18Mail'; 
                c.LastName = 'Owner18Mail';
                c.Email = 'pavloshchur@ukr.net';               
    }
    insert c;
    mail.mailSending(c);
}