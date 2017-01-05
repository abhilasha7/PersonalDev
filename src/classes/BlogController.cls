public with sharing class BlogController {
public Blog__c blog {get;set;}
public List<Blog__c> blogs {get;set;}
    public BlogController (){
       
    }
   public void saveBlog(){
       blog.Blog_Date__c = System.today();
       insert blog;
       loadBlogs();
       //system.debug('List of blogspppp'+ blogs.size());
    }
    
    public void LoadBlogs(){
        blog = new Blog__c();    

        blogs = [Select blogger_name__c,description__c, Blog_Date__c
                 from   Blog__c order by createdDate desc];
 }   
}