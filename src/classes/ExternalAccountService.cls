global class ExternalAccountService {
    
    private static final String APEX_SPECIALIST_URL = 'https://eu11.salesforce.com/services/data/v40.0/sobjects/Contact/';
    private static final String CLIENT_ID = '3MVG9HxRZv05HarTXOE6U.75VlxQN7o_Wq4QJoelLDkkjX8Fk5YsWpPs_fFZ_Ba3Fj3Gkpk7XEBK2qU9uvoOZ';
    private static final String CLIENT_SECRET = '4617137027380055078';
    private static final String USER_NAME = 'apexspeciali@trailhead.com';
    private static final String USER_PASSWORD = 'auf253100vbnc45';
    
    	@future (callout=true)
 		public static void createExternalAccount(id acctID) {
  
    		HttpRequest request = new HttpRequest();
    		request.setHeader('Content-Type','application/json');
    		request.setMethod('POST');
    		request.setEndpoint(APEX_SPECIALIST_URL); 
    		Account acct = [SELECT id, Name FROM Account WHERE id = : acctID];
   			String JsonString = JSON.serialize(acct);
    		request.setBody(JsonString);
    		Http http = new Http();
    		HTTPResponse res = http.send(request);
  
    }
}