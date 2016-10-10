dmcountrypls = 0
dmbuildpls = 0

function getDMPlayers ( )
	triggerClientEvent ( source, "updatePlayersDMCountS", getRootElement(), dmcountrypls, dmbuildpls  )
end

addEvent( "getDMPlayersC", true )
addEventHandler( "getDMPlayersC", getRootElement(), getDMPlayers )

function setDMPlayers ( num, type )
	if source then
		takeAllWeapons ( source )
	end
	if num == 1 then
		if type == 1 then
			dmcountrypls = dmcountrypls+1
		elseif type == 2 then
		    dmcountrypls = dmcountrypls-1
		end
 	elseif num == 2 then
		if type == 1 then
			dmbuildpls = dmbuildpls+1
		elseif type == 2 then
		    dmbuildpls = dmbuildpls-1
		end
	end
end

addEvent( "setDMPlayersC", true )
addEventHandler( "setDMPlayersC", getRootElement(), setDMPlayers )

function playerLeavedDmZone()
	setElementInterior( source, 2, 2526.8134765625,-1315.6943359375,1031.421875 )
end

addEvent( "playerLeavedDmZoneC", true )
addEventHandler( "playerLeavedDmZoneC", getRootElement(), playerLeavedDmZone )

--function leaveFromDM ( )
--    setElementPosition
--end
--
--addEvent( "leaveFromDMC", true )
--addEventHandler( "leaveFromDMC", getRootElement(), leaveFromDM )

dmZonesSpawns = {
	{
		{ -1466.3994140625,-1482.5419921875,101.7578125 },
		{ -1439.91796875,-1446.85546875,101.921875 },
		{ -1364.72265625,-1473.861328125,102.43141174316 },
		{ -1315.5306396484,-1518.7410888672,103.42401885986 },
		{ -1357.638671875,-1570.3427734375,102.38388061523 },
		{ -1427.5869140625,-1597.9658203125,101.7578125 },
	},
	{	
		{ -2134.9541015625,220.2197265625,35.636680603027, },
		{ -2132.51953125,181.2275390625,41.636856079102, },
		{ -2045.8271484375,123.53125,28.898284912109, },
		{ -2059.2099609375,255.4248046875,36.958866119385, },
		{ -2084.9912109375,308.46484375,35.342315673828, },
	
	}

}

function respawnDMPlayer ()
	local dmzone = getElementData ( source, "dmzone" )
	if dmzone > 0 then
		local spawnnum = math.random (1,#dmZonesSpawns[dmzone])
		spawnPlayer ( source,dmZonesSpawns[dmzone][spawnnum][1],dmZonesSpawns[dmzone][spawnnum][2],dmZonesSpawns[dmzone][spawnnum][3], 0, getElementModel (source) )
		giveWeapon ( source, 29, 50 )
	end
end

addEvent( "respawnDMPlayerC", true )
addEventHandler( "respawnDMPlayerC", getRootElement(), respawnDMPlayer )

function toDMLobby ( source )
	if not isElementFrozen ( source ) then 
		setElementFrozen ( source, true )
		if(exports.sweetyRP:playerToPoint(source, 3, -572.5166015625,2022.857421875,60.3828125)) then
			setElementData ( source, "lobby", 1 )
			setElementPosition ( source,2526.8134765625,-1315.6943359375,1031.421875 )
			setElementInterior ( source, 2 )
		elseif (exports.sweetyRP:playerToPoint(source, 3, -168.669921875,2707.10546875,62.525890350342)) then
			setElementData ( source, "lobby", 2 )
			setElementInterior ( source, 2 )
			setElementPosition ( source,2526.8134765625,-1315.6943359375,1031.421875 )
		elseif(exports.sweetyRP:playerToPoint(source, 3, -253.77354431152,1495.8074951172,76.01212310791)) then
			setElementData ( source, "lobby", 3 )
			setElementPosition ( source,2526.8134765625,-1315.6943359375,1031.421875 )
			setElementInterior ( source, 2 )
		end
		setTimer ( function ( player ) setElementFrozen ( player, false ) end, 1500, 1, source )
	end
end

function toDMFromLobby ( source )
    triggerClientEvent ( source, "showDMZoneSelectS", getRootElement() )
end