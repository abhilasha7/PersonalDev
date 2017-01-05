@isTest
private class RTAMigrationToolInfoControllerTest {

	@isTest static void testJob() {

		//setupData
		//generate custom settings
		TestUtils.generateRTASettings();

		Account acc = TestUtils.createAccountWithImage('Test Record');
		insert acc;

		//set for webservice call too
		Test.setMock(WebServiceMock.class, new CalloutMocksHandler());

		// Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new CalloutMocksHandler());

		Test.startTest();
 			RTAMigrationToolInfoController controller = new RTAMigrationToolInfoController();
 			controller.runJob();
		Test.stopTest();

		System.assertEquals(CalloutMocksHandler.SESSION, GetRichTextAreaWithImagesJob.SESSION);
		System.assertEquals(0, GetRichTextAreaWithImagesJob.failedRecords.size());

	}
}