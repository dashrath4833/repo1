public class triggerHelper {
    public static void methodForLineItem1(List<OpportunityLineItem> opLineItemList){
        Map<Id,List<OpportunityLineItem>> opporLineMap = new Map<Id,List<OpportunityLineItem>>();
        Map<Id,list<Opportunity>> oppMap = new Map<Id,List<Opportunity>>();
        for(opportunityLineItem opl:opLineItemList){
            if(!opporLineMap.containsKey(opl.OpportunityId)){
                opporLineMap.put(opl.OpportunityId,new List<OpportunityLineItem>());
            }
            opporLineMap.get(opl.OpportunityId).add(opl);
        }
        
		List<Opportunity> oppList = [Select Id,AccountId from Opportunity where Id In :OpporLineMap.keySet()];
        for(opportunity op:oppList){
            if(!oppMap.containsKey(op.AccountId)){
                oppMap.put(op.AccountId,new List<Opportunity>());
            }
            oppMap.get(op.AccountId).add(op);
        }
        
       List<Account> accList = [Select Id, Description from Account where Id in :oppMap.keySet()];
       List<Account> updateAccount = new List<Account>();
         for(account ac: accList){
            Decimal temp = 0;
            List<Opportunity> opList = oppMap.get(ac.Id);
            for(opportunity op:opList){
                List<OpportunityLineItem> optlist = opporLineMap.get(op.Id);
                for(opportunityLineItem opl : optList){
                      temp+=opl.Quantity;
                }
            }
         ac.Description=String.valueOf(temp);
         updateAccount.add(ac);
        }
        update updateAccount;
    }
    
    public static void methodForLineItem2(List<OpportunityLineItem> opLineItemList){
        Set<Id> oppId = new Set<Id>();
        for(OpportunityLineItem oppProd:opLineItemList){
            oppId.add(oppProd.OpportunityId);
        }
        Map<Id,String> oppIdSerialNoMap =new Map<Id,String>();
        List<OpportunityLineItem> oppProdList=[Select Id,Serial_No__c,OpportunityId from OpportunityLineItem where OpportunityId=:oppId];
        if(oppProdList.size()>0){
            for(OpportunityLineItem oppoPrd:oppProdList){
                if(oppoPrd.Serial_No__c!=null){
                    String lastword = oppoPrd.Serial_No__c.right(0);
                    system.debug(oppoPrd.serial_No__c);
                    system.debug(lastword);
                    Integer num = Integer.valueOf(lastword);
                    num++;
                    oppoPrd.Serial_No__c=oppoPrd.Serial_No__c+','+(num);
                }
                
            }
        }
    }
   
}