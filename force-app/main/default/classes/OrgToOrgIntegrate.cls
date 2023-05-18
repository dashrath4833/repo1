public class OrgToOrgIntegrate {
    public static void orgIntegration(string obj){ 
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setMethod('GET'); 	
        Map<String,string> newMap = new Map<String,string>();
		request.setEndpoint('callout:cyntexaPvtAPI/services/data/v55.0/query/?q=SELECT+name+from+'+obj+'+LIMIT+10');
        HTTPResponse res = http.send(request);
        //system.debug('res:'+res.getBody());
        Map<String,Object>mapOfData = (Map<String,Object>)Json.deserializeUntyped(res.getBody());
        //system.debug(mapOfData);
        List<Object> records = (List<Object>) mapOfData.get('records');
        //system.debug(records);
        List<String> lstData = new List<String>();
        for(object ob:records){
            map<string,Object> test = (map<string,Object>) ob;
            
            system.debug('test '+test.get('Name'));
            lstData.add((String)test.get('Name'));
            //newMap.put('Name',(String)test.get('Name'));
           // system.debug('test key '+test.keySet());
            //system.debug(ob);
        }
        List<Account> acList = new List<Account>();
      system.debug(lstData);
        for(string std:lstData){
            Account ac = new Account(Name=std);
            acList.add(ac);
        }
        insert acList;
    }

}