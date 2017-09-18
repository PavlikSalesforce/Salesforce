@isTest
public class HelloWrld_2TestClass {
		
    static testMethod void validateHelloWorld_2() {
        Book_2__c b = new Book_2__c(Name = 'Behind the Cloud', Price__c = 100);
        System.debug('Price before inserting new book ' + b.Price__c);
        insert b;
        
        b = [SELECT Price__c FROM Book_2__c WHERE Id =:b.Id];
        System.debug('Price after trigger fired ' + b.Price__c);
        
        System.assertEquals(90, b.Price__c);
    }
}