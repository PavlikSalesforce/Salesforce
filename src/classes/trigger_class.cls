public class trigger_class {
        
    public static void check_opp(List<Opportunity> opps) {
        Double totalAmount = 0.0;

        for(Opportunity o_1 : [SELECT Amount FROM Opportunity
                             WHERE createdDate = TODAY
                            AND createdByID = : UserInfo.getUserId()]) {
            totalAmount += o_1.Amount;
        }
        
        for(Opportunity o_2 : opps) {
            totalAmount += o_2.Amount;
            if(totalAmount > 100000) {
                o_2.addError('You have exceeded daily limit');
            }
        }
    }


}