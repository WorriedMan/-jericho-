playersPedsStage9={}
vehiclesStage8={}

function isQuestWindowNotVisibleS (player)
	triggerClientEvent ( player, "checkQuestWindowVisible", getRootElement() )
end

function mainQuest_stage_9 ()
	local sourcePlayerID = getElementData ( source, "playerid" )
	local soldPed1 = createPed ( 159, -270.9033203125,2583.2353515625,63.5703125,285.97573852539, false )
	local soldPed2 = createPed ( 133, -247.3828125,2578.9765625,63.57031250,55.028594970703, false )
	local soldPed3 = createPed ( 34, -285.1640625,2585.5634765625,63.5703125,285.32754516602, false )
	local soldPed4 = createPed ( 158, -282.818359375,2592.3935546875,63.5703125,0.84323120117188, false )
	local soldPed5 = createPed ( 132, -250.1513671875,2592.48046875,63.5703125,6.4133911132813, false )
	local driverPed = createPed ( 133, -270.9033203125,2583.2353515625,63.5703125,285.97573852539, false )
	local vehiclePed = createVehicle ( 541, -256.66796875,2589.0166015625,63.195362091064,0,0,88.867004394531, "VEGAS" )
	playersPedsStage9[sourcePlayerID] = {
		soldPed1,
		soldPed2, 
		soldPed3,
		soldPed4,
		soldPed5, 
		driverPed,
		vehiclePed
	}
	setElementDimension ( playersPedsStage9[sourcePlayerID][1], sourcePlayerID ) 
	giveWeapon ( playersPedsStage9[sourcePlayerID][1], 31, 30, true )
	setElementDimension ( playersPedsStage9[sourcePlayerID][2], sourcePlayerID )
	setElementDimension ( playersPedsStage9[sourcePlayerID][3], sourcePlayerID )
	setElementDimension ( playersPedsStage9[sourcePlayerID][4], sourcePlayerID )
	setElementDimension ( playersPedsStage9[sourcePlayerID][5], sourcePlayerID )
	giveWeapon ( playersPedsStage9[sourcePlayerID][2], 31, 30, true )
	giveWeapon ( playersPedsStage9[sourcePlayerID][3], 31, 30, true )
	giveWeapon ( playersPedsStage9[sourcePlayerID][4], 31, 30, true )
	giveWeapon ( playersPedsStage9[sourcePlayerID][5], 31, 30, true )
	setElementDimension ( playersPedsStage9[sourcePlayerID][6], sourcePlayerID )
	setElementDimension ( playersPedsStage9[sourcePlayerID][7], sourcePlayerID )
	setVehicleColor ( playersPedsStage9[sourcePlayerID][7], 0, 1, 0, 0 )
	setVehicleEngineState ( playersPedsStage9[sourcePlayerID][7], true )
	setVehicleLightState ( playersPedsStage9[sourcePlayerID][7], 3, 0 )
	setVehicleLocked ( playersPedsStage9[sourcePlayerID][7], true )
	warpPedIntoVehicle ( playersPedsStage9[sourcePlayerID][6], playersPedsStage9[sourcePlayerID][7] )
	callClientFunction( source, "setPedControlState", playersPedsStage9[sourcePlayerID][1], "aim_weapon", true )
	callClientFunction( source, "setPedAimTarget", playersPedsStage9[sourcePlayerID][1], -266.3896484375,2586.1650390625,63.5703125 )
end

addEvent( "mainQuest_stage_9c", true )
addEventHandler( "mainQuest_stage_9c", getRootElement(), mainQuest_stage_9 )

function mainQuest_finish_stage_9 ()
	local sourcePlayerID = getElementData ( source, "playerid" )
	destroyElement ( playersPedsStage9[sourcePlayerID][1] )
	destroyElement ( playersPedsStage9[sourcePlayerID][2] )
	destroyElement ( playersPedsStage9[sourcePlayerID][3] )
	destroyElement ( playersPedsStage9[sourcePlayerID][4] )
	destroyElement ( playersPedsStage9[sourcePlayerID][5] )
	destroyElement ( playersPedsStage9[sourcePlayerID][6] )
	destroyElement ( playersPedsStage9[sourcePlayerID][7] )
	playersPedsStage9[sourcePlayerID][1] = nil 
	playersPedsStage9[sourcePlayerID][2] = nil 
	playersPedsStage9[sourcePlayerID][3] = nil 
	playersPedsStage9[sourcePlayerID][4] = nil 
	playersPedsStage9[sourcePlayerID][5] = nil 
	playersPedsStage9[sourcePlayerID][6] = nil 
	playersPedsStage9[sourcePlayerID][7] = nil 
