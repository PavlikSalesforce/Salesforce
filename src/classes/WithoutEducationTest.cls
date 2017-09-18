@isTest
public class WithoutEducationTest {
    
    @isTest static void TestOne() {
        List<Account> accList = new List<Account>();
        Integer count = 5000;
        for(Integer i = 0; i < count;i++)
        {
            accList.add(new Account(Name='My Account '+ i, Industry = 'Education'));
        }
       
        Test.startTest();
         insert accList;
        Test.stopTest();
        
        System.assertEquals(0, accList.size());
    }
    
        @isTest static void TestTwo() {
        List<Account> accList = new List<Account>();
        Integer count = 5000;
        for(Integer i = 0; i < count;i++)
        {
            accList.add(new Account(Name='My Account '+ i, Industry = 'Energy'));
        }
        Test.startTest();
         insert accList;
        Test.stopTest();
            
        System.assertEquals(count, accList.size());
    }
    
    @isTest static void TestThree()
    {
        List<Account> accList = new List<Account>();
        Integer count = 5000;
        for(Integer i = 0; i < count;i++)
        {
            accList.add(new Account(Name='My Account '+ i, Industry = 'Energy'));
        }       
        insert accList;
        
        List<Contact> contList=new List<Contact>();
        for(Integer i = 0; i < count; i++)
        {
            contList.add(new Contact(Email='contact@gmail' + i + '.com', LastName='Contacter '+i));
        }
        insert contList;
        
        List<Contact> res = [Select Id,AccountId From Contact Where Id IN :contList ORDER BY Id];
        
        for(Integer i = 0 ; i < count; i++)
        {
            System.assertNotEquals(accList[i].Id, res[i].AccountId);
        }        
    }
    
    
    @isTest static void TestFour()
    {
        List<Account> accList = new List<Account>();
        Integer count = 5000;
        for(Integer i = 0; i < count;i++)
        {
            accList.add(new Account(Name='16', Industry = 'Energy'));
        }
        
        insert accList;
        
        List<Contact> contList=new List<Contact>();
        for(Integer i = 0; i < count; i++)
        {
            contList.add(new Contact(Email = 'contact@gmail' + i + '.com', LastName = 'Contacter '+i));
        }
        Test.startTest();
         insert accList;
        Test.stopTest();
        
        List<Contact> res = [SELECT Id, AccountId FROM Contact WHERE Id IN : contList ORDER BY Id];
        
        for(Integer i = 0 ;i < count; i++)
        {
            System.assertEquals(accList[i].Id, res[i].AccountId);
        }        
    }

}