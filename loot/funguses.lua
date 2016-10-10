funguses = 1

fungusPlaces = {}
fungusesCount = { 0, 0, 0, 0 }

fungusSpawnPoints = { -- x1 x2 y1 y2 количество
	{ 491, 2767, 150, 517, 20 }, -- Кламат
	{ 154, 2825, -1975, 88, 80 }, -- Север ЛС
	{ -2824, -167, -2815, -868, 50 }, -- Чилиад
	{ -2828, -2215, 2234, 2633, 25 }, -- Бай Сайд
}

function placeFungusesAroundMap ()
	for i = 1,#fungusSpawnPoints do
		for d = 1, fungusSpawnPoints[i][5] do
			local x = math.random ( fungusSpawnPoints[i][1], fungusSpawnPoints[i][2] )
			local y = math.random ( fungusSpawnPoints[i][3], fungusSpawnPoints[i][4] )
			local far = createColCircle ( x, y, 50 )
			table.insert ( fungusPlaces, far )
			setElementData ( far, "fungusCreator", true )
			setElementData ( far, "place", i )
			setElementData ( far, "created", false )
			fungusesCount[i] = fungusesCount[i]+1

			funguses = funguses+1
		end
	end	
	outputDebugString ( "Fungus places total: "..funguses)
	setTimer ( respawnFunguses, 7200000, 0 )
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), placeFungusesAroundMap )

function spawnFungusS ( shape, x,y,z )
	if not getElementData ( shape, "created" ) then
		setElementData ( shape, "created", true )
		local fungus = createObject ( 2823, x, y, z+0.3, 0, 0, math.random (0,360) )
		local fungusSphere = createColSphere ( x, y, z+0.3, 1 )
		local lootSphereFar = createColSphere ( x, y, z+0.3, 30 )
		local lootSphereVeryFar = createColSphere ( x, y, z+0.3, 50 )
		setElementCollisionsEnabled ( fungus, false )
		setElementData ( fungus, "fungus", true )
		setElementData ( fungusSphere, "fungus", true )
		setElementData ( fungusSphere, "action", true )
		setElementData ( fungusSphere, "type", 7 )
		setElementData ( fungusSphere, "place", getElementData ( shape, "place" ) )
		
		setElementData ( shape, "fungusSphere", fungusSphere )
		setElementData ( shape, "fungusObject", fungus )
		setElementData ( fungusSphere, "shape", shape )
	end
end

addEvent( "spawnFungus", true )
addEventHandler( "spawnFungus", getRootElement(), spawnFungusS )

function respawnFunguses ()
	for i = 1, #fungusesCount do
		local difference = fungusSpawnPoints[i][5]-fungusesCount[i]
		if difference > 0 then
			for d = 1, difference do 
				local x = math.random ( fungusSpawnPoints[i][1], fungusSpawnPoints[i][2] )
				local y = math.random ( fungusSpawnPoints[i][3], fungusSpawnPoints[i][4] )
				local far = createColCircle ( x, y, 50 )
				table.insert ( fungusPlaces, far )
				setElementData ( far, "fungusCreator", true )
				setElementData ( far, "ident", funguses )
				setElementData ( far, "created", false )
				setElementData ( far, "place", i )
				fungusesCount[i] = fungusesCount[i]+1
				funguses = funguses+1
			end
		end
	end
end

function checkFungusPlace( theElement, matchingDimension )
    if ( getElementType ( theElement ) == 'player' ) and matchingDimension then
		if getElementData ( source, "fungusCreator" ) then
			local x, y, z = getElementPosition ( source )
			if not getElementData ( source, "created" ) then
				triggerClientEvent ( theElement, "getPositionFungus", theElement, x, y, source )
			end
		end
		if getElementData ( source, "fungus" ) and not getElementData ( source, "inuse" ) then
			bindKey ( theElement, "E", "down", checkFungusPlacePress, source )
		end
    end
end
addEventHandler("onColShapeHit",getRootElement(),checkFungusPlace)

function checkFungusPlaceLeave( theElement, matchingDimension )
    if ( getElementType ( theElement ) == 'player' ) then
		if getElementData ( source, "fungus" ) then
			unbindKey ( theElement, "E", "down", checkFungusPlacePress )
		elseif getElementData ( source, "fungusCreator" ) then
			if getElementData ( source, "created" ) then
				if #getElementsWithinColShape ( source, "player" ) == 0 then
					if isElement ( getElementData ( source, "fungusSphere" ) ) then destroyElement ( getElementData ( source, "fungusSphere" ) ) end
					if isElement ( getElementData ( source, "fungusObject" ) ) then destroyElement ( getElementData ( source, "fungusObject" ) ) end
					setElementData ( source, "created", false )
				end
			end
		end
    end
end
addEventHandler("onColShapeLeave",getRootElement(),checkFungusPlaceLeave)

function checkFungusPlacePress ( player, key, keyState, fungus )
	if getElementData ( player, "inventoryAllowed" ) == 1 then
		if isElement(fungus) then
			if not getElementData (fungus, "inuse" ) then
				setElementData ( fungus, "inuse", true )
				setElementData ( player, "collectingFungus", getElementData ( fungus, "shape" ) )
				setPedAnimation ( player, "BOMBER", "BOM_Plant", -1, false, true, true, false )
				setTimer ( triggerClientEvent, 1500, 1, player, "checkFungusAnimation", getRootElement(), fungus )
				unbindKey ( player, "E", "down", checkFungusPlacePress )
			end
		end
	end
end

function destroyFungus ( fungus )
	if isElement ( fungus ) then
		local shape = getElementData ( fungus, "shape" )
		local place = getElementData ( shape, "place" )
		unbindKey ( source, "E", "down", checkFungusPlacePress )
		setElementData ( source, "collectingFungus", false )
		if isElement ( getElementData ( shape, "fungusObject" ) ) then destroyElement ( getElementData ( shape, "fungusObject" ) ) end 
		destroyElement ( fungus )
		destroyElement ( shape )
		fungusesCount[place]=fungusesCount[place]-1
	end
end

addEvent( "destroyFungusC", true )
addEventHandler( "destroyFungusC", getRootElement(), destroyFungus )

function notComplFungus ( fungus )
	setElementData ( fungus, "inuse", false )
end

addEvent( "notComplFungusC", true )
addEventHandler( "notComplFungusC", getRootElement(), notComplFungus )