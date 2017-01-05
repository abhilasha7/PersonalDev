public class CallMemberService1{

    public void createMember(){
    
        soapSforceComSchemasClassMemberserv.MemberService member = new  
            soapSforceComSchemasClassMemberserv.MemberService();
         member.createMember('Abhilasha',98765423);  
    }

}