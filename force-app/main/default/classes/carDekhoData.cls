public class carDekhoData {
    @AuraEnabled(cacheable=true)
	public static List<Car__c> carsData(){
        List<Car__c> carDataList = [select Name, MSRP__c, Picture_URL__c from Car__c];
        return carDataList;
    }
}