@RestResource(urlMapping='/v1/contacts')
global class webhookHubspot {
    @HttpPost
    global static String createOrUpdateCustomerErp() {
        String jsonData = RestContext.request.requestBody.toString();
       	List<Object> data = (List<Object>) JSON.deserializeUntyped(jsonData);
        Map<String,Object> dataToExtract = (Map<String,Object>)data[0];
        string idz = string.valueOf(dataToExtract.get('objectId'));
        hubspotController.fetchAndCreateContactsWebhook(idz);
        system.debug('test '+idz);
        RestResponse response = new RestResponse();
        response.statusCode = 201;
        RestContext.response = response;
        return String.valueOf(response);
    }
    
    
    
    
}