public class Process {
    public void processWithSomeObject(HttpRequestResponseInterface  h) {
        HttpResponse resp = h.performRequest();
        h.processResponse(resp); 
        
    }
}