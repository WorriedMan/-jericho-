local database

local ownersID = {
	-- {608},
	-- {567},
	-- {126,567,1362,1746,1817,2188},
	-- {9489,2404,11231,2403,9850,9232},
	-- {6570, 6977, 9505,10705},
	-- {7870, 7248,5576,7767},
	-- {6584, 4421},
	-- {5424,6570,6977,10705},
	-- {802,4431},
	-- {12134,16656,21227,20607},
}
local gates = {
	--{ id = 2634, coords = { 155.69, 1776.199, 17.799, 0, 0, 84 }, move_to = { 155.69, 1776.199, 14.799}, ownerid = 1, gateType = 1, name = "gate 1", radius = 5},
	{ id = 2634, coords = { 155.69, 1776.199, 17.799, 0, 0, 84 }, move_to = { 155.69, 1776.199, 14.799}, ownerid = 21, gateType = 1, name = "gate 1", radius = 5},
	{ id = 976, coords = { -2132, -80.80, 34.29, 0, 0, 0 }, move_to = { -2123.5, -80.80, 34.29 }, ownerid = 1, gateType = 3, radius = 10},
	{ id = 980, coords = { 135.1000, 1768.0999, 19.3999, 0, 0, 81.75 }, move_to = { 135.1000, 1768.0999, 13.3999 }, ownerid = 1, gateType = 1, name = "gate 4", radius = 10},
	{ id = 988, coords = { 2344.7, -14.89, 25.3, 0, 0, 0 }, move_to = { 2344.7, -14.89, 19.3 }, ownerid = 1, gateType = 3, radius = 10},
	{ id = 985, coords = { 123.39, -152.39, 2.24, 0, 0, 90 }, move_to = { 123.39, -152.39, -6.24 }, ownerid = 5, gateType = 1, name = "gate 7", radius = 5},
	{ id = 987, coords = { 2635, 821, 9, 0, 0, 270 }, move_to = { 2635, 821, -1.9 }, ownerid = 8, gateType = 1, name = "gate 13", radius = 10},
	{ id = 987, coords = { 2635, 821, 4.2, 0, 0, 270 }, move_to = { 2635, 821, -6.7 }, ownerid = 8, gateType = 1, name = "gate 14", radius = 10},
	{ id = 10184, coords = { 2698.25, 791.8, 16, 0, 0, 180 }, move_to = { 2698.25, 791.8, 7.4 }, ownerid = 8, gateType = 1, name = "gate 15", radius = 7},
	{ id = 10184, coords = { 2698.25, 791.8, 12.35, 0, 0, 180 }, move_to = { 2698.25, 791.8, 3.75 }, ownerid = 8, gateType = 1, name = "gate 16", radius = 7},
	{ id = 10184, coords = { 2698.25, 798, 16, 0, 0, 180 }, move_to = { 2698.25, 798, 7.4 }, ownerid = 8, gateType = 1, name = "gate 17", radius = 7},
	{ id = 10184, coords = { 2698.25, 798, 12.35, 0, 0, 180 }, move_to = { 2698.25, 798, 3.75 }, ownerid = 8, gateType = 1, name = "gate 18", radius = 7},
	{ id = 10184, coords = { 2669.4, 806.4, 14, 90, 180, 270 }, move_to = { 2681.7, 806.4, 14 }, ownerid = 8, gateType = 1, name = "gate 19", radius = 10},
	{ id = 10184, coords = { 2664.4, 806.4, 14, 90, 180, 270 }, move_to = { 2676.7, 806.4, 14 }, ownerid = 8, gateType = 1, name = "gate 20", radius = 10},
	{ id = 10184, coords = { 2659.7, 806.4, 14, 90, 180, 270 }, move_to = { 2672.7, 806.4, 14 }, ownerid = 8, gateType = 1, name = "gate 21", radius = 10},
	{ id = 969, coords = { 2215, -1561, 1.2, 0, 0, 63.99 }, move_to = { 2212.3, -1568, 1.2 }, ownerid = 1, gateType = 3, radius = 10},
	{ id = 980, coords = { 1017.7, 2133.29, 12.6, 0, 0, 90 }, move_to = { 1017.7, 2133.29, 5 }, ownerid = 10, gateType = 1, name = "gate 40", radius = 10},
	{ id = 980, coords = { 1055.6, 2087.6, 12.6, 0, 0, 90 }, move_to = { 1055.6, 2087.6, 5 }, ownerid = 10, gateType = 1, name = "gate 41", radius = 10},
	{ id = 988, coords = { -141.0202, 2640.1567, 62.9231, 0, 0, 84 }, move_to = { -141.0202, 2640.1567, 58.2315 }, ownerid = "nwkey", gateType = 2, radius = 10},
	{ id = 988, coords = { -141.5864, 2634.7651, 62.9231, 0, 0, 84 }, move_to = { -141.5864, 2634.7651, 58.2315 }, ownerid = "nwkey", gateType = 2, radius = 10},
	{ id = 988, coords = { -141.3646, 2629.3696, 62.9231, 0, 0, 100 }, move_to = { -141.3646, 2629.3696, 58.2315 }, ownerid = "nwkey", gateType = 2, radius = 10},
	{ id = 988, coords = { -332.6213, 2702.9057, 61.6174, 0, 0, 276 }, move_to = { -332.6213, 2702.9057, 57.1741 }, ownerid = "nwkey", gateType = 2, radius = 10},
	{ id = 988, coords = { -332.6608, 2697.5327, 61.6174, 0, 0, 264 }, move_to = { -332.6608, 2697.5327, 57.1741 }, ownerid = "nwkey", gateType = 2, radius = 10},
	{ id = 988, coords = { -353.3368, 1398.4868, 58.0381, 0, 0, 0 }, move_to = { -353.3368, 1398.4868, 51.0381 }, ownerid = "sckey", gateType = 2, radius = 10},
	{ id = 988, coords = { -881.4545, 1948.0356, 59.3273, 0, 0, 14 }, move_to = { -881.4545, 1948.0356, 55.0308 }, gateType = 3, radius = 10},
	{ id = 988, coords = { -1506.2106, 2598.5710, 53.5870, 0, 0, 90.25 }, move_to = { -1506.2106, 2598.5710, 45.5870 }, gateType = 3, radius = 10},
	{ id = 988, coords = { -778.1604, 2744.3488, 43.2469, 0, 0, 0 }, move_to = { -778.1604, 2744.3488, 40 }, gateType = 3, radius = 10},
	--{ id = 988, coords = { -1991.5996, 732, 45.3, 0, 0, 270 }, move_to = { -1991.5996, 737.3, 45.2999 }, gateType = 3, radius = 5},
	--{ id = 976, coords = { -1952.5, 686.1992, 45.1800, 0, 0, 0 }, move_to = { -1949, 686.19925, 45.1800 }, gateType = 3, radius = 5},
}