end

addEvent( "mainQuest_finish_stage_9c", true )
addEventHandler( "mainQuest_finish_stage_9c", getRootElement(), mainQuest_finish_stage_9 )

function callServerFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onClientCallsServerFunction", true)
addEventHandler("onClientCallsServerFunction", resourceRoot , callServerFunction)

function callClientFunction(client, funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    -- If the clientside event handler is not in the same resource, replace 'resourceRoot' with the appropriate element
    triggerClientEvent(client, "onServerCallsClientFunction", resourceRoot, funcname, unpack(arg or {}))
end

function exportWeaponTrade ( num )
	exports["mabako-services"]:showWeaponTrade(source, num) 
end
addEvent( "exportWeaponTradeC", true )
addEventHandler( "exportWeaponTradeC", getRootElement(), exportWeaponTrade )

function questLoadAllTasksS ( source )
	callClientFunction ( source, "loadAllTasks" )
end

function createStage8step1vehicle ()
	local createdVehicle = createVehicle ( 456, 1021.8505859375,2362.2919921875,9.9389963150024,0,0,233.7142791748, "LOL" )
	setElementData ( createdVehicle, "task8", getElementData ( source, "playerid" ) )
	warpPedIntoVehicle ( source, createdVehicle )
	table.insert ( vehiclesStage8, createdVehicle )
end

addEvent( "createStage8step1vehiclec", true )
addEventHandler( "createStage8step1vehiclec", getRootElement(), createStage8step1vehicle )

function destroyStage8step1vehicle ()
	for i, veh in ipairs(vehiclesStage8) do
		if isElement ( veh ) then
			if getElementData ( veh, "task8" ) == getElementData ( source, "playerid" ) then
				destroyElement ( veh )
			end
		end
	end
end

addEvent( "destroyStage8step1vehiclec", true )
addEventHandler( "destroyStage8step1vehiclec", getRootElement(), destroyStage8step1vehicle )

function createStage8step2vehicle ()
	local createdVehicle = createVehicle ( 464, 1541.01171875,779.2861328125,10.8203125, "LOL" )
	setElementData ( createdVehicle, "task8", getElementData ( source, "playerid" ) )
	warpPedIntoVehicle ( source, createdVehicle )
	table.insert ( vehiclesStage8, createdVehicle )
end

addEvent( "createStage8step2vehiclec", true )
addEventHandler( "createStage8step2vehiclec", getRootElement(), createStage8step2vehicle )

function destroyStage8step2vehicle ()
	for i, veh in ipairs(vehiclesStage8) do
		if getElementData ( veh, "task8" ) == getElementData ( source, "playerid" ) then
			destroyElement ( veh )
		end
	end
end

addEvent( "destroyStage8step2vehiclec", true )
addEventHandler( "destroyStage8step2vehiclec", getRootElement(), destroyStage8step2vehicle )

function checkQuestsQuitPlayers ( quitType )
	if getElementData ( source, "onmission" ) then
		if getElementData ( source, "mission" ) == 1 or getElementData ( source, "mission" ) == 2 then
			for i, veh in ipairs(vehiclesStage8) do
				if isElement ( veh ) then
					if getElementData ( veh, "task8" ) == getElementData ( source, "playerid" ) then
						destroyElement ( veh )
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), checkQuestsQuitPlayers )

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		if getElementData ( source, "onmission" ) then
			if getElementData ( source, "mission" ) == 1 or getElementData ( source, "mission" ) == 2 then
				triggerClientEvent ( source, "destroyFromSever", source )
				outputChatBox ("Задание провалено, возвращайтесь к Катерине Минет.", source, 255, 255 )
				setElementData ( source, "onmission", false )
				setElementData ( source, "mission", 0 )
				for i, veh in ipairs(vehiclesStage8) do
					if getElementData ( veh, "task8" ) == getElementData ( source, "playerid" ) then
						destroyElement ( veh )
					end
				end
			end
		end
	end
)

addEventHandler ( "onVehicleExplode", getRootElement(),
	function ()
		if getElementData ( source, "task8" ) then
			local players = getElementsByType ( "player" )
			for theKey,thePlayer in ipairs(players) do 
				if getElementData ( thePlayer, "onmission" ) then
					if getElementData ( thePlayer, "mission" ) == 1 then
						triggerClientEvent ( thePlayer, "destroyFromSever", thePlayer )
						outputChatBox ("Машина уничтожена, возвращайтесь к Катерине Минет.", thePlayer, 255, 255, 255 )
						setElementData ( thePlayer, "onmission", false )
						setElementData ( thePlayer, "mission", 0 )
					elseif getElementData ( thePlayer, "mission" ) == 2 then
						outputChatBox ("Машина уничтожена, возвращайтесь к Катерине Минет.", thePlayer, 255, 255, 255 )
						triggerClientEvent ( thePlayer, "destroyFromSever", thePlayer )
						setElementData ( thePlayer, "onmission", false )
						setElementData ( thePlayer, "mission", 0 )
					end
				end
			end
		end
	end
)

