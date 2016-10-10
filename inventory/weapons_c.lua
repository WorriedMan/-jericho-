currWeapon = 0
currWeaponHand = false
currAmmo = 0
currAmmoAmount = 0
currAmmoInvSlot = 0
currAmmoInvID = 0 
currWeaponInventoryID = 0

ammoToShell = {
	[46] = 62,
	[42] = 63,
	[44] = 65,
	[45] = 64,
	[47] = 66,
	[48] = 67,
	[111] = 112,
	[118] = 119,
	[130] = 131,
	[137] = 119,
	[141] = 142,
	[146] = 147,
	[25] = 153,
	[154] = 155,
}

weaponToAmmo = {
	["Китайский автомат"] = 25,
	["Китайский автомат+"] = 25,
	["Китайский автомат Джерико"] = 25,
	["9-мм пистолет"] = 130,
	["9-мм пистолет+"] = 130,
	["Мария"] = 130,
	["9-мм пистолет-пулемёт"] = 130,
	["10-мм пистолет-пулемёт"] = 45,
	["12,7-мм пистолет-пулемёт"] = 48,
	["Винтовка Гаусса"] = 137,
	["12,7-мм пистолет"] = 48,
	["12,7-мм пистолет+"] = 48,
	["Револьвер Магнум кал. 357"] = 141,
	["Бластер Чужих"] = 137,
	["Охотничий револьвер"] = 146,
	["Секвойя рейнджера"] = 146,
	["10-мм пистолет"] = 45,
	["10-мм пистолет+"] = 45,
	["Штурмовая винтовка"] = 25,
	["Штурмовая винтовка+"] = 25,
	["Снайперская винтовка"] = 154,
	["Винтовка резервиста"] = 154,
	["Винтовка «Виктория»"] = 154,
	["Инфильтратор"] = 25,
	["Дырокол"] = 25,
	["Дробовик"] = 46,
	["Обрез"] = 46,
	["Боевой дробовик"] = 46,
}

weaponReduceOnFire = {
	['Инфильтратор'] = 0.25,
	['Дырокол'] = 0.33,
	['Китайский автомат'] = 0.1,
	['Китайский автомат+'] = 0.1,
	['Мария'] = 0.1,
	['9-мм пистолет'] = 0.134,
	['9-мм пистолет+'] = 0.144,
	['9-мм пистолет-пулемёт'] = 0.03,
	['10-мм пистолет-пулемёт'] = 0.04,
	['12,7-мм пистолет-пулемёт'] = 0.04,
	['12,7-мм пистолет'] = 0.25,
	['12,7-мм пистолет+'] = 0.27,
	['Винтовка Гаусса'] = 0.5,
	['Револьвер Магнум кал. 357'] = 0.1005,
	['Охотничий револьвер'] = 0.18,
	['Секвойя рейнджера'] = 0.25,
	['10-мм пистолет'] = 0.253,
	['10-мм пистолет+'] = 0.27,
	['Штурмовая винтовка'] = 0.05,
	['Штурмовая винтовка+'] = 0.05,
	['Винтовка «Виктория»'] = 0.01,
	['Винтовка резервиста'] = 0.8,
	['Снайперская винтовка'] = 0.7,
	['Кий'] = 3, -- кий
	['Бензопила'] = 1, -- бензопила
	['Лопата'] = 3, -- лопата
	['Катана'] = 0.1, -- катана
	['Дубинка'] = 1, -- дубинка
	['Супердубина'] = 0.5, -- супердубина
	['Дробовик'] = 1,

}

function takeInventoryWeapon ()
	--triggerServerEvent ( "takePlayerCustomWeaponC", localPlayer )
	setElementData ( localPlayer, "currentWeapon", nil)
	setElementData ( localPlayer, "meeleWeapon", false )
	currAmmoAmount = 0
	currAmmoInvSlot = 0
	currAmmoInvID = 0 
	setElementData ( localPlayer, "currAmmoAmount", 0 )
end

addEvent( "takeInventoryWeaponS", true )
addEventHandler( "takeInventoryWeaponS", getRootElement(), takeInventoryWeapon )

