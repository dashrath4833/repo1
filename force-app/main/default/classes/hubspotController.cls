public class hubspotController {
    
    @future(callout=true)
    public static void contactsGetAndSet(string jsonString){
        
        try{
            List<Contact> contacts = (List<Contact>) JSON.deserialize(jsonString, List<Contact>.class); 
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:namedCredHubspot/crm/v3/objects/contacts?archived=false');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Accept', 'application/json');
            set<id> accountIds = new set<Id>();
            for (Contact contact : contacts) {
                accountIds.add(contact.AccountId);
            }
            Map<Id, Account> accountsMap = new Map<Id, Account>([
                SELECT Id, Name,website
                FROM Account
                WHERE Id IN :accountIds
            ]);
            jsonHandlerForHubsotContact jsonDataContact = new jsonHandlerForHubsotContact();        
            for (Contact contact : contacts) {
                jsonHandlerForHubsotContact.properties prop = new jsonHandlerForHubsotContact.properties();
                prop.firstname=contact.FirstName;
                prop.lastname=contact.LastName;
                prop.email=contact.Email;
                prop.company=accountsMap.get(contact.AccountId).Name;
                prop.phone=contact.Phone;
                prop.website =accountsMap.get(contact.AccountId).Website;
                jsonDataContact.properties=prop;
                
            }
            String jsonBody = JSON.serialize(jsonDataContact);            
            request.setBody(jsonBody);
            Http http = new Http();
            HttpResponse response = http.send(request);
        }catch(Exception e){
            system.debug('excep '+e.getMessage()+' '+e.getLineNumber());
        }
    } 
    
    public static void fetchAndCreateContactsWebhook(string id){
        try{
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:namedCredHubspot/crm/v3/objects/contacts/'+id+'?archived=false');
            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Accept', 'application/json');
            Http http = new Http();
            HttpResponse response = http.send(request);
            system.debug('resp '+response.getBody());
            Map<String,Object> mapOfResponse = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            Map<String,Object> mapOfInnerResponse  = (Map<String,Object>)mapOfResponse.get('properties');
            system.debug('mapOfInnerResponse '+mapOfInnerResponse);
            string firstNameVal;
            string lastNameVal;
            string emailVal;
            string websiteVal;
            string phoneVal;
            string companyVal;
            if(mapOfInnerResponse.containsKey('firstName')){
                system.debug('inside');
                firstNameVal=string.valueof(mapOfInnerResponse.get('firstname'));
            }
            if(mapOfInnerResponse.containsKey('lastname')){
                lastNameVal=string.valueof(mapOfInnerResponse.get('lastname'));
            }
            
            if(mapOfInnerResponse.containsKey('email')){
                emailVal=string.valueof(mapOfInnerResponse.get('email'));
            }
            
            if(mapOfInnerResponse.containsKey('website')){
                websiteVal=string.valueof(mapOfInnerResponse.get('website'));
            }
            
            if(mapOfInnerResponse.containsKey('company')){
                companyVal=string.valueof(mapOfInnerResponse.get('company'));
            }
            
            if(mapOfInnerResponse.containsKey('phone')){
                phoneVal=string.valueof(mapOfInnerResponse.get('phone'));
            }
            contact c = new Contact();
            c.FirstName=firstNameVal;
            c.LastName=lastnameVal;
            c.Email=emailVal;
            c.Phone=phoneVal;
            List<contact> lstCont = [select email from contact where email =:emailVal];
            if(lstCont.size()<=0){
                try{
                    insert c;
                }catch(DMLexception e){
                    system.debug('DMLException '+e.getMessage());
                }
            }
            
            
        }catch(Exception e){
            system.debug('exception '+e.getMessage()+' '+e.getLineNumber());
        }
    }
    
    
}