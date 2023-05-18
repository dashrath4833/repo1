public class simpleClass {
    @future
    public static void caseOrigin(List<Id> ids){
        List<Account> acc = [select NumberOfMailCases__c,NumberOfPhoneCases__c,NumberOfWebCases__c ,(select Id,origin from cases) from account where id in :ids];
        for(account a:acc){
            integer web=0;integer phone=0;integer mail=0;
            for(case c:a.cases){
                if(c.origin=='Phone'){
                    phone++;
                }else if(c.origin=='Email'){
                    mail++;
                }else if(c.origin=='Web'){
                    web++;
                }
            }
            a.NumberOfMailCases__c=mail;
            a.NumberOfPhoneCases__c=phone;
            a.NumberOfWebCases__c=web;
        }
        if(!acc.isEmpty()){
            update acc;
        }
        
    }
}