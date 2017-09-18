public class CallExtension {
    
    	//Our collection of the class/wrapper objects cContact
    public List<WrapperEmployeeSkills> wrapEmpSkill{
        get{
            if ( wrapEmpSkill == null ){
                
                wrapEmpSkill = new List<WrapperEmployeeSkills>();
                // This method allows us to get only that user from whom profile we go the edit page 
            	Id employeeId = ApexPages.currentPage().getParameters().get('Id');

                for ( EmployeeSkills__c skills : [SELECT Id, Name, Grade__c, Experience__c,
                                                 Skill_Category__c, Employee__c, Project__c
                     FROM EmployeeSkills__c WHERE EmployeeSkills__c.Employee__c =:employeeId]){
                // As each employeeSkill is processes we create a new EmployeeSkills__c object and add it to the
                    wrapEmpSkill.add( new WrapperEmployeeSkills( skills ) );
                         
                }          
            }
                return wrapEmpSkill;            
        }
        set;
    }
        
    public void deleteProcessSelected() {
        
        // We create a new list of EmployeeSkills that will be populated only with EmployeeSkills if they are selected
        List<EmployeeSkills__c> selectedEmployeeSkills = new List<EmployeeSkills__c>();
        
        // We will cycle through our list of WrapperEmployeeSkills and will check to see if the selected property is set to true,
        // if it is we add EmployeeSkills__c to the selectedEmployeeSkills list.
        for(WrapperEmployeeSkills w: wrapEmpSkill ) {
            if(w.selected == true) {
                selectedEmployeeSkills.add(w.empskills);
            }
        }
        
        // Now we have our list of selected employeeSkills and can perform any type of logic we want, sending emails,
        // updating/deleting a field on the EmployeeSkills__c, etc
        System.debug('These are the selected EmployeeSkills...');
        delete selectedEmployeeSkills;
        
        wrapEmpSkill = null; // we need this line if we performed a write operation because GetSkills gets a fresh list now
        
    } 
    
    public PageReference saveEmployeeSkill() {
        List<EmployeeSkills__c> eployee = new List<EmployeeSkills__c>();
        for (WrapperEmployeeSkills e: wrapEmpSkill) {
            eployee.add(e.empskills);     
        }
		PageReference pageRef = new PageReference('/apex/EditPage?Id=' + ApexPages.currentPage().getParameters().get('id'));
        pageRef.setRedirect(true);
        update eployee;
        return pageRef;
    }
	
       // This is our wrapper/container class. A container class is a class,
       //  a data structure, or an abstract data type whose instances are collections of other objects.
       //   In this example a wrapper class contains both the custom salesforce object EmployeeSkills__c and a Boolean value
    public class WrapperEmployeeSkills {
        public EmployeeSkills__c empskills {get; set;}
        public Boolean selected {get; set;}
        
        //This is the contructor method. When we create a new WrapperEmployeeSkills object
        // we pass a EmployeeSkills__c that is set to the con property.
        //  We also set the selected value to false
        public WrapperEmployeeSkills(EmployeeSkills__c employeeSkills) {
            empskills = employeeSkills;
            selected = false;
        }
    }        
}