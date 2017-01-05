global class CalloutMocksHandler implements WebServiceMock, HttpCalloutMock {
	public static String SESSION = 'random-session';

	public static String SERVERURL = 'https://ap1.salesforce.com/services/Soap/u/20.0';

	global void doInvoke(
	   Object stub,
	   Object request,
	   Map<String, Object> response,
	   String endpoint,
	   String soapAction,
	   String requestName,
	   String responseNS,
	   String responseName,
	   String responseType) {

		partnerSoapSforceCom.loginResponse_element response_element = new partnerSoapSforceCom.loginResponse_element();
		response_element.result = new partnerSoapSforceCom.LoginResult();
		response_element.result.serverUrl = SERVERURL;
		response_element.result.sessionId = SESSION;
		response.put('response_x', response_element); 
	}

	global HTTPResponse respond(HTTPRequest req) {
		HttpResponse res = new HttpResponse();
		if(req.getEndpoint() == TestUtils.SITE_URL+'/servlet/image'){
			res.setBody('Blob content');
			res.setStatusCode(200);
		}else{
			res.setStatusCode(201);
		}
		return res;
	}
}