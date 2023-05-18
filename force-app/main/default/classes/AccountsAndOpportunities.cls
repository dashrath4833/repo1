public with sharing class AccountsAndOpportunities {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(string searchKey){
        if(searchKey!=null){
            string key='%'+searchKey+'%';
            List<Account> acc=[select name,id,Total_no_of_opportunities__c from Account where name like :key limit 5];
            return acc;
        }else{
            List<Account> acc=[select name,id,Total_no_of_opportunities__c from Account limit 5];
            return acc;
        }
        
    }   
    @AuraEnabled(cacheable=true)
        public static List<Opportunity> getOpportunity(string searchKey){   
            if(searchKey!=null){
                string key='%'+searchKey+'%';
                List<Opportunity> opp=[select name,id,Account.Name,Amount from Opportunity where name like :key limit 5];
                return opp;
            }else{
                List<Opportunity> opp=[select name,id,Account.name,Amount from Opportunity limit 5];
                return opp;
            } 
        }
    
        
    

    @AuraEnabled(cacheable=true)
        public static string updateOpportunity(string oppList){
            List<Opportunity> opp=(List<Opportunity>)JSON.deserialize(oppList, List<Opportunity>.class);
            System.debug(opp);
            Database.SaveResult[] srList=database.update(opp,false);
            for(Database.SaveResult sr : srList) {
            if(sr.isSuccess()) {
                System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                return 'Successfully Inserted';
            }
            else {
            // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
                
        return null;
    }
    
    
}