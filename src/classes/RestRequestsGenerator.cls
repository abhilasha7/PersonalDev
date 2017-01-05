/**********************************************************************
 Name:  RestRequestsGenerator
 Copyright © 2015
=======================================================================
=======================================================================
Purpose:                                                            
-------
class to make urls, body , header required for rest API

======================================================================
======================================================================
History                                                            
-------                                                            
    VERSION     	AUTHOR            DATE              DETAIL             
      1.0   	Lakshay Katney      09/02/2015       INITIAL DEVELOPMENT    
***********************************************************************/
public class RestRequestsGenerator {

	/*********************************************************************************
		@description 	: method to create endpoint for create
						  Example : https://na1.salesforce.com/services/data/v20.0/sobjects/Account
		@param 			: String (endpoint)
	**********************************************************************************/
	public static String createEndpointForCreate(String serverurl, String apiVersion, String objectName){
		return serverurl+'/services/data/v'+apiVersion+'/sobjects/'+objectName;
	}

	/*********************************************************************************
		@description 	: method to create endpint for external Id
		@param 			: String (endpoint)
	**********************************************************************************/
	public static String createEndpointWithExternalId(String url, String fieldName, String value){
		return url+'/'+fieldName+'/'+value;
	}

	/*********************************************************************************
		@description 	: method to create headers for consecutive calls
		@param 			: Map<String,String>
	**********************************************************************************/
	public static Map<String,String> createHeadersForRequest(String sessionId){
		return new Map<String, String>{'Content-Type' => 'application/json', 'Authorization' => 'Bearer '+sessionId};
	}

	/*********************************************************************************
		@description 	: method to create body for rest call
						  will use the same object if don't have field mappings
		@param 			: String(body)
	**********************************************************************************/
	public static String createBody(Sobject record, Map<String, String> mappings){
		Map<String, Object> values = new Map<String,Object>();
		if(mappings != null){
			for(String field : mappings.keySet()){
				values.put(mappings.get(field) , record.get(field));
			}
			return JSON.serialize(values);
		}else{
			return JSON.serialize(record);
		}
	}
}