playersInventories = {}

function updatePlayerInventoryS ( invTable )
	playersInventories[getElementData ( source, 'playerid')] = invTable
end

addEvent( "updatePlayerInventory", true )
addEventHandler( "updatePlayerInventory", getRootElement(), updatePlayerInventoryS )


addEventHandler ( "onResourceStop", getResourceRootElement(), 
    function ( resource )
        for i, v in ipairs ( getElementsByType("player")) do
			setElementData (v, "temp_inv",playersInventories[getElementData ( v, 'playerid')] )
		end
   end 
)

function askInventoryFromServerS ( )
	triggerClientEvent ( source, 'updateInventoryFromServer', source, playersInventories[getElementData ( source, 'playerid')] )
end

addEvent( "askInventoryFromServer", true )
addEventHandler( "askInventoryFromServer", getRootElement(), askInventoryFromServerS )

function quitPlayer ( quitType )
	if playersInventories[getElementData ( source, 'playerid')] then
		setTimer ( function ( playerid ) playersInventories[playerid] = nil end, 5000, 1, getElementData ( source, 'playerid') )
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )

function getPlayerItemPosFromNull (player, item_pos, item_id)
	if isElement ( player ) and item_pos and item_id then
		local off = 0
		for i,v in ipairs ( playersInventories[getElementData(player,"playerid")] ) do
			if v[2] <= 0 then
				off = off+1
			end
			if i == item_pos then
				--outputDebugString ( "item id: "..tostring(item_id).." item pos: "..tostring(item_pos).." off: "..tostring(off))
				if item_id == v[1] then
					return item_pos-off
				else
					return false
				end
			end
		end
	end
	return false
end


function givePlayerItemServer ( player, id, quant, qty )
	triggerClientEvent ( player, "givePlayerItemS", getRootElement(), id, quant,qty)
end
function givePlayerItemServerWW ( player, id, quant,qty )
	triggerClientEvent ( player, "givePlayerItemWW", getRootElement(), id, quant,qty)
end

function givePlayerItemTest (thePlayer, cmd, id, quant,qty)
	local accName = getAccountName ( getPlayerAccount ( thePlayer ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) )then
		if not qty then qty = math.random (1,100) end
		triggerClientEvent ( thePlayer, "givePlayerItemWW", root, tonumber(id), tonumber(quant), tonumber(qty) )
	end
end

addCommandHandler ( "qwertyui", givePlayerItemTest )

function stopFiringJam ( player )
	if getControlState ( player, 'fire' ) then
		setControlState  ( player, 'fire', false )
		triggerClientEvent ( player, 'fireFail', player )
		setElementData ( player, 'fireFail', true )
	end
end

addEvent( "fireJamHappen", true )
addEventHandler( "fireJamHappen", getRootElement(), function () stopFiringJam ( source ) end )

function fireCustom (player)
	if getControlState ( player, 'aim_weapon' ) and getElementData ( player, 'fireAllowed' ) then
		if getElementData ( player, 'fireFail' ) then
			--setWeaponAmmo ( player, getPedWeapon ( player ), getPedTotalAmmo ( player ) - 1, 1 )
			triggerClientEvent ( player, 'fireFail', player )
		else
			setControlState  ( player, 'fire', true )
		end
	elseif isElementInWater ( player ) then
		setControlState  ( player, 'fire', true )
	end
end

function fireStopCustom (player)
	--if getControlState ( player, 'fire' ) then
	if not getPedOccupiedVehicle ( player ) then
		setControlState  ( player, 'fire', false )
	end
end

addEventHandler("onPlayerLogin", root,
  function()
	bindKey ( source, "mouse1", "down", fireCustom )
	bindKey ( source, "mouse1", "up", fireStopCustom )
	toggleControl ( source, 'fire', false );
	toggleControl ( source, 'action', false );
  end
)

function displayLoadedRes ( res )
	for i, player in ipairs ( getElementsByType ( 'player' ) ) do
		bindKey ( player, "mouse1", "down", fireCustom )
		bindKey ( player, "mouse1", "up", fireStopCustom )
		toggleControl ( player, 'fire', false );
		playersInventories[getElementData ( player, "playerid")] = getElementData (player,"temp_inv") or {} 
		--triggerClientEvent ( player, 'updateInventoryFromServer', player, getElementData (player,"temp_inv") or {} )
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), displayLoadedRes )

