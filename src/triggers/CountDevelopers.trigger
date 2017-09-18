trigger CountDevelopers on Employee__c (after insert, after update, after delete) {
			
    List<Employee__c> emp = Trigger.isDelete ? Trigger.old:Trigger.new;
    
    Set<Id> projectIds = new Set<Id>();
    
    
}