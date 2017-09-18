trigger RestrictNumberOfOpportunitiesTrigger on Opportunity (before insert) {
            
    RestrictNumberOfOpportunities.trigger_method(Trigger.new);
    
    
}