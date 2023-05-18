public class zoomIntegration1 {
    public static void zoom(){
        String accessToken = 'eyJhbGciOiJIUzUxMiIsInYiOiIyLjAiLCJraWQiOiJiOGU2ZjViYS00NjEyLTQ3NTAtODA1Ni1mZDY3MGIwOWQxNjMifQ.eyJ2ZXIiOjcsImF1aWQiOiIwNWQyNTg1MmZlYmYwODQ4MDI1MmU3ZDY2OWMyMDFkMCIsImNvZGUiOiJCUGlVV29JbHpWXzBRREk5NnZTUklxT3lUZzI4VDRKUHciLCJpc3MiOiJ6bTpjaWQ6cEo5eGM5bVFacTRRQ24zaHNtNzdRIiwiZ25vIjowLCJ0eXBlIjowLCJ0aWQiOjAsImF1ZCI6Imh0dHBzOi8vb2F1dGguem9vbS51cyIsInVpZCI6IjBRREk5NnZTUklxT3lUZzI4VDRKUHciLCJuYmYiOjE2NjE5MzY5NzUsImV4cCI6MTY2MTk0MDU3NSwiaWF0IjoxNjYxOTM2OTc1LCJhaWQiOiJueUQtc3JaUVJyV25RTVVPM1FmaUJnIiwianRpIjoiZDI5YTVlZjQtMGUzNS00ZGIwLWE1MGQtZjljMjY1NDA3NDgxIn0.q8o9peHf9wt80BEppfFN9z446mQUO4knK7U_FAnxU6zpcAq05l5a_Gq6KnLVTnfYDBjTi-aL1x-yWaf7vfo45Q';
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setMethod('GET'); 	
		request.setEndpoint('https://api.zoom.us/v2/users/me/meetings');
		request.setHeader('Content-Type','application/json');    
        request.setHeader('Authorization','Bearer '+accessToken );
		String body = 'd';
		HttpResponse response = new HttpResponse();
		//request.setBody(body);
		response = http.send(request);
		String responseBody = response.getBody();
        system.debug(responseBody);
    }
}