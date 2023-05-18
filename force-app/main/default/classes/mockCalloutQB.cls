global class mockCalloutQB implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        req.setBody('{"Customer": {"Id": "67"}}');
        res.setStatusCode(200);
        return res;
    }
}