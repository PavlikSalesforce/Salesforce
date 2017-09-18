@isTest
private class TestRestrictContactByName {
    @isTest static void checkInsert(){
        Contact contact = new Contact(LastName = 'INVALIDNAME', FirstName = 'Error');
        Test.startTest();
        try {
            insert contact;
        } catch(Exception e){
            Test.stopTest();
        }
        
    }
}