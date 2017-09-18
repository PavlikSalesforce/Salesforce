global class LeadProcessor implements Database.Batchable<sObject> {
    
    global Integer count = 0;
    

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }

    global void execute(Database.BatchableContext bc, List<Lead> records){
        List<Lead> listRecordsNew = new List<Lead>();
        for(Lead l: records) {
            l.leadsource = 'Dreamforce';
            listRecordsNew.add(l);
            count ++;
        }
        update listRecordsNew;
    }    

    global void finish(Database.BatchableContext bc){
        System.debug('count = ' + count);
    }    
}