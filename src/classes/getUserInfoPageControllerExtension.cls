public with sharing class getUserInfoPageControllerExtension {
    
    public static Id LoggedInUserId{get;set;}
    public static String LoggedInUserName{get;set;}
    
    public getUserInfoPageControllerExtension(ApexPages.StandardController controller){
        LoggedInUserId = userinfo.getUserId();
        LoggedInUserName = userinfo.getUserName();
    }

}