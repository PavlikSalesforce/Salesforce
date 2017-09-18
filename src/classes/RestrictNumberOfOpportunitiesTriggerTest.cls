@isTest
public class RestrictNumberOfOpportunitiesTriggerTest {

     static testMethod void insertNewOpportunitiesPositive() {
        
         List<Opportunity> opportunities = new List<Opportunity>();
         
         for(Integer i = 0; i < 10; i++) {
             Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity Triggers',
            CloseDate = Date.parse('01/01/2017'),
            Amount = 15,
            StageName = 'Sourcing Demand');
            opportunities.add(testOpportunity);
         }
         
         insert opportunities;


        Test.startTest();

        update opportunities;

        Test.stopTest();

        System.assertEquals(10, opportunities.size());
    }

}