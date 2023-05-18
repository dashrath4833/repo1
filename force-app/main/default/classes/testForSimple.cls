@isTest
public class testForSimple {
     @testSetup static void setup() {
        Account ac = new Account(Name = 'TestAccount');        
        insert ac;
    }
    
    private static void testClass(){
        account acc = [select name from account where name='TestAccount'];
        
    }
}