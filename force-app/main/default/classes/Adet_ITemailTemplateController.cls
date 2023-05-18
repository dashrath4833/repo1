public class Adet_ITemailTemplateController {
    
    public String accountNumber{get;set;}
    public Decimal perc{get;set;}
    public String accountName{get;set;}
    public String dueDate{get;set;}
    public String sentDate{get;set;}
    public String address{get;set;}
    public String city{get;set;}
    public String zipCode{get;set;}
    public String NetTotal{get;set;}
    public String SubTotal{get;set;}
    public Decimal balance{get;set;}
    public String products{get;set;} 
    public Opportunity opp{get;set;}
    public String taxValue{get;set;} 
    public String authUrl{get;set;}
    public Decimal formattedDecimal{get;set;}
    
    public List<OpportunityLineItem> oppLineItems{get;set;}
    
    
   
     public Adet_ITemailTemplateController(String TotalTax){
        

    
         taxValue = TotalTax;
        
    }
    

    public Adet_ITemailTemplateController(){
        authUrl = 'callout:QBCred';
        
        
        String recordId = System.currentPagereference().getParameters().get('recordId');
        
       	formattedDecimal = Decimal.valueOf(System.currentPagereference().getParameters().get('formattedDecimal'));

        
        opp = [SELECT Id, Name,CloseDate, Account.BillingStreet, Account.Name,Account.BillingCity,Account.BillingPostalCode,Opportunity.OwnerId,
                                               (SELECT Product2.Name, Quantity, UnitPrice,Amount__c FROM OpportunityLineItems)
                                               FROM Opportunity WHERE Id = :recordId AND StageName = 'Closed Won'];

        accountName = opp.Account.Name;
        accountNumber = '3';
        dueDate = String.valueOf(opp.CloseDate);
        sentDate = String.valueOf(date.today());
        address = String.valueOf(opp.Account.BillingStreet);
        city = opp.Account.BillingCity;
        zipCode = opp.Account.BillingPostalCode;
     
        oppLineItems = opp.OpportunityLineItems;
        Decimal temAmount = 0;
        for(OpportunityLineItem oli: oppLineItems){
            
            temAmount = temAmount + oli.Amount__c;  
            
        }
       

        Decimal amountOfPercent = (temAmount * formattedDecimal) / 100;
		Decimal temAmount1 = temAmount + amountOfPercent;
       	Decimal temAmount2 =  temAmount1.setScale(2, RoundingMode.HALF_UP); 
		SubTotal = String.valueOf(temAmount);
       	NetTotal = String.valueOf(temAmount2);
        
        
      	
        try{
						
        }
        catch(Exception err){
            system.debug(err);
        }    
    }
    
    
    
}