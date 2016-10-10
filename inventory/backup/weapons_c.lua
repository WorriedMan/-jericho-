currWeapon = 0
currWeaponHand = false
currAmmo = 0
currAmmoAmount = 0
currAmmoInvSlot = 0
currAmmoInvID = 0 
currWeaponInventoryID = 0

ammoToShell = {
	['46'] = 62,
	['42'] = 63,
	['44'] = 65,
	['45'] = 64,
	['47'] = 66,
	['48'] = 67,
	['111'] = 112,
	['118'] = 119,
}

function takeInventoryWeapon ()
	triggerServerEvent ( "takePlayerCustomWeaponC", localPlayer )
	setElementData ( localPlayer, "weaponSelected", false )
	setElementData ( localPlayer, "meeleWeapon", false )
	currWeapon = 0
	currAmmo = 0
	currAmmoAmount = 0
	currAmmoInvSlot = 0
	currAmmoInvID = 0 
	setElementData ( localPlayer, "currAmmoAmount", 0 )
end

addEvent( "takeInventoryWeaponS", true )
addEventHandler( "takeInventoryWeaponS", getRootElement(), takeInventoryWeapon )

function equipAK ()
	if currWeapon == 30 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 30
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 30, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 25 ) then equipAmmoAUTO () end
	end
end

function equipLASER ()
	if currWeapon == 22 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 22
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 22, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 118 ) then equipAmmoLASER () end
	end
end

function equipFlamethrower ()
	if currWeapon == 37 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 37
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 37, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 111 ) then equipFlameAmmo () end
	end
end

function equipFlameAmmo ()
	local slot = getPlayerItemByID ( 111 )
	if slot then
		if currWeapon == 37 then
			currAmmo = 37
			currAmmoInvID = 111
			currAmmoAmount = getItemAmountOld ( 111 )*50+1
			setElementData ( localPlayer, "currAmmoAmount", getItemAmountOld ( 111 )*50+1 )
			triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, 37, getItemAmountOld ( 111 )*50+1, false )
			removePlayerItem ( 111, 1 )
			givePlayerItem ( 112, 1 )
			currAmmoInvSlot = slot
			if not getElementData ( localPlayer, "safezone.id" ) then
				setElementData ( localPlayer, 'fireAllowed', true)
			end
		end
	end
end

function equipAmmoAUTO ()
	local slot = getPlayerItemByID ( 25 )
	if slot then
		if currWeapon == 30 then
			currAmmo = 30
			currAmmoInvID = 25
			currAmmoAmount = getItemAmountOld ( 25 )
			setElementData ( localPlayer, "currAmmoAmount", getItemAmountOld ( 25 ) )
			triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, 30, getItemAmountOld ( 25 ), false )
			currAmmoInvSlot = slot
			if not getElementData ( localPlayer, "safezone.id" ) then
				setElementData ( localPlayer, 'fireAllowed', true)
			end
		end
	end
end

function equipAmmoLASER ()
	local slot = getPlayerItemByID ( 118 )
	if slot then
		if currWeapon == 22 then
			currAmmo = 22
			currAmmoInvID = 118
			currAmmoAmount = getItemAmountOld ( 118 )
			setElementData ( localPlayer, "currAmmoAmount", getItemAmountOld ( 118 ) )
			triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, 22, getItemAmountOld ( 118 ), false )
			currAmmoInvSlot = slot
			if not getElementData ( localPlayer, "safezone.id" ) then
				setElementData ( localPlayer, 'fireAllowed', true)
			end
		end
	end
end

function equipPoolCue ()
	if currWeapon == 7 then
		takeInventoryWeapon ()
		setElementData ( localPlayer, "meeleWeapon", false )
	else
		currWeaponHand = true
		currWeapon = 7
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 7, true )
		setElementData ( localPlayer, "meeleWeapon", true )
		setElementData ( localPlayer, "weaponSelected", true )
		if not getElementData ( localPlayer, "safezone.id" ) then
			setElementData ( localPlayer, 'fireAllowed', true)
		end
	end
