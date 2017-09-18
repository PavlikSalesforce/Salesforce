public class NewCaseListController {
    private String val = 'New';
public List<Case> getNewCases() { 
        List<Case> results = Database.query('SELECT Id, CaseNumber FROM Case WHERE Status = \'' + String.escapeSingleQuotes(val)+'\'');
    return results;
}
}