function inventoryLoaded ( player, row )
	local finishTable = fromJSON ( row.inv )
	if #row.inv == 0 then finishTable = {} end
	if finishTable then
		if not playersInventories[getElementData ( player, "playerid")] then
			playersInventories[getElementData ( player, "playerid")] = finishTable 
			triggerClientEvent ( player, 'updateInventoryFromServer', player, finishTable )
		end
	elseif not getElementData ( player, 'oldInventoryLoaded' ) then
		playersInventories[getElementData ( player, "playerid")] = {} 
		triggerClientEvent ( player, 'updateInventoryFromServer', player, {} )
		outputChatBox ('ВАШ ИНВЕНТАРЬ НЕ ЗАГРУЖЕН, ОБРАТИТЕСЬ К АДМИНИСТРАТОРУ', player, 255, 0,0 )
	end
end

function inventoryLoadedOldWay ( player )
	triggerClientEvent ( player, 'invOldWayLoaded', player )
end

function removePlayerItemServer ( player, id, quant )
	triggerClientEvent ( player, "removePlayerItemS", getRootElement(), id, quant)
end

function setPlayerRandItem ( player )
	triggerClientEvent ( player, "setPlayerRandItemS", getRootElement() )
end

function getItemAmountServer ( player, id )
	local itemsTable = playersInventories[getElementData ( player, 'playerid')]
	for i = 1, #itemsTable do 
		if itemsTable[i][1] == id then
			return itemsTable[i][2]
		end
	end
end

function getPlayerItemByIDServer ( player, id )
	local itemsTable = playersInventories[getElementData ( player, 'playerid')]
	for i = 1, #itemsTable do 
		if itemsTable[i][1] == id then
			return i
		end
	end
	return false
end

function getFreeSlotInventoryServer ( player )
	for i = 1, 20 do 
		if getElementData ( player, "item"..tostring(i).."_q" ) == 0 then
			return i
		end
	end
	return false
end

function getItemsTableServer ( player )
	return playersInventories[getElementData ( player, 'playerid')]
end

function getItemsLargeNull ( player )
	local itemsTable = {}
	local items = playersInventories[getElementData ( player, 'playerid')]
	for i = 1, #items do 
		if items[i][2] > 0 then
			table.insert( itemsTable, { items[i][1], items[i][2], items[i][3] } )
		end
	end
	return itemsTable
end

function useAntiRadWearServer ( id )
	if id == 1 then
		setElementModel ( source, 20 )
	else
		setElementModel ( source, getElementData ( source, "modelid" ) )
	end
end

addEvent( "useAntiRadWear", true )
addEventHandler( "useAntiRadWear", getRootElement(), useAntiRadWearServer )

function useArmor ( id )
	if id == 1 then
		setElementModel ( source, 22 )
	elseif id == 2 then
		setElementModel ( source, 21 )
	elseif id == 3 then
		setElementModel ( source, 23 )
	elseif id == 4 then
		setElementModel ( source, 257 )
	elseif id == 5 then
		setElementModel ( source, 253 )
	elseif id == 6 then
		setElementModel ( source, 233 )
	elseif id == 7 then
		setElementModel ( source, 231 )
	elseif id == 8 then
		setElementModel ( source, 226 )
	elseif id == 9 then
		setElementModel ( source, 225 )
	else
		setElementModel ( source, getElementData ( source, "modelid" ) )
	end
end

addEvent( "useArmor", true )
addEventHandler( "useArmor", getRootElement(), useArmor )

function calculateInvWeight ( weight )
	setElementData ( source, "invWeight", math.floor(weight*100)/100 )
end

addEvent( "calculateInvWeightC", true )
addEventHandler( "calculateInvWeightC", getRootElement(), calculateInvWeight )

function givePlayerCustomAmmo ( weap, ammo, hand )
	--takeAllWeapons ( source )
	if hand then
	
	else
		local stat = "poor" 
		if getPedStat ( source, 69 ) == 999 then
			stat = "pro"
		end
		local maxAmmoInClip = getWeaponProperty ( weap, stat, "maximum_clip_ammo" )
		if maxAmmoInClip >= ammo then
			setWeaponAmmo ( source, weap, ammo+1, ammo )
		else
			setWeaponAmmo ( source, weap, ammo+1, maxAmmoInClip )
		end
		checkPlayerFireAllowed(source)
	end
