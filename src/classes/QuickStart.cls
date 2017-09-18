public class QuickStart {
    
    
    public void newAccounts(){
    	Integer NUM = 10;
    	Account[] accs;
    	accs = [SELECT Id FROM Account WHERE name LIKE 'test%'];
    	Delete accs;
    
	    accs = new Account[NUM];
        For (Integer I = 0; I < NUM; I++) {
            accs[I] = new Account(name = 'test   ' + I,
                                 outstandingshares__c = I);
        }
    }
    
    
    
    

}