function createGates ()
	database = dbConnect( "sqlite", "gates.db" )
	dbExec ( database, "CREATE TABLE IF NOT EXISTS `gatesAccess` (`gate` TEXT, `playerid` INTEGER)" )
	for i, gate in ipairs (gates) do
		local createdGate = createObject ( gate.id, unpack (gate.coords) )
		local createdColSphere = createColSphere ( gate.coords[1],gate.coords[2],gate.coords[3], gate.radius )
		gates[i].object = createdGate
		setElementData ( createdColSphere, "gateID", i, false )
		addEventHandler ( "onColShapeHit", createdColSphere, gatesOpen )
		addEventHandler ( "onColShapeLeave", createdColSphere, gatesClose )
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(), createGates )

function moveGate ( gate )
	if not getElementData ( gate, "moving" ) then
		local id = getElementData ( source, "gateID" )
		setElementData ( gate, "moving", true, false )
		stopObject ( gates[id].object )
		setTimer ( function () setElementData ( gate, "moving", false, false ) end, 5000, 1 )
		setTimer ( moveObject, 1000, 1, gates[id].object, 4000, unpack(gates[id].move_to) )
	end
end

function closeGate ( gate )
	if not getElementData ( gate, "closing" ) then
		local id = getElementData ( source, "gateID" )
		setElementData ( gate, "closing", true, false )
		stopObject ( gates[id].object )
		if getElementData ( gate, "moving" ) then
			setElementData ( gate, "moving", false, false )
			stopObject ( gates[id].object )
		end
		setTimer ( function () setElementData ( gate, "closing", false, false ) end, 5000, 1 )
		setTimer ( moveObject, 1000, 1, gates[id].object, 4000, gates[id].coords[1], gates[id].coords[2], gates[id].coords[3] )
	end
