public class ObjectController {
public string SObject1 {get; set;}
public List<String> AllFields{get;set;}

//public string dummySelectedItem {get; set;}


public List<SelectOption> getSobjectList()
    {
      List<SelectOption> SObjectList = new List<SelectOption>();
      
      SObjectList.add(new SelectOption('-None-', '-None-'));
      
     Map<String,Schema.SobjectType> gd= Schema.getGlobalDescribe();
       Set<String> gdKeySet = gd.keySet();
       for(String k : gdKeySet){
           SObjectList.add(new SelectOption(k, k));
       }     
 
       return SObjectList;
    }
    
public void method1(){
    System.debug('SObject1 :::'+SObject1);
    Map<String,Schema.SobjectType> gd= Schema.getGlobalDescribe();    
    Schema.SobjectType st=gd.get(SObject1);
    
    Schema.DescribeSObjectResult r=st.getDescribe();
    Map<String,Schema.SObjectField> fieldmap= r.fields.getMap();
    AllFields= new List<String>();
    for(String a : fieldmap.keySet()){
     AllFields.add(a);
     }
    
  } 
}

//public void CheckValue(){
  //  System.debug('dummySelectedItem :::'+dummySelectedItem);
//}