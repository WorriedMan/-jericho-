addEvent("cweap:playWeaponReloadAnim", true)
addEventHandler("cweap:playWeaponReloadAnim",getRootElement(),function(anim)
	setPedAnimation (source,anim[1],anim[2],-1,false,true,false,false)
end)

function checkPlayerFireAllow ( player, name )
	local weap = name or getElementData ( player, "selectedWeapon" )
	if weap and weaponStats[weap] then
		toggleControl (player, "fire", false)
	else
		toggleControl (player, "fire", true)
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

local meeleWeapons = {
	["Кий"] = 7,
	["Бензопила"] = 9,
	["Лопата"] = 6,
	["Катана"] = 8,
	["Дубинка"] = 3,
	["Супердубина"] = 5,
}

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
		elseif dataName == "currentWeapon" then
			if oldValue then
				if isElement(playersBackWeaponObjects[source]) then
					destroyElement (playersBackWeaponObjects[source])
					playersBackWeaponObjects[source] = nil
				end
				for i, v in pairs (weaponID) do
					takeWeapon ( source, i )
				end
				setPedWeaponSlot ( source, 0 )
			end
			local weap = getPlayerCurrentWeaponStats (source)
			if weap and not weap.onehand then
				giveWeapon ( source, weap.id, 10, true )
			end
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
		if ( weaponID[currentWeaponID] ) then
			toggleControl ( source, 'fire', false )
		else
			toggleControl ( source, 'fire', true )
		end
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