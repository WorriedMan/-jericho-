lootsCreated = 1
lootCanGetLoot = 0

lootPlaces = {}
lootBoxes = {}
lootCircles = {}


nonStackableItems = {
	[24] = true,
	[26] = true,
	[27] = true,
	[28] = true,
	[29] = true,
	[30] = true,
	[31] = true,
	[32] = true,
	[33] = true,
	[34] = true,
	[35] = true,
	[36] = true,
	[37] = true,
	[38] = true,
	[39] = true,
	[40] = true,
	[41] = true,
	[74] = true,
	[75] = true,
	[76] = true,
	[77] = true,
	[78] = true,
	[79] = true,
	[80] = true,
	[81] = true,
	[82] = true,
	[83] = true,
	[84] = true,
	[85] = true,
	[86] = true,
	[87] = true,
	[88] = true,
	[93] = true,
	[94] = true,
	[113] = true,
	[114] = true,
	[115] = true,
	[116] = true,
	[117] = true,
	[118] = true,
	[119] = true,
	[120] = true,
	
}

lootSpawnPoints = { -- x1 x2 y1 y2 количество уровень
	{ 862, 2786, 691, 2875, 100, 30 }, -- ЛВ
	{ -2909, -1656, -846, 1427, 120, 35 }, -- СФ
	{ -462, 745, 593, 2777, 20, 20 }, -- Пустыня
	{ 491, 2767, 150, 517, 10, 30 }, -- Кламат
	{ 154, 2825, -1975, 88, 300, 999 }, -- Север ЛС
	{ 986, 2823, -2691, -1882, 40, 999 }, -- Юг ЛС
	{ -2824, -167, -2815, -868, 25, 999 }, -- Чилиад
	{ -1770, -42, -791, -205, 15, 40 }, -- Аэро СФ
	{ -2828, -2215, 2234, 2633, 30, 999 }, -- Бай Сайд
	{ -2012, -1235, 2204, 2819, 5, 6 }, -- Эль Кебрадос
	{ -871, -460, 2300, 2880, 5, 6 }, -- NDES
	{ -1767, -1003, 1683, 2217, 15, 6 }, -- SEHL (дамба)
	{ -1022, -685, 671, 1618, 9, 9 }, -- EDES (юг SEHL)
}

debug_server = false

function placeLootsAroundMap ()
	local loots = getElementsByType ( "loot" )
	for i = 1,#lootSpawnPoints do
		for d = 1, lootSpawnPoints[i][5] do
			local x = math.random ( lootSpawnPoints[i][1], lootSpawnPoints[i][2] )
			local y = math.random ( lootSpawnPoints[i][3], lootSpawnPoints[i][4] )
			local far = createColCircle ( x, y, 100 )
			table.insert ( lootCircles, far )
			setElementData ( far, "useLevel", lootSpawnPoints[i][6] )
			setElementData ( far, "lootCreator", true )
			setElementData ( far, "ident", lootsCreated )
			setElementData ( far, "level", 1 )
			setElementData ( far, "created", false )
			table.insert ( lootPlaces, { false, far, 0 } )
			putRandItemsInLoot ( far, lootsCreated )
			lootsCreated = lootsCreated+1
		end
	end	
	lootCanGetLoot = 1
	outputDebugString ( "Loot places total: "..lootsCreated)
	setTimer ( spawnLootItems, 1600000, 0 )
--	setTimer ( spawnLootItems, 1000, 0 )
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), placeLootsAroundMap )

