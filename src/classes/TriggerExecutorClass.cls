public class TriggerExecutorClass {
    
    public static List<Account> execute (Set<Id> accountId) {
        
        Map<Id, Decimal> prequalifiedAmountMap = TriggerHelperClass.getSumOfPrequalifiedAmount(accountId);
        Map<Id, Decimal> numberOfContactsMap = TriggerHelperClass.getNumberOfContacts(accountId);
        List<Account> updateAccounts = TriggerHelperClass.performCalculation(accountId);
       // TriggerHelperClass.updateAccounts(updateAccounts);
        
        return updateAccounts;
        
    }

}