end

function gatesOpen ( thePlayer, matchingDimension )
    if getElementType ( thePlayer ) == "player" then
		local id = getElementData ( source, "gateID" )
		if id then
			if gates[id].gateType == 3 then
				moveGate ( source )
			elseif gates[id].gateType == 2 then
				if getElementData ( thePlayer, gates[id].ownerid ) == 1 then
					moveGate ( source )
				end
			elseif gates[id].gateType == 1 then
				local accName = getAccountName ( getPlayerAccount ( thePlayer ) )
				if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) )then
					moveGate ( false, false, false, source )
				else			
					local playerID = tonumber(getElementData(thePlayer,"playerid"))
					if playerID then
						if playerID == gates[id].ownerid then
							--moveGate ( source )
						else
							local qh = dbQuery( database, "SELECT * FROM `gatesAccess` WHERE `gate` = ? AND `playerid` = ?", gates[id].name, playerID )
							local list = dbPoll( qh, -1 )
							if list[1] then
								--moveGate ( source )
							end
						end
					end
				end
			end
        end
	end
end

function gatesClose ( thePlayer, matchingDimension )
    local gateLink = getElementData ( source, "gateLink" )
    if getElementType ( thePlayer ) == "player" then
		local id = getElementData ( source, "gateID" )
		if id then
			if gates[id].gateType == 3 then
				closeGate ( source )
			elseif gates[id].gateType == 2 then
				--local gateString = getElementData ( source, "gateOwn" )
				--if ( getElementData ( thePlayer, gateString ) or 0 ) == 1 then
					closeGate ( source )
				--end
			elseif gates[id].gateType == 1 then
				local accName = getAccountName ( getPlayerAccount ( thePlayer ) )
				if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) )then
					closeGate ( source )
				else			
					local playerID = tonumber(getElementData(thePlayer,"playerid"))
					if playerID then
						if playerID == gates[id].ownerid then
							closeGate ( source )
						else
							local qh = dbQuery( database, "SELECT * FROM `gatesAccess` WHERE `gate` = ? AND `playerid` = ?", gates[id].name, playerid )
							local list = dbPoll( qh, -1 )
							if list[1] then
								closeGate ( source )
							end
						end
					end
				end
			end
		end
	end
end

function addPlayer (gate,playerid)
	if gate and playerid then
		dbExec ( database, "INSERT INTO `gatesAccess` (`gate`, `playerid`) values(?,?)", gate, playerid )
	end
end

addEvent("gates:addPlayer",true)
addEventHandler("gates:addPlayer",getRootElement(),addPlayer)

function deletePlayer (gate,playerid)
	if gate and playerid then
		dbExec ( database, "DELETE FROM `gatesAccess` WHERE `gate`= ? AND `playerid` = ?", gate, playerid )
	end
end

addEvent("gates:deletePlayer",true)
addEventHandler("gates:deletePlayer",getRootElement(),deletePlayer)

function showPlayerPanel(player)
	local playerid = getElementData (player, "playerid")
	if playerid then
		local playerGates = {}
		for i, v in ipairs (gates) do
			if v.ownerid == playerid then
				playerGates[#playerGates+1] = v.name
			end
		end
		local sendTable = {}
		for i, v in ipairs ( playerGates ) do
			sendTable[v] = {}
			local qh = dbQuery( database, "SELECT `playerid` FROM `gatesAccess` WHERE `gate` = ?", v )
			local result = dbPoll( qh, -1 )
			for _, d in pairs (result) do
				table.insert(sendTable[v], d.playerid)
			end
		end
		triggerClientEvent ( player, "gates:showGatesWindow", player, sendTable )
	end
end

addCommandHandler ("shplpan", showPlayerPanel)