end

function equipSledge ()
	if currWeapon == 5 then
		takeInventoryWeapon ()
		setElementData ( localPlayer, "meeleWeapon", false )
	else
		currWeaponHand = true
		currWeapon = 5
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 5, true )
		setElementData ( localPlayer, "meeleWeapon", true )
		setElementData ( localPlayer, "weaponSelected", true )
		if not getElementData ( localPlayer, "safezone.id" ) then
			setElementData ( localPlayer, 'fireAllowed', true)
		end
	end
end

function equipBaton ()
	if currWeapon == 3 then
		takeInventoryWeapon ()
		setElementData ( localPlayer, "meeleWeapon", false )
	else
		currWeaponHand = true
		currWeapon = 3
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 3, true )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, "meeleWeapon", true )
		if not getElementData ( localPlayer, "safezone.id" ) then
			setElementData ( localPlayer, 'fireAllowed', true)
		end
	end
end

function equipKatana ()
	if currWeapon == 8 then
		takeInventoryWeapon ()
		setElementData ( localPlayer, "meeleWeapon", false )
	else
		currWeaponHand = true
		currWeapon = 8
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		setElementData ( localPlayer, "meeleWeapon", true )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 8, true )
		setElementData ( localPlayer, "weaponSelected", true )
		if not getElementData ( localPlayer, "safezone.id" ) then
			setElementData ( localPlayer, 'fireAllowed', true)
		end
	end
end

function equipShovel ()
	if currWeapon == 6 then
		takeInventoryWeapon ()
		setElementData ( localPlayer, "meeleWeapon", false )
	else
		currWeaponHand = true
		currWeapon = 6
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 6, true )
		setElementData ( localPlayer, "meeleWeapon", true )
		setElementData ( localPlayer, "weaponSelected", true )
		if not getElementData ( localPlayer, "safezone.id" ) then
			setElementData ( localPlayer, 'fireAllowed', true)
		end
	end
end

function equipChanSaw ()
	if currWeapon == 9 then
		takeInventoryWeapon ()
		setElementData ( localPlayer, "meeleWeapon", false )
	else
		currWeaponHand = true
		currWeapon = 9
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		setElementData ( localPlayer, "meeleWeapon", true )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 9, true )
		setElementData ( localPlayer, "weaponSelected", true )
		if not getElementData ( localPlayer, "safezone.id" ) then
			setElementData ( localPlayer, 'fireAllowed', true)
		end
	end
end

function equipM4 ()
	if currWeapon == 31 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 31
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 31, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 48 ) then equipM4Am () end
	end
end

function equipMinigun ()
	if currWeapon == 38 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 38
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 38, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 48 ) then equipM4Am () end
	end
end

function equipM4Am ()
	local slot = getPlayerItemByID ( 48 )
	if slot then
		if currWeapon == 31 or currWeapon == 38 then
			currAmmo = currWeapon
			currAmmoInvID = 48
			currAmmoAmount = getItemAmountOld ( 48 )
			setElementData ( localPlayer, "currAmmoAmount", inventory[slot][2] )
			triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, currWeapon, inventory[slot][2], false )
			currAmmoInvSlot = slot
			if not getElementData ( localPlayer, "safezone.id" ) then
				setElementData ( localPlayer, 'fireAllowed', true)
			end
		end
	end
end

function equipMP5 ()
	if currWeapon == 29 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 29
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 29, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 45 ) then equipDesertAm () end
	end
end

function equipDesert ()
	if currWeapon == 24 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 24
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 24, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 45 ) then equipDesertAm () end
	end
end

function equipDesertAm ()
	local slot = getPlayerItemByID ( 45 )
	if slot then
		if currWeapon == 24 or currWeapon == 29 then
			currAmmo = currWeapon
			currAmmoInvID = 45
			currAmmoAmount = getItemAmountOld ( 45 )
			setElementData ( localPlayer, "currAmmoAmount", inventory[slot][2] )
			triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, currWeapon, inventory[slot][2], false )
			currAmmoInvSlot = slot
			if not getElementData ( localPlayer, "safezone.id" ) then
				setElementData ( localPlayer, 'fireAllowed', true)
			end
		end
	end
