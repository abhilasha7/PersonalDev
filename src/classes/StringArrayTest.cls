Public with sharing class StringArrayTest{

    public static List<String> strList;

    public static List<String> generateStringArray(Integer a){
        strList = new List<String>();
        for(integer b=0; b < a; b++){
            String stringToBe = 'Test'; 
            stringToBe = stringToBe + ' ' + b;
            strList.add(stringToBe); 
        }
    system.debug('----------strList------------'+strList);
    return strList;
    }
}