addEvent("onZombieWasted",true)
playersObjInsane = {}

function insanePlayerCreate ( source )
	local sourcePlayerID = getElementData ( source, "playerid" )
	local veh1 = createVehicle ( 529, 415.39999389648, 2447.3999023438,16.200000762939,0,0,50 )
	local veh2 = createVehicle ( 426, 408.20001220703,2444.8999023438,16.299999237061 )
	local obj1 = createObject ( 1379, 391.39999389648, 2466.3000488281, 18.5, 90, 180, 178 )
	local obj2 = createObject ( 3257, 399.39999389648, 2446.3999023438, 15.5)
	
	local killer1 = exports.peds:createCustomPed({model = 133, weapon = "Штурмовая винтовка", health = 250, pos=Vector3(414.7412109375,2443.771484375,16.5), accuracy = math.random ( 0.6, 0.9 ), dim = sourcePlayerID})
	local killer2 = exports.peds:createCustomPed({model = 110, weapon = "9-мм пистолет", health = 150, pos=Vector3(407.203125,2441.6474609375,16.5), accuracy = math.random ( 0.6, 0.9 ), dim = sourcePlayerID})
	local killer3 = exports.peds:createCustomPed({model = 109, weapon = "9-мм пистолет", health = 150, pos=Vector3(395.34628295898,2457.3010253906,17.9909324646), accuracy = math.random ( 0.6, 0.9 ), dim = sourcePlayerID})
	setElementData ( killer1, "pID", sourcePlayerID )
	setElementData ( killer2, "pID", sourcePlayerID )
	setElementData ( killer3, "pID", sourcePlayerID )
	
	setElementData ( source, "killedInsane", 0 )
	playersObjInsane[sourcePlayerID] = {
		veh1,
		veh2, 
		obj1,
		obj2,
		killer1,
		killer2,
		killer3,
	}
	setElementDimension ( veh1, sourcePlayerID ) 
	setElementDimension ( veh2, sourcePlayerID )
	setElementDimension ( obj1, sourcePlayerID )
	setElementDimension ( obj2, sourcePlayerID )
	setElementDimension ( killer1, sourcePlayerID )
	setElementDimension ( killer2, sourcePlayerID )
	setElementDimension ( killer3, sourcePlayerID )
	exports.npc_hlc:addNPCTask(killer1, {"killPed", source, 7, 7} )
	exports.npc_hlc:addNPCTask(killer2, {"killPed", source, 7, 7} )
	exports.npc_hlc:addNPCTask(killer3, {"killPed", source, 7, 7} )
	addEventHandler ( "onPlayerWasted", source, insanePlayerDied )
	addEventHandler ( "onPedWasted", killer1, insaneBotDied )
	addEventHandler ( "onPedWasted", killer2, insaneBotDied )
	addEventHandler ( "onPedWasted", killer3, insaneBotDied )
end

--addEvent( "insanePlayerCreateC", true )
--addEventHandler( "insanePlayerCreateC", getRootElement(), insanePlayerCreate )


function insanePlayerDied ( ammo, attacker, weapon, bodypart )
	destroyInsaneObjects ( source )
end

function insaneBotDied ( ammo, attacker )
	local botID = getElementData ( source, "pID" )
	local players = getElementsByType ( "player" )
	for theKey,thePlayer in ipairs(players) do
	   if (getElementData ( thePlayer, "playerid" ) == botID ) then
			setElementData ( thePlayer, "killedInsane", getElementData ( thePlayer, "killedInsane" )+1 ) 
			if getElementData ( thePlayer, "killedInsane" ) == 3 then
				exports.pipboy:addInfoBox ( "Банда Великих Ханов убита, возвращаемся к Чудаку", 3, thePlayer )
				callClientFunction( thePlayer, "updateCompassAdditMarker", 2, 3 )
				setElementData ( thePlayer, "quest_nvinsane", 3 )
				fadeCamera ( thePlayer, false )
				setTimer ( function ()
								destroyInsaneObjects ( thePlayer )
								setElementDimension ( thePlayer, 0 )
								setElementPosition ( thePlayer, 419.1611328125,2477.0849609375,16.492168426514 )
								fadeCamera ( thePlayer, true )
							end, 1000, 1 )
			end
			return true
	   end
	end
