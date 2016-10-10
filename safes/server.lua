safes = {}
local bagsCreated = 0

function loadMysqlSafes ()
	local database = exports.players:askMysqlHandler ()
	local qh = dbQuery(database, "SELECT * FROM safes")
	if qh then
		local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
		if num_affected_rows > 0 then
			for result, row in pairs ( result ) do
				loadBagPlace ( row )
			end
		end
	end
	outputDebugString ( "safes total: "..bagsCreated )
end

unable = false

function loadBagPlace (row)
	local z = tonumber(row.z)
	local bag = createObject ( 2975, tonumber(row.x), tonumber(row.y), z, tonumber(row.rx), tonumber(row.ry), tonumber(row.rz) )
	local bagSphere = createColSphere ( tonumber(row.x), tonumber(row.y), tonumber(row.z)+1, 1.5 )
	setElementCollisionsEnabled ( bag, false )
	setObjectScale ( bag, 0.4 )
	setElementInterior ( bag, tonumber(row.inter ) )
	setElementDimension ( bag, tonumber(row.dim) )
	--outputChatBox ( getElementDimension ( bag ) )
	setElementInterior ( bagSphere, tonumber(row.inter ) )
	setElementDimension ( bagSphere, tonumber(row.dim) )
	bagsCreated = bagsCreated+1
	setElementData ( bag, "bag", true )
	attachElements ( bagSphere, bag )
	safes[bagSphere] = { bag, bagSphere, 0, {} }
	setElementData ( bagSphere, "safe", true )
	setElementData ( bagSphere, "action", true )
	setElementData ( bagSphere, "type", 6 )
	setElementData ( bagSphere, "ident", tonumber(row.id) )
	setElementData ( bagSphere, "pass", row.pass )
	safes[bagSphere][4] = fromJSON(row.items) or {}
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), loadMysqlSafes )

--function putItemsIntoSafe ( id, items, save, stop )
	--if safes[id] then
		--safes[id][4] = items
		--outputChatBox ( tostring ( stop ) )
		-- if stop then
			-- safes[id][3] = 0
		-- end
		-- if save == nil then
			-- saveSafePlace ( id )
		-- end
		-- return true
	-- end
-- end

-- addEvent( "changeSafeTable", true )
-- addEventHandler( "changeSafeTable", getRootElement(), putItemsIntoSafe )

function saveSafePlace ( id,player )
	if safes[id] then
		local items = toJSON ( safes[id][4] )
		local database = exports.players:askMysqlHandler ()
		local accname = ""
		if player then
			accname = getAccountName(getPlayerAccount(player))
		end
		local res1 = dbQuery ( database, "UPDATE `safes` SET items = '" .. items .. "', lastuser = '"..accname.."' WHERE `id` = '"..tostring(getElementData(id,"ident")).."'" )
		dbPoll ( res1, -1 )
		return true
	end
end

function createSafePlace (id,x,y,z,int,dim,rx,ry,rz,pass)
	bagsCreated = bagsCreated+1
	local bag = createObject ( 2975, x, y, z,rx,ry,rz )
	setElementCollisionsEnabled ( bag, false )
	setObjectScale ( bag, 0.4 )
	local bagSphere = createColSphere ( x, y, z, 1.5 )
	attachElements ( bagSphere, bag )
	safes[bagSphere] = { bag, bagSphere, 0, {} }
	setElementData ( bagSphere, "safe", true )
	setElementData ( bagSphere, "action", true )
	setElementData ( bagSphere, "type", 6 )
	setElementData ( bagSphere, "ident", id )
	setElementData ( bagSphere, "pass", pass )
	setElementInterior ( bag, int )
	setElementDimension ( bag, dim )
	setElementInterior ( bagSphere, int )
	setElementDimension ( bagSphere, dim )
	return bagSphere
end

function checkSafePlaceHit( theElement, matchingDimension )
	if isElement ( theElement ) then
		if ( getElementType ( theElement ) == 'player' ) then
			if matchingDimension then
				if getElementData ( source, "safe" ) then
					if not getKeyBoundToFunction(theElement, checkSafePlacePress) then
						setElementData ( theElement, "currentCol", source )
						bindKey ( theElement, "E", "down", checkSafePlacePress )
					end
				end
			end
		end
	end
end
addEventHandler("onColShapeHit",getRootElement(),checkSafePlaceHit)

function checkSafePlaceLeave( theElement, matchingDimension )
    if ( getElementType ( theElement ) == 'player' ) then
		if matchingDimension then
			if getElementData ( source, "safe" ) then
				unbindKey ( theElement, "E", "down", checkSafePlacePress )
				setElementData ( theElement, "currentCol", nil )
			end
		end
    end
end
addEventHandler("onColShapeLeave",getRootElement(),checkSafePlaceLeave)

shapesPlayers = {}

