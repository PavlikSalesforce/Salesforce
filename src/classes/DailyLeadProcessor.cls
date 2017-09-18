global class DailyLeadProcessor implements Schedulable {
	
    global void execute(SchedulableContext ctx) {
        List<Lead> leadList = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];
       
        if(!leadList.isEmpty()) {
        for (Lead l: leadList) {
            l.LeadSource = 'DreamForce';
        }
        update leadList;
        }
    }
}