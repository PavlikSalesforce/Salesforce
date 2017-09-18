public class AccountProcessor {
    
    @future
    public static void countContacts (Set<id> setIds) {
        List<Account> listAccounts = [SELECT Id, Number_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :setIds];
        for(Account acct: listAccounts) {
            List<Contact> listContacts = acct.Contacts;
            acct.Number_of_Contacts__c = listContacts.size();           
        }
            update listAccounts;

    }
}