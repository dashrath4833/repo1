public class drive {
    @AuraEnabled(cacheable=true)
	public static List<String> files(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Microsoft/drive/root/children');
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug(res.getBody());
        // system.debug(req);
        fromJSON resBody = (fromJSON)JSON.deserialize(res.getBody(), fromJSON.class); 
        List<String> lstName = new List<String>();
        //system.debug(resBody.value[1].name);
       /* for(integer i=0;i<resBody.value.size();i++){
            system.debug(resBody.value[i].name);
            lstName.add(resBody.value[i].name);
            
        } */
        return lstName;       // system.debug(values[0].get('createdBy'));
       
    }

    
}