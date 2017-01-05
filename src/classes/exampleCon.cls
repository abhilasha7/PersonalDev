public class exampleCon {

    public PageReference methodOne() {
        return null;
    }


    public String getState() {
        return null;
    }


    public String state { get; set; }

    public String username { get; set; }

    public String getUsername() {
        return null;
    }


    public PageReference sayHello() {
        return null;
    }

    Integer count = 0;
                        
    public PageReference incrementCounter() {
        count++;
       // PageReference pr = new  PageReference ('http://www.google.com');
       // return pr;
     return null;

    }
                        
    public Integer getCount() {
        return count;
    }
}