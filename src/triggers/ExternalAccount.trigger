trigger ExternalAccount on Account (after insert) {
      
        for (Account acct : Trigger.new) {
            ExternalAccountService.createExternalAccount(acct.Id);
            
     }
 }