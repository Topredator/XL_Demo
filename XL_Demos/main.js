require('UIAlertView')
defineClass("RootViewController : XL_BaseViewController<UIAlertViewDelegate>", {
	tableView_didSelectRowAtIndexPath : function(tableView, indexPath)
	{
		tableView.deselectRowAtIndexPath_animated(indexPath, YES);
		var alert = UIAlertView.alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("Alert", "JSPatch change me", self, "OK", null);
		alert.show()
	},
	alert_clickedButtonAtIndex : function(alertView, ButtonIndex)
	{
		console.log('click btn ' + alertView.buttonTitleAtIndex(idx).toJS())
	}
})