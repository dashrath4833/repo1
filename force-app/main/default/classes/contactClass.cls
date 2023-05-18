public class contactClass {
    public static void recordData(List<Contact> contList,List<Contact> contOldList){
        List<Id> AccountIds = new List<Id>(); 
        for(contact cont:contList){
            AccountIds.add(cont.AccountId);
        }
        List<Account> accList = [Select Name,Id from Account where Id in :AccountIds and AnnualRevenue>=1000];
	        
    }

}