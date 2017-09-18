public class HttpCalloutSample {

  public String getCalloutResponseContents(String url) {

    Http h = new Http();

    HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setMethod('GET');

    HttpResponse res = h.send(req);
      JSONParser parser = JSON.createParser(res.getBody());
        String convRate = '';
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'Rate')) {
                parser.nextToken();
                convRate = parser.getText();
            }
        }
        System.debug('convRate :' + convRate);       
        Rate__c rate = new Rate__c();
        rate.Conversion_rate__c = convRate;
        insert rate;   
      System.debug(res.getBody());
    return res.getBody();
  }
}