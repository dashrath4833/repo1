public class SendMails {
    @InvocableMethod
    public static void sendSimpleEmail(List<String> emailAddress){
        for(String em: emailAddress){
            
            String[] toAddresses = new String[] {em};
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(toAddresses);
            email.setSubject('subject');
            email.setPlainTextBody('Lead Converted');
            email.setHtmlBody('emailBody');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
        
    }
}