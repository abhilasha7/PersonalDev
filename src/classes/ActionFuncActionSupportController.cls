public with sharing class ActionFuncActionSupportController {
    
    public string resultingText {get;set;}
    
    public ActionFuncActionSupportController(){
        resultingText = 'No Action Occurred';
    } 
    
    public void actionFunctionMethod(){
        system.debug('hello====================');
        resultingText = 'Action Function is called!';
        //return resultingText;
    }
    
    public void actionSupportMethod(){
        system.debug('Inside actionSupportMethod()');
        resultingText = 'Action Support is called!';
        //return resultingText;
    }
    
    //public string getresultingText(){
        //return resultingText;
    //} 
}