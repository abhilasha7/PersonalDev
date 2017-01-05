public with sharing class CustomerTriggerHandler {

	public void onBeforeInsert(final List<Customer__c> newCustomerList) {
        
       //iterating this customer list
       for(Customer__c cust : newCustomerList){
       		cust.Phone__c = '1234567890';
			
			if(cust.Phone__c == '1234567890'){
				cust.Address__c = 'abc';
			}
		}

	}

	public void onBeforeUpdate(Map<Id,Customer__c> oldCustMap, final List<Customer__c> custList, Map<Id,Customer__c> newCustMap){
		//for(List<Customer__c> c : oldCustMap){
			//if(c.Phone__c == '1234567890'){
				//custList.add(c);
			//}
		//}

		//if(custList.size() > 0 && custList.size() != null){

		//}
	}

}