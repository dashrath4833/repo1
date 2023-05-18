public class FromGoogleSheetToSFDX {
    @AuraEnabled
    public static void fetchDataFromSheet(){
        List<Contact> contList = [Select FirstName from Contact];
        List<Object> mainListInStringOfContacts = new List<Object>();
        list<String> strr = new List<String>();
        List<Contact> contactsToBeSaved = new List<Contact>();
        List<Object> temp = new List<Object>();
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setMethod('GET'); 	
		request.setEndpoint('callout:googleSheetAPI/v4/spreadsheets/1fY7f68-mu3SK-43rtUeQsjsT838TDrigstTDmnjjmVY/values/Sheet1');
		request.setHeader('Content-Type','application/json');  
        request.setHeader('Accept', 'application/json');
       	HTTPResponse res = http.send(request);
       //	system.debug('res:'+res.getBody());
        Map<String,Object> mapOfData = (map<string,Object>)Json.deserializeUntyped(res.getBody());
        //system.debug('Map:'+mapOfData);
        List<Object> values =(List<Object>) mapOfData.get('values');
       	for(integer i=1;i<values.size();i++){
       		//system.debug('i:'+values[i]);
        	temp.add(((List<Object>)values[i])[0]);  	
        }
       // system.debug('temp:'+temp);
        
        for(contact c:contList){
            strr.add(c.firstName);
        }
       for(integer i=1;i<temp.size();i++)
       {
           if(!strr.contains((String)temp[i])){
               mainListInStringOfContacts.add(temp[i]);
           }
       }
        
        for(object ob:mainListInStringOfContacts){
            contact cnt = new Contact(FirstName=(String)ob,LastName=(String)ob);
            contactsToBeSaved.add(cnt);
        }
        system.debug('contactToBeSaved:'+mainListInStringOfContacts);
     	insert contactsToBeSaved;
        
    }

}