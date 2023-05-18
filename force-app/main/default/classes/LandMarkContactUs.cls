public class LandMarkContactUs {
 
    @AuraEnabled(cacheable=true)
    public static List<Topic__c> getTopics(){
        try {
            List<Topic__c> topicList =  [Select id,Name_of_Topic__c from Topic__c];
            return topicList;
        } catch (Exception e) {
            System.debug('Exception: '+e.getMessage());
            return null;
        }
    }
    
     @AuraEnabled(cacheable=true)
    public static List<Question_And_Answer__c> getQA(string topicId){
        try {
            List<Question_And_Answer__c> QAList =  [Select id,Question__c,Topic__c from Question_And_Answer__c where Topic__c=:topicId];
            return QAList;
        } catch (Exception e) {
            System.debug('Exception: '+e.getMessage());
            return null;
        }
    }
}