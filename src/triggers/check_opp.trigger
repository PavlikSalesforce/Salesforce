trigger check_opp on Opportunity (before insert) {
    
    trigger_class.check_opp(Trigger.New);

}