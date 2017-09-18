public class RestrictNumberOfOpportunities {
    
    public static void trigger_method(List<Opportunity> opportunities) {
        Double totalAmount = 0;
        
        for(Opportunity o1 : [SELECT Amount FROM Opportunity WHERE CreatedDate = Today
                              AND CreatedById = : UserInfo.getUserId()]) {
                                totalAmount += o1.Amount;         
                              }
 
    	for(Opportunity o2 : opportunities) {
			totalAmount += o2.Amount;
        		if(totalAmount > 100000)
            o2.addError('You have exceeded your daily limit');
        }
    }
}