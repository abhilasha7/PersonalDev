/**********************************************************************
 Name:  GetRichTextAreaWithImagesJob
 Copyright © 2015
=======================================================================
=======================================================================
Purpose:                                                            
-------
Jobs to do following:
1. process Richtext area fields from specified objects and process
their images to get blob.

2. Deployed to destination org

======================================================================
======================================================================
History                                                            
-------                                                            
    VERSION     	AUTHOR            DATE              DETAIL             
      1.0   	Lakshay Katney      09/02/2015       INITIAL DEVELOPMENT    
***********************************************************************/
global class GetRichTextAreaWithImagesJob implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
	
	global String query;

	global static List<String> failedRecords = new List<String>();

	public static String SESSION;

	public static String SERVER_URL;

	/**************************************************************************************
									GETTER SETTERS VARIABLES
	***************************************************************************************/

	private static String EXTERNAL_ID_FIELD{
		get{
			if(EXTERNAL_ID_FIELD == null){
				if(String.isNotBlank(RTA_Setup__c.getOrgDefaults().External_Id_s_Mapping__c)){
					List<String> ids = RTA_Setup__c.getOrgDefaults().External_Id_s_Mapping__c.split(':');
					if(ids.size() == 2){
						EXTERNAL_ID_FIELD = ids[0];
					}
				}
			}
			return EXTERNAL_ID_FIELD;
		}
		set;
	}

	private static String DESTINATION_EXTERNAL_ID_FIELD{
		get{
			if(DESTINATION_EXTERNAL_ID_FIELD == null){
				if(String.isNotBlank(RTA_Setup__c.getOrgDefaults().External_Id_s_Mapping__c)){
					List<String> ids = RTA_Setup__c.getOrgDefaults().External_Id_s_Mapping__c.split(':');
					if(ids.size() == 2){
						DESTINATION_EXTERNAL_ID_FIELD = ids[1];
					}
				}
			}
			return DESTINATION_EXTERNAL_ID_FIELD;
		}
		set;
	}

	private static String SITE_URL{
		get{
			if(SITE_URL == null){
				if(String.isBlank(RTA_Setup__c.getOrgDefaults().Site_Url__c)){
					throw new JobException('Site url is not defined!');
				}else{
					SITE_URL = RTA_Setup__c.getOrgDefaults().Site_Url__c;
				}
			}
			return SITE_URL;
		}
		set;
	}

	private static String OBJECT_NAME{
		get{
			if(OBJECT_NAME == null){
				if(String.isBlank(RTA_Setup__c.getOrgDefaults().Object_Name__c)){
					throw new JobException('Source object name is not defined!');
				}else{
					OBJECT_NAME = RTA_Setup__c.getOrgDefaults().Object_Name__c;
				}
			}
			return OBJECT_NAME;
		}
		set;
	}

	private static String DESTINATION_OBJECT_NAME{
		get{
			if(DESTINATION_OBJECT_NAME == null){
				if(String.isBlank(RTA_Setup__c.getOrgDefaults().De_Object_Name__c)){
					throw new JobException('Destination Object name is not defined!');
				}else{
					DESTINATION_OBJECT_NAME = RTA_Setup__c.getOrgDefaults().De_Object_Name__c;
				}
			}
			return DESTINATION_OBJECT_NAME;
		}
		set;
	}


	private static String FIELDS{
		get{
			if(FIELDS == null){
				if(String.isBlank(RTA_Setup__c.getOrgDefaults().Fields__c)){
					throw new JobException('Source fields are not defined!');
				}else{
					FIELDS = RTA_Setup__c.getOrgDefaults().Fields__c;
				}
			}
			return FIELDS;
		}
		set;
	}

	private static String DESTINATION_FIELDS{
		get{
			if(DESTINATION_FIELDS == null){
				if(String.isBlank(RTA_Setup__c.getOrgDefaults().De_Fields__c)){
					throw new JobException('Destination fields are not defined!');
				}else{
					DESTINATION_FIELDS = RTA_Setup__c.getOrgDefaults().De_Fields__c;
				}
			}
			return DESTINATION_FIELDS;
		}
		set;
	}


	private static String API_VERSION{
		get{
			if(API_VERSION == null){
				if(String.isBlank(String.valueOf(RTA_Setup__c.getOrgDefaults().API_Version__c))){
					throw new JobException('API version is not defined!');
				}else{
					API_VERSION = String.valueOf(RTA_Setup__c.getOrgDefaults().API_Version__c);
				}
			}
			return API_VERSION;
		}
		set;
	}

	private static String USERNAME{
		get{
			if(USERNAME == null){
				if(String.isBlank(RTA_Setup__c.getOrgDefaults().Username__c)){
					throw new JobException('Username is not defined!');
				}else{
					USERNAME = RTA_Setup__c.getOrgDefaults().Username__c;
				}
			}
			return USERNAME;
		}
		set;
	}


	private static String PASSWORD{
		get{
			if(PASSWORD == null){
				if(String.isBlank(RTA_Setup__c.getOrgDefaults().Password__c)){
					throw new JobException('Username is not defined!');
				}else{
					PASSWORD = RTA_Setup__c.getOrgDefaults().Password__c;
				}
			}
			return PASSWORD;
		}
		set;
	}

	/*********************************************************************************
		@description 	: constructor to build query
	**********************************************************************************/
	global GetRichTextAreaWithImagesJob() {

		//build query
		//add external id to query in case of upsert
		if(String.isNotBlank(EXTERNAL_ID_FIELD)){
			FIELDS = FIELDS+','+EXTERNAL_ID_FIELD;
		}

		query = 'SELECT '+ FIELDS + ' FROM '+OBJECT_NAME;
	}
	

	/*********************************************************************************
		@description 	: start method to validate format for urls
	**********************************************************************************/
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}


	/*********************************************************************************
		@description 	: execute method to process the records
	**********************************************************************************/
   	global void execute(Database.BatchableContext BC, List<Sobject> records) {
   		List<Sobject> recordsToBeUpdated = new List<Sobject>();
		for(Sobject record : records){
			for(String field : FIELDS.split(',')){
				field = field.trim();
				Map<String,String> encodedImagesData = getAllImages(String.valueOf(record.get(field)));

				if(encodedImagesData != null){
					for(String url : encodedImagesData.keySet()){
						record.put(field,String.valueOf(record.get(field)).replace(url, encodedImagesData.get(url)));
						recordsToBeUpdated.add(record);
					}
				}
			}
		}
		
		if(!recordsToBeUpdated.isEmpty()){
			startMigrationOfRecords(records);
		}
	}
	
	/*********************************************************************************
		@description 	: final method
	**********************************************************************************/
	global void finish(Database.BatchableContext BC) {

		if(!failedRecords.isEmpty()){
			System.debug('************************ FAILED RECORDS ************************');
			System.debug(String.join(failedRecords, ','));
			System.debug('************************ END ************************');
		}
	}



	/*************************************************************************************\
									PRIVATE METHODS
	***************************************************************************************/

	/*********************************************************************************
		@description 	: method to migrate data to destination org
		@param 			: List of Sobject Records
	**********************************************************************************/
	private static void startMigrationOfRecords(List<Sobject> records){
		for(SObject record : records){
			System.debug('********************* STARTING MIGRATION TO OTHER SYSTEM FOR RECORDS ID **************************');
			System.debug('\n\n'+record.get('Id'));


			System.debug('********************* GET SESSION ****************************');
			if(String.isBlank(SESSION)){
				makeLoginCall();
			}
			System.debug('*********** SESSION *************'+SESSION);
			System.debug('*********** SERVER URL ***********'+SERVER_URL);
			SERVER_URL = RestRequestsGenerator.createEndpointForCreate(SERVER_URL, API_VERSION, DESTINATION_OBJECT_NAME);
			SERVER_URL = RestRequestsGenerator.createEndpointWithExternalId(SERVER_URL, DESTINATION_EXTERNAL_ID_FIELD, String.valueOf(record.get(EXTERNAL_ID_FIELD.toLowercase())));
			System.debug('*********** SERVER URL FOR CONSECUTIVE CALLS ***********'+SERVER_URL);


			System.debug('********************* CREATE HEADERS ****************************');
			Map<String, String> headers = RestRequestsGenerator.createHeadersForRequest(SESSION);
			System.debug('********************* HEADERS ****************************\n'+headers);


			Map<String,String> mappings = getObjectMappings();
			System.debug('********************** MAPPINGS **************************\n'+mappings);


			String body = RestRequestsGenerator.createBody(record, mappings);
			System.debug('************ BODY **************\n');
			System.debug(body);
			System.debug('************ BODY ENDS **************');


			System.debug('************ MAKE REQUEST **************');
			HttpResponse res = Utils.makeCallout(SERVER_URL, 'PATCH', body , headers);
			System.debug('************ RESULTS **************\n');

			if(res.getStatusCode() != 201 && res.getStatusCode() != 204){
				System.debug(res.getBody());
				failedRecords.add(String.valueOf(record.get('Id')));
			}
		}
	}


	/*********************************************************************************
		@description 	: make login call
	**********************************************************************************/
	private static void makeLoginCall(){
		partnerSoapSforceCom.Soap sf = new partnerSoapSforceCom.Soap();
		partnerSoapSforceCom.LoginResult result = sf.login(USERNAME, PASSWORD);
		SESSION = result.sessionId;
		SERVER_URL = result.serverUrl.substring(0, result.serverurl.indexOf('/services/'));
	}


	/*********************************************************************************
		@description 	:method to return object fields mappings
	**********************************************************************************/
	private static Map<String,String> getObjectMappings(){
		Map<String,String> mappings = new Map<String, String>();

		List<String> sourceFields = FIELDS.split(',');
		List<String> destinationFeilds = DESTINATION_FIELDS.split(',');

		for(Integer i = 0 ; i < destinationFeilds.size() ; i++){
			mappings.put(sourceFields[i].toLowercase(), destinationFeilds[i].toLowercase());
		}
		return mappings;
	}


	/*********************************************************************************
		@description 	: method to get richtext area HTML and process them
		@param 			: String (HTML)
		@return 		: Map<String,String> Src -> Equivalent Blob binding
	**********************************************************************************/
	private static Map<String,String> getAllImages(String richTextBody){

		List<String> imageTags = new List<String>();
		Map<String,String> encodedBodyMap ;
		String subStringbody = richTextBody;

		if(String.isNotBlank(richTextBody)){
			while(subStringbody.contains('<img')){
				Integer startIndex = subStringbody.indexOf('<img',0);
				Integer endIndex = 0;
				if(subStringbody.contains('</img>')){
					endIndex = subStringbody.indexOf('</img>',startIndex) + 6;
				}else if(subStringbody.contains('/>')){
					endIndex = subStringbody.indexOf('/>',startIndex) + 2;
				}
				imageTags.add(subStringbody.substring(startIndex,endIndex));
				subStringbody = subStringbody.substring(endIndex);
			}

			if(!imageTags.isEmpty()){
				List<String>  urls = getAllUrlsFromTags(imageTags);
				if(!urls.isEmpty()){
					encodedBodyMap = createMapForBlobData(urls);
				}
			}
		}
		return encodedBodyMap;
	}

	/*********************************************************************************
		@description 	: method to create blobs from extracted urls
		@param 			: List<url>
		@return 		: Map<String,String> Src -> Equivalent Blob binding
	**********************************************************************************/
	private static Map<String,String> createMapForBlobData(List<String> urls){

		Map<String,String> mapBinaryImageBody = new Map<String,String>();

		for(String url : urls){
			if(Limits.getHeapSize() > 3000000){
				System.debug('******************** SIZE EXCEEDED FOR THIS RECORD *******************');
				return null;
			}else{
				Blob bResult;
				String finalUrl = url.replaceAll('&amp;','&').replace(url.substring(0, url.indexOf('/servlet')), SITE_URL);
				HttpResponse res = Utils.makeCallout(finalUrl, 'GET' , null, null);
				bResult = res.getBodyAsBlob();
				mapBinaryImageBody.put(url,createBinaryImageData(EncodingUtil.base64Encode(bResult)));  
			}
		}
		return mapBinaryImageBody;
	}

	/*********************************************************************************
		@description 	: method to add string in addition to images's blob 
						  to make a valid image for migration
		@param 			: String(encoded data)
		@return 		: String(valid image blob)
	**********************************************************************************/
	private static String createBinaryImageData(String encodedData){
		return 'data:image/png;base64,'+encodedData;
	}


	/*********************************************************************************
		@description 	: method to get all image urls from HTML
		@param 			: List<String>(img tags)
		@return 		: List<Url>
	**********************************************************************************/
	private static List<String> getAllUrlsFromTags(List<String> imageTags){
		List<String> urls = new List<String>();
		for(String tag : imageTags){
			String url = findSrcAtt(tag);
			if(String.isNotBlank(url)){
				urls.add(url);
			}			
		}
		return urls;
	}

	/*********************************************************************************
		@description 	: method to get url from src attribute of img tag
		@param 			: String (img tag)
		@return 		: String(url)
	**********************************************************************************/
	private static String findSrcAtt(String tag){
		String url ;

		if(tag.contains('src')){
			Integer startIndex = tag.indexOf('src');
			Integer endIndex = tag.indexOf('\"',startIndex+5);
			String srcUrl = tag.substring(startIndex+5,endIndex);
			if(Utils.validateUrl(srcUrl)){
				url = srcUrl;
			}
		}
		return url;
	}

	/*********************************************************************************
								EXCEPTION CLASS
	**********************************************************************************/
	public class JobException extends Exception{}
}