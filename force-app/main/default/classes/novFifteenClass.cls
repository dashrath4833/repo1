public class novFifteenClass {
    public static void myMethod(){
        List<Account> accList = [Select name from account Limit 10];
        
    }
    
    public static void records(List<Account> accList){
       
        List<id> accountListId = new List<id>(); 
        List<Contact> contactList = new List<Contact>();
        List<Account> listOfAccount = new List<Account>();
        for(account acc:accList){
            if(acc.AnnualRevenue>=1000){
                accountListId.add(acc.Id);
            }
        }
        system.debug('acId '+accountListId);
        List<Account> accountList = [select Name,Id,(Select Name,MailingAddress,Description from Contacts) from Account where id IN :accountListId];
        system.debug(accountList);
         integer count=0;
        For(Account a: accountList){
            For(contact ct: a.contacts){
                if(ct.Description=='test'){
                    count+=1;
                    ct.Fax='1234';
                    contactList.add(ct);
                }
            }
        }
       system.debug(count);
        update contactList;
       
    }
    
    
    
    
}