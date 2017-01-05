public with sharing class DocumentController {
public List<Document> docList{get;set;}
public id myid;
ApexPages.StandardController Controller1;
     public DocumentController(ApexPages.StandardController controller) {
     Controller1=controller;
      //  Document d = (Document) Controller1.getRecord();
       // d.folderid = UserInfo.getUserId();
       docList=[select name, id from Document];
}
    // public void Doc(){
   // for(Document d:docList)
   // docList=new List<Document>();
   // docList.add(new Document());
   // } 
    
    public pagereference AddNew(){
    //Controller1.save();
   //myid=((Document)Controller1.getRecord()).id;
    
  //  for(Document d:docList){
  //  d.id=myid;
   pageReference pref = new PageReference('/apex/DocumentPage3');
    return pref; 
    }
    
    //insert docList;      
   public void BrowsePage(){
    Document d = (Document) controller1.getRecord();
        d.folderid = UserInfo.getUserId();
        
   }
   
    }