global class ExternalContactBatchSchedule implements Schedulable {
    
   global void execute(SchedulableContext sc) {
      ExternalContactBatch b = new ExternalContactBatch(); 
      database.executebatch(b, 1);
   }
}