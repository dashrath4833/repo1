public class contactClassForAccount {
    public static void insertAccount(List<Contact> cntList){
   		List<Account> accList = new List<Account>();
        List<Contact> contactListwithoutAccount = new List<Contact>();
        for(contact cnt : cntList){
            if(string.isBlank(cnt.AccountId)){
                contactListwithoutAccount.add(cnt);
            }
        }
        map<string,contact> cntMap = new map<string,contact>();
        for(contact c:contactListwithoutAccount){
            account ac =new account();
            string accountName = c.LastName;
            cntMap.put(accountName,c);
            ac.name=accountName;
            accList.add(ac);
        }
        insert accList;
        for(account acc:accList){
            if(cntMap.containsKey(acc.Name)){
                cntMap.get(acc.Name).AccountId = acc.id;
            }
        }
	}
}