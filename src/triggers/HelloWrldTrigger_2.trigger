trigger HelloWrldTrigger_2 on Book_2__c (before insert) {

    Book_2__c[] books = Trigger.new;
    
    MyHelloWorld_2.applyDiscount(books);
}