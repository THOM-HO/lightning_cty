({
    closeModel: function(component, event, helper) {
       component.set("v.isModalOpen", false);
    },

    getModalRecordData: function(component, event, helper) {
       component.set("v.isModalOpen", true);
    },

    handleSuccess : function(component, event, helper) {
      component.set("v.isModalOpen", false);
      component.find('notifLib').showToast({
         "variant": "success",
         "title": "Student Created",
         "message": "Record ID: " + event.getParam("id")
     });
     $A.get('e.force:refreshView').fire();
  }
     
 })