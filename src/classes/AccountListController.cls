public with sharing class AccountListController {

    public List<Account> accountList {get; set;}
    public List<wrapperAccountClass> wrapperAccList;
    public List<Account> toBeDeletedAccList {get;set;}
    public List<Account> MovingAccList {get;set;}
    public List<Account> toBeMovedAccList {get;set;}
    public boolean removeCheckboxForAccount {get;set;}
    //Pagination : START
    public integer counter=0;  //keeps track of the offset
    public integer list_size=5; //sets the page size or number of rows
    public integer total_size; //used to show user the total size of the list
    //Pagination: END
    
    public AccountListController() {
        //Pagination: Start
        total_size = [select count() from Account]; //set the total size in the constructor
        //Pagination: End
        getwrapperAccList();
        toBeMovedAccList  = new List<Account>();
        //removeCheckboxForAccount = false;
    }
    
    public List<wrapperAccountClass> getwrapperAccList(){
        wrapperAccList = new List<wrapperAccountClass>();
        accountList = new List<Account>([Select Id, Name from Account limit :list_size offset :counter]);
        
        for(Account a : accountList){
            wrapperAccountClass wrapperObj = new wrapperAccountClass();
            wrapperObj.account1 = a;
            wrapperAccList.add(wrapperObj);
        }
        return wrapperAccList;
    }
    
    public pagereference deleteAccounts(){
        toBeDeletedAccList = new List<Account>();
        for (wrapperAccountClass b : wrapperAccList){
            if(b.selected == true){
                toBeDeletedAccList.add(b.account1);
            }
        }
        if(toBeDeletedAccList.size() > 0){
            delete toBeDeletedAccList;
        }
        return null;
    }
    
    public pagereference moveAccounts(){
        for(wrapperAccountClass b : wrapperAccList){
            if(b.selected == true){
                toBeMovedAccList.add(b.account1);
                b.disableCheckbox = b.selected;
            }
        }
        return null;
    }
    
    //Pagination: START ****
    //public Number__c[] getNumbers() {
      //try {
         //Number__c[] numbers = [select Number__c, Square_Root__c 
                                //from Number__c 
                                //order by Number__c 
                                //limit :list_size 
                                //offset :counter];
 
         //return numbers;
      //} catch (QueryException e) {
         //ApexPages.addMessages(e);   
         //return null;
      //}
    
    public PageReference Beginning() { 
    //user clicked beginning
      counter = 0;
      return null;
    }
    
    public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      return null;
    }
    
    public PageReference Next() { //user clicked next button
      counter += list_size;
      return null;
    }
    
    public PageReference End() { //user clicked end
      counter = total_size - math.mod(total_size, list_size);
      return null;
    }
    
    public Boolean getDisablePrevious() { 
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
    }
    
    public Boolean getDisableNext() { //this will disable the next and end buttons
      if (counter + list_size < total_size) return false; else return true;
    }
    
    public Integer getTotal_size() {
      return total_size;
    }
 
    public Integer getPageNumber() {
      return counter/list_size + 1;
    }
 
    public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
    }
    //Pagination: END ****
    
    public class wrapperAccountClass{
        public boolean selected {get; set;}
        public Account account1 {get; set;}
        public boolean disableCheckbox {get; set;}
    }
}