trigger HocSinhTrigger on HocSinh__c (before delete, before insert, before update, after delete, after insert, after update) {  
 
    if (Trigger.isBefore) {
        
        if (Trigger.isInsert) {

              HocSinhTriggerHandler.onBeforeInsert(Trigger.new);
        }    
     }
      
    if (Trigger.isAfter) {
       if (Trigger.isInsert) {
             HocSinhTriggerHandler.onAfterInsert(Trigger.new);
        } 
        if (Trigger.isUpdate) {
           HocSinhTriggerHandler.onAfterUpdate(Trigger.new, Trigger.old);
        }
        if (Trigger.isDelete) {
           HocSinhTriggerHandler.onAfterDelete(Trigger.old);
        }
     }  
    }