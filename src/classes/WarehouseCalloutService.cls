public with sharing class WarehouseCalloutService {  

    // URI (In addition to the HTTP method, each request sets a URI,
    // which is the endpoint address at which the service is located)
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
           Product2 product = new Product2();
            JSONParser parser = JSON.createParser(response.getBody());
            while(parser.nextToken() != null) {
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                    if(parser.getText() == 'name') {
                        product.Name = parser.getText();
                    } else if (parser.getText() == 'cost') {
                    	product.Cost__c = Integer.valueOf(parser.getText());
                    } else if (parser.getText() == 'maintenanceperiod') {
                    	product.Maintenance_Cycle__c = Integer.valueof(parser.getText());
                    } else if (parser.getText() == 'quantity') {
                        product.Current_Inventory__c = Integer.valueOf(parser.getText());
                    }
                }
            }
            
           /* // Deserializes the JSON string into collections of primitive data types.
            // In this List we have fields of Equipment(Product2) stadart object.
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            
            List<Product2> listOfProducts = new List<Product2>();
            
            for(Object product : results) {
                Product2 temporaryInstance = new Product2();
                                
                
                // get value of fileds from JSON and write the into temporaryInstance.
            } */
            

        }
    }

          

}