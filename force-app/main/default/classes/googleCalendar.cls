public class googleCalendar {
    public static void calendarInfo(){
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
       // req.setEndpoint('callout:Calendar/c_4b05f4bf237be9f099a114b4cfd4737b1dddc0f3becef9981531aa41d5ed3fb2@group.calendar.google.com/events');
        req.setEndpoint('callout:Calendar/primary/events');
      	req.setHeader('Content-Type','application/json');  
        req.setHeader('Accept', 'application/json');

        
        Http http = new Http();
        HttpResponse res = http.send(req);
        system.debug('res'+res);
        system.debug('resB'+res.getBody());
        if (res.getStatusCode() == 200) {
            // Successful response
            // Parse the JSON response
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            system.debug('jsonRes'+jsonResponse);
        } else {
            // Handle 
            system.debug('error'+res.getStatusCode());
        }
        
    }
}