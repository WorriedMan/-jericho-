function sendActionMessageClient ( nomer )
	triggerServerEvent ( "sendActionMessageC", getLocalPlayer(), nomer)
end

function sendActionMessage ( text )
	triggerServerEvent ( "sendActionMessageTextC", getLocalPlayer(), text)
end

bindKey("u", "down", "chatbox", "Чат")


