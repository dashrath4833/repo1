public class QbPaymentConnect {
 	
    @future(callout=true)
    public static void QbCustomers(string recordId){
        opportunity op = [select name from opportunity where id=:recordId];
        system.Debug(op);
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setMethod('POST'); 	
		request.setEndpoint('callout:qbOnline/v3/company/4620816365248252120/customer?minorversion=40');
		request.setHeader('Content-Type','application/json');  
		request.setHeader('Accept', 'application/json');
        string jsonString='{"DisplayName" :"'+op.name +'"}';
		request.setBody(jsonString);
		HTTPResponse res = http.send(request);
		system.debug('res:'+res.getBody());
		//system.debug('Status Code: '+res.getStatusCode());
        QuickBookWrapperClass cus = new QuickBookWrapperClass();
        cus = (QuickBookWrapperClass)JSON.deserialize(res.getBody(), QuickBookWrapperClass.class);
        String custId = cus.Customer.Id;
       	op.customerId__c=custId;
        update op;
        //system.debug('customer Id: '+custId);
      // QbCreateCard(custId);
        
    }
    
   /* public static void QbCreateCard(string cusId){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setMethod('POST'); 	
		request.setEndpoint('callout:qb_named_cred/quickbooks/v4/customers/'+cusId+'/cards');
		request.setHeader('Content-Type','application/json');  
        request.setHeader('request-Id', '1234');
		request.setHeader('Accept', 'application/json');
        string json1 = '{\"expMonth\":\"12\",\"address\":{\"postalCode\":\"44112\",\"city\":\"Richmond\",\"streetAddress\":\"1245HanaRd\",\"region\":\"VA\",\"country\":\"US\"},\"number\":\"4408041234567893\",\"name\":\"TestUser\",\"expYear\":\"2026\"}';
        request.setBody(json1);
        system.debug(json1);
        HTTPResponse res = http.send(request);
        cardJson resBody = (cardJson)JSON.deserialize(res.getBody(),cardJson.class); 
		system.debug('res:'+res.getBody());
       	String cardId = resBody.id;
        system.debug(cardId);
		request.setMethod('POST'); 	
		request.setEndpoint('callout:qb_named_cred/quickbooks/v4/payments/tokens/ie');  
		request.setHeader('Content-Type','application/json'); 
        request.setHeader('request-Id', 'qwerty12345');
		request.setHeader('Accept', 'application/json');
        request.setBody('{"card" :"{"id" : '+cardId+'"}}');
        HTTPResponse response = http.send(request);
		system.debug('res:'+response.getBody());
        
    }
    */
   
        
       
    
   	@AuraEnabled
     public static void QBCreatePayment(String cardNumber,string CardHolderName,string expiryMonth,string expiryYear, integer cvc,decimal amt,string recordId){
        Opportunity opp = [select name,customerId__c,Amount,Remaining_Amount__c from opportunity where id=:recordId];
        integer inte = Integer.valueof((Math.random()*10000000));
		String sInteger = String.valueOf(inte);
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setMethod('POST'); 	
		request.setEndpoint('callout:qb_named_cred/quickbooks/v4/payments/charges');
		request.setHeader('Content-Type','application/json');  
        request.setHeader('request-Id', sInteger);
		request.setHeader('Accept', 'application/json');
        request.setHeader('entityType', 'Company');
        request.setHeader('entityId','4620816365248252120');
        system.debug(expiryYear);
         string json = '{\"currency\":\"USD\",\"amount\":\"'+ amt +'\",\"context\":{\"mobile\":\"false\",\"isEcommerce\":\"true\"},\"card\":{\"name\":\"'+cardHolderName+'\",\"number\":\"'+cardNumber+'\",\"expMonth\":\"'+expiryMonth+'\","address\":{\"postalCode\":\"94086\",\"country\":\"US\",\"region\":\"CA\",\"streetAddress\":\"1130 KiferRd\",\"city\":\"Sunnyvale\"},\"expYear\":\"'+expiryYear+'\",\"cvc\":\"'+cvc+'\"}}';
        system.debug(json);
        request.setBody(json);
        HTTPResponse res = http.send(request);
		system.debug('res:'+res.getBody());
		system.debug('Status Code: '+res.getStatusCode());
        opp.Remaining_Amount__c=opp.Amount-amt;
        update opp;
    }
    
    
}