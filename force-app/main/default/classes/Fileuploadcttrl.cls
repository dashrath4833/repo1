public class Fileuploadcttrl {
    @AuraEnabled(cacheable=false)
    public static List<ContentDocumentLink> fetchFiles(String recordId){
        List<ContentDocumentLink> att= [SELECT ContentDocumentId,LinkedEntityId, ContentDocument.CreatedDate, ContentDocument.Title, ContentDocument.ContentSize, ContentDocument.FileType
        FROM ContentDocumentLink WHERE LinkedEntityId  =:recordId];
        return att;
    }

    @AuraEnabled(cacheable=false)
    public static List<ContentDocumentLink> fetchFilterFiles(String recordId, String type){
        System.debug(recordId);
        System.debug(type);
        string type1 = '%'+type+'%';
        //Datetime dt = DateTime.parse(type1);
        List<ContentDocumentLink> att1= [SELECT ContentDocumentId,LinkedEntityId, ContentDocument.CreatedDate, ContentDocument.Title, ContentDocument.ContentSize, ContentDocument.FileType
        FROM ContentDocumentLink WHERE LinkedEntityId  =:recordId and ContentDocument.FileType Like :type1];
        System.debug(att1);
        return att1;

    }

}