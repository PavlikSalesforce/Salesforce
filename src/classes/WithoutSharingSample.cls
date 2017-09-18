public without sharing class WithoutSharingSample {

    public List<CustomContact__c> getContactRecords(){
        return [SELECT Id, Name, FirstName__c, LastName__c, AccountCityFormula__c, CustomAccount__c, 
                		CustomAccount__r.City__c, CustomAccount__r.Name
                FROM CustomContact__c];
    }
    	
    //DEFAULT SHARING
    public List<CustomContact__c> getContactRecordsWithSharing(){
        return new DefaultSharingSample().getContactRecords();
    }
    
}