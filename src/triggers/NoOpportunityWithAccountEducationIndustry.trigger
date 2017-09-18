trigger NoOpportunityWithAccountEducationIndustry on Opportunity (after insert) {

    for(Opportunity o : Trigger.new) {
        ID aId = o.Account.Id;
        Account acct = [SELECT Name, Industry FROM Account WHERE ID = :aId];
        if(acct.Industry == 'Education'){
           /* acct.addError('You cannot create an opportunity for an account whose industry id Education'); */
        }
    }
    
}