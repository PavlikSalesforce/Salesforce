public class AddPrimaryContact implements Queueable {
    
    // fields
    private Contact contact;
    private String state;
    
    // constructor
    public AddPrimaryContact (Contact c, String s) {
        this.contact = c;
        this.state = s;
    }    
    
    public void execute(QueueableContext qc) {
         List<Account> ListAccount = [SELECT ID, Name ,
                                      (Select id,FirstName,LastName from contacts )
                                      FROM ACCOUNT WHERE BillingState = :state LIMIT 200];
         List<Contact> lstContact = new List<Contact>();
         for (Account acc:ListAccount)
         {
                 Contact cont = contact.clone(false,false,false,false);
                 cont.AccountId =  acc.id;
                 lstContact.add( cont );
         }
          
         if(lstContact.size() >0 )
         {
             insert lstContact;
         }
          
    }
    
}