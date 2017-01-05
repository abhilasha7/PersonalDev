public with sharing class PaymentController {

    public Payment__c payment{get;set;}
    
     String paymentId ;
    public PaymentController (){
       paymentId= ApexPages.currentPage().getParameters()
       .get('id');
       
       payment=[Select total_cost__c from Payment__c where id=:paymentId];
       System.debug('Payment object from db---' + payment);
    }
    
    public void SavePayment()
    {    
        System.debug('Payment object ---' + payment);
        
        createMember();
        update payment;
        
        
   } 
    
    private void createMember(){
        
        MemberServiceStub.MemberService service = new  MemberServiceStub.MemberService();
        service.SessionHeader =  new MemberServiceStub.SessionHeader_element();
        service.SessionHeader.sessionId = '00D90000000bp0b!ARoAQE6CmqvWiclwWScOLmjn8r076rPaqaYDlkPgG2F_LKU3MtD09yj_CHXrQTQE6_vcAua0vS5ZVYcfG5kUo6m91ZxqAVk1';
        service.createMember('Abhishek',15421231);
    }
}