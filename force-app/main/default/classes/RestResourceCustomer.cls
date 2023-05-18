@RestResource(urlMapping='/v1/customers')
global class RestResourceCustomer {
    @HttpPost
    global static String createOrUpdateCustomer() {
       
        String jsonData = RestContext.request.requestBody.toString();
        system.debug('json'+jsonData);
        Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(jsonData);
        system.debug('Map'+data);
        Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(jsonData);
        system.debug('jsoNMap'+jsonMap);
        string id;
        List<Object> eventNotifications = (List<Object>) jsonMap.get('eventNotifications');
        for (Object obj : eventNotifications) {
            Map<String, Object> dataChangeEvent = (Map<String, Object>) ((Map<String, Object>) obj).get('dataChangeEvent');
            List<Object> entities = (List<Object>) dataChangeEvent.get('entities');
            for (Object entity : entities) {
                id = (String) ((Map<String, Object>) entity).get('id');
                System.debug(id);
            }
        }
        if(!Test.isRunningTest()){ 
             QBintegration.fetchCustomer(id);
        }
       
        
        RestResponse response = new RestResponse();
        response.responseBody = Blob.valueOf(JSON.serialize(new Map<String, Object>{
            'opportunity_id' =>'test'
                }));
        response.statusCode = 201;
        RestContext.response = response;
        return String.valueOf(response);
    }
    
    
    
    
}