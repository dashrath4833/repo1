global class duplicatesFindInAccount implements Database.Batchable<SObject>  {
  Global Map<String , Account> accountNameMap = new Map<String , Account>();
    global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator([Select Name from Account where Name != null and name = 'dcd']);
      }
    
    global void execute(Database.BatchableContext BC , List<Account> accList){
        List<Account> duplicatelist = new List<Account>();
        for(Account acc : accList){
			if(!accountNameMap.containsKey(acc.Name)){
				accountNameMap.put(acc.Name , acc);
			}
			else{
				duplicatelist.add(acc);			
			}                        
        }  
        system.debug(duplicatelist);
		if(duplicatelist.size() > 0){
			delete duplicatelist;
		}
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
        

}