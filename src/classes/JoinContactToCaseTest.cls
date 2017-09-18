@isTest(seeAllData = false)
private class JoinContactToCaseTest {
		
    public static List<Contact> contactsList;
    public static List<Case> casesList;
    public static String email1;
    
    static void init() {
        contactsList = new LIst<Contact>();
        casesList = new List<Case>();
        
        email1 = 'toto@toto.com';
        
        casesList.add(new Case(SuppliedEmail = email1));
    }
    
    static testMethod void testWithExistingContact(){
        init();
        Test.startTest();
        
        contactsList.add(new Contact(
        Email = email1, LastName = email1));
        
        insert contactsList;
        insert casesList;
        
        casesList = [SELECT Id, ContactId FROM Case WHERE Id =: casesList[0].Id];
        
        System.assertEquals(casesList[0].ContactId, contactsList[0].Id);
        
        Test.stopTest();
    }
    static testMethod void testWithDoesntExistingContact() {
        init();
        Test.startTest();
        insert casesList;
        
        casesList = [SELECT Id, ContactId FROM Case WHERE Id =: casesList[0].Id];
        contactsList = [SELECT Id, Email FROM Contact Where Email =: email1];
        
        System.assertEquals(casesList[0].ContactId, contactsList[0].Id);
        
        Test.stopTest();
    }
}