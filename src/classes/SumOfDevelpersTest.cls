@isTest
public class SumOfDevelpersTest {
    
	String depQA = 'QA';
    String depDev = 'Software Development';
    
    
    @isTest public static void addSkill(){
       List<EmployeeSkills__c> skills = new List<EmployeeSkills__c>();
       skills.add(new EmployeeSkills__c(Experience__c = 'Less than one year', Project__c = 'AutoProject'));
       insert skills;
    }
    
    @isTest public static void addProject(){
        List<Project__c> project = new List< Project__c>();
        project.add(new Project__c(Importancy__c = 'Low'));
        insert project;
    }
}