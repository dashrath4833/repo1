public class associateContactToAccount {
    public static void updateAccount(List<Account> accList){
        system.debug(accList);
        List<Contact> contactList = new List<Contact>();
        for(account ac:accList){
            contact cnt = new contact();
            cnt.accountId = ac.id;
            cnt.LastName=ac.Name;
            contactList.add(cnt);
        }
        system.debug(contactList);
       	insert contactList;
    }
    
    public static void makeGivenNumberOfContacts(List<Account> accList){
        List<Contact> lstContact = new List<Contact>();
        for(Account ac:accList){
            for(integer i = 0;i<ac.NumberOfEmployees;i++){
                contact cnt = new contact();
                cnt.lastName = ac.Name;
                cnt.AccountId=ac.Id;
                lstContact.add(cnt);
            }
        }
        insert lstContact;
    }
    
    public static void makeGivenNumberOfContactsFromMap(List<Account> accList){
        map<Id,Integer> newMap = new map<Id,Integer>();
        List<Contact> lstContact = new List<Contact>();
        for(account ac:accList){
            newMap.put(ac.Id, ac.NumberOfEmployees);
        }
        for(id acId:newMap.keyset()){
            for(integer i =0 ;i<newMap.get(acId);i++){
                contact cn = new Contact();
                cn.LastName = 'contact '+i;
                cn.AccountId = acId;
                lstContact.add(cn);
            }
        }
        insert lstContact;
    }
    
    
}