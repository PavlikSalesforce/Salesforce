trigger CustomContactDynamicTrigger on CustomContactDynamic__c (before insert, before update) {

 if ( Trigger.isBefore ){
        
        if ( Trigger.isInsert || Trigger.isUpdate ){
            
            CustomContactDynamicTriggerService service = new CustomContactDynamicTriggerService();
            for(CustomContactDynamic__c customContact : Trigger.new){
                List<String> fields = service.getAllAmountFields();
             Double summ = service.getSumOfAllAmountFields(fields, customContact);
                customContact.SUM_dynamic__c = summ;   
                
            }
        }       
    }
}