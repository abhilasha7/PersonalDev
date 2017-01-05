@isTest
public class TestUtils {

	public static String IMAGE_URL = 'http://image.testImage.com/servlet/image';

	public static String SITE_URL = 'http://site.testImage.com';

	public static String SOURCE_OBJECT_NAME = 'Account';

	public static STRINg DESTINATION_OBJECT_NAME = 'Account';

	public static Account createAccountWithImage(String name){
		return new Account(
				Name = name,
				Description = '<img src="'+IMAGE_URL+'"></img>'
		);
	}


	public static void generateRTASettings(){
		RTA_Setup__c setup = new RTA_Setup__c();
		setup.API_Version__c = 32.0;
		setup.Site_Url__c = SITE_URL;
		setup.Object_Name__c = SOURCE_OBJECT_NAME;
		setup.Fields__c = 'Name,Description';
		setup.De_Object_Name__c = DESTINATION_OBJECT_NAME;
		setup.De_Fields__c = 'Name,Description';
		setup.Username__c = 'admin@RTAMig.com';
		setup.Password__c = 'random123';
		setup.External_Id_s_Mapping__c = 'AccountNumber:AccountNumber';
		insert setup;
	}
	
}