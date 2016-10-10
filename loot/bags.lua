bags = {}
local bagsCreated = 0

function loadMysqlBags ()
	local database = exports.players:askMysqlHandler ()
	local qh = dbQuery(database, "SELECT * FROM tents_new")
	if qh then
		local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
		if num_affected_rows > 0 then
			for result, row in pairs ( result ) do
				loadBagPlace ( row )
			end
		end
	end
	outputDebugString ( "bags total: "..bagsCreated )
end

unable = false

function loadBagPlace (row)
	local z = tonumber(row.z)
	local bag = createObject ( 2060, tonumber(row.x), tonumber(row.y), z, tonumber(row.rx), tonumber(row.ry), tonumber(row.rz) )
	local bagSphere = createColSphere ( tonumber(row.x), tonumber(row.y), tonumber(row.z)+1, 1.5 )
	setElementInterior ( bag, tonumber(row.inter ) )
	setElementDimension ( bag, tonumber(row.dim) )
	--outputChatBox ( getElementDimension ( bag ) )
	setElementInterior ( bagSphere, tonumber(row.inter ) )
	setElementDimension ( bagSphere, tonumber(row.dim) )
	bagsCreated = bagsCreated+1
	setElementData ( bag, "bag", true )
	attachElements ( bagSphere, bag )
	--table.insert ( bags, { bag, bagSphere, 0, {}, tonumber(row.id) } )
	bags[tonumber(row.id)] = { bag, bagSphere, 0, {} }
	setElementData ( bagSphere, "bag", true )
	setElementData ( bagSphere, "action", true )
	setElementData ( bagSphere, "type", 6 )
	setElementData ( bagSphere, "ident", tonumber(row.id) )
	setElementData ( bagSphere, 'kind', tonumber(row.kind) )
	setElementCollisionsEnabled ( bag, false )
	--local itemsTable = stringToTable ( row.items )
	--outputDebugString ( row.items )
	-- if not row.items then
		-- bags[tonumber(row.id)][4] = {}
	-- else
		bags[tonumber(row.id)][4] = fromJSON(row.items) or {}
	--	putItemsIntoBag ( tonumber(row.id), fromJSON(row.items), true )	
	--end
	-- for i,v in ipairs ( itemsTable ) do --вернуть перед загрузкой на сервер
		-- if nonStackableItems[v[1]] then
			-- table.insert(v,math.random(0,100))
		-- end
	-- end
	-- debug_server = true
	-- new_items = toJSON ( itemsTable )
	-- if debug_server and not unable then
		-- local database = exports.players:askMysqlHandler ()
		-- result = dbQuery( database, "INSERT INTO tents_new (id, x, y, z, rx, ry, rz, inter, dim, items, kind) values ( '"..tostring(row.id).."','"..tostring(row.x).."', '"..tostring(row.y).."', '"..tostring(row.z).."', '"..tostring(row.rx).."', '"..tostring(row.ry).."', '"..tostring(row.rz).."', '"..tostring(row.inter).."', '"..tostring(row.dim).."', '"..tostring(new_items).."','"..tostring(row.kind).."') " )
		-- if result then
			-- if dbFree (result) then
				-- unable = false
			-- else
				-- unable = true
			-- end
		-- else
			-- unable = true
		-- end
	-- end
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), loadMysqlBags )

function stringToTable ( itString )
	i = 1
	local total = 0
	local lastnum = 0
	local tmpTable = {}
	while gettok ( itString, i, string.byte(',') ) do
		local pos = math.ceil (i/2) 
		if pos ~= lastnum then table.insert ( tmpTable, pos, {} ) end
		lastnum = pos
		table.insert ( tmpTable[pos], tonumber(gettok ( itString, i, string.byte(',') )) )
		i = i+1
	end
	return tmpTable
end

function tableToString (itemsT)
	local itString = ''
	for i = 1, #itemsT do
		for b = 1, 2 do
			itString=itString..tostring(itemsT[i][b])..','
		end
	end
	return itString
end

function putItemsIntoBag ( id, items, save )
	if bags[id] then
		bags[id][4] = items
		bags[id][3] = 0
		if save == nil then
			saveBagPlace ( id )
		end
		return true
	end
