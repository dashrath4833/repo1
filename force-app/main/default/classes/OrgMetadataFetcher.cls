// Apex class to fetch org metadata using Apex
public with sharing class OrgMetadataFetcher {
    
    public static void getMaxApiRequestsLimit() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v43.0/limits/');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        HttpResponse response = new Http().send(request);
    }
    
    public static void test(){
        Organization edition = [SELECT Id, Name, OrganizationType FROM Organization LIMIT 1];
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v57.0/tooling/query/?q=SELECT+count()+FROM+CustomObject');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        HttpResponse res = new Http().send(request);
        integer totalSize;
        if (res.getStatusCode() == 200) {
            Map<String, Object> jsonResponse = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            System.debug('jsonR '+jsonResponse);
            totalSize = integer.valueOf(jsonResponse.get('totalSize'));
            
        } else {
            System.debug('Error: ' + res.getBody());
        }
        integer valueToPrint;
        integer maximum;
        if(edition.OrganizationType=='Developer Edition'){
            maximum=400;
            valueToPrint=400 - totalSize;
        }else if(edition.OrganizationType=='Professional Edition'){
            maximum=50;
            valueToPrint=50 - totalSize;
        }else if(edition.OrganizationType=='Enterprise Edition'){
            maximum=200;
            valueToPrint=200 - totalSize;
        }else if(edition.OrganizationType=='Unlimited and Performance Edition'){
            maximum=2000;
            valueToPrint=2000 - totalSize;
        }
        
        String test = '<br/><br/><h2 style="text-decoration: underline;">Object Limit</h2>'
            +'<table style="width:50%;border: 1px solid black;border-collapse: collapse;"><tr>'
            +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Custom Object Count</th>'
            +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Maximum</th>'
            +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Available</th>'
            +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Used</th>'
            +'</tr><tr>'
            +'<td style="border: 1px solid black;border-collapse: collapse;">Object count</td>'
            +'<td style="border: 1px solid black;border-collapse: collapse;">'+maximum+'</td>'
            +'<td style="border: 1px solid black;border-collapse: collapse;">'+valueToPrint+'</td>'
            +'<td style="border: 1px solid black;border-collapse: collapse;">'+totalSize+'</td>'
            
            +'</tr></table>';
        string dhcStr = 'Hi All,<br/><br/>Daily Health Check of <b>Landmark for '+system.now().format('MMMM dd, yyyy')+'.</b><br/><br/>'
            +test+'<br/><br/><b><i>Testing Health Check</i></b>';
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> st = new List<String>{'vipinsharma@cyntexa.com'};
            mail.setToAddresses(st);
        mail.setReplyTo('test@test.com');
        mail.setSenderDisplayName('Tester');
        mail.setSubject('Testing Subject');
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setHtmlBody(dhcStr);
        Messaging.sendEmail(new Messaging.Email[] { mail });
        
    }
    
    public static void getInactiveUsersCount() {
        Date thirtyDaysAgo = Date.today().addDays(-30);
        String soqlQuery30 = 'SELECT Id, Name, LastLoginDate FROM User WHERE LastLoginDate >=:thirtyDaysAgo AND IsActive = true ORDER BY LastLoginDate DESC';
        List<User> usrList30 =  Database.query(soqlQuery30);
        integer count30 = usrList30.size();
        system.debug('usrList '+count30);
        
        Date sixtyDaysAgo = Date.today().addDays(-60);
        String soqlQuery60 = 'SELECT Id, Name, LastLoginDate FROM User WHERE LastLoginDate >=:thirtyDaysAgo AND IsActive = true ORDER BY LastLoginDate DESC';
        List<User> usrList60 =  Database.query(soqlQuery60);
        integer count60 = usrList60.size();
        system.debug('usrList '+count60);
        
        Date nintyDaysAgo = Date.today().addDays(-60);
        String soqlQuery90 = 'SELECT Id, Name, LastLoginDate FROM User WHERE LastLoginDate >=:thirtyDaysAgo AND IsActive = true ORDER BY LastLoginDate DESC';
        List<User> usrList90 =  Database.query(soqlQuery90);
        integer count90 = usrList90.size();
        system.debug('usrList '+count90);
        
    }      
    
    
    
    public static void test(String obj) {
        HttpRequest request = new HttpRequest();
        /*
String st = 'Select%20id,ValidationName%20from%20ValidationRule%20where%20EntityDefinition.DeveloperName=\'contact\'';
request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v57.0/tooling/query/?q='+st);
request.setMethod('GET');
request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
HttpResponse response = new Http().send(request);
system.debug('records '+response.getBody());


map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe(); 
for (Schema.SObjectType Obj : GlobalMap.values()) {
Schema.DescribeSObjectResult ObjDesc = Obj.getDescribe();
system.debug('Object Name: ' + ObjDesc.getName());
Map<string,Schema.SObjectField> get_F_name=Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap();
System.debug('fields: '+get_F_name.keySet().size());
}

List<FlowDefinitionView> tst = [Select id, IsActive, Label, ProcessType, ManageableState , TriggerObjectOrEventId, TriggerObjectOrEventLabel, TriggerType from FlowDefinitionView where TriggerObjectOrEventLabel='Opportunity'];
integer totalFlows = tst.size();   


String st1 = 'Select%20id,ActiveVersion.VersionNumber,LatestVersion.VersionNumber,DeveloperName,Metadata%20from%20FlowDefinition%20Limit%201';
request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v57.0/tooling/query/?q='+st1);
request.setMethod('GET');
request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
HttpResponse response1 = new Http().send(request);
system.debug('records '+response1.getBody());
*/
        
        String st1 = 'SELECT+Id,+DurableId,+Type,+Label,+Max,+Remaining,+EntityDefinitionId+FROM+EntityLimit+WHERE+EntityDefinitionId+=+\''+obj+'\'';
        request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v57.0/tooling/query/?q='+st1);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        HttpResponse response1 = new Http().send(request);
        String responseBody = response1.getBody();
        Map<String, Object> parsedResponse = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
        List<Object> records = (List<Object>) parsedResponse.get('records');
        
        List<Map<String, Object>> valuesList = new List<Map<String, Object>>();
        for (Object record : records) {
            Map<String, Object> recordMap = (Map<String, Object>) record;
            Map<String, Object> attributes = (Map<String, Object>) recordMap.get('attributes');
            String label = (String) recordMap.get('Label');
            Integer remaining = (Integer) recordMap.get('Remaining');
            Integer max = (Integer) recordMap.get('Max');
            
            Map<String, Object> valuesMap = new Map<String, Object>{
                'label' => label,
                    'remaining' => remaining,
                    'max' => max
                    };
                        
                        valuesList.add(valuesMap);
        }
        
        String limits = '<h2 style="text-decoration: underline;">Object Limits '+obj+'</h2>'
            +'<table style="width:50%;border: 1px solid black;border-collapse: collapse;"><tr>'
            +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Label</th>'
            +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Max</th>'
            +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Remaining</th>'
            +'</tr>';
        
        system.debug('valuesList '+valuesList);
        for (Map<String, Object> valuesMap : valuesList) {
            String label = (String) valuesMap.get('label');
            Integer remaining = (Integer) valuesMap.get('remaining');
            Integer max = (Integer) valuesMap.get('max');
            limits += '<tr>'
                +'<td style="border: 1px solid black;border-collapse: collapse;">'+label+'</td>'
                +'<td style="border: 1px solid black;border-collapse: collapse;">'+max+'</td>'
                +'<td style="border: 1px solid black;border-collapse: collapse;">'+remaining+'</td>'
                +'</tr>';
        }
        limits+='</table><br/><br/>';
        string dhcStr = 'Hi All,<br/><br/>Daily Health Check of <b>Landmark for '+system.now().format('MMMM dd, yyyy')+'.</b><br/><br/>'
            +limits+'<br/><br/><b><i>Health Check Test</i></b>';
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> st = new List<String>{'vipinsharma@cyntexa.com'};
            mail.setToAddresses(st);
        mail.setReplyTo('test@test.com');
        mail.setSenderDisplayName('Tester');
        mail.setSubject('Testing Subject');
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setHtmlBody(dhcStr);
        Messaging.sendEmail(new Messaging.Email[] { mail });
        
        
        
    }
    
    //////////////////////
    public static void test1(String cloud) {
        List<String> objArray = new List<String>();
        if(cloud=='Sales Cloud'){
            objArray = new List<String>{'Account','Contract','Product2','Opportunity','Campaign','Lead','Contact','Pricebook2','Task'};
        }else if(cloud=='Service Cloud'){
              objArray = new List<String>{'ServiceResource','ServiceResourceFeed','ServiceAppointmentStatus','ServiceReport','ServiceResourceCapacity','ServiceTerritoryWorkType','CaseContactRole','ServiceTerritoryMember','ServiceTerritory','ServiceContract','Case','ServiceCrew','ServiceAppointment','ServiceResourceSkill'};
                        
        }
        string dhcStr = 'Hi All,<br/><br/>Daily Health Check of <b>'+cloud+ 'for '+system.now().format('MMMM dd, yyyy')+'.</b><br/><br/><br/><br/><b><i>Health Check Test</i></b> </br>';
        string ss='';
        
        
        for(string st: objArray){//for(integer i = 0;i<objArray.size();i++){
            HttpRequest request = new HttpRequest();   
            String st1 = 'SELECT+Id,+DurableId,+Type,+Label,+Max,+Remaining,+EntityDefinitionId+FROM+EntityLimit+WHERE+EntityDefinitionId+=+\''+st+'\'';
            request.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v57.0/tooling/query/?q='+st1);
            request.setMethod('GET');
            request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
            HttpResponse response1 = new Http().send(request);
            String responseBody = response1.getBody();
            system.debug('responseBody '+responseBody);
            Map<String, Object> parsedResponse = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
            List<Object> records = (List<Object>) parsedResponse.get('records');
            
            List<Map<String, Object>> valuesList = new List<Map<String, Object>>();
            for (Object record : records) {
                Map<String, Object> recordMap = (Map<String, Object>) record;
                Map<String, Object> attributes = (Map<String, Object>) recordMap.get('attributes');
                String label = (String) recordMap.get('Label');
                Integer remaining = (Integer) recordMap.get('Remaining');
                Integer max = (Integer) recordMap.get('Max');
                
                Map<String, Object> valuesMap = new Map<String, Object>{
                    'label' => label,
                        'remaining' => remaining,
                        'max' => max
                        };
                            
                            valuesList.add(valuesMap);
            }
            
            String limits = '<h2 style="text-decoration: underline;">Object Limits '+st+'</h2>'
                +'<table style="width:50%;border: 1px solid black;border-collapse: collapse;"><tr>'
                +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Label</th>'
                +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Max</th>'
                +'<th style="border: 1px solid black;border-collapse: collapse;background-color:#FCE8DA;">Remaining</th>'
                +'</tr>';
            
            system.debug('valuesList '+valuesList);
            for (Map<String, Object> valuesMap : valuesList) {
                String label = (String) valuesMap.get('label');
                Integer remaining = (Integer) valuesMap.get('remaining');
                Integer max = (Integer) valuesMap.get('max');
                limits += '<tr>'
                    +'<td style="border: 1px solid black;border-collapse: collapse;">'+label+'</td>'
                    +'<td style="border: 1px solid black;border-collapse: collapse;">'+max+'</td>'
                    +'<td style="border: 1px solid black;border-collapse: collapse;">'+remaining+'</td>'
                    +'</tr>';
            }
            limits+='</table><br/><br/>';
            dhcStr+='<br/>'+limits;
            ss += dhcStr;
            dhcStr='';
            
        }
        system.debug('ssttss '+ ss);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> st = new List<String>{'dashrath@cyntexa.com'};
        mail.setToAddresses(st);
        mail.setReplyTo('test@test.com');
        mail.setSenderDisplayName('Tester');
        mail.setSubject('Testing Subject');
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setHtmlBody(ss);
       // Messaging.sendEmail(new Messaging.Email[] { mail });
        
        
        
    }
    
    
}