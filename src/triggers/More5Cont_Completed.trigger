trigger More5Cont_Completed on Contact (after insert, after update, after delete, after undelete) {
    
    
    Set<Id> accountIdsSet = new Set<Id>();
    Set<Id> contactIdsSet = new Set<Id>();
    List<Contact> verifyAgeContactList = new List<Contact>();
    
        if(Trigger.IsAfter){
            
                if(Trigger.IsInsert || Trigger.IsUndelete){
                    for(Contact c : Trigger.new){
                        
                        if(c.AccountId != null){   
                            accountIdsSet.add(c.AccountId); 
                        }
                        
                    }
                }
            
                if(Trigger.IsDelete){
                    for(Contact c : Trigger.Old){
                        
                        if(c.AccountId != null){   
                            accountIdsSet.add(c.AccountId); 
                        }
                        
                    }
                }
            
                if(Trigger.IsUpdate){
                    for(Contact c : Trigger.New){
                        
                        if(Trigger.isUpdate && Trigger.oldMap.get(c.ID).Age__c != c.Age__c) {
                            contactIdsSet.add(c.Id);
                        }
                        
                        if(c.AccountId != null){   
                            accountIdsSet.add(c.AccountId); 
                        }
                    }
                }
            
        }
    
    More5Cont_CompletedProcessClass.verifyAgeContactListMethod(contactIdsSet);
    More5Cont_CompletedProcessClass.accountStatus_Completed_Draft(accountIdsSet);
      
}