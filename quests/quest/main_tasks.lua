localPlayer = getLocalPlayer ()

function start_Main_Q ()
	stuntPlane = createVehicle ( 513, 405.1025390625,2480.1337890625,16.484375,0,0,20.970489501953 )
	triggerServerEvent ( "putHimInStuntPlaneC", getLocalPlayer(), stuntPlane ) 
end

addCommandHandler ("tpto1", start_Main_Q)

addEventHandler("onClientVehicleExplode", getRootElement(), onPlaneDestroy)

function onPlaneDestroy ( source )
	if source == getPedOccupiedVehicle(localPlayer) then 
		outputChatBox("Задание провалено!")
	end
end


-- закрываем знакомство

-- закрываем Суареса

function finish()

end