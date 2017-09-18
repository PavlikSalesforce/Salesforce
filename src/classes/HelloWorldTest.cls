@isTest(seeAllData = true)
public class HelloWorldTest {
    
    static testmethod void testHelloWorld() {
        
        List<Lead> listOfLeads = [SELECT Id, Company, FirstName, LastName, Email FROM Lead];
        
        listOfLeads[0].Company = 'TestCompany';
        listOfLeads[0].FirstName = 'TestName';
        listOfLeads[0].LastName = 'TestSurname';
        listOfLeads[0].Email = 'pavloshchur@ukr.net';
        
        update listOfLeads;
        
        Test.startTest();
        
        System.assertEquals('Hello', listOfLeads[0].FirstName);
        System.assertEquals('World', listOfLeads[0].LastName);
        
        Test.stopTest();
    }  
}