global class mockCalloutDrive implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"value": [{"name": "Attachments"}]}');
        res.setStatusCode(200);
        return res;
    }
}