function spawnLootS ( shape, x,y,z )
	if not getElementData ( shape, "created" ) then
		setElementData ( shape, "created", true )
		local loot = createObject ( 1271, x, y, z+0.3  )
		setElementFrozen(loot,true)
		local lootSphere = createColSphere ( x, y, z+0.3, 1 )
		local lootSphereFar = createColSphere ( x, y, z+0.3 , 30 )
		local lootSphereVeryFar = createColSphere ( x, y, z+0.3, 60 )
		setElementData ( loot, "useLevel", getElementData ( shape, "useLevel" ) )
		setElementData ( loot, "loot", true )
		attachElements ( lootSphere, loot )
		attachElements ( lootSphereFar, loot )
		attachElements ( lootSphereVeryFar, loot )
		--table.insert ( lootPlaces, { loot, lootSphere, 0 } )
		setElementData ( lootSphere, "useLevel", getElementData ( shape, "useLevel" ) )
		setElementData ( lootSphere, "level", getElementData ( shape, "level" ) )
		setElementData ( lootSphere, "loot", true )
		setElementData ( lootSphere, "action", true )
		setElementData ( lootSphere, "type", 6 )
		setElementData ( lootSphere, "ident", getElementData ( shape, "ident" ) )
		setElementData ( lootSphereFar, "lootFar", true )
		setElementData ( lootSphereFar, "ident", getElementData ( shape, "ident" ) )
		setElementData ( lootSphereVeryFar, "lootVeryFar", true )
		setElementData ( lootSphereVeryFar, "ident", getElementData ( shape, "ident" ) )
		
		setElementData ( shape, "lootObject", loot )
		setElementData ( shape, "lootShape", lootSphere )
		setElementData ( shape, "lootShapeFar", lootSphereFar )
		setElementData ( shape, "lootShapeVeryFar", lootSphereVeryFar )
	end
end

addEvent( "spawnLoot", true )
addEventHandler( "spawnLoot", getRootElement(), spawnLootS )

local ghoulsItems = {
	{id = 5, chance = 7, quant = 4},
	{id = 7, chance = 5, quant = 1},
	{id = 11, chance = 5, quant = 1},
	{id = 12, chance = 5, quant = 1},
	{id = 17, chance = 2, quant = 1},
	{id = 18, chance = 3, quant = 1},
	{id = 22, chance = 10, quant = 1},
	{id = 21, chance = 5, quant = 1},
	{id = 37, chance = 10, quant = 1},
	{id = 45, chance = 5, quant = 10},
	{id = 46, chance = 7, quant = 5},
	{id = 48, chance = 5, quant = 7},
	{id = 57, chance = 10, quant = 1},
	{id = 60, chance = 80, quant = 1},
	{id = 61, chance = 10, quant = 1},
	{id = 70, chance = 5, quant = 4},
	{id = 71, chance = 5, quant = 4},
	{id = 72, chance = 5, quant = 1},
	{id = 73, chance = 5, quant = 1},
	{id = 95, chance = 5, quant = 1},
}

