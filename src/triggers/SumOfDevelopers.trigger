trigger SumOfDevelopers on EmployeeSkills__c (after insert, after update) {

	Id[] pIds = new List<Id>();
    
    for(EmployeeSkills__c e: trigger.New) {
        pIds.add(e.Project__c);
    }
    String QADepartment = 'QA';
    String devDepartment = 'Software Development';
    
    List<Employee__c> employees = [SELECT Name, Department__c FROM Employee__c WHERE Id IN 
                                   (SELECT Employee__c FROM EmployeeSkills__c WHERE Project__r.Id =: pIds)
                                  AND (Department__c =: QADepartment OR Department__c =: devDepartment)];
    
    Integer QADevelopers = 0;
    for(Employee__c e: employees){
        if(e.Department__c == QADepartment){
            QADevelopers++;
        }
    }
    
    Integer devDevelopers = 0;
    for(Employee__c e: employees){
        if(e.Department__c == devDepartment){
            devDevelopers++;
        }
    }
    
    List<Project__c> projects = [SELECT Name, Developers__c FROM Project__c];
    for(Project__c p: projects){
    if(p.Name == 'Task_3' || p.Name == 'Project_1' || p.Name == 'Project_2'){
        p.Developers__c = devDevelopers;
    	}
    }
     update projects;

}