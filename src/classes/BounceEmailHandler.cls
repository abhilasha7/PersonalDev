global class BounceEmailHandler implements Messaging.InboundEmailHandler {
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          zAbhi__Bounce_Email_Settings__c setting = zAbhi__Bounce_Email_Settings__c.getOrgDefaults();
          
          if(String.isNotBlank(email.subject) && email.subject.contains(setting.zAbhi__Email_Subject__c)){
              sendEmail(new List<String>{setting.zAbhi__Send_Email_To__c}, email);
          }else{
              
              String fromAddress;
              if(String.isNotBlank(email.plaintextbody)){
                  fromAddress = getFromAddressFromBody(email.plaintextbody);
              }
              
              System.debug('===>'+fromAddress);
              if(String.isNotBlank(fromAddress)){
                  sendEmail(new List<String>{fromAddress}, email);
              }
          }
          return result;
      }
      
    public static String getFromAddressFromBody(String body){
        String regex = 'From: ([a-zA-Z0-9_\\-\\.]+)@(((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3}))';     
        Pattern myPattern = Pattern.compile(regex );    
        Matcher myMatcher = myPattern.matcher(body);
        
        //The below code will give you my.email@mycompany.com in the debug log.     
        if (myMatcher.find()) {
             return myMatcher.group().split(':')[1].trim();
        }else{
             return '';
        }
    } 
          
    public static void sendEmail(List<String> toAddresses, Messaging.InboundEmail email){
        // new instance of a single email message
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        zAbhi__Bounce_Email_Settings__c setting = zAbhi__Bounce_Email_Settings__c.getOrgDefaults();
        EmailTemplate et = [SELECT id, body FROM EmailTemplate WHERE developerName = 'TEST_Template'];
        //emailtemplate et = [select body, BrandTemplateId from emailtemplate where brandtemplateId.name='Test letterhead template' limit 1];
           
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName(setting.zAbhi__Sender_Display_Name__c);
        mail.setSubject(email.subject);
        mail.setBccSender(false);
        mail.setUseSignature(false);
        //mail.setPlainTextBody(email.plainTextBody);
        mail.setPlainTextBody(et.body.replace('{0}', email.plainTextBody));
        //mail.setTemplateId(et.id);
        //mail.setPlainTextBody(et.body);
        String[] bccEmail = new String[]{setting.zAbhi__Send_Email_to_Bcc_Address__c};
        mail.setBccAddresses(bccEmail);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }  

  }