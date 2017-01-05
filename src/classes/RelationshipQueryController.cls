public with sharing class RelationshipQueryController {

    public id current_Acc_Id;
    
    public RelationshipQueryController(ApexPages.StandardController controller){
        current_Acc_Id = controller.getRecord().Id;
        system.debug('\n\n------current_Acc_Id---'+current_Acc_Id);
    }
    
    public List<Contact> getRelatedContacts(){ 
        List<Contact> conList = new List<Contact>();
        List<Account> accList = new List<Account>();
        accList = [Select Id, Name, (Select Id, Name, Email from Contacts) From Account Where id =: current_Acc_Id];
        
        for(Account acc: accList){
            for(contact con: acc.Contacts){
                conList.add(con);
            }
        }
        return conList;
    }
}