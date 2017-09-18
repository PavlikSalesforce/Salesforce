public without sharing class WithoutSharingEditPage {
    
    
    public List<EmployeeSkills__c> getSkillsRecords(){
        Id employeeId = ApexPages.currentPage().getParameters().get('Id');
					return  [SELECT Id, Name, Grade__c, Experience__c, Skill_Category__c, Employee__c, Project__c
                     FROM EmployeeSkills__c WHERE EmployeeSkills__c.Employee__c =:employeeId];

    }

}