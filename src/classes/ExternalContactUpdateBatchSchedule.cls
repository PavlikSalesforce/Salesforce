global class ExternalContactUpdateBatchSchedule {
    
      global void execute(SchedulableContext sc) {
      ExternalContactBatchUpdate b = new ExternalContactBatchUpdate(); 
      database.executebatch(b, 1);
   }

}