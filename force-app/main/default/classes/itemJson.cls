public class itemJson{
	public boolean TrackQtyOnHand;
	public String Name;	//Garden Supplies
	public Integer QtyOnHand;	//10
	public IncomeAccountRef IncomeAccountRef;
	public AssetAccountRef AssetAccountRef;
	public String InvStartDate;	//2015-01-01
	public String Type;	//Inventory
	public ExpenseAccountRef ExpenseAccountRef;
	public class IncomeAccountRef {
		public String name;	//Sales of Product Income
		public String value;	//79
	}
	public class AssetAccountRef {
		public String name;	//Inventory Asset
		public String value;	//81
	}
	public class ExpenseAccountRef {
		public String name;	//Cost of Goods Sold
		public String value;	//80
	}
	
}