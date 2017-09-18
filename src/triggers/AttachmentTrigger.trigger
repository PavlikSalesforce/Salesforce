trigger AttachmentTrigger on Attachment (before insert) {
			
    List<Account> acctList = new List<Account>();
    List<Account> acctListAfterUpdate = new List<Account>();
    Set<Id> acctIdsSet = new Set<Id>();
    
    for(Attachment at : Trigger.new) {
        acctIdsSet.add(at.parentid);
    }
    
    acctList = [SELECT Id, has_attachment__c FROM Account WHERE ID IN : acctIdsSet];
    
    if(acctList != null && acctList.size() > 0) {
        for(Account acct : acctList) {
            acct.has_attachment__c = true;
            acctListAfterUpdate.add(acct);
        }
        
        update acctListAfterUpdate;
    }
}