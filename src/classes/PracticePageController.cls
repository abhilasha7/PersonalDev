public class PracticePageController {

    //creating a string variable to get the current logged-in users info
    public String u {get; set;}
    
    public PageReference printUserInfo() {
        u = Userinfo.getFirstName();
        return null;
    }
    
    public PageReference removeUserInfo() {
        printUserInfo();
        u = '';
        return null;
    }
}