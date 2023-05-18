public class accountApexClass {
    public static void triggerHandler(List<Account> accList){
        List<Opportunity> opporList = new List<Opportunity>();
        List<Opportunity> oppList = [select Name,stageName,createdDate from Opportunity where AccountId IN :accList and createdDate<N_DAYS_AGO:30];
        for(opportunity op:oppList){
            if(op.stageName!='Closed Won'){
                op.stageName='Closed Lost';
                opporList.add(op);
            }
        }
        update opporList;
    }
    
    /*
    public static void updateTotalOppAmount(List<Account> lstAccount){
        List<Id> ids = new List<Id>(); 
        for(Account acc:lstAccount){
            acc.Total_Amount__c=0;
            ids.add(acc.Id);
        }
        Map<Id,Integer> mapOfAmount = new Map<Id,Integer>();
        List<AggregateResult> results = [select AccountId,Sum(Amount)TotalAmount from Opportunity where AccountId IN :ids group by accountId];
        for(aggregateResult ag:results){
            id accountId = (Id)ag.get('AccountId');
            integer totalAmt = (Integer)ag.get('TotalAmount');
            mapOfAmount.put(accountId,totalAmt);
        }
        for(account ac:lstAccount){
            if(mapOfAmount.containsKey(ac.Id)){
                ac.Total_Amount__c=mapOfAmount.get(ac.Id);
            }
        }  
    } */
    
    public static void lookUpContact(List<Account> accList){
        List<Contact> contactList = new List<Contact>();
        List<Id> ids = new List<Id>();
        for(account ac:accList){
            contact c = new contact();
            c.LastName = ac.Name;
            c.AccountId=ac.Id;
            contactList.add(c);
            ids.add(ac.Id);
        }
        insert contactList;
        List<Account> aList = new List<Account>();
        List<Account> accountList = [select name,fax from account where id IN :ids];
        map<id,account> mapOfAccount = new Map<Id,Account>();
        for(account a:accountList){
       		mapOfAccount.put(a.Id,a);
        }
        for(contact c:contactList){
            if(mapOfAccount.containsKey(c.AccountId)){
                account a = mapOfAccount.get(c.AccountId);
                a.Fax=c.Id;
                aList.add(a);
            } 
        }
        Update aList;
    }
    
    
    
}