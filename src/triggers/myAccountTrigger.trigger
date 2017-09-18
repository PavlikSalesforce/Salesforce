trigger myAccountTrigger on Account (before delete, before insert, before update, after delete, after insert, after update) {
        
    // Step 0: Create a master list to hold the emails we'll send
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    
                if(Trigger.isInsert) {
                    List<Contact> contacts = new List<Contact>();
                    for(Account a : Trigger.new) {
                        if(a.Name == 'makeContact') {
                            contacts.add(new Contact(FirstName = a.Name, LastName = a.Name,
                                                     Email = 'pavloshchur@ukr.net',
                                                    AccountId = a.Id));
                            
                            // Step 1: Create a new Email
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                            
                            
                            // Step 2: Set list of people who should get the email
                            List<String> sendTo = new List<String>();
                            for(Contact c: contacts) {
                            sendTo.add(c.Email);
                            mail.setToAddresses(sendTo);    
                                                     
                            // Step 3: Set who the email is sent from
                            mail.setReplyTo('pavloshchur@gmail.com');
                            mail.setSenderDisplayName('Official Bank of Nigeria');
    
      

                            // Step 4. Set email contents - you can use variables!
                            mail.setSubject('URGENT BUSINESS PROPOSAL');
                            String body = 'Dear ' + c.FirstName + ', ';
                            body += 'I confess this will come as a surprise to you.';
                            body += 'I am John Alliston CEO of the Bank of Nigeria.';
                            body += 'I write to request your cooperation in this ';
                            body += 'urgent matter as I need a foreign partner ';
                            body += 'in the assistance of transferring $47,110,000 ';
                            body += 'to a US bank account. Please respond with ';
                            body += 'your bank account # so I may deposit these funds.';
                            mail.setHtmlBody(body);
    
                            // Step 5. Add your email to the master list
                            mails.add(mail);
                            }
                        }
                            // Step 6: Send all emails in the master list
                            Messaging.sendEmail(mails);
                        
                    }
                    insert contacts;
                } 
        }