lootItems = { -- ид, вероятность, максимум, за раз
	{ 1, 15, 3, 1, false },
	{ 2, 2, 4, 1, false },
	{ 3, 2, 3, 1, false },
	{ 4, 2, 3, 1, false },
	{ 5, 3, 5, 1, false },
	{ 6, 8, 3, 1, false },
	{ 7, 20, 3, 1, false },
	{ 10, 4, 2, 1, false },
	{ 11, 4, 3, 1, false },
	{ 12, 4, 3, 1, false },
	{ 13, 4, 3, 1, false },
	{ 14, 100, 1, 1, true },
	{ 15, 400, 3, 1, false },
	{ 16, 300, 3, 1, false },
	{ 17, 4, 5, 1, false },
	{ 21, 4, 15, 1, false },
	{ 23, 10, 1, 1, false },
	{ 24, 500, 1, 1, false },
	{ 25, 20, 50, 5, false },
	{ 26, 300, 1, 1, false },
	{ 27, 400, 1, 1, true },
	{ 28, 300, 1, 1, true },
	{ 29, 300, 1, 1, true },
	{ 30, 600, 1, 1, true },
	{ 31, 500, 1, 1, true },
	{ 32, 3000, 1, 1, true },
	{ 33, 1000, 1, 1, true },
	{ 34, 1000, 1, 1, true },
	{ 35, 1500, 1, 1, true },
	{ 36, 2000, 1, 1, true },
	{ 37, 20, 1, 1, false }, 
	{ 42, 10, 50, 5, false },
	{ 44, 10, 30, 5, false },
	{ 45, 10, 50, 5, false },
	{ 48, 20, 50, 10, false },
	{ 50, 2, 5, 1, false },
	{ 52, 1, 3, 1, false },
	{ 53, 1, 5, 2, false },
	{ 54, 10, 3, 1, false },
	{ 55, 1, 10, 1, false },
	{ 56, 1, 4, 1, false },
	{ 57, 3, 4, 1, false },
	{ 58, 5, 3, 1, false },
	{ 59, 4, 5, 1, false },
	{ 60, 2, 5, 1, false },
	{ 61, 4, 5, 1, false },
	{ 62, 2, 30, 4, false },
	{ 63, 2, 40, 10, false },
	{ 64, 4, 40, 15, false },
	{ 65, 2, 40, 15, false },
	{ 66, 2, 40, 15, false },
	{ 67, 2, 40, 15, false },
	{ 68, 2, 20, 5, false },
	{ 69, 5, 3, 1, false },
	{ 70, 4, 20, 5, false },
	{ 71, 4, 20, 5, false },
	{ 72, 4, 3, 1, false },
	{ 73, 4, 5, 1, false },
	{ 74, 100, 1, 1, false },
	{ 75, 10, 2, 1, false },
	{ 76, 10, 2, 1, false },
	{ 77, 10, 2, 1, false },
	{ 78, 10, 2, 1, false }, 
	{ 79, 5, 2, 1, false },
	{ 80, 7, 2, 1, false },
	{ 81, 7, 2, 1, false },
	{ 82, 9, 2, 1, false },
	{ 83, 9, 2, 1, false },
	{ 84, 15, 2, 1, false },
	{ 85, 11, 2, 1, false },
	{ 86, 11, 2, 1, false },
	{ 87, 11, 2, 1, false },
	{ 93, 100, 1, 1, false },
	{ 95, 1, 3, 1, false },
	{ 100, 12, 2, 1, false },
	{ 101, 30, 1, 1, false },
	{ 102, 13, 1, 1, false },
	{ 103, 5, 1, 1, false },
	{ 104, 5, 1, 1, false },
	{ 105, 5, 1, 1, false },
	{ 106, 10, 1, 1, false },
	{ 110, 10, 5, 2, false },
	{ 111, 10, 3, 2, false },
	{ 112, 10, 5, 2, false },
	{ 114, 30, 2, 1, false },
	{ 123, 10, 2, 1, false },
	{ 124, 20, 2, 1, false },
	{ 125, 10, 2, 1, false },
	{ 126, 5, 5, 1, false },
	{ 129, 20, 1, 1, true },
	{ 130, 20, 50, 10, true },
	{ 132, 80, 2, 1, true },
	{ 133, 1000, 1, 1, true },
	{ 134, 200, 1, 1, true },
	{ 135, 100, 1, 1, true },
	{ 137, 50, 50, 15, true },
	{ 141, 30, 80, 15, true },
	{ 146, 30, 100, 15, true },
	{ 154, 30, 100, 15, true },
	{ 138, 100, 1, 1, true },
	{ 139, 200, 1, 1, true },
	{ 140, 200, 1, 1, true },
	{ 140, 200, 1, 1, true },
	{ 144, 50, 1, 1, true },
	{ 148, 400, 1, 1, true },
	{ 152, 1000, 1, 1, true },
	{ 156, 500, 1, 1, true },
	
}

-- local specialLootItems = {
--	{ "id" = 24, "chance" = 10, "minimum" = 1, "maximum" = 1 },
--	{ "id" = 27, "chance" = 20, "minimum" = 1, "maximum" = 1 },
--	{ "id" = 30, "chance" = 10, "minimum" = 1, "maximum" = 1 },
--	{ "id" = 31, "chance" = 20, "minimum" = 1, "maximum" = 1 },
	
-- }

