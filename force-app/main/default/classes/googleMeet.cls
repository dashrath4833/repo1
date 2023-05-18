public class googleMeet{
    @AuraEnabled(cacheable=true)
    public static void getMails(string recordId){
        list<Account>  acList = [Select Name,Mail__c from Account where id=:recordId];
        System.debug(acList);
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendTo = new List<String>();
        sendTo.add(acList[0].Mail__c);
        mail.setToAddresses(sendTo);
        mail.setReplyTo('dashrath@cyntexa.com');
        mail.setSenderDisplayName('Dashrath Singh');      
        mail.setSubject('Google Meetup Link');
        String body = 'Dear ' + acList[0].Name + ',   meet.google.com/ukv-exyh-xsb';
        mail.setHtmlBody(body);
        mails.add(mail);
        Messaging.sendEmail(mails);
        System.debug('bye');
    }

    
  
  
}