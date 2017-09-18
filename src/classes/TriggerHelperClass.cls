public class TriggerHelperClass {
    
    public static Set<Id> AccountIds = new Set<Id>();
    
    
    public static Integer getNumberOfContacts(Id accountId) {
        List<Contact> accountList = new List<Contact>();
        accountList = [SELECT Id, LastName FROM Contact WHERE AccountId = :accountId];
        
        return   accountList.size();      
    }
    
    public static Set<Id> saveAccountIds(Set<Id> accountId) {
        
        AccountIds.addAll(accountId);
        System.debug('');
        
        return AccountIds;       
    }
    
    public static Map<Id, Decimal> getSumOfPrequalifiedAmount(Set<Id> AccountIds) {
        Map<Id, Decimal> totalAmountMap = new Map<Id,Decimal>();
        for(Contact contact : [SELECT Id, Amount__c, AccountId FROM Contact WHERE AccountId IN: AccountIds]){
            
            if(contact.Amount__c == null) {
                contact.Amount__c = 0;
            }
            
            Decimal TotalAmount = 0;
            if(totalAmountMap.containsKey(contact.AccountId)) {
                TotalAmount = totalAmountMap.get(contact.AccountId);            
            } 
            TotalAmount = TotalAmount + contact.Amount__c;
            totalAmountMap.put(contact.AccountId, TotalAmount);           
        }
        return totalAmountMap;
        
    }
    
    public static List<Account> getNumberOfContacts (Map<Id, Decimal> totalAmountMap) {
        List<Account> updateAccounts = new List<Account>();
        if(TotalAmountMap.size() > 0) {
            for(Id accountId : TotalAmountMap.keySet()){
                Account account = [SELECT Id, SumOfPrequalifiedAmount__c, NumberOfContacts__c FROM Account WHERE ID = :accountId];
                account.SumOfPrequalifiedAmount__c = TotalAmountMap.get(accountId);
                account.NumberOfContacts__c = TriggerHelperClass.getNumberOfContacts(accountId);
                updateAccounts.add(account);
                
            } 
        } else {
            for(Id acctId: AccountIds) {
                Account account = [SELECT Id, SumOfPrequalifiedAmount__c, NumberOfContacts__c FROM Account WHERE ID = :acctId];
                account.SumOfPrequalifiedAmount__c = 0;
                account.NumberOfContacts__c = 0;
                updateAccounts.add(account);
            }
        }
        
        return updateAccounts;
        
    }
    
}