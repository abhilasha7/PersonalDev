/**********************************************************************
 Name:  Utils
 Copyright © 2015
 ======================================================
======================================================
Purpose:                                                            
-------
- Methods to handle all utility methods

======================================================
======================================================
History                                                            
-------                                                            
    VERSION     	AUTHOR            DATE              DETAIL             
      1.0   	Lakshay Katney      09/02/2015       INITIAL DEVELOPMENT    
***********************************************************************/
public with sharing class Utils {
	
	/*********************************************************************************
		@description 	: method to validate format for urls
		@param 			: url
		@return 		: Boolean
	**********************************************************************************/
	public static Boolean validateUrl(String url){
		String urlRegex = '(http(s)?://)?([\\w-]+\\.)+[\\w-]+(/[\\w- ;,./?%&=]*)?';
	    Pattern MyPattern = Pattern.compile(urlRegex);
	    Matcher MyMatcher = MyPattern.matcher(url);
		return MyMatcher.matches();
	}

	/*********************************************************************************
		@description 	: method to make https callouts
		@param 			: url, method, body , headers
		@return 		: HttpResponse
	**********************************************************************************/
	public static HttpResponse makeCallout(String url, String method, String body, Map<String,String> headers){
		HttpRequest req = new HttpRequest();
		HTTPResponse res = new HTTPResponse();
		Http http = new Http();

		//for patch
		if(method == 'PATCH'){
			req.setMethod('POST');
			url += '?_HttpMethod=PATCH';
		}else{
			req.setMethod(method);
		}

		req.setEndpoint(url);

		if(String.isNotBlank(body)){
			req.setBody(body);
		}
		if(headers != null){
			for(String key : headers.keySet()){
				req.setHeader(key, headers.get(key));
			}
		}
		res = http.send(req);
		return res;
	}
}