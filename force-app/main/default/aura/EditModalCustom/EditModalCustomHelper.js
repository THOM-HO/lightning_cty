({
	reloadList : function(component) {
		var reloadEvt = component.getEvent("reload_evt");
		reloadEvt.fire();
		$A.enqueueAction(reloadEvt);
	}
})