@isTest
public class AccountProcessorTest {

    public static testmethod void TestAccountProcessorTest() {
        
        // Put new data into Account
        Account a = new Account();
        a.Name = 'Test Account';
        Insert a;
        
        // Put new data into Account
        Contact cont = new Contact();
        cont.FirstName = 'Pavlo';
        cont.LastName = 'Shchur';
        cont.AccountId = a.Id;
        Insert cont;
        
        Set<Id> setAcctIds = new Set<Id>();
        setAcctIds.add(a.Id);
        
        Test.startTest();
        
        	AccountProcessor.countContacts(setAcctIds);
        
        Test.stopTest();
        
        Account Acct = [SELECT Number_of_Contacts__c FROM Account WHERE ID =: a.Id LIMIT 1];
        System.assertEquals(Integer.valueOf(Acct.Number_of_Contacts__c), 1);
        
        
    }
}