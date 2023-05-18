public class QuickBookWrapperClass{
	public cls_Customer Customer;
	public String tim;	//2015-07-23T10:58:12.099-07:00
	public class cls_Customer {
		public String domain;	//QBO
		public cls_PrimaryEmailAddr PrimaryEmailAddr;
		public String DisplayName;	//King's Groceries
		public cls_CurrencyRef CurrencyRef;
		public cls_DefaultTaxCodeRef DefaultTaxCodeRef;
		public String PreferredDeliveryMethod;	//Print
		public String GivenName;	//James
		public String FullyQualifiedName;	//King's Groceries
		public boolean BillWithParent;
		public String Title;	//Mr
		public boolean Job;
		public Integer BalanceWithJobs;	//0
		public cls_PrimaryPhone PrimaryPhone;
		public boolean Taxable;
		public cls_MetaData MetaData;
		public cls_BillAddr BillAddr;
		public String MiddleName;	//B
		public String Notes;	//Here are other details.
		public boolean Active;
		public Integer Balance;	//0
		public String SyncToken;	//0
		public String Suffix;	//Jr
		public String CompanyName;	//King Groceries
		public String FamilyName;	//King
		public String PrintOnCheckName;	//King Groceries
		public boolean sparse;
		public String Id;	//67
	}
	class cls_PrimaryEmailAddr {
		public String Address;	//jdrew@myemail.com
	}
	class cls_CurrencyRef {
		public String name;	//United States Dollar
		public String value;	//USD
	}
	class cls_DefaultTaxCodeRef {
		public String value;	//2
	}
	class cls_PrimaryPhone {
		public String FreeFormNumber;	//(555) 555-5555
	}
	class cls_MetaData {
		public String CreateTime;	//2015-07-23T10:58:12-07:00
		public String LastUpdatedTime;	//2015-07-23T10:58:12-07:00
	}
	class cls_BillAddr {
		public String City;	//Mountain View
		public String Country;	//USA
		public String Line1;	//123 Main Street
		public String PostalCode;	//94042
		public String CountrySubDivisionCode;	//CA
		public String Id;	//112
	}
	public static fromJSON parse(String json){
		return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
	}
}