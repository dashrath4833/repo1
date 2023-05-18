public class discountForOpportunity {
    @AuraEnabled
    public static decimal discountOpportunity(string recordId){
        List<Opportunity> oppList = [select Id, Amount, Amount_After_Discount__c FROM Opportunity WHERE id=:recordId];
        if (oppList.size() > 0) {
            Opportunity op = oppList[0];
            return op.Amount;
        }
        return 120;
    }
    
}