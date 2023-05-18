public class ContactController {
	@AuraEnabled
    public static List<Contact> getContacts(id recordid){
        return [SELECT Id,FirstName, Email,Phone FROM Contact WHERE AccountId = :recordId];
    }
}