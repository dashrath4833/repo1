@isTest
public class sfdxTestClass {
	@isTest
    static void mainTest(){
    	 Account ac = new Account(Name='Test Account');
        insert ac;
        
        // Call the main method of sfdxMainClass
        Test.startTest();
        sfdxMainClass.main();
        Test.stopTest();
        
    }
}