robotItems = {
	{ 1, 5, 1, 1 }, 
	{ 52, 5, 1, 1 }, 
	{ 53, 5, 1, 1 }, 
	{ 54, 5, 1, 1 }, 
	{ 55, 2, 1, 5 }, 
	{ 75, 5, 1, 1 }, 
	{ 76, 5, 1, 1 }, 
	{ 77, 5, 1, 2 }, 
	{ 78, 5, 1, 1 }, 
	{ 79, 5, 1, 1 }, 
	{ 87, 5, 1, 1 }, 
	{ 86, 5, 1, 1 }, 
	{ 85, 5, 1, 1 }, 
	{ 84, 5, 1, 1 }, 
	{ 83, 5, 1, 1 }, 
	{ 82, 5, 1, 1 }, 
	{ 81, 5, 1, 1 }, 
	{ 80, 5, 1, 1 }, 
	{ 125, 5, 1, 1 }, 
	{ 123, 3, 1, 1 }, 
	{ 158, 100, 1, 1 },
	{ 146, 5, 1, 50 },

}

tyranItems = {
	{ 2, 2, 1, 2 }, 
	{ 3, 2, 1, 2 }, 
	{ 4, 2, 1, 2 }, 
	{ 5, 2, 1, 2 }, 
	{ 10, 2, 1, 2 }, 
	{ 13, 2, 1, 2 }, 
	{ 23, 5, 1, 2 }, 
	{ 41, 20, 1, 1 }, 
	{ 49, 5, 1, 5 }, 
	{ 72, 5, 1, 5 }, 
	{ 15, 100, 1, 1 },
	{ 16, 100, 1, 1 },
	{ 124, 10, 1, 1 },
	{ 126, 2, 5, 4 }, 
	{ 159, 5, 1, 1 }, 
	{ 133, 50, 1, 1 }, 
}

function loadRadZones ()
	local loots = getElementsByType ( "loot" )
	for i,lootNum in ipairs(loots) do
		if math.random ( 1, 2 ) == 1 then
			local loot = createObject ( 1271, tonumber(getElementData ( lootNum, "posX" )), tonumber(getElementData ( lootNum, "posY" )), tonumber(getElementData ( lootNum, "posZ" )) )
			setElementFrozen(loot,true)
			local lootSphere = createColSphere ( tonumber(getElementData ( lootNum, "posX" )), tonumber(getElementData ( lootNum, "posY" )), tonumber(getElementData ( lootNum, "posZ" )), 1 )
			local lootSphereFar = createColSphere ( tonumber(getElementData ( lootNum, "posX" )), tonumber(getElementData ( lootNum, "posY" )), tonumber(getElementData ( lootNum, "posZ" )), 30 )
			local lootSphereVeryFar = createColSphere ( tonumber(getElementData ( lootNum, "posX" )), tonumber(getElementData ( lootNum, "posY" )), tonumber(getElementData ( lootNum, "posZ" )), 50 )
			if getElementData ( lootNum, "interior" ) then
				setElementInterior ( loot, tonumber(getElementData ( lootNum, "interior" )))
				setElementInterior ( lootSphere, tonumber(getElementData ( lootNum, "interior" )))
				setElementInterior ( lootSphereFar, tonumber(getElementData ( lootNum, "interior" )))
				setElementInterior ( lootSphereVeryFar, tonumber(getElementData ( lootNum, "interior" )))
			end
			local x, y = tonumber(getElementData ( lootNum, "posX" )), tonumber(getElementData ( lootNum, "posY" ))
			if x > -2012 and x < -460 and y > 1683 then
				setElementData ( lootSphere, "useLevel", 5 )
			end
			if x > -1022 and x < -685 and y > 671 then
				setElementData ( lootSphere, "useLevel", 5 )
			end
			if x > -462 and x < 745 and y > 593 then
				setElementData ( lootSphere, "useLevel", 8 )
			end
			if x > 862 and y > -846 then
				setElementData ( lootSphere, "useLevel", 13 )
			end
			if x > -2909 and x < -1656 and y > -846 and y < 1427 then
				setElementData ( lootSphere, "useLevel", 13 )
			end
			setElementData ( loot, "loot", true )
			attachElements ( lootSphere, loot )
			table.insert ( lootPlaces, { loot, lootSphere, 0 } )
			setElementData ( lootSphere, "level", tonumber(getElementData ( lootNum, "level" )) )
			setElementData ( lootSphere, "loot", true )
			setElementData ( lootSphere, "action", true )
			setElementData ( lootSphere, "type", 6 )
			setElementData ( lootSphere, "ident", lootsCreated )
			setElementData ( lootSphereFar, "lootFar", true )
			setElementData ( lootSphereFar, "ident", lootsCreated )
			setElementData ( lootSphereVeryFar, "lootVeryFar", true )
			setElementData ( lootSphereVeryFar, "ident", lootsCreated )
			putRandItemsInLoot ( lootSphere, lootsCreated )
			lootsCreated = lootsCreated+1
		end
	end	
	lootCanGetLoot = 1
	outputDebugString ( "Loot places total: "..lootsCreated)
	setTimer ( spawnLootItems, 7200000, 0 )
