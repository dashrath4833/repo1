public class retrieveRecords{
    @AuraEnabled(cacheable=true)
    public static List<Account> retrieveAccount(String city,String state,String mail){
        string email='%'+mail+'%';
		List<Account> accList = [Select Name, Industry,Rating from Account where (City__c=:city and State__c=:state and Mail__c Like :email)];
        System.debug(accList);
        return accList;
    }

    @AuraEnabled
    public static void saveContactRecord(Contact objAcc){
        	system.debug(objAcc);
            insert objAcc;
            system.debug('ei');

    }
}