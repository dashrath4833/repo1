public class YourClassName {
    public List<Account> leadList {get; set;}

    public YourClassName() {
        leadList = new List<Account>();
    }

    public void method1() {
        leadList.add(new Account(Name='John Doe'));
        System.debug(leadList.size());
    }

    public void method2() {
        System.debug(leadList.size());
    }
}