end

function destroyInsaneObjects ( player )
	--if source then player = source end
	local sourcePlayerID = getElementData ( player, "playerid" )
	removeEventHandler ( "onPlayerWasted", player, insanePlayerDied )
	destroyElement ( playersObjInsane[sourcePlayerID][1] )
	destroyElement ( playersObjInsane[sourcePlayerID][2] )
	destroyElement ( playersObjInsane[sourcePlayerID][3] )
	destroyElement ( playersObjInsane[sourcePlayerID][4] )
	if isElement ( playersObjInsane[sourcePlayerID][5] ) then
		destroyElement ( playersObjInsane[sourcePlayerID][5] )
	end
	if isElement ( playersObjInsane[sourcePlayerID][6] ) then
		destroyElement ( playersObjInsane[sourcePlayerID][6] )
	end
	if isElement ( playersObjInsane[sourcePlayerID][7] ) then
		destroyElement ( playersObjInsane[sourcePlayerID][7] )
	end
	playersObjInsane[sourcePlayerID][1] = nil 
	playersObjInsane[sourcePlayerID][2] = nil 
	playersObjInsane[sourcePlayerID][3] = nil 
	playersObjInsane[sourcePlayerID][4] = nil 
	playersObjInsane[sourcePlayerID][5] = nil 
	playersObjInsane[sourcePlayerID][6] = nil 
	playersObjInsane[sourcePlayerID][7] = nil 
--	playersObjInsane[sourcePlayerID][8] = nil 
--	playersObjInsane[sourcePlayerID][9] = nil 
end

playersObjClam = {}

function clamPlayerCreate ( source )
	local sourcePlayerID = getElementData ( source, "playerid" )
		local killer1 = exports.peds:createCustomPed({model = 133, weapon = "Супердубина", health = 10, pos=Vector3(371.658203125,-6.5341796875,1001.8588867188), dim = sourcePlayerID, int = 9})
		local killer2 = exports.peds:createCustomPed({model = 110, weapon = "Китайский автомат", health = 250, pos=Vector3(369.5263671875,-4.005859375,1001.8588867188), dim = sourcePlayerID, int = 9})
		exports.npc_hlc:addNPCTask(killer1, {"killPed", source, 7, 7} )
		exports.npc_hlc:addNPCTask(killer2, {"killPed", source, 7, 7} )
		setElementData ( killer1, "pID", sourcePlayerID )
		setElementData ( killer2, "pID", sourcePlayerID )
		setElementData ( source, "killedClam", 0 )
		playersObjClam[sourcePlayerID] = {
			killer1,
			killer2,
		}
		addEventHandler ( "onPlayerWasted", source, calmPlayerDied )
		addEventHandler ( "onPedWasted", killer1, calmBotDied )
		addEventHandler ( "onPedWasted", killer2, calmBotDied )
		--callClientFunction( source, "setPedAimTarget", playersPedsStage9[sourcePlayerID][1], -266.3896484375,2586.1650390625,63.5703125 )
end

--addEvent( "insanePlayerCreateC", true )
--addEventHandler( "insanePlayerCreateC", getRootElement(), insanePlayerCreate )


function calmPlayerDied ( ammo, attacker, weapon, bodypart )
	destroyCalmObjects ( source )
end

function calmBotDied ( weapon, attacker )
	local botID = getElementData ( source, "pID" )
	local players = getElementsByType ( "player" )
	for theKey,thePlayer in ipairs(players) do
	   if (getElementData ( thePlayer, "playerid" ) == botID ) then
			setElementData ( thePlayer, "killedClam", getElementData ( thePlayer, "killedClam" )+1 ) 
			if getElementData ( thePlayer, "killedClam" ) == 2 then
				exports.pipboy:addInfoBox ( "Бандиты убиты, возвращамся к Бобу.", 3, thePlayer )
				callClientFunction( thePlayer, "updateCompassAdditMarker", 7, 3 )
				callClientFunction( thePlayer, "leaveClamTaskBell" )
				setElementData ( thePlayer, "quest_prob", 3 )
			end
			return true
	   end
	end
end

function destroyCalmObjects ( player )
	--if source then player = source end
	local sourcePlayerID = getElementData ( player, "playerid" )
	removeEventHandler ( "onPlayerWasted", player, insanePlayerDied )
	destroyElement ( playersObjClam[sourcePlayerID][1] )
	destroyElement ( playersObjClam[sourcePlayerID][2] )
	playersObjClam[sourcePlayerID][1] = nil 
	playersObjClam[sourcePlayerID][2] = nil 
end