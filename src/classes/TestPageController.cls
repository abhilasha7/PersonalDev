public with sharing class TestPageController {

    public List<StatesAndCapitals__c> StatesAndCapitalsList = new List<StatesAndCapitals__c>();

    Public TestPageController(){
        StatesAndCapitalsList = [select Name, Capital__c from StatesAndCapitals__c];
        
        //Get all the states and their capitals
        for(StatesAndCapitals__c saC: StatesAndCapitalsList ){
            System.debug('State Name is #'+ saC.Name +'and it s capital is'+ saC.Capital__c);
        }
    
        //Get capital of a specific state
        StatesAndCapitals__c CapitalOfGoa =  StatesAndCapitals__c.getValues('Goa');
        System.debug('Capital of goa is -' + CapitalOfGoa.Capital__c );
    }

}