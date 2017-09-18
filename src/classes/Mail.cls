public class Mail {
    
    public void mailSending(Contact c) {
      	Messaging.reserveSingleEmailCapacity(2);
    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
        String[] toAddresses = new String[] {c.Email};
        String[] ccAddresses = new String[] {'pavloshchur@gmail.com'};
            
         	mail.setToAddresses(toAddresses);
        	mail.setCcAddresses(ccAddresses);
        mail.setReplyTo(c.Email);
        mail.setSenderDisplayName('Pavlo Shchur');
        mail.setSubject('New Opportunity Created');
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setPlainTextBody('Your Opportunity: ' + c.FirstName + ' has been created');
        mail.setHtmlBody('Your opportunity:<b> ' + c.Id +' </b>gas been created.');
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    }
    
    

}