end

function equipSawed ()
	if currWeapon == 26 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 26
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 26, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 46 ) then equipShotAm () end
	end
end

function equipCShot ()
	if currWeapon == 27 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 27
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 27, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 46 ) then equipShotAm () end
	end
end

function equipShotgun ()
	if currWeapon == 25 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 25
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 25, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 46 ) then equipShotAm () end
	end
end

function equipShotAm ()
	local slot = getPlayerItemByID ( 46 )
	if slot then
		if currWeapon == 25 or currWeapon == 26 or currWeapon == 27 then
			currAmmo = currWeapon
			currAmmoInvID = 46
			currAmmoAmount = getItemAmountOld ( 46 )
			setElementData ( localPlayer, "currAmmoAmount", getItemAmountOld ( 46 ) )
			triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, currWeapon, getItemAmountOld ( 46 ), false )
			currAmmoInvSlot = slot
			if not getElementData ( localPlayer, "safezone.id" ) then
				setElementData ( localPlayer, 'fireAllowed', true)
			end
		end
	end
end

function equipCommonPistol ()
	if currWeapon == 22 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 22
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 22, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 44 ) then equipPistolAm () end
	end
end

function equipSilenced ()
	if currWeapon == 23 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 23
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 23, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 44 ) then equipPistolAm () end
	end
end

function equipPistolAm ()
	local slot = getPlayerItemByID ( 44 )
	if slot then
		if currWeapon == 22 or currWeapon == 23 then
			currAmmo = currWeapon
			currAmmoInvID = 44
			currAmmoAmount = getItemAmountOld ( 44 )
			setElementData ( localPlayer, "currAmmoAmount", getItemAmountOld ( 44 ) )
			triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, currWeapon, getItemAmountOld ( 44 ), false )
			currAmmoInvSlot = slot
			if not getElementData ( localPlayer, "safezone.id" ) then
				setElementData ( localPlayer, 'fireAllowed', true)
			end
		end
	end
end

function equipSniper ()
	if currWeapon == 34 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 34
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 34, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 42 ) then equipSnipAm () end
	end
end

function equipRifle ()
	if currWeapon == 33 then
		takeInventoryWeapon ()
	else
		currWeaponHand = false
		currWeapon = 33
		currAmmo = 0
		currAmmoAmount = 0
		currAmmoInvSlot = 0
		currAmmoInvID = 0
		triggerEvent ( "onPlayerEquipWeapon", localPlayer, currWeapon, curr_inv_slot, currWeaponHand )
		triggerServerEvent ( "givePlayerCustomWeaponC", localPlayer, 33, false )
		setElementData ( localPlayer, "weaponSelected", true )
		setElementData ( localPlayer, 'fireAllowed', false)
		if getPlayerItemByID ( 42 ) then equipSnipAm () end
	end
end

function equipSnipAm ()
	local slot = getPlayerItemByID ( 42 )
	if slot then
		if currWeapon == 33 or currWeapon == 34 then
			currAmmo = currWeapon
			currAmmoInvID = 42
			currAmmoAmount = getItemAmountOld ( 42 )
			setElementData ( localPlayer, "currAmmoAmount", getItemAmountOld ( 42 ) )
			triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, currWeapon, getItemAmountOld ( 42 ), false )
			currAmmoInvSlot = slot
			if not getElementData ( localPlayer, "safezone.id" ) then
				setElementData ( localPlayer, 'fireAllowed', true)
			end
		end
	end
end

