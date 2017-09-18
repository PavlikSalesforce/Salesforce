@isTest(seeAllData = false)
public class AttachmentTriggerTest {
    
    public static List<Account> acctList;
    public static List<Attachment> atList;
    public static Set<Id> acctIdsSet;
    
    
    static void initAccount() {
        acctList = new List<Account>();
        atList = new List<Attachment>();
        acctIdsSet = new Set<Id>();
                Account acct = new Account(Name = 'Test');
                Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body'); 
                Attachment at = new Attachment(Name = 'Test ', Body = bodyBlob, ParentId = acct.Id);
                acctIdsSet.add(at.parentid);
         
		insert acct;
        System.debug(acct.Id);

    }
    
       static testMethod void testWithExistingAttachment(){
        List<Account> updatedAccountList = new List<Account>();
        
        initAccount();
        Test.startTest();
        updatedAccountList = [SELECT Id, has_attachment__c FROM Account WHERE ID IN : acctIdsSet];
        System.debug('www' + acctIdsSet);
        System.assertEquals(1, updatedAccountList.size());
        
        Test.stopTest();        
    }
    
    
    static testMethod void testWithDoesntExistingAttachment(){
        List<Account> updatedAccountList = new List<Account>();
        
        initAccount();
        Test.startTest();
        insert acctList;
        updatedAccountList = [SELECT Id, has_attachment__c FROM Account WHERE has_attachment__c = true];
        
        System.assertEquals(0, updatedAccountList.size());
        
        Test.stopTest();        
    } 
}