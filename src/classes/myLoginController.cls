public class myLoginController {
    public string username {get; set;}
    public string password {get; set;}
    
    
    //chr limitation
    //verification then redirection
    //error message
    
    public pagereference login(){
        pagereference pr;
        system.debug('-----------------username---------------'+username);
        system.debug('-----------------password---------------'+password);
        
        string actualUsername = 'abhilasha';
        string actualPassword = 'pass123';
        
        if(actualUsername == username && actualPassword == password){
            system.debug('--------------entered-------------');
            //pagereference pr =  new PageReference('/apex/afterLoginPage');
            pr = page.afterLoginPage;
            pr.setRedirect(true);
            return pr;
        }
        else if(username != actualUsername){
            apexpages.Message msg = new Apexpages.Message(ApexPages.severity.error,'Invalid Username');
            apexpages.addmessage(msg);
            return null;
        }else if(password != actualPassword){
            apexpages.Message msg = new Apexpages.Message(ApexPages.severity.error,'Invalid Password');
            apexpages.addmessage(msg);
            return null;
        }else if((username == null || username == '') && password != null){
            apexpages.Message msg = new Apexpages.Message(ApexPages.severity.error,'Please enter Username');
            apexpages.addmessage(msg);
            return null;
        }else if(actualUsername != null && (password == null || password =='')){
            apexpages.Message msg = new Apexpages.Message(ApexPages.severity.error,'Please enter Password');
            apexpages.addmessage(msg);
            return null;
        }
        return null;       
        
        /*
        try{
        String startUrl = System.currentPageReference().getParameters().get('startUrl');
        //System.debug('@@@@@ StartUrl @@@@' +startUrl);
        return Site.login(username, password, startUrl);
        }catch(Exception e){
            System.debug('@@@@@ Exception @@@@' +e);
        return null;
        }*/
    }
}