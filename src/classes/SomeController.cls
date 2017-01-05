public class SomeController {
    public String q { get; set; }
    public list<Account> listAccount;

    public PageReference search() {
        string query= '%'+q+'%';            
        listAccount=new List<Account>([Select name from account where name like
         :query]);
        return null;       
    }
    
    public list<Account> getListAccount(){
        return listAccount;
    }



}