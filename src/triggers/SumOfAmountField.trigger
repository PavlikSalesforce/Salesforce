trigger SumOfAmountField on CustomContact__c (after insert, after update, after delete, after undelete) {
    
    /*if(Trigger.isInsert || Trigger.isUpdate) {
        Id[] accIds = new List<Id>();
    
    for(CustomContact__c c: Trigger.new){
        accIds.add(c.CustomAccount__c);
    }
    
    CustomAccount__c acc = [SELECT Id, SUM_Valid__c FROM CustomAccount__c WHERE Id in :accIds LIMIT 1];
    AggregateResult[] groupResults = [SELECT SUM(Amount__c)sum FROM CustomContact__c WHERE CustomContact__c.CustomAccount__c =: acc.Id];
    Object sumAmount = groupResults[0].get('sum');
        
    acc.SUM_Valid__c = (Double)sumAmount;
    update acc;
        
       List<CustomContact__c> customContact = [SELECT Id, Amount__c FROM CustomContact__c WHERE  CustomContact__c.CustomAccount__c =: acc.Id];
        
        for(CustomContact__c c: customContact) {
               if (Schema.sObjectType.CustomContact__c.fields.Amount__c.isAccessible()) {
        AggregateResult[] groupResults_2 = [SELECT SUM(Amount__c)sum FROM CustomContact__c WHERE CustomContact__c.CustomAccount__c =: acc.Id];
    Object sumAmount_2 = groupResults_2[0].get('sum');
        
    acc.SUM_Valid__c = (Double)sumAmount_2;
    update acc;
} 
        }
        
   
    } */
    
    }