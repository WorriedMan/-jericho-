addEvent("cweap:playWeaponReloadAnim", true)
addEventHandler("cweap:playWeaponReloadAnim",getRootElement(),function(anim)
	setPedAnimation (source,anim[1],anim[2],-1,false,true,false,false)
end)

local meeleWeapons = {
	["Кий"] = 7,
	["Бензопила"] = 9,
	["Лопата"] = 6,
	["Катана"] = 8,
	["Дубинка"] = 3,
	["Супердубина"] = 5,
}

function checkPlayerFireAllow ( player )
	checkPlayerFireAllowWithID(player,getPedWeapon ( player ))
end

function checkPlayerFireAllowWithID(player,weap_id)
	local weapon = getPlayerCurrentWeapon(player)
	local fireAllowed = exports.inventory:checkPlayerFireAllowed(player)
	if weapon and meeleWeapons[weapon] then
		toggleControl ( player, 'fire', fireAllowed )
	else
		if ( weaponID[weap_id] ) then
			toggleControl ( player, 'fire', false )
			setElementData(player,"fireAllowed",fireAllowed)
		else
			if weapon and weaponStats[weapon] and weaponStats[weapon].defaultweapon then
				--local ammo = exports.inventory:getItemAmountServer(player,weaponStats[weapon].ammo_id) or 0
				local ammo = getElementData(player,"currAmmoAmount") or 0
				if fireAllowed then
					fireAllowed = ammo > 0
				end
				toggleControl ( player, 'fire', fireAllowed )
			else	
				toggleControl ( player, 'fire', fireAllowed )
			end
		end
	end
end

function bindFireKeys ( )
	--bindKey (source,"mouse1", "down", fireCustomPedWeapon)
	--bindKey (source,"mouse1", "up", function (player) if getElementData ( player, "firing_weap" ) then setElementData (player, "firing_weap", false ) end end)
end
addEventHandler ( "onPlayerJoin", getRootElement(), bindFireKeys )


function fireCustomPedWeapon (player)
	local sel_weapon = getElementData ( player, "selectedWeapon" )
	if sel_weapon and weaponStats[sel_weapon] then
		if weaponStats[sel_weapon].shoot_fast or getControlState ( player, "aim_weapon" ) then
			triggerClientEvent("startFiringCustomPlWeapon", player, weaponStats[sel_weapon])
		end
	end
end

for i, v in ipairs ( getElementsByType ( "player" ) ) do
	--bindKey (v,"mouse1", "down", fireCustomPedWeapon)
	--bindKey (v,"mouse1", "up", function () if getElementData ( v, "firing_weap" ) then setElementData (v, "firing_weap", false ) end end)
end

function setFiringOnDataChange(dataName,oldValue)
	if getElementType(source) == "player" then
		--outputDebugString("data "..dataName.." changed: "..tostring(getElementData(source,dataName)))
		if dataName == "cweap.firing" then 
			local was_firing = getElementData ( source, "cweap.was_firing" )
			local state = getElementData ( source, "cweap.firing" )
			if state and not was_firing then
				setElementData ( source, "cweap.was_firing", true, false )
				triggerClientEvent ("startFiringCustomPlayerWeapon",source)
			elseif not state and was_firing then
				setElementData ( source, "cweap.was_firing", false, false )
				triggerClientEvent ("stopFiringCustomPlayerWeapon",source)
			end
		elseif dataName == "currAmmoAmount" then
			if not oldValue or getElementData(source,"currAmmoAmount") > oldValue then
				local weap = getPlayerCurrentWeaponStats (source)
				if weap and weap.defaultweapon then
					setWeaponAmmo ( source, weap.id, getElementData(source,"currAmmoAmount"), weap.clip )
					checkPlayerFireAllow(source)
				end
			end
		elseif dataName == "currentWeapon" then
			if oldValue then
				if isElement(playersBackWeaponObjects[source]) then
					destroyElement (playersBackWeaponObjects[source])
					playersBackWeaponObjects[source] = nil
				end
				takeAllWeapons(source)
				setPedWeaponSlot ( source, 0 )
			end
			local weap = getPlayerCurrentWeaponStats (source)
			if weap and not weap.onehand then
				if weap.defaultweapon then
					local ammo = exports.inventory:getItemAmountServer(source,weap.ammo_id) or 0
					if ammo == 0 then
						setElementData(source,"cweap.inclip",0)
					elseif ammo < weap.clip then
						setElementData(source,"cweap.inclip",ammo)
					else
						setElementData(source,"cweap.inclip",weap.clip)
					end
					giveWeapon(source,weap.id,ammo+1, true )
				else
					giveWeapon ( source, weap.id, 10, true )
				end
			end
			checkPlayerFireAllow ( source )
		elseif dataName == "meeleWeapon" then
			local new = getElementData ( source, dataName )
			if new then
				if meeleWeapons[new] then
					giveWeapon ( source, meeleWeapons[new], 1, true )
				end
			else
				if oldValue then
					if meeleWeapons[oldValue] then
						takeWeapon ( source, meeleWeapons[oldValue] )
					end
				end
			end
			checkPlayerFireAllow ( source )
		end
	end
end
addEventHandler("onElementDataChange",getRootElement(),setFiringOnDataChange)

playersBackWeaponObjects = {}

addEventHandler ( 'onPlayerWeaponSwitch', getRootElement ( ),
	function ( previousWeaponID, currentWeaponID )
		local weapon = getPlayerCurrentWeapon(source)
		toggleControl ( source, "action", false )
		if weaponModels[weapon] and weaponModels[weapon].id ~= currentWeaponID then
			local x,y,z = getElementPosition (source)
			local weap_back = createObject(weaponModels[weapon].model,x,y,z+2) 
			setElementCollisionsEnabled (weap_back,false)
			exports.bone_attach:attachElementToBone(weap_back,source,unpack(weaponModels[weapon].coords)) 
			playersBackWeaponObjects[source] = weap_back
		else
			if isElement (playersBackWeaponObjects[source]) then
				destroyElement (playersBackWeaponObjects[source])
			end
			playersBackWeaponObjects[source] = nil
		end
		triggerClientEvent ("playerChangedCustomWeapon",source,currentWeaponID,previousWeaponID)
		checkPlayerFireAllowWithID(source,currentWeaponID)
	end
)

function destroyBackWeaponOnQuit ()
	if isElement(playersBackWeaponObjects[source]) then
		destroyElement (playersBackWeaponObjects[source])
		playersBackWeaponObjects[source] = nil
	end
end

addEventHandler ( "onPlayerQuit", getRootElement(), destroyBackWeaponOnQuit )

function destroyBackWeaponOnDeath ()
	if isElement(playersBackWeaponObjects[source]) then
		destroyElement (playersBackWeaponObjects[source])
		playersBackWeaponObjects[source] = nil
	end
end

addEventHandler ( "onPlayerWasted", getRootElement(), destroyBackWeaponOnDeath )

function reloadWeapon()
	local weap = getPedWeapon ( client )
	local totalAmmo = getPedTotalAmmo ( client )
	if totalAmmo > 1 then
		if reloadPedWeapon(client) then
			checkPlayerFireAllow(client)
		end
	else
		return
	end
end
addEvent("relWep", true)
addEventHandler("relWep", resourceRoot, reloadWeapon)