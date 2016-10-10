addEvent("onGUIPrivateMessage", true)
addEventHandler("onGUIPrivateMessage", getRootElement(), 
	function(toplayer, text)
		triggerClientEvent(toplayer, "onPrivateChatSent", source, source, text)
	end
)