@RestResource(urlMapping='/v1/erpcustomers')
global class restResourceErp {
    @HttpPost
    global static String createOrUpdateCustomerErp() {
        
        String jsonData = string.valueOf(RestContext.request);
        system.debug('RestContext.request '+jsonData);
        
        system.debug('RestContext.request.params '+RestContext.request.params);
        Map<String, String> params = RestContext.request.params;
        string s = string.valueOf(params);
        String jsonString = s.substring(1, s.length()-2);
        
        // Use the JSON.deserialize method to convert the JSON string to a Map
        Map<String,String> mp = (Map<String,String>) JSON.deserialize(jsonString, Map<String,String>.class);
        system.debug('jsonStringUpdate '+jsonString);
        
        String customerName = mp.get('customer_name');
        String customerGroup = mp.get('customer_group');
        String territory = mp.get('territory');
        String customerType = mp.get('customer_type');
        //  Map<String,Object> mappedResponse = (Map<String,Object>)JSON.deserializeUntyped(jsonData);
        Account ac = new Account(Name=customerName,BillingCountry=territory);
        insert ac;
        
        
        
        RestResponse response = new RestResponse();
        response.statusCode = 201;
        RestContext.response = response;
        system.debug('String.valueOf(response) '+String.valueOf(response));
        return String.valueOf(response);
    }
    
    
    
    
}