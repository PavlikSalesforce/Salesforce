trigger Amount_Less_5000 on Opportunity (before insert, before update) {
                
    for(Opportunity o : Trigger.new) {
        if((o.Amount < 5000 || o.Amount == null) 
                && Trigger.isInsert) {
            o.addError('Amount can not be less than 5000');
        } else if ((o.Amount < 3000 || o.Amount == null) 
                && Trigger.isUpdate) {
            o.addError('For the existing Opportunity Amount can not be less than 3000');
         }
    }
}