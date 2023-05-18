global class batchPrac implements Database.Batchable<sObject>{
        global database.QueryLocator start(Database.BatchableContext BC){
            string query ='select name from account limit 10';
            return database.getQueryLocator(query);
        }
    
    global void execute(database.BatchableContext BC,List<Account> accList){
       	List<Account> newAccList = new list<Account>();
        integer i = 0;
        for(account ac:accList){
            ac.name='test ';
            newAccList.add(ac);
            i++;
        }
        update newAccList;
       
    }
    global void finish(Database.BatchableContext BC){
        system.debug('finish');
    } 
    }