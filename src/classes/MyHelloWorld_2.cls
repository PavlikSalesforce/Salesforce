public class MyHelloWorld_2 {
    
	public static void applyDiscount(Book_2__c[] books) {

      for (Book_2__c b :books){

         b.Price__c *= 0.9;

      }

   }
}