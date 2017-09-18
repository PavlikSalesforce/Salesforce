public class DefaultSharingSample {
	
    
    public List<CustomContact__c> getContactRecords(){
        return [SELECT Id, Name, FirstName__c, LastName__c, AccountCityFormula__c, CustomAccount__c, 
                		CustomAccount__r.City__c, CustomAccount__r.Name
                FROM CustomContact__c];
    }
    
    
}