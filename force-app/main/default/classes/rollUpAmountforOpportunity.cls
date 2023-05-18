public class rollUpAmountforOpportunity {
    public static void rollUps(List<Opportunity> opList){
        List<Account> accountList = new List<Account>();
        List<Id> accIds = new List<Id>();
        for(opportunity op:opList){
            accIds.add(op.AccountId);
        }
        List<Account> accList = [Select Name,Total_Amount__c,(Select Name,amount from opportunities) from account where Id IN :accIds];
        for(account ac:accList){
            decimal amt = 0;
            for(opportunity op:ac.Opportunities){
                amt+=op.Amount;
            }
            ac.Total_Amount__c=amt;
        	accountList.add(ac);
        }
        update accountList;
    }

}