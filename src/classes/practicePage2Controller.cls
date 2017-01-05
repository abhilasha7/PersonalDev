public class practicePage2Controller {
    public Account MyAccounts{get; set;}
    public List<Account> myAccountList{get; set;}
    public List<Account> accountList;
    public Set<Account> accountSet;

    public Account getMyAccounts(){
        return myAccounts;
    }
    
    public List<SelectOption> getMyAccountList(){
        List<SelectOption> myAccountList = new List<SelectOption>();
        myAccountList.add(new SelectOption('-None-', '-None-'));
      
        accountList= [select Name, Id from Account limit 10];
        for(Account s : accountList){
            accountSet.add(s);
            myAccountList.add(new SelectOption('accountSet', 'accountSet'));
        }
        
        
        
        return MyAccountList;
    }

}