--	setTimer ( spawnLootItems, 1000, 0 )
end

--addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), loadRadZones )


function spawnLootItems ()
	for i = 1, #lootPlaces do
		if not getElementData ( lootPlaces[i][2], "playerLoot" ) then
			if lootPlaces[i][3] == 0 then
				--putRandItemsInLoot ( lootPlaces[i][2], i )
				spawnRandItemsInLoot ( lootPlaces[i][2], i )
			end
		end
	end
end

function spawnRandItemsInLoot ( loot, id )
	local level = getElementData ( loot, "level" )
	if #lootBoxes[id][2] < 5*level then
		for i = 1, level do
			local itemID = math.random ( 1, #lootItems )
			local itemTable = {}
			if math.random ( 1, lootItems[itemID][2] ) == 1 then
				local exist = false
				for b = 1, #lootBoxes[id][2] do
					if lootBoxes[id][2][1] == lootItems[itemID][1] then 
						if lootBoxes[id][2][2] <= lootItems[itemID][3] then
							local quant = math.random ( 1, lootItems[itemID][4] )
							lootBoxes[id][2][2]=lootBoxes[id][2][2]+quant
						end
						exist = true
					end
				end
				if not exist then 
					local quant = math.random ( 1, lootItems[itemID][4] )
					table.insert ( lootBoxes[id][2], { lootItems[itemID][1], quant, math.random (0,40) } )
				end
			end
		end
	end
end


function putRandItemsInLoot ( loot, id )
	local level = getElementData ( loot, "level" )
	for i = 1, level do
		local itemID = math.random ( 1, #lootItems )
		local itemTable = {}
		if math.random ( 1, lootItems[itemID][2] ) == 1 then
			table.insert ( itemTable, { lootItems[itemID][1], 1, math.random (0,50) } )
		end
		table.insert ( lootBoxes, id, { id, itemTable, math.random (0,50) } )
	end
end

function createPlayerLootBox ( player )
	local pItemsTable = exports.inventory:getItemsLargeNull ( player )
	local itemTable = {}
	for i = 1, #pItemsTable do
		if pItemsTable[i][2] > 0 then
			if pItemsTable[i][1] ~= 8 and pItemsTable[i][1] ~= 9 then
				table.insert ( itemTable, { pItemsTable[i][1], pItemsTable[i][2], pItemsTable[i][3] } )
				exports.inventory:removePlayerItemServer ( player, pItemsTable[i][1], pItemsTable[i][2] )
			end
		end
	end
	if #itemTable > 0 then
		local x,y,z = getElementPosition ( player )
		local int = getElementInterior ( player )
		lootsCreated = lootsCreated+1
		table.insert ( lootBoxes, lootsCreated, { lootsCreated, itemTable } )
		local createdLoot = createLootBox ( lootsCreated, x,y,z-1.5, int, 0 )
		setElementData ( createdLoot, "playerLoot", true )
	end
end

function createLootBox (id,x,y,z,level,int,dim)
	local loot = createObject ( 1271, x,y,z )
	setElementFrozen(loot,true)
	local lootSphere = createColSphere ( x,y,z, 1 )
	local lootSphereFar = createColSphere ( x,y,z, 30 )
	local lootSphereVeryFar = createColSphere ( x,y,z, 50 )
	setElementData ( loot, "loot", true )
	attachElements ( lootSphere, loot )
	table.insert ( lootPlaces, id, { loot, lootSphere, 0 } )
	setElementData ( lootSphere, "level", 1 )
	setElementData ( lootSphere, "loot", true )
	setElementData ( lootSphere, "action", true )
	setElementData ( lootSphere, "type", 6 )
	setElementData ( lootSphere, "ident", id )
	setElementData ( lootSphereFar, "lootFar", true )
	setElementData ( lootSphereFar, "ident", id )
	setElementData ( lootSphereVeryFar, "lootVeryFar", true )
	setElementData ( lootSphereVeryFar, "ident", id )
	return lootSphere
end


function getLootState ( id )
	if lootPlaces[id] then
		return lootPlaces[id][3]
	end
end

function checkLootPlace( theElement, matchingDimension )
    if ( getElementType ( theElement ) == 'player' ) and matchingDimension then
		if getElementData ( source, "lootCreator" ) then
			local x, y, z = getElementPosition ( source )
			if not getElementData ( source, "created" ) then
				triggerClientEvent ( theElement, "getPositionLoot", theElement, x, y, source )
			end
		elseif getElementData ( source, "loot" ) or getElementData ( source, 'deadBandit' )then
			local playerLevel = getElementData ( source, "useLevel" )
			if playerLevel then
				if getElementData ( theElement, "rplvl" ) > playerLevel then
					exports.pipboy:addInfoBox( "Ваш уровень слишком высок для этого ящика", 3, theElement )
					return true
				end
			end
			bindKey ( theElement, "E", "down", checkLootPlacePress, getElementData ( source, "ident" ), getElementData ( source, "level" ), getElementData ( source, "zloot" ), source, getElementData ( source, 'deadBandit' ) )
		end
    end
end
addEventHandler("onColShapeHit",getRootElement(),checkLootPlace)

function checkLootPlaceLeave( theElement, matchingDimension )
    if ( getElementType ( theElement ) == 'player' ) then
		if getElementData ( source, "loot" ) then
			unbindKey ( theElement, "E", "down", checkLootPlacePress )
		elseif getElementData ( source, "lootCreator" ) then
			if getElementData ( source, "created" ) then
				if #getElementsWithinColShape ( source, "player" ) == 0 then
					if isElement ( getElementData ( source, "lootObject" ) ) then destroyElement ( getElementData ( source, "lootObject" ) ) end
					if isElement ( getElementData ( source, "lootShape" ) ) then destroyElement ( getElementData ( source, "lootShape" ) ) end
					if isElement ( getElementData ( source, "lootShapeFar" ) ) then destroyElement ( getElementData ( source, "lootShapeFar" ) ) end
					if isElement ( getElementData ( source, "lootShapeVeryFar" ) ) then destroyElement ( getElementData ( source, "lootShapeVeryFar" ) ) end
					setElementData ( source, "created", false )
				end
			end
		end
    end
end
addEventHandler("onColShapeLeave",getRootElement(),checkLootPlaceLeave)

function checkLootPlacePress ( player, key, keyState, ident, level, zloot, loot, bandit )
		if getElementData ( player, "inventoryAllowed" ) == 1 then
			if isElement(loot) and not getPedOccupiedVehicle ( player ) then
				if zloot then
					unbindKey ( player, "E", "down", checkLootPlacePress )
					if destroyElement ( loot ) then
						triggerClientEvent(player,"unShowActLabelS",player)
						local item_quant = 0
						local item = ghoulsItems[math.random(#ghoulsItems)]
						for i = 1, item.quant do
							if math.random(1,100) <= item.chance then
								item_quant = item_quant+1
							end
						end
						if item_quant > 0 then
							exports.inventory:givePlayerItemServerWW ( player, item.id, item_quant, math.random(0,25) )
						else
							exports.pipboy:addInfoBox( "На гуле ничего нет", 2, player)
						end
					end
				elseif bandit then
					if isElement ( loot ) then
						if not getElementData ( loot, 'seeing' ) then
							setElementData ( loot, 'seeing', true ) 
							triggerClientEvent ( player, "initLootBarterBandit", player, loot )
						else
							exports.pipboy:addInfoBox( "Другой игрок осматривает этот труп" , 2, player)
						end
					end
					unbindKey ( player, "E", "down", checkLootPlacePress )
				else
					if not isElement(shapesPlayers[loot]) then
						shapesPlayers[loot] = player
						setElementData ( player, "inventoryAllowed", 0 )
						setElementData ( player, "workLoot", ident )
						triggerClientEvent ( player, "initLootBarterS", player, lootBoxes[ident][2] )
					else
						exports.pipboy:addInfoBox( "Другой игрок осматривает этот ящик" , 2, player)
					end
				end
			end
		end
end


function loadLootPlaces ()
	if lootCanGetLoot == 1 then
		triggerClientEvent ( source, "sendLootPlaceS", getRootElement(), lootPlaces )
	end
end

addEvent( "loadLootPlacesC", true )
addEventHandler( "loadLootPlacesC", getRootElement(), loadLootPlaces )

function giveLootAmmoS ( player, weapon )
	local ammo = math.random ( 1, 40 )
	outputChatBox ("Вы нашли "..ammo.." патронов для "..getWeaponNameFromID ( weapon ).."", source, 0,153,51 )	
	giveWeapon ( source, weapon, ammo )
end

addEvent( "giveLootAmmo", true )
addEventHandler( "giveLootAmmo", getRootElement(), giveLootAmmoS )

function changeLootTable ( lootID, itemTable, finito )
	if lootBoxes[lootID] then
		lootBoxes[lootID][2] = itemTable
	end
end

addEvent( "changeLootTableC", true )
addEventHandler( "changeLootTableC", getRootElement(), changeLootTable )

function quitPlayer ( quitType )
	if getElementData ( source, "workBag" ) or getElementData ( source, "workLoot" ) then
		for i, v in pairs ( shapesPlayers ) do
			if v == source then
				shapesPlayers[i] = nil
				return true
			end
		end
	end
	if getElementData ( source, "collectingFungus" ) then
		local fungus = getElementData ( source, "collectingFungus" )
		if #getElementsWithinColShape ( fungus, "player" ) == 0 then
			if isElement ( getElementData ( source, "fungusSphere" ) ) then destroyElement ( getElementData ( source, "fungusSphere" ) ) end
			if isElement ( getElementData ( source, "fungusObject" ) ) then destroyElement ( getElementData ( source, "fungusObject" ) ) end
			setElementData ( fungus, "created", false )
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )

function putItemsInCustomLoot ( loot, num, who )
	local itemTable = {}
	for i = 1, num do
		local lootTable = lootItems
		local qty = math.random(0,50)
		if who then
			if who == 1 then
				lootTable = tyranItems
				qty = math.random(20,100)
			elseif who == 2 then
				lootTable = robotItems
				qty = math.random(50,100)
			end
		end
		local itemID = math.random ( 1, #lootTable )
		if math.random ( 1, lootTable[itemID][2] ) == 1 then
			table.insert ( itemTable, { lootTable[itemID][1], math.random ( 1, lootTable[itemID][4] ), qty } )
		end
	end
	setElementData ( loot, 'itemsTable', itemTable )

	addEventHandler("onColShapeHit",loot,checkLootPlace)
	addEventHandler("onColShapeLeave",loot,checkLootPlaceLeave)
end

function createCustomLoot (x,y,z,dim,int,items_table,checkrandom)
	-- items {ид,количество,вероятность,{качество}}
	local items = items_table
	if checkrandom then
		items = {}
		for i, v in ipairs ( items_table ) do
			if v[4] then
				for c = 1, v[2] do
					if math.random ( 1, 100 ) <= v[3] then
						table.insert ( items, { v[1], 1, math.random(v[4][1],v[4][2]) } )
					end
				end
			else
				local quant = 0
				for c = 1, v[2] do
					if math.random ( 1, 100 ) <= v[3] then
						quant = quant+1
					end
				end
				if quant > 0 then
					table.insert ( items, { v[1], quant } )
				end
			end
		end
	end
	local createdShape = createColSphere ( x, y,z, 2 )
	setElementDimension ( createdShape, dim )
	setElementInterior ( createdShape, int )
	setElementData ( createdShape, "deadBandit", true )
	setElementData ( createdShape, "action", true )
	setElementData ( createdShape, "type", 6 )
	setElementData ( createdShape, 'itemsTable', items )
	return createdShape
end