end
	
addEvent( "givePlayerCustomAmmoC", true )
addEventHandler( "givePlayerCustomAmmoC", getRootElement(), givePlayerCustomAmmo )

function givePlayerCustomWeapon ( weap, hand )
	takeAllWeapons ( source )
	if hand then
		giveWeapon ( source, weap, 1, true )
		setElementData ( source, "currAmmoAmount", 1 )
		checkPlayerFireAllowed(source)
		if not getElementData ( source, "safezone.id" ) then
			setElementData ( source, 'fireAllowed', true )
		end
	else
		giveWeapon ( source, weap, 1, true )
		--outputChatBox ( "Патронов: "..tostring(getPedTotalAmmo ( source )) )
	end
end
	
addEvent( "givePlayerCustomWeaponC", true )
addEventHandler( "givePlayerCustomWeaponC", getRootElement(), givePlayerCustomWeapon )

function takePlayerCustomWeapon ()
	takeAllWeapons ( source )
	setElementData ( source, "weaponSelected", false )
end
	
addEvent( "takePlayerCustomWeaponC", true )
addEventHandler( "takePlayerCustomWeaponC", getRootElement(), takePlayerCustomWeapon )

function zombieMarker( hitElement, matchingDimension )
	if getElementType ( hitElement ) == "player" then
		if getElementData ( source, "boomMarker" ) then
			if getElementData ( hitElement, "quest_fire" ) > 0 then
				setElementData ( hitElement, "quest_fire", getElementData ( hitElement, "quest_fire" ) + 1 )
				outputChatBox ( "Вы собрали синюю эссенцию, всего ее у вас "..(getElementData ( hitElement, "quest_fire" )-1).." грамм", hitElement, 100, 255, 100 )
			end
		end
	end
end
addEventHandler( "onMarkerHit", root, zombieMarker )

function takeInventoryWeapon ( player )
	if isElement ( player ) then
		triggerClientEvent ( player, "takeInventoryWeaponS", getRootElement() )
	end
end

function putPlayerInStealthS ()
	setElementAlpha ( source, 10 )
	setPlayerNametagShowing ( source, false )
	for i, v in ipairs ( getAttachedElements ( source ) ) do
		if getElementType ( v ) == 'object' then
			setElementAlpha ( v, 10 )
		end
	end
end
	
addEvent( "putPlayerInStealth", true )
addEventHandler( "putPlayerInStealth", getRootElement(), putPlayerInStealthS )

function removePlayerFromStealthS ()
	setElementAlpha ( source, 255 )
	setPlayerNametagShowing ( source, true )
	for i, v in ipairs ( getAttachedElements ( source ) ) do
		if getElementType ( v ) == 'object' then
			setElementAlpha ( v, 255 )
		end
	end
end
	
addEvent( "removePlayerFromStealth", true )
addEventHandler( "removePlayerFromStealth", getRootElement(), removePlayerFromStealthS )

-- function checkPlayerWeightServer ( player )
	-- local totalWeight = 0
	-- for i = 1, 20 do 
		-- if getElementData ( player, "item"..tostring(i).."_q" ) > 0 then
			-- local quant = getElementData ( player, "item"..tostring(i).."_q" )
			-- local id = getElementData ( player, "item"..tostring(i).."_t" )
			-- local plus = things[id][2]*quant
			-- totalWeight = totalWeight+plus
		-- end
	-- end
	-- setElementData ( localPlayer, "invWeight", totalWeight )
	-- local startVal = 2*(getElementData ( localPlayer, "rplvl" )-1)
	-- if getElementData ( localPlayer, "spinePerk" ) then startVal=startVal+20 end
	-- setElementData ( localPlayer, "maxWeight", startVal )
	-- if totalWeight > 15+startVal then 
		-- setElementData ( localPlayer, "overWeight", true )
		-- outputChatBox ( "Вы перегружены и будете получать на 50% больше урона и 100% больше радиации" )
		-- return true
	-- end
	-- setElementData ( localPlayer, "overWeight", false )
-- end

