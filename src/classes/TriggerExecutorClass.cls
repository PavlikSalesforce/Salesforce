public class TriggerExecutorClass {
    
    public static List<Account> execute (Id accountId) {
        
        Set<Id> AccountIds = TriggerHelperClass.saveAccountIds(accountId);
        Map<Id, Decimal> totalAmountMap = TriggerHelperClass.getSumOfPrequalifiedAmount(AccountIds);
        List<Account> updateAccounts = TriggerHelperClass.getNumberOfContacts(totalAmountMap);
        
        return updateAccounts;
        
    }

}