function checkSafePlacePress ( player, key, keyState, ident, bag )
	if getElementData ( player, "inventoryAllowed" ) == 1 then 
		local col = getElementData (player, "currentCol")
		--outputChatBox ( tostring ( col ) )
		if not isElement ( col ) then
			col = nil
			setElementData ( player, "currentCol", nil )
		end
		if isElement(col) and getElementData ( col, "safe" ) and safes[col] then
			if not isElement ( shapesPlayers[col] ) then
				shapesPlayers[col] = player
				setElementData ( player, "inventoryAllowed", 0 )
				triggerClientEvent ( player, "showSafeMenuS", player, safes[col][4], isObjectInACLGroup ( "user." .. getAccountName ( getPlayerAccount ( player ) ), aclGetGroup ( "Admin" ) ) )
			else
				outputChatBox ( "Другой игрок осматривает этот сейф" , player, 255, 255, 255)
			end
			return true
		end
	end
end

function deleteSafeFromClientS ()
	local col = getElementData ( source, "currentCol" )
	if isElement ( col ) and getElementData ( col, "safe" ) then
		local database = exports.players:askMysqlHandler ()
		local qh = dbQuery(database, "DELETE FROM safes WHERE id='"..tostring(getElementData ( col, "ident")).."'")
		local result = dbPoll( qh, -1 ) 
		if result then
			result = nil
			setElementData ( source, "inventoryAllowed", 1 )
			setElementData ( source, "currentCol", nil )
			unbindKey ( source, "E", "down", checkSafePlacePress )
			if safes[col] then
				destroyElement ( safes[col][1] )
				destroyElement ( safes[col][2] )
				exports.inventory:givePlayerItemServerWW ( source, 124, 1 )
				safes[col] = nil
				return true
			end
		else
			outputChatBox ( 'Извините, не удается забрать сейф', source, 255, 150, 150 )
		end
	end
	setElementData ( source, "inventoryAllowed", 1 )
	setElementData ( source, "currentCol", nil )
end

function createSafeFromC ( pass )
	setPedAnimation (source,"BOMBER","BOM_Plant",-1,false,false,false,false)
	setTimer( function (player)	
		setElementData ( player, "inventoryAllowed", 1 )
		local x,y,z = getElementPosition ( player )
		local rx, ry, rz = getElementRotation ( player )
		local int = getElementInterior ( player )
		local dim = getElementDimension ( player ) 
		x = x+2*math.cos(math.rad(rz+90))
		y = y+2*math.sin(math.rad(rz+90))
		z = z-1
		rz = math.random ( 0, 360 )
		local database = exports.players:askMysqlHandler ()
		local id = 0
		local idquery = dbQuery( database, "SELECT Max(id) FROM safes" )
		local result, num_affected_rows, errmsg = dbPoll ( idquery, -1 )
		if num_affected_rows > 0 then
			for result, row in pairs ( result ) do
				if row['Max(id)'] then id = tonumber(row['Max(id)'])+1 end
				break
			end
		end
		local result = nil
		if idquery then
			result = dbQuery( database, "INSERT INTO safes (id, x, y, z, rx, ry, rz, inter, dim, items, pass) values ( '"..tostring(id).."','"..tostring(x).."', '"..tostring(y).."', '"..tostring(z).."', '"..tostring(rx).."', '"..tostring(ry).."', '"..tostring(rz).."', '"..tostring(int).."', '"..tostring(dim).."', '[[]]','"..tostring(pass).."') " )
		else
			result = dbQuery( database, "INSERT INTO safes (x, y, z, rx, ry, rz, inter, dim, items, pass) values ( '"..tostring(x).."', '"..tostring(y).."', '"..tostring(z).."', '"..tostring(rx).."', '"..tostring(ry).."', '"..tostring(rz).."', '"..tostring(int).."', '"..tostring(dim).."', '[[]]', '"..tostring(pass).."') " )	
		end
		if result then
			dbFree ( result )	
			exports.inventory:removePlayerItemServer ( player, 124, 1 )
			createSafePlace (id,x,y,z,int,dim,rx,ry,rz, pass)
		else
			outputChatBox ( 'Не удается поставить сейф', source )
		end
	end,1500,1,source)		
end

addEvent( "createSafeFromClient", true )
addEventHandler( "createSafeFromClient", getRootElement(), createSafeFromC )
addEvent( "deleteSafeFromClient", true )
addEventHandler( "deleteSafeFromClient", getRootElement(), deleteSafeFromClientS )


function changeSafeTableS (inv)
	local currentCol = getElementData ( source, "currentCol" )
	if isElement ( currentCol ) and safes[currentCol] then
		safes[currentCol][4] = inv
		saveSafePlace ( currentCol, client )
	end
end

addEvent( "changeSafeTable", true )
addEventHandler( "changeSafeTable", getRootElement(), changeSafeTableS )

function cancelUsingSafe ()
	--outputChatBox ("SAFE CANCELLED")
	setElementData ( source, "inventoryAllowed", 1 )
	for i, v in pairs ( shapesPlayers ) do
		if v == source then
			--outputChatBox ("SUCCESS")
			shapesPlayers[i] = nil
			--return true
		end
	end
end

addEvent( "cancelUsingSafeC", true )
addEventHandler( "cancelUsingSafeC", getRootElement(), cancelUsingSafe )

function quitPlayer ( quitType )
	setElementData ( source, "inventoryAllowed", 1 )
	for i, v in pairs ( shapesPlayers ) do
		if v == source then
			shapesPlayers[i] = nil
			return true
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )