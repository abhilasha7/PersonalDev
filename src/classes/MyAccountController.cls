public with sharing class MyAccountController {
public List<Contact> conList{get;set;}
public Id myid;
ApexPages.StandardController Controller1;
    
    public MyAccountController(ApexPages.StandardController controller) {
        Controller1=controller;
    }

    public void PopContactList(){
    conList=new List<Contact>();
    conList.add(new Contact());
    conList.add(new Contact());
    conList.add(new Contact());
    }
    
    public PageReference Submit(){
    Controller1.save();
    myid=((Account)Controller1.getRecord()).id;
    
    for(Contact con:conList){
    con.Accountid=myid;
    }
    insert conList;      
    pageReference pref = Controller1.view();    
    return pref; 
    
    }
    
}