weaponReduceOnFire = {
	['24'] = 0.1, -- китайский автомат
	['26'] = 3, -- кий
	['27'] = 1, -- бензопила
	['28'] = 3, -- лопата
	['29'] = 0.1, -- катана
	['30'] = 0.05, -- винтовка
	['31'] = 0.1, -- бесшумный
	['32'] = 0.5, -- снайперская винтовка
	['33'] = 0.1, -- шотган
	--['33'] = 5, -- шотган
	['34'] = 0.2, -- 10 мм пистолет
	['35'] = 0.1, -- 10 мм смг
	['36'] = 0.07, -- американская винтовка
	['37'] = 1, -- дубинка
	['38'] = 0.1, -- боевой шотган
	['39'] = 0.0001, -- горбомет - 1
	['40'] = 0.1, -- обрез
	['41'] = 0.5, -- супердубина
	['117'] = 0.05, -- лазерный пистолет

}

function fireFailed ()
	playSound ( 'sound/jam.ogg' )
	setControlState  ( 'fire', false )
	exports.pipboy:addInfoBox ( 'Оружие заклинило, перезарядите его, нажав на кнопку R', 3 )
end


addEvent( "fireFail", true )
addEventHandler( "fireFail", getRootElement(), fireFailed )

shootedPatrons = 0

function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	if source == localPlayer then
		if getElementData ( localPlayer, "inarena" ) == 0 and getElementData ( localPlayer, "indmzone" ) == 0 then
			if weapon == currWeapon then
				if not getKeyState ( "mouse1" ) then
					setControlState ( "fire", false )
				end
				if getKeyState ( "tab" ) then
					setControlState ( "fire", false )
				end
				if weapon ~= 37 then
					if currAmmoAmount == 1 then
						setElementData ( localPlayer, 'fireAllowed', false)
					end
					if getElementData ( localPlayer, 'fireFail' ) then
					--	fireFailed ()
					--	setControlState  ( 'fire', false )
					--	setElementData ( localPlayer, 'fireFail', false )
						triggerServerEvent ( 'fireJamHappen', localPlayer )
					elseif math.random ( 1, 70 ) == 1 then
						if weapon > 10 then
							setElementData ( localPlayer, 'fireFail', true )
						end
					end
					currAmmoAmount = currAmmoAmount-1
					inventory[currAmmoInvSlot][2] = currAmmoAmount
					setElementData ( localPlayer, "currAmmoAmount", currAmmoAmount )
					reduceItemHealth ( currWeaponInventoryID, weaponReduceOnFire[tostring(inventory[currWeaponInventoryID][1])] or 0.01, 1 )
					if ammoToShell [tostring(currAmmoInvID)] then
						givePlayerItem ( ammoToShell [tostring(currAmmoInvID)], 1, true )
					end
				else
					shootedPatrons = shootedPatrons+1
					currAmmoAmount = currAmmoAmount-1
					setElementData ( localPlayer, "currAmmoAmount", currAmmoAmount )
					if shootedPatrons >= 50 then
						removePlayerItem ( 111, 1 )
						givePlayerItem ( 112, 1 )
						shootedPatrons = 0
					end
				end
			else
				cancelEvent()
			end
		end
	end
end

addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc )

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

function disableMinigunOnSwitch ( prevSlot, newSlot )
	if source == localPlayer then
		if not getElementData ( localPlayer, "safezone.id" ) and getElementData ( localPlayer, "inarena" ) == 0 and getElementData ( localPlayer, "indmzone" ) == 0 then
			if newSlot == 1 or newSlot == 0 or newSlot == 10 or newSlot == 11 then
				setElementData ( localPlayer, 'fireAllowed', true)
			else
				if currAmmoAmount == 0 then
					setElementData ( localPlayer, 'fireAllowed', false)
				else
					setElementData ( localPlayer, 'fireAllowed', true)
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), disableMinigunOnSwitch )
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), takeInventoryWeapon )

bindKey( 'mouse1', 'both', function( key, state )
  toggleControl( 'action', (state == "down" and false or true) )
end )

addEvent ( "onPlayerEquipWeapon", true )

function parseEquippedWeapon ( weap, inv_slot, meele )
	currWeaponInventoryID = inv_slot
end

addEventHandler ( "onPlayerEquipWeapon", root, parseEquippedWeapon )