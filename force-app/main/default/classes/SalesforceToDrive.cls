public class SalesforceToDrive {
    
    public static string ContentType(string fileType)
    {
        switch on fileType.toLowerCase()
        {
            when 'docx'
            {
                return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            }
            when 'csv'
            {
                return 'application/vnd.ms-excel';
            }
            when 'wav'
            {
                return 'audio/wav';
            }
            when 'wmv'
            {
                return 'video/x-ms-wmv';
            }
            when 'mp3'
            {
                return 'audio/mpeg';
            }
            when 'mp4'
            {
                return 'video/mp4';
            }
            when 'png'
            {
                return 'image/png';
                
            }
            when 'pdf'
            {
                return 'application/pdf';
                
            }
            when 'txt'
            {
                return 'text/plain';      
            }
            when else {
                return 'image/jpeg';
            }
        }
    }
    @AuraEnabled(cacheable=true)
     public static void UploadDocuments(string recordId)
    { 
        List<ContentDocumentLink> links=[SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink where LinkedEntityId=:recordId];
        Set<Id> ids=new Set<Id>();
        for(ContentDocumentLink link:links)    
        {
            ids.add(link.ContentDocumentId);
            system.debug(link.ContentDocumentId);
        }
        List<ContentVersion> versions=[SELECT VersionData,Title,ContentDocumentId,FileExtension FROM ContentVersion WHERE ContentDocumentId = :ids AND IsLatest = true];        
        for(ContentVersion attach:versions)
        {
            try
            {
                system.debug('test1');
                uploadFile(attach.VersionData, attach.Title, attach.FileExtension);
                system.debug('test2');
            }
            catch(Exception ex)
            {
               system.debug('error');
            }
        }
    }
    
     	@Future(callout=true)
    public static void uploadFile(blob versionData,string title,string extn){
        String attachmentBody = EncodingUtil.base64Encode(versionData);
        String filename = title;
        string contentType=ContentType(extn);
        system.debug(contentType);
        string endpointUrl='/2555a844-14e8-4ea3-83d6-d1598ea68df7/drive/items/root:/{file}:/content';
        string file=EncodingUtil.URLENCODE(filename,'UTF-8').replace('+', '%20');
        endpointUrl=endpointUrl.replace('{file}',file+'.'+extn);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Microsoft'+endpointUrl);
        req.setMethod('PUT'); 
        //req.setHeader('Content-Encoding', 'UTF-8');
        req.setHeader('Content-type',contentType);
          req.setHeader('Content-type','text/html, image/gif, image/jpeg, *; q=.2, /; q=.2');
        Http http = new Http();
        system.debug('getBody1 '+req);
        req.setBodyAsBlob(versionData);
        system.debug(versionData);
        req.setTimeout(120000);
        HTTPResponse res = http.send(req);
        system.debug('getBody2 '+res.getBody());
        if(res.getStatusCode()==200)
        {
            system.debug('getBody '+res.getBody());
        }
    }   
    
}