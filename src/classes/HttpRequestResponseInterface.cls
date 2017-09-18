public interface HttpRequestResponseInterface {
    
    HttpResponse performRequest(HttpRequest__c httpRequest);
    void processResponse(HttpResponse someHttpRersponse, Id contactId);
    HttpRequest__c getRequestObject( id objectId );
    
}