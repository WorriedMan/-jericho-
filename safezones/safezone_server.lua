function buildSafeZones()
	for theKey, theZone in ipairs(safeZones) do
        colShape  = createColRectangle ( theZone.coords[1], theZone.coords[2], theZone.coords[3], theZone.coords[4] )
		setElementData ( colShape, "safezone.id", theKey )
        radarArea = createRadarArea (theZone.coords[1], theZone.coords[2], theZone.coords[3], theZone.coords[4], unpack(theZone.color))
		addEventHandler ( "onColShapeHit", colShape, safeZoneEnter )
		addEventHandler ( "onColShapeLeave", colShape, safeZoneExit )
	end
end
addEventHandler("onResourceStart", getResourceRootElement(), buildSafeZones)

newbieZone = createColPolygon ( -1160, 671, -1160, 671, -1200, 1618, -2012, 1683, -2012, 2819, -1003, 2819, -685, 1618, -685, 671 )
addEventHandler ( "onColShapeHit", newbieZone, function (hitElement) if getElementType( hitElement ) == "player" then setElementData ( hitElement, 'inNewbieZone', true ) end end )
addEventHandler ( "onColShapeLeave", newbieZone, function (hitElement)
	if getElementType(hitElement) == "player" then
		exports.pipboy:addInfoBox ( 'Вы выходите из зоны для новичков', 2, hitElement )
		setElementData ( hitElement, 'inNewbieZone', false )
	end
 end )

function checkIfPlayerInsideNewbieZone(player)
	return isElementWithinColShape ( player, newbieZone )
end
 
function setZoneSafe(colShape,config)
	local id = #safeZones
	safeZones[id+1] = config
	setElementData ( colShape, "safezone.id", id+1 )
	addEventHandler ( "onColShapeHit", colShape, safeZoneEnter )
	addEventHandler ( "onColShapeLeave", colShape, safeZoneExit )
end 
 
function safeZoneEnter ( hitElement, matchingDimension )
	local id = getElementData ( source, "safezone.id" )
	if id then
		if getElementType( hitElement ) == "player" then 
			setElementData (hitElement, "safezone.id", id) 
			if safeZones[id].noFight then
				exports.cweap_jericho:checkPlayerFireAllow(hitElement)
			end			
		elseif getElementType( hitElement) == "ped" then
			if safeZones[id].noZombie and getElementData(hitElement,"customped") and not getElementData ( hitElement, "arenaZ" ) then
				setElementData(hitElement,"customped:killedBySafezone",true,false)
				killPed ( hitElement )
			end
		end
	end
end

function safeZoneExit ( hitElement, matchingDimension )
	local id = getElementData ( source, "safezone.id" )
	if id and getElementType( hitElement ) == "player" then 
		setElementData (hitElement, "safezone.id", nil) 
		if id == 1 or id == 4 then
			setElementData ( hitElement, 'inNewbieZone', true )
		end
		if safeZones[id].noFight then
			exports.cweap_jericho:checkPlayerFireAllow(hitElement)
		end
	end
end