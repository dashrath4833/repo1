public class AccountController {
	@AuraEnabled
    public static List<Account> getAccount(){
        return [SELECT id, Name FROM Account LIMIT 10];
    }
}