public class random{
List<String> RandomList= new List<String>();

    Public void RandomMethod()
    {
         List<Customer__c> CustList=[select Name from Customer__c];
         for(Customer__c c:CustList){
         RandomList.add(c.Name);
         }
    }
}