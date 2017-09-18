trigger HelloWorld on Lead (before update) {
    
    	List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		
   			 for(Lead l : Trigger.new) {
       			 l.FirstName = 'Hello';
        		 l.LastName = 'World';
        
        if(l.Email == null) {
            l.Email = 'pavloshchur@ukr.net';
        }
            List<String> sendTo = new List<String>();
            sendTo.add(l.Email);
            
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(sendTo);
            
            mail.setReplyTo('pavloshchur@gamil.com');
            mail.setSenderDisplayName('Mark Johan');
            mail.setSubject('URGENT BUSINESS PROPOSAL');
            
      		String body = 'Dear ' + l.FirstName + ', ';
      		body += 'I confess this will come as a surprise to you.';
      		body += 'I am John Alliston CEO of the Bank of Nigeria.';
      		body += 'I write to request your cooperation in this ';
      		body += 'urgent matter as I need a foreign partner ';
      		body += 'in the assistance of transferring $47,110,000 ';
      		body += 'to a US bank account. Please respond with ';
      		body += 'your bank account # so I may deposit these funds.';
      		mail.setHtmlBody(body);
            
            mails.add(mail);
            Messaging.sendEmail(mails);
        }
    }