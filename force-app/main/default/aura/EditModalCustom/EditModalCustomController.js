({
   closeModel: function(component, event, helper) {
      component.set("v.isModalOpen", false);
   },
  
   getModalRecordData: function(component, event, helper) {
      var params = event.getParam('arguments');
      component.set("v.recordId", params.Id);
      component.set("v.isModalOpen", true);
   },

   handleSuccess : function(component, event, helper) {
      component.set("v.isModalOpen", false);
      component.find('notifLib').showToast({
         "variant": "success",
         "title": "Student Update",
         "message": "Record ID: " + event.getParam("id")
     });
      helper.reloadList(component);
  },   
})