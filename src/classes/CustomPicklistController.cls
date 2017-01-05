public with sharing class CustomPicklistController{
    
    public String SelectedState {get;set;}
    public String SelectedCity {get;set;}
    
    public CustomPicklistController(ApexPages.StandardController controler){
    }
    
    public List<SelectOption> getCity(){
        List<SelectOption> CityOptions = new List<SelectOption>();
        CityOptions.add(new SelectOption('NDelhi','NDelhi'));
        CityOptions.add(new SelectOption('Pune','Pune'));
        CityOptions.add(new SelectOption('Kolkata','Kolkata'));
        CityOptions.add(new SelectOption('Margao','Margao'));
        
        return CityOptions;
    }    
}