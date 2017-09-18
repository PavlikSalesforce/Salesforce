public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String lastName){
        List<Contact> listContact = new List<Contact>();
        for (Integer i = 0; i < numberOfContacts; i++) {
            lastName = 'Test ' + i;
            Contact contact = new Contact(FirstName = lastName, LastName = lastName);
            listContact.add(contact);
        }
        
        return listContact;
    }
}