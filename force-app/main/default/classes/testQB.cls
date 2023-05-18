@isTest
public class testQB {
    @testSetup static void setup() {
        Opportunity op = new Opportunity(Name = 'TestOpp',closeDate = System.today(),stageName='Prospecting');        
        insert op;
    }
    
    @isTest 
    private static void QbCustomerTest(){
        opportunity op = [select Name,id from opportunity where name like 'TestOpp'];
        string recordId = op.Id;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new mockCalloutQB());
        //QbPaymentConnect.QbCustomers(recordId);
        opportunity o = new opportunity(name='demo',closeDate=System.today(),stageName='Prospecting');
       	insert o;
        Test.stopTest();
    }
     @isTest 
    private static void QbCustomerTest1(){
        opportunity op = [select Name,id from opportunity where name like 'TestOpp'];
        string recordId = op.Id;
        Test.startTest();
        QbPaymentConnect.QbCustomers(recordId);
        Test.stopTest();
    }

    
    
   
    
}