public class erpController {
    @future(callout=true)
    public static void createCustomerOverErp(string jsonDataAcc){
        
        Account account = (Account)JSON.deserialize(jsonDataAcc, Account.class);
        customerCreateForErpNext Cust = new customerCreateForErpNext();
        cust.customer_name = account.Name;
        cust.country = account.BillingCountry;
        cust.city = account.BillingCity;
        cust.territory='India';
        cust.customer_group='Individual';
        cust.email_id = account.Mail__c;
        cust.address_line1= account.BillingStreet;
        cust.customer_type='Individual';
        cust.state=account.BillingState;
        cust.tax_id='GSTIN123456';
	
        String endpoint = 'https://cyntexa.erpnext.com/api/resource/Customer';
        
	
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        
       //req.setHeader('Cookie', 'full_name=Dashrath; sid=228d44417b386fc9462cb72770778e8f58b2bc1094c944a225f3379b; system_user=yes; user_id=dashrath%40cyntexa.com;');
     //  req.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(auth)));
       // req.setHeader('b90757792f', 'dbf67ec6ce');
       req.setHeader('Authorization', 'token 2dc956686e06cba:6deda61460e74d9');
        req.setHeader('Content-Type', 'application/json');

        String customerBody = JSON.serialize(Cust);
        //system.debug('cusb '+customerBody);
		req.setBody(customerBody);
		//req.setBody('{"customer_name": "John11 Doe", "customer_type": "Individual", "email_id": "johndoe@example.com", "mobile_no": "+91 1234567890", "website": "http://www.johndoe.com", "customer_group": "Individual", "territory": "India", "default_price_list": "Standard Selling", "tax_id": "GSTIN123456", "credit_days": 30, "credit_limit": 5000, "address_line1": "123 Main St", "address_line2": "Sai Nagar", "city": "Pune", "state": "Maharashtra", "pincode": "411027", "country": "India"}');

        req.setHeader('Accept', 'application/json');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
      	system.debug('res '+res.getBody());
        if (res.getStatusCode() == 200) {
            
            System.debug('Customer created successfully!');
        } else {
          
            System.debug('Error creating customer: ' + res.getBody());
        }
        
        
        
        
        
        
        
        
    }
}