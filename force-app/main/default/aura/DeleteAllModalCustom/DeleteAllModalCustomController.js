({
    openModel: function(component, event, helper) {
       component.set("v.isModalOpen", true);
    },
   
    closeModel: function(component, event, helper) {
       component.set("v.isModalOpen", false);
    },
   
    deleteAllRecordData: function(component, event, helper) {
       component.set("v.isModalOpen", false);
       helper.deleteStudentAll(component);

    },
    
    confirmDeleteModal: function(component, event, helper) {
       var list = event.getParam('arguments');
       component.set("v.listId", list.listId);
       // hien thi modal 
       component.set("v.isModalOpen", true);
    },
 })