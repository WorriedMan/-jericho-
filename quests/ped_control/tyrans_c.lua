function playerChasedC (zomb, shape)
	if not getElementData ( zomb, "zTarget" ) then
		--outputChatBox ( 'Проверяю походку' )
		checkStillCrouching (zomb, shape)
	end
end

addEvent( "playerChased", true )
addEventHandler( "playerChased", getRootElement(), playerChasedC )