function getPlayerCurrentWeapon ()
	return getElementData ( localPlayer, "currentWeapon" )
end

function getPlayerCurrentMeele ()
	return getElementData ( localPlayer, "meeleWeapon" ) or "no"
end

function equipMeeleWeapon(id)	
	if not id then 
		id = curr_inv_item
	end
	local name = things[id][1]
	if not name then return false end
	local curr = getPlayerCurrentWeapon ()
	local meele = getPlayerCurrentMeele ()
	if curr then
		setElementData (localPlayer,"currentWeapon",nil)
		setElementData (localPlayer,"currAmmoAmount",0)
	end
	if meele and meele == name then
		setElementData ( localPlayer, "meeleWeapon", nil )
	else
		setElementData (localPlayer, "meeleWeapon", name)
	end
end

function equipFiringWeapon(id)	
	if not id then 
		id = curr_inv_item
	end
	local name = things[id][1]
	if not name then return false end
	local curr = getPlayerCurrentWeapon ()
	local curr_meele = getPlayerCurrentMeele ()
	if curr_meele then
		setElementData ( localPlayer, "meeleWeapon", nil )
	end
	if curr and curr == name then
		setElementData (localPlayer,"currentWeapon",nil)
		setElementData (localPlayer,"currAmmoAmount",0)
	else
		currWeaponInventoryID = curr_inv_slot
		currWeaponHand = false
		currAmmoInvSlot = 0
		equipAmmoAuto (weaponToAmmo[name],name)
		setElementData (localPlayer, "currentWeapon", name)
	end
end

function equipAmmoAuto(id,weap)
	currAmmoInvSlot = getPlayerItemByID ( id )
	if currAmmoInvSlot then
		if weaponToAmmo[weap] == id then
			setElementData ( localPlayer, "currAmmoAmount", inventory[currAmmoInvSlot][2] )
		end
	else 
		setElementData (localPlayer,"currAmmoAmount",0)
	end
end

function equipAmmo()
	local ammo = curr_inv_item
	if ammo then
		currAmmoInvSlot = getPlayerItemByID ( ammo )
		if currAmmoInvSlot then
			local currAmmo = getElementData (localPlayer,"currAmmoAmount") or 0
			if currAmmo <= 0 then
				local weap = getPlayerCurrentWeapon()
				if weap and weaponToAmmo[weap] == ammo then
					setElementData ( localPlayer, "currAmmoAmount", inventory[currAmmoInvSlot][2] )
				end
			end
		end
	end
end

function checkWeaponFire(weapon_name)
	if weapon_name ~= "Горбомет" then
		local currAmmoAmount = getElementData (localPlayer,"currAmmoAmount") or 0
		--if getElementData ( localPlayer, 'fireFail' ) then
		--	fireFailed ()
		--	setControlState  ( 'fire', false )
		--	setElementData ( localPlayer, 'fireFail', false )
		--	triggerServerEvent ( 'fireJamHappen', localPlayer )
		--elseif math.random ( 1, 70 ) == 1 then
			-- if weapon > 10 then
				-- setElementData ( localPlayer, 'fireFail', true )
			-- end
		--end
		local currAmmoAmount = getElementData (localPlayer,"currAmmoAmount")
		currAmmoAmount = currAmmoAmount-1
		inventory[currAmmoInvSlot][2] = currAmmoAmount
		setElementData ( localPlayer, "currAmmoAmount", currAmmoAmount )
		triggerServerEvent ( "updatePlayerInventory", localPlayer, inventory )
		if weaponReduceOnFire[weapon_name] then
			reduceItemHealth ( currWeaponInventoryID, weaponReduceOnFire[weapon_name], 1 )
		end
		if ammoToShell [weaponToAmmo[weapon_name]] then
			givePlayerItem ( ammoToShell [weaponToAmmo[weapon_name]], 1, true )
		end
	-- else
		-- shootedPatrons = shootedPatrons+1
		-- currAmmoAmount = currAmmoAmount-1
		-- setElementData ( localPlayer, "currAmmoAmount", currAmmoAmount )
		-- if shootedPatrons >= 50 then
			-- removePlayerItem ( 111, 1 )
			-- givePlayerItem ( 112, 1 )
			-- shootedPatrons = 0
		-- end
	end
