@isTest
private class TestVerifyDate {
    @isTest static void checkDatesTestTrue(){
        Date date_1 = Date.today();
        Date date_2 = date_1.addDays(29);
        Date t = VerifyDate.CheckDates(date_1, date_2);
        System.assertEquals(t, date_2);   
    }
    
    @isTest static void DateOver(){
        
        Date date_1 = Date.today();
        Date date_2 = date_1.addDays(31);
        Date t = VerifyDate.CheckDates(date_1, date_2);
        System.assertNotEquals(t, date_1);
        
    }
}