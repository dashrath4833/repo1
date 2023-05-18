@isTest
public class testBatch {
    @isTest static void test() {
        
        Test.startTest();
      //  List<account> ac = [select name from account];
        batchPrac batchObj = new batchPrac();
        id batchId = database.executeBatch(batchObj);
        system.debug('batchId '+batchId);
        
        Test.stopTest();
        
        // System.assert logic afterwards
    }
}