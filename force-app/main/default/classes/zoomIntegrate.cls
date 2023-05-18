public class zoomIntegrate {
    @AuraEnabled(cacheable=True)
    public static string zoom(string recordId){
    	String accessToken = 'eyJhbGciOiJIUzUxMiIsInYiOiIyLjAiLCJraWQiOiI4Mzc5NzRmYi05Y2Y5LTQ5NDctODVjZC0wMjBiMzBlZGY1Y2MifQ.eyJ2ZXIiOjcsImF1aWQiOiIwNWQyNTg1MmZlYmYwODQ4MDI1MmU3ZDY2OWMyMDFkMCIsImNvZGUiOiJEcFpqOHdKVGp2XzBRREk5NnZTUklxT3lUZzI4VDRKUHciLCJpc3MiOiJ6bTpjaWQ6cEo5eGM5bVFacTRRQ24zaHNtNzdRIiwiZ25vIjowLCJ0eXBlIjowLCJ0aWQiOjAsImF1ZCI6Imh0dHBzOi8vb2F1dGguem9vbS51cyIsInVpZCI6IjBRREk5NnZTUklxT3lUZzI4VDRKUHciLCJuYmYiOjE2NjI1NDkxNTMsImV4cCI6MTY2MjU1Mjc1MywiaWF0IjoxNjYyNTQ5MTUzLCJhaWQiOiJueUQtc3JaUVJyV25RTVVPM1FmaUJnIiwianRpIjoiMjI4Y2MwYzQtOWFmOS00NDRmLWI2ZWItMDRjMzY2Mjk0ZjAwIn0.83-JeXQEicYAl03FXzEmv5gs4hpQ4JO_KLcXKag4574157rrr-aaKfa-FCa2gizeCmjtqS5ZjXH8zBZxuTfLdw';
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setMethod('GET'); 	
		request.setEndpoint('https://api.zoom.us/v2/users/me/meetings');
		request.setHeader('Content-Type','application/json');    
        request.setHeader('Authorization','Bearer '+accessToken );
        String body = '{ "topic": "testing","type":2,"start_time": "2021-05-10T12:10:10Z","duration":"3","settings":{"host_video":true,"participant_video":true,"join_before_host":true,"mute_upon_entry":"true","watermark": "true","audio": "voip","auto_recording": "cloud"} }';
        request.setBody(body);
		HttpResponse response = new HttpResponse();
		response = http.send(request);
		String responseBody = response.getBody();
       // system.debug(responseBody);
        map<string,Object> mapOfData = (map<string,Object>)(Json.deserializeUntyped(responseBody));
        //system.debug('map:'+mapOfData);
        string joinUrl = (string)mapOfData.get('join_url');
        string passwd = (string)mapOfData.get('password');
        string startUrl = (string)mapOfData.get('start_url');
        system.debug(joinUrl);
        system.debug(startUrl);
        system.debug(passwd);
        List<Account> acList = [select (select Name,Email from Contacts) from Account where id=: recordId];
		List<contact> cntct = new List<contact>();
		for(Account ac : acList){
    		for(Contact cp :ac.Contacts){
        		cntct.add(cp);
    		}
		}
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>();
        for(Contact c: cntct){
            if(c.Email!=null){
            	sendTo.add(c.Email);
            }
		} 
        //sendTo.add('dashrathsingh4833@gmail.com');
        system.debug('sendTo:'+ sendTo);
        mail.setToAddresses(sendTo);
        mail.setReplyTo('dashrath@cyntexa.com');
        mail.setSenderDisplayName('Dashrath Singh');      
        mail.setSubject('Zoom Meetup Link');
        String body1 = 'Dear ' + cntct[0].Name + 'Your Meeting Link Is ' +joinUrl+' and password is: '+passwd;
        mail.setHtmlBody(body1);
        mails.add(mail);
       	Messaging.sendEmail(mails);
        System.debug('bye');
        return startUrl;
    }
}