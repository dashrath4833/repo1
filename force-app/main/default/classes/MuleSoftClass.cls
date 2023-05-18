public class MuleSoftClass {
    
    @future(callout=true)
    public static void main(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://testproject-5j5f0p.5sc6y6-4.usa-e2.cloudhub.io');
        request.setMethod('GET');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        System.debug('Limits.getCallouts - '+ Limits.getCallouts());
        System.debug('Limits.getLimitCallouts - '+ Limits.getLimitCallouts());
    }
}