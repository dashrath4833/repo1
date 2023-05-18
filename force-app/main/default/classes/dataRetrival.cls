public class dataRetrival {
    @AuraEnabled(cacheable=true)
    public static List<Object> dataFetchForObjNames(){
        List<AggregateResult> sObj = [SELECT SObjectType FROM ObjectPermissions GROUP BY SObjectType];
        list<Object> nameOfAllObjects = new List<Object>();
        for(AggregateResult s: sObj){
            nameOfAllObjects.add(s.get('SobjectType'));
        }
        system.debug('sObj '+nameOfAllObjects);
        return nameOfAllObjects;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<String> getFields(String obj){
        List<String> fieldNames = new List<String>();
        String SobjectApiName = obj;
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
        for(String fieldName : fieldMap.keyset() )
        {
            fieldNames.add(fieldName);
        }
        SYSTEM.debug('fieldNames: '+fieldNames);
        return fieldNames;
    }
}