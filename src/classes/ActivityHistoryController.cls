public with sharing class ActivityHistoryController {
//public task ActHistory {get;set;}
//public void Delete_Record {get;set;}
id recordid;
List<Task> act_list;
public string delRec{get; set;}

   public ActivityHistoryController(ApexPages.StandardController controller) {
        recordid = ApexPages.currentPage().getParameters().get('id');
    }
      
       public List<Task> getActHistory1(){
           act_list=new List<Task>([select subject, whoid, activitydate, ownerid, LastModifiedById from task where status='Completed' and whatId =:recordid]);
           system.debug('-----act_list---'+act_list);
       return act_list;
       }
       
           public pagereference getDelete_Record(){

            system.debug('---------1--------');
              for(Task t : act_list){
               system.debug('-----------2------'+ t.Id);
                             system.debug('----------3-------'+ delRec);
              if (t.Id== delRec) {

              delete t;
             
               system.debug('-------4----------');
             break; 
                      }
                }
return null;
            }
            
}