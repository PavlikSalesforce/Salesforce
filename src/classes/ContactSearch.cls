public class ContactSearch {
    public static List<Contact> searchForContacts(String name, String mailingPostalCode) {
        List<Contact> retList  = [SELECT id, Name, LastName, MailingPostalCode 
                                  FROM Contact WHERE LastName =: name AND MailingPostalCode =: mailingPostalCode];
        
        return retList;
    }
}