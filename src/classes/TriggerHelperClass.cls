public class TriggerHelperClass {
    
    public static Set<Id> accountIds = new Set<Id>();       
    
    public static Map<Id, Decimal> getSumOfPrequalifiedAmount(Set<Id> accountId) {
        
        accountIds.addAll(accountId);
        
        Map<Id, Decimal> prequalifiedAmountMap = new Map<Id, Decimal>();
        
        if(!accountIds.isEmpty()) {
            
            for(Contact contact : [SELECT Id, Amount__c, AccountId 
                                   FROM Contact 
                                   WHERE AccountId IN: accountIds])
            {
                
                if(contact.Amount__c == null) {
                    contact.Amount__c = 0;
                    
                }
                
                Decimal TotalAmount = 0;
                
                if(prequalifiedAmountMap.containsKey(contact.AccountId)) {
                    TotalAmount = PrequalifiedAmountMap.get(contact.AccountId);            
                } 
                
                TotalAmount = TotalAmount + contact.Amount__c;
                
                prequalifiedAmountMap.put(contact.AccountId, TotalAmount);           
            } 
        }
        
        return prequalifiedAmountMap;
        
    }
    
    
    //IF YOU USE Map<Id, Decimal> in getSumOfPrequalifiedAmount, WHY NOT USE SMTH LIKE THIS HERE?
    //      YOU HAVE getNumberOfContacts, BUT FOR SOME REASON IT CALCUALTES SUM AS WELL.
    //      SEPARATE LOGIC: MAKE getNumberOfContacts TO RETURN MAP AS WELL AND THEN CREATE 
    //      SEPARATE METHOD TO HANDLE UPDATE OF ACCOUNTS BASED ON THESE 2 MAPS.
    
    public static  Map<Id, Decimal> getNumberOfContacts (Set<Id> accountId) {
        
        Map<Id, Decimal> numberOfContactsMap = new Map<Id, Decimal>();
        
        if(!accountId.isEmpty()) {
            System.debug('if(!accountId.isEmpty())  accountId = 50 ' + accountId);
            for(AggregateResult r : 
                [SELECT AccountId AcctId, Count(id) ContactCount 
                 FROM Contact 
                 WHERE AccountId IN: accountId 
                 GROUP BY AccountId]
               ) {
                   System.debug('for(AggregateResult r :');
                   Account account = new Account();
                   
                   account.Id = (Id) r.get('AcctId');
                   account.NumberOfContacts__c = (Integer) r.get('ContactCount');                        
                   numberOfContactsMap.put(account.Id, account.NumberOfContacts__c);   
               }
            
            //PUT DELETION INTO SEPARATE METHOD. SEEMS TO BE CONFUSIVE.
        } else {
            
            Account account = [SELECT Id, NumberOfContacts__c FROM Account WHERE ID IN :accountIds];
            account.NumberOfContacts__c = 0;
            numberOfContactsMap.put(account.Id, account.NumberOfContacts__c);
        }
        
        return numberOfContactsMap;
        
    }
    
    public static List<Account> performCalculation(Set<Id> accountIds) {
        
      Map<Id, Decimal> prequalifiedAmountMap = TriggerHelperClass.getSumOfPrequalifiedAmount(accountIds);
      Map<Id, Decimal> numberOfContactsMap = TriggerHelperClass.getNumberOfContacts(accountIds);
        
        List<Account> updateAccounts = new List<Account>();
        
        for(Account a: [SELECT Id, NumberOfContacts__c, SumOfPrequalifiedAmount__c FROM Account WHERE Id IN : accountIds]) {
            
            Account account = new Account();
            
            account.Id = a.Id;
            account.NumberOfContacts__c = numberOfContactsMap.get(account.Id);                        
            account.SumOfPrequalifiedAmount__c = prequalifiedAmountMap.get(account.Id);  
            
            updateAccounts.add(account);   
        }
        
                if(updateAccounts.size() > 0) {

                try{
                    update updateAccounts; 
                } catch(DMLException e) {
                    System.debug('An unexpected error occurred ' + e.getMessage());
                }
        }
        
        return updateAccounts;
        
    }
    
    public static void updateAccounts(List<Account> updateAccounts) {
        
        if(updateAccounts.size() > 0) {

                try{
                    update updateAccounts; 
                } catch(DMLException e) {
                    System.debug('An unexpected error occurred ' + e.getMessage());
                }
        }
    }
    
}