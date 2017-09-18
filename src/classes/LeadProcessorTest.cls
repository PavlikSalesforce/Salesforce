@isTest
public class LeadProcessorTest {
	@isTest
    public static void testLeadProcessorTest () {
        List<Lead> leadList = new List<Lead>();
        for(Integer i = 0; i < 200; i++) {
            Lead l = new Lead();
            l.LastName = 'LastName ' + i;
            l.Company = 'Company';
            l.Status = 'Random Status';
            leadList.add(l);
        }
        insert leadList;
    
    Test.startTest();
    		LeadProcessor ld = new LeadProcessor();
    		Id batchId = Database.executeBatch(ld);
    Test.stopTest();
	}
}