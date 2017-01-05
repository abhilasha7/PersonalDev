public class RTAMigrationToolInfoController {

	private static final Integer BATCH_SIZE = 1;

	public Boolean showMsg {get;set;}

	public Pagereference runJob(){
		Id jobId = Database.executeBatch(new GetRichTextAreaWithImagesJob(), BATCH_SIZE);
		showMsg = true;
		return null;
	}

}