end

function defaultWeaponFire(weaponID)
	local wname = getPlayerCurrentWeapon()
	if wname then
		local stats = exports.cweap_jericho:getWeaponStats(wname)
		if stats and stats.id == weaponID then
			checkWeaponFire(wname)
			if inventory[currAmmoInvSlot][2] < 1 then
				toggleControl("fire",false)
			end
		end
	end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), defaultWeaponFire )

function customWeaponFire()
	local owner = getElementData ( source,"cweap.owner" ) 
	local wname = getElementData ( source,"cweap" )
	if owner and owner == localPlayer then
		if wname then
			if getPlayerCurrentWeapon() and getPlayerCurrentWeapon() == wname then
				checkWeaponFire(getPlayerCurrentWeapon())
			end
		end
	end
end

addEventHandler ( "onClientWeaponFire", root, customWeaponFire )

function produceMeeleReduce ( attacker )
	if attacker and attacker == localPlayer then
		local oneHand = getElementData (source,"meeleWeapon")
		if onehand then
			if weaponReduceOnFire[onehand] then
				reduceItemHealth ( currWeaponInventoryID, weaponReduceOnFire[onehand], 1 )
			end
		end
	end
end
addEventHandler ( "onClientPedDamage", getRootElement(), produceMeeleReduce )
addEventHandler ( "onClientPlayerDamage", getRootElement(), produceMeeleReduce )

function reduceItemHealth (slot_id, amount, item_type)
	if slot_id and amount and slot_id > 0 and inventory[slot_id] and inventory[slot_id][3] then
		inventory[slot_id][3] = inventory[slot_id][3]-amount
		if inventory[slot_id][3] <= 0 then
			inventory[slot_id][3] = 0
			if item_type == 1 then
				exports.pipboy:addInfoBox ( "Ваше оружие \""..things[inventory[slot_id][1]][1].."\" сломалось",3)
				takeInventoryWeapon ()
			elseif item_type == 2 then
				removeArmorBuffs()
				triggerServerEvent ( "useArmor", localPlayer, 0 )
				setElementData ( localPlayer, "antiRadWear", 0 )
				setElementData ( localPlayer, "useArmor", 0 )
				exports.pipboy:addInfoBox ( "Ваша броня сломалась, ее необходимо отремонтировать",2)
			end
		end
	end
end

addEvent ( "reduceItemHealth", true )
addEventHandler ( "reduceItemHealth", root, reduceItemHealth )

function disableMinigunOnSwitch ( prevSlot, newSlot )
	if source == localPlayer then
		if not getElementData ( localPlayer, "safezone.id" ) and getElementData ( localPlayer, "inarena" ) == 0 and getElementData ( localPlayer, "indmzone" ) == 0 then
			if newSlot == 1 or newSlot == 0 or newSlot == 10 or newSlot == 11 then
				setElementData ( localPlayer, 'fireAllowed', true)
			else
				if currAmmoAmount == 0 then
					setElementData ( localPlayer, 'fireAllowed', false)
				else
					--setElementData ( localPlayer, 'fireAllowed', true)
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), disableMinigunOnSwitch )
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), takeInventoryWeapon )

-- bindKey( 'mouse1', 'both', function( key, state )
  -- toggleControl( 'action', (state == "down" and false or true) )
-- end )

addEvent ( "onPlayerEquipWeapon", true )

setPlayerHudComponentVisible ( "ammo", false )
setPlayerHudComponentVisible ( "weapon", false )
setPlayerHudComponentVisible ( "money", false )
setPlayerHudComponentVisible ( "health", false )
--setPlayerHudComponentVisible ( "armor", false )
setPlayerHudComponentVisible ( "clock", false )

function parseEquippedWeapon ( weap, inv_slot, meele )
	currWeaponInventoryID = inv_slot
end

addEventHandler ( "onPlayerEquipWeapon", root, parseEquippedWeapon )