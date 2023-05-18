public class restResourceJson{
		public Customer Customer{get;set;}
	public class PrimaryPhone{
		public String FreeFormNumber{get;set;}
	}
	public class PrimaryEmailAddr{
		public String Address{get;set;}
	}
	public class Mobile{
		public String FreeFormNumber{get;set;}
	}
	public class MetaData{
		public String CreateTime{get;set;}
		public String LastUpdatedTime{get;set;}
	}
	public class Fax{
		public String FreeFormNumber{get;set;}
	}
	public class DefaultTaxCodeRef{
		public String value{get;set;}
	}
    
    public class WebAddr{
		public String URI{get;set;}
	}
	public class Customer{
		public String Id{get;set;}
        public WebAddr WebAddr{get;set;}
        public String Suffix{get;set;}
		public Boolean IsProject{get;set;}
		public String domain{get;set;}
		public String PreferredDeliveryMethod{get;set;}
		public Boolean sparse{get;set;}
		public CurrencyRef CurrencyRef{get;set;}
       	public ParentRef ParentRef{get;set;}
		public String SyncToken{get;set;}		
        public String Title{get;set;}
		public String FamilyName{get;set;}
		public String FullyQualifiedName{get;set;}
		public String MiddleName{get;set;}
		public String CompanyName{get;set;}
		public String GivenName{get;set;}
		public String DisplayName{get;set;}
		public MetaData MetaData{get;set;}
		public String PrintOnCheckName{get;set;}
		public Decimal BalanceWithJobs{get;set;}
		public Boolean Active{get;set;}
		public Decimal Balance{get;set;}
		public PrimaryPhone PrimaryPhone{get;set;}
		public Boolean BillWithParent{get;set;}
		public Mobile Mobile{get;set;}
		public Boolean Job{get;set;}
		public Fax Fax{get;set;}
		public String Notes{get;set;}
		public PrimaryEmailAddr PrimaryEmailAddr{get;set;}
        public BillAddr BillAddr{get;set;}
       	public ShipAddr ShipAddr{get;set;}
		public DefaultTaxCodeRef DefaultTaxCodeRef{get;set;}
		public Boolean Taxable{get;set;}
	}
    public class ParentRef{
		public String value{get;set;}
	}
	public class CurrencyRef{
		public String name{get;set;}
		public String value{get;set;}
	}
	public class BillAddr{
		public String Country{get;set;}
		public String City{get;set;}
		public String CountrySubDivisionCode{get;set;}
		public String Line1{get;set;}
		public String PostalCode{get;set;}
		public String Id{get;set;}
	}
    
    public class ShipAddr{
		public String Country{get;set;}
		public String City{get;set;}
		public String CountrySubDivisionCode{get;set;}
		public String Line1{get;set;}
		public String PostalCode{get;set;}
		public String Id{get;set;}
	}
}