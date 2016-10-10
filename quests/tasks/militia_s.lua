milEhlShape = createColRectangle ( -1524, 2596, 15, 14)


nc_peds = {
	{ "рабочего, для возведения новых укреплений", 260, "он" },
	{ "одного пенсионера, ", 49, "он" },
	{ "механика, для починки механизма ворот", 50, "он" },
}

function createMilitiaPed  ( player )
	local ped_type = getElementData ( player, "ncTarg" )
	local createdPed = createPed ( nc_peds[ped_type][2], -760.67, 2051.20, 60.18 )
	exports.npc_hlc:enableHLCForNPC ( createdPed, "run" )
	exports.npc_hlc:addNPCTask(createdPed, {"walkFollowElement", player, 3} )
	local pedShape = createColSphere ( -760.67, 2051.20, 60.18, 60 )
	attachElements ( pedShape, createdPed )
	setElementData ( pedShape, "militiaPed", true )
	setElementData ( pedShape, "pedLink", createdPed )
	setElementData ( player, "pedLink", createdPed )
	setElementData ( pedShape, "playerLink", player )
	setElementData ( createdPed, "shapeLink", pedShape )
	setElementData ( createdPed, "playerLink", player )
	setElementData ( createdPed, "militiaPed", true )
	setElementData ( createdPed, "npc_ped", true )
	addEventHandler ( "onColShapeLeave", pedShape, militiaPedShapeLeaved )
	addEventHandler ( "onPlayerVehicleEnter", player, putMilitiaPedInVehicle )
	addEventHandler ( "onPlayerVehicleExit", player, remMilitiaPedInVehicle )
	addEventHandler ( "onPlayerWasted", player, milPlayerWasted )
	addEventHandler( "onElementColShapeHit", createdPed, militiaPedHitColShape ) 
end

function militiaPedHitColShape (theColShape, matchingDimension)
	if theColShape == milEhlShape then
		if isPedInVehicle ( source ) then
			removePedFromVehicle ( source )
			exports.npc_hlc:enableHLCForNPC ( source, "run" )
		end
		exports.npc_hlc:addNPCTask(source, {"walkToPos", -1529.1064453125,2610.64453125,55.8359375, 1} )
		local playerLink = getElementData ( source, "playerLink" ) 
		setElementData ( playerLink, "ncType", 4 )
		if isElement ( playerLink ) then
			exports.pipboy:addInfoBox ( "Задание выполнено, возвращайтесь к ДеВитту", 3, playerLink )
			setTimer ( destroyMilitiaPed, 5000, 1, playerLink )
		else
			local shape = getElementData ( source, "shapeLink" )
			destroyElement ( source )
			if isElement ( shape ) then destroyElement ( shape ) end
		end
	end
end

function destroyMilitiaPed  ( player )
	local ped = getElementData ( player, "pedLink" )
	if isElement ( ped ) then
		removeEventHandler ( "onPlayerVehicleEnter", player, putMilitiaPedInVehicle )
		removeEventHandler ( "onPlayerVehicleExit", player, remMilitiaPedInVehicle )
		removeEventHandler ( "onPlayerWasted", player, milPlayerWasted )
		local shape = getElementData ( ped, "shapeLink" )
		destroyElement ( ped )
		if isElement ( shape ) then destroyElement ( shape ) end
	end
end

function putMilitiaPedInVehicle ( theVehicle, seat, jacked )
	local ped = getElementData ( source, "pedLink" )
	if isElement ( ped ) then
		local seatV = 1
		for seat, occupant in pairs(getVehicleOccupants(theVehicle)) do
			if not getElementType(occupant)=="player" and not getElementType(occupant)=="ped" then 
				seatV = seat
				break
			end
		end
		exports.npc_hlc:disableHLCForNPC ( ped, "run" )
		warpPedIntoVehicle ( ped, theVehicle, seatV )
	else
		removeEventHandler ( "onPlayerVehicleEnter", source, putMilitiaPedInVehicle )
		removeEventHandler ( "onPlayerVehicleExit", source, remMilitiaPedInVehicle )
		removeEventHandler ( "onPlayerWasted", source, milPlayerWasted )
	end
end

function remMilitiaPedInVehicle ( theVehicle )
	local ped = getElementData ( source, "pedLink" )
	if isElement ( ped ) then
		if isPedInVehicle ( ped ) then
		--	local syncer = getElementSyncer ( ped )
		--	if syncer then
				removePedFromVehicle ( ped )
				exports.npc_hlc:enableHLCForNPC ( ped, "run" )
				exports.npc_hlc:addNPCTask(ped, {"walkFollowElement", source, 3} )
				--triggerClientEvent ( "removeMilPedFromVehS", ped )
		--	end
		end
	end
end

function milPlayerWasted ( ammo, attacker, weapon, bodypart )
	local ped = getElementData ( source, "pedLink" )
	if isElement ( ped ) then
		removeEventHandler ( "onPlayerVehicleEnter", source, putMilitiaPedInVehicle )
		removeEventHandler ( "onPlayerVehicleExit", source, remMilitiaPedInVehicle )
		removeEventHandler ( "onPlayerWasted", source, milPlayerWasted )
		local shape = getElementData ( ped, "shapeLink" )
		destroyElement ( ped )
		if isElement ( shape ) then destroyElement ( shape ) end
		exports.pipboy:addInfoBox ( "Житель вернулся в Новую Деревню", 3, source )
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), milPlayerWasted )

function milPlayerQuited ( quitType )
	local ped = getElementData ( source, "pedLink" )
	if isElement ( ped ) then
		removeEventHandler ( "onPlayerVehicleEnter", source, putMilitiaPedInVehicle )
		removeEventHandler ( "onPlayerVehicleExit", source, remMilitiaPedInVehicle )
		removeEventHandler ( "onPlayerWasted", source, milPlayerWasted )
		local shape = getElementData ( ped, "shapeLink" )
		destroyElement ( ped )
		if isElement ( shape ) then destroyElement ( shape ) end
	end
end

addEventHandler ( "onPlayerQuit", getRootElement(), milPlayerQuited )


function militiaPedShapeLeaved ( player )
	if getElementType ( player ) == "player" then
		if player == getElementData ( source, "playerLink" ) then
			exports.pipboy:addInfoBox ( "Житель отстал от вас и вернулся в Новую Деревню", 3, player )
			if isElement ( getElementData ( source, "pedLink" ) ) then
				destroyElement ( getElementData ( source, "pedLink" ) )
				destroyElement ( source )
				removeEventHandler ( "onPlayerVehicleEnter", player, putMilitiaPedInVehicle )
				removeEventHandler ( "onPlayerVehicleExit", player, remMilitiaPedInVehicle )
				removeEventHandler ( "onPlayerWasted", player, milPlayerWasted )
			end
		end
	end
end
