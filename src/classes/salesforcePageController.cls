public with sharing class salesforcePageController {

    public salesforcePageController(){
    }
    
    public void retrieveBooks(){
        List<Book__c> bookList = new List<Book__c>();
        List<Book__c> books = new List<Book__c>();
        
        books = [select Name, Author__c from Book__c];    
        
        for(Book__c b : books){
            bookList.add(b);
        }
    }
}