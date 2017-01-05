public class SObject1{

public SObject1 getNewSobject(String t)
   {
    
       // Call global describe to get the map of string to token.
       system.debug('S- objects' +  Schema.getGlobalDescribe());
    
       // Get the token for the sobject based on the type.
      // Schema.SObjectType st = gd.get(t);
    
      // Instantiate the sobject from the token.
      //Sobject s = st.newSobject();
   
      //return s;
      return null;
  }
}