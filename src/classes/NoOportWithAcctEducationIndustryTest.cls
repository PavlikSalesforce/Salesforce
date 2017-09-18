@isTest
public class NoOportWithAcctEducationIndustryTest {
    
    @isTest
    public static void WithoutEducationAccount() {
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();  
        
        for(Integer i = 0; i < 100; i++) {
            accList.add(new Account(Name='My Account '+ i, Industry = 'Education'));
        }
        
         insert accList; 
        
        for(Integer i = 0; i < accList.size(); i++) {
            oppList.add(new Opportunity(Name='My Opportunity '+ i, CloseDate = Date.today(), StageName = 'Prospecting',
                                       AccountId = accList.get(i).Id));
        }
        
        Test.startTest();
         insert oppList;
        Test.stopTest();  
        
        System.assertEquals(0, oppList.size());

    }
}