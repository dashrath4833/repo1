public class GoogleSheetApi {
    @AuraEnabled
    public static string appendRowByIds(string contactId){
        //system.debug(contactId);
        contact singleCont = [select id,firstName,lastName,Sheet_Sync__c from contact where id=:contactId];
        string returnBody;
        if(singleCont.Sheet_Sync__c==false){
            Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setMethod('POST'); 	
			request.setEndpoint('callout:googleSheetAPI/v4/spreadsheets/1fY7f68-mu3SK-43rtUeQsjsT838TDrigstTDmnjjmVY/values/Sheet1:append?valueInputOption=RAW');
			request.setHeader('Content-Type','application/json');  
            request.setHeader('Accept', 'application/json');
        	string jsonString = '{'+
            	'"majorDimension": "ROWS", '+
            	'"values":['+
            	'["'+singleCont.FirstName+'","'+singleCont.LastName+'"]'+
            
          	  ' ],'+
            	'"range":"Sheet1"'+
            	'}';
        	request.setBody(jsonString);
        	HTTPResponse res = http.send(request);
        	system.debug('res:'+res.getBody());
        	system.debug('Status Code : '+res.getStatusCode());
        	if(res.getStatusCode()==200){
     			singleCont.Sheet_Sync__c=true;
            	database.update(singleCont,false);
            	returnBody = 'Successfully Synced';
         	}        
          }
        else{
   			returnBody='Already Synced';         
        }
    return returnBody;
    }

}