eatAnims = {
	{ { "FOOD", "EAT_Burger" },
	  { "FOOD", "EAT_Pizza" },
	  { "FOOD", "EAT_Chicken" },
	  { "VENDING", "vend_eat1_P" },
	},
	{ { "VENDING", "VEND_Drink2_P" },
	  { "VENDING", "VEND_Drink_P" },
	}
}

function eatAnimationS ( num )
	local insideNum = math.random ( 1, #eatAnims[num] )
	setPedAnimation ( source, eatAnims[num][insideNum][1], eatAnims[num][insideNum][2], -1, false, false, true, false )
end

addEvent( "eatAnimation", true )
addEventHandler( "eatAnimation", getRootElement(), eatAnimationS )

usedFires = {}
usedFireTimers = {}

function playerPitchFire (inrain)
	local x,y,z = getElementPosition(source)
	local xr,yr,zr = getElementRotation(source)
	px, py, pz = getElementPosition(source)
	prot = getPedRotation(source)
	local offsetRot = math.rad(prot+90)
	local vx = px + 1 * math.cos(offsetRot)
	local vy = py + 1 * math.sin(offsetRot)
	local vz = pz + 2
	local vrot = prot+90
	--local x,y = getPointFromDistanceRotation(x,y,5,0)
	local wood = createObject(1463,vx,vy,pz-0.9,xr,yr,vrot)
	usedFires[wood] = {}
	setObjectScale(wood,2)
	setElementCollisionsEnabled(wood, false)
	setElementFrozen (wood,true)
	local fire = createObject(3525,vx,vy,pz-0.9,xr,yr,vrot)
	setObjectScale(fire,0)
	local fireCol = createColSphere(x,y,z,2)
	local fireColFar = createColSphere(x,y,z,5)
	if usedFireTimers[source] and isTimer ( usedFireTimers[source][1] ) then
		killTimer ( usedFireTimers[source][1] )
	end
	usedFireTimers[source] = { setTimer (checkPlayerNearFire,5000,1,source), fireColFar }
	addEventHandler ( "onColShapeHit", fireColFar, fireColFarHit )
	setElementData(fireCol,"fireplace",true)
	setPedAnimation (source,"BOMBER","BOM_Plant", -1, false, false, false, false)
	timeToDestroy = inrain and 5000 or 90000+(1000*( (getElementData(source,'breath') or 0 )+(getElementData(source,'tempbreath') or 0 ) ))
	setTimer(destroyFireInTime,timeToDestroy,1,fireCol,fireColFar,fire,wood)
end

addEvent( "playerPitchFire", true )
addEventHandler( "playerPitchFire", getRootElement(), playerPitchFire )

function checkPlayerNearFire(player)
	if isElement ( player ) then
		if usedFireTimers[player] and isElement ( usedFireTimers[player][2] ) then
			if isElementWithinColShape ( player, usedFireTimers[player][2] ) then
				triggerClientEvent ( player, "givePlayerFireBenefits", player )
				usedFireTimers[player][1] = setTimer (checkPlayerNearFire,5000,1,player)
				return true
			end
		end
	end
	usedFireTimers[player] = nil
end

function fireColFarHit (player)
	if getElementType ( player ) == "player" then
		if usedFireTimers[player] and isTimer ( usedFireTimers[player][1] ) then
			killTimer ( usedFireTimers[player][1] )
		end
		usedFireTimers[player] = { setTimer (checkPlayerNearFire,5000,1,player), source }
	end
end

function destroyFireInTime (fireCol,fireColFar,fire,wood)
	if isElement ( fireCol ) then
		destroyElement(fireCol)
	end
	if isElement ( fireColFar ) then 
		destroyElement(fireColFar)
	end
	if isElement ( fire ) then
		destroyElement(fire)
	end
	setTimer ( destroyElement, 120000, 1, wood)
end

function checkPlayerFireAllowed(player)
	local zone = exports.safezones:getPlayerZoneConfig(player)
	if ( not zone or not zone.noFight ) and ( getElementData ( player, "currAmmoAmount" ) > 0 or not getElementData ( player, "weaponSelected" ) or getElementData ( player, "meeleWeapon" ) or getPedWeapon ( player ) == 0 ) then
		setElementData ( player, 'fireAllowed', true )
		return true
	else	
		setElementData ( player, 'fireAllowed', false )
		return false
	end
end
