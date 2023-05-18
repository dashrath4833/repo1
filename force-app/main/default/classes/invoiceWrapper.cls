public class invoiceWrapper{
		public list<Line> Line{get;set;}
		public CustomerRef CustomerRef{get;set;}
    	public string DueDate{get;set;}
	public class SalesItemLineDetail{
		public ItemRef ItemRef{get;set;}
        public TaxCodeRef TaxCodeRef{get;set;}
        public Decimal UnitPrice{get;set;}
        public integer Qty{get;set;}
	}
    public TxnTaxDetail TxnTaxDetail{get;set;}
    public class TxnTaxDetail{
		public TxnTaxCodeRef TxnTaxCodeRef{get;set;}
	}
    
	public class Line{
		public SalesItemLineDetail SalesItemLineDetail{get;set;}
        public String Description{get;set;}
		public Decimal Amount{get;set;}
		public String DetailType{get;set;}
	}
	public class ItemRef{
		public String value{get;set;}
		public String name{get;set;}
	}
    
    public class TaxCodeRef{
		public String value{get;set;}
	}
    
    public class TxnTaxCodeRef{
		public String value{get;set;}
		public String name{get;set;}
	}	
	public class CustomerRef{
		public String value{get;set;}
	}
}