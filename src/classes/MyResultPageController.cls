public class MyResultPageController {

    public List<String> objects = new List<String>();
    public Set<String> setObj = new Set<String>();
    public list<string> ListOfSelectedObjectRecords = new list<string>();
    public list<Lead> listOfLeadRecords = new list<Lead>();
    public list<Account> listOfAccountRecords = new list<Account>();
    public list<Opportunity> listOfOpportunityRecords = new list<Opportunity>();
    
    public List<SelectOption> Getoptions(){
        List<SelectOption> selectedOption = new List<SelectOption>();
        selectedoption.add(new SelectOption('Lead' , 'Lead'));
        selectedoption.add(new SelectOption('Account' , 'Account'));
        selectedoption.add(new SelectOption('Opportunity' , 'Opportunity'));
        return selectedOption;
    }
    
    public List<String> GetObjects(){
        return objects;
    } 
    
    public void setObjects(List<String> objects) {
        this.objects = objects;
    }
    
    public PageReference Results() {
        return null;
    }
    
    public PageReference getData() {
        return null;
    }

    public list<sObject> getListOfSelectedObjectRecords(){
        
        setobj.addAll(objects);
        
        if(setobj.contains('Lead')){
            listOfLeadRecords = [select id, name from Lead limit 5];
            return listOfLeadRecords;
        }
        else if(setobj.contains('Account')){
            listOfAccountRecords = [select id, name from Account limit 5];
            return listOfAccountRecords;
        }
        else if(setobj.contains('Opportunity')){
            listOfOpportunityRecords = [select id, name from opportunity limit 5];
            return listOfOpportunityRecords;
        }
        else{
            return null;
        }
        
    }
}