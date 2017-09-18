public with sharing class WithSharingSample {	
    
    public String myStr {get;set;}
    
    // WITH SHARING
    public List<CustomContact__c> getContactRecords(){
        return [SELECT Id, Name, FirstName__c, LastName__c, AccountCityFormula__c, CustomAccount__c, 
                		CustomAccount__r.City__c, CustomAccount__r.Name
                FROM CustomContact__c];
    }
    

    	    
   	// WITHOUT SHARING 
    public List<CustomContact__c> getContactRecordsSharingWithout(){
        return new WithoutSharingSample().getContactRecords();
    }
    
   	// CONFUSIVE? WITHOUT / WITHOUT SHARING 
    public List<CustomContact__c> getContactRecordsSharingMulti(){
        return new WithoutSharingSample().getContactRecordsWithSharing();
    }
    	    
    	
   	//DEFAULT SHARING
    public List<CustomContact__c> getContactRecordsSharingDefault(){
        return new DefaultSharingSample().getContactRecords();
    }    
    
    
}