end

addEvent( "changeBagTable", true )
addEventHandler( "changeBagTable", getRootElement(), putItemsIntoBag )

function saveBagPlace ( id )
	if bags[id] then
		local x,y,z = getElementPosition ( bags[id][1] )
		local rx, ry, rz = getElementRotation ( bags[id][1] )
		local int = getElementInterior ( bags[id][1] )
		local dim = getElementDimension ( bags[id][1] )
		local items = toJSON ( bags[id][4] )
		local database = exports.players:askMysqlHandler ()
		local res1 = dbQuery ( database, "UPDATE `tents_new` SET x = '" .. tostring(x) .. "', y = '" .. tostring(y) .. "', z = '" .. tostring(z) .. "', rx = '" .. tostring(rx) .. "', ry = '" .. tostring(ry) .. "', rz = '" .. tostring(rz) .. "', inter = '" .. tostring(int) .. "', dim = '" .. tostring(dim) .. "', items = '" .. items .. "' WHERE `id` = '"..tostring(id).."'" )
		dbPoll ( res1, -1 )
		return true
	end
end

function createBagPlace (id,x,y,z,int,dim,rx,ry,rz,kind)
	--if id == 0 then id = bagsCreated end
	bagsCreated = bagsCreated+1
	local bag = createObject ( 2060, x, y, z,rx,ry,rz )
	local bagSphere = createColSphere ( x, y, z, 1.5 )
	setElementData ( bag, "bag", true )
	attachElements ( bagSphere, bag )
	bags[id] = { bag, bagSphere, 0, {} }
	setElementCollisionsEnabled ( bag, false )
	--outputChatBox ( bags[bagsCreated][3] )
	setElementData ( bagSphere, "bag", true )
	setElementData ( bagSphere, "action", true )
	setElementData ( bagSphere, "type", 6 )
	setElementData ( bagSphere, "ident", id )
	local itemsTable = {}
	setElementInterior ( bag, int )
	setElementDimension ( bag, dim )
	setElementInterior ( bagSphere, int )
	setElementDimension ( bagSphere, dim )
	setElementData ( bagSphere, 'kind', kind )
	return bagSphere
end

function checkBagPlaceHit( theElement, matchingDimension )
	if isElement ( theElement ) then
		if ( getElementType ( theElement ) == 'player' ) then
			if matchingDimension then
				if getElementData ( source, "bag" ) then
					if not getKeyBoundToFunction(theElement, checkBagPlacePress) then
						bindKey ( theElement, "E", "down", checkBagPlacePress, getElementData ( source, "ident" ), source )
					end
				end
			end
		end
	end
end
addEventHandler("onColShapeHit",getRootElement(),checkBagPlaceHit)

function checkBagPlaceLeave( theElement, matchingDimension )
    if ( getElementType ( theElement ) == 'player' ) then
		if matchingDimension then
			if getElementData ( source, "bag" ) then
				unbindKey ( theElement, "E", "down", checkBagPlacePress )
			end
		end
    end
end
addEventHandler("onColShapeLeave",getRootElement(),checkBagPlaceLeave)

shapesPlayers = {}

function checkBagPlacePress ( player, key, keyState, ident, bag )
		if getElementData ( player, "inventoryAllowed" ) == 1 then
			if isElement(bag) then
				if bags[ident] then
					if not isElement(shapesPlayers[bag]) then
						shapesPlayers[bag] = player
						setElementData ( player, "inventoryAllowed", 0 )
						setElementData ( player, "workBag", ident )
						setElementData ( player, "workLoot", ident )
						triggerClientEvent ( player, "showBagMenuS", player, bags[ident][4], getElementData ( bag, 'kind' ) or 1 )
					else
						outputChatBox ( "Другой игрок осматривает эту сумку" , player, 255, 255, 255)
					end
					return true
				end
			end
		end
end

bagTypes = {
	[1] = 23,
	[2] = 100,
	[3] = 101,
}

function deleteBagFromClientS ()
	local database = exports.players:askMysqlHandler ()
	local qh = dbQuery(database, "DELETE FROM tents_new WHERE id='"..tostring(getElementData ( source, "workBag")).."'")
	local result = dbPoll( qh, -1 ) 
	if result then
		result = nil
		setElementData ( source, "inventoryAllowed", 1 )
		local id = getElementData ( source, "workBag")
		setElementData ( source, "workBag", false )
		unbindKey ( source, "E", "down", checkBagPlacePress )
		if bags[id] then
			kind = getElementData ( bags[id][2], 'kind' )
			destroyElement ( bags[id][1] )
			destroyElement ( bags[id][2] )
			bags[id][1] = nil
			bags[id][5] = -1
			exports.inventory:givePlayerItemServerWW ( source, bagTypes[kind], 1 )
			bags[id] = nil
			return true
		end
	else
		outputChatBox ( 'Извините, не удается забрать сумку', source, 255, 150, 150 )
	end
end

kindToID = {23,100,101}

function createBagFromC ( int, dim, kind )
	local x,y,z = getElementPosition ( source )
	local rx, ry, rz = getElementRotation ( source )
--	outputChatBox ( 'Интерьер: '..int )
--	outputChatBox ( 'Виртуальный мир: '..dim )
	x = x+2*math.cos(math.rad(rz+90))
	y = y+2*math.sin(math.rad(rz+90))
	z = z-0.90
	rz = math.random ( 0, 360 )
	local database = exports.players:askMysqlHandler ()
	local id = 0
	local idquery = dbQuery( database, "SELECT Max(id) FROM tents_new" )
	local result, num_affected_rows, errmsg = dbPoll ( idquery, -1 )
	if num_affected_rows > 0 then
		for result, row in pairs ( result ) do
			if row['Max(id)'] then id = tonumber(row['Max(id)'])+1 end
			break
		end
	end
	local result = nil
	--idquery = false
	if idquery then
		result = dbQuery( database, "INSERT INTO tents_new (id, x, y, z, rx, ry, rz, inter, dim, items, kind) values ( '"..tostring(id).."','"..tostring(x).."', '"..tostring(y).."', '"..tostring(z).."', '"..tostring(rx).."', '"..tostring(ry).."', '"..tostring(rz).."', '"..tostring(int).."', '"..tostring(dim).."', '[[]]','"..tostring(kind).."') " )
	else
		result = dbQuery( database, "INSERT INTO tents_new (x, y, z, rx, ry, rz, inter, dim, items, kind) values ( '"..tostring(x).."', '"..tostring(y).."', '"..tostring(z).."', '"..tostring(rx).."', '"..tostring(ry).."', '"..tostring(rz).."', '"..tostring(int).."', '"..tostring(dim).."', '[[]]', '"..tostring(kind).."') " )	
	end
	if result then
		dbFree ( result )
		createBagPlace (id,x,y,z,int,dim,rx,ry,rz, kind)
		if kindToID[kind] then
		--	outputChatBox('loots '..tostring(kindToID[kind))
			exports.inventory:removePlayerItemServer(source,kindToID[kind],1)
		end
	else
		outputChatBox ( 'Не удается поставить сумку', source )
	end
end

addEvent( "createBagFromClient", true )
addEventHandler( "createBagFromClient", getRootElement(), createBagFromC )
addEvent( "deleteBagFromClient", true )
addEventHandler( "deleteBagFromClient", getRootElement(), deleteBagFromClientS )

function finishWorkWithLoot ()
	for i, v in pairs ( shapesPlayers ) do
		if v == source then
			shapesPlayers[i] = nil
			return true
		end
	end
end

addEvent( "finishWorkWithLoot", true )
addEventHandler( "finishWorkWithLoot", getRootElement(), finishWorkWithLoot )


function cancelUsingBox ()
	local ident = getElementData ( source, "workBag" )
	setElementData ( source, "workBag", false )
	setElementData ( source, "inventoryAllowed", 1 )
	for i, v in pairs ( shapesPlayers ) do
		if v == source then
			shapesPlayers[i] = nil
			return true
		end
	end
end

addEvent( "cancelUsingBoxC", true )
addEventHandler( "cancelUsingBoxC", getRootElement(), cancelUsingBox )