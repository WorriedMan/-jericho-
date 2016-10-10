function fireWeapOnClientRender()

	for i, v in ipairs ( getElementsByType ("weapon", true) ) do
		if getElementData ( v, "cweap" ) then
			local owner = getElementData ( v, "cweap.owner" )
			if not isElement (owner) or not playersWeapons[owner] then
				destroyElement ( v )
			elseif getWeaponState (v,"firing") then
				local targetSuccess = false
				if not getPedControlState ( owner, "aim_weapon" ) then
					setWeaponState (v,"ready")
				else
					local aim = getElementData ( owner, "cweap.aim" )
					local pos = getElementData ( owner, "cweap.pos" )
					local sx, sy, sz = aim[1], aim[2], aim[3]
					--elemenet = v
					--aimx, aimy, aimz =  sx, sy, sz
					setElementPosition ( v, pos[1], pos[2], pos[3] )
					if sx and sy and sz then
						setWeaponTarget (v,sx, sy, sz)
						if playersWeapons[owner].element ~= v then
							destroyElement ( v )
							destroyPlayerWeapon ( owner )
						elseif getWeaponState (v,"firing") and ( not getElementData (owner, "cweap.firing" ) or not checkPlayerTargeting (owner) ) then
							setWeaponState (v,"ready")
						end
					end
				end
			end
		end
	end
end

addEventHandler('onClientRender', root, fireWeapOnClientRender )


function drawAimLine ()
	if isElement( elemenet) then
		local x,y,z = getElementPosition (elemenet )
		
		dxDrawLine3D (x,y,z,aimx, aimy, aimz)
	end
end


--addEventHandler('onClientRender', root, drawAimLine )

function destroyPlayerWeapon ( player )
	if playersWeapons[player] then
		if isElement ( playersWeapons[player].object ) then
			destroyElement ( playersWeapons[player].object )
		end
		if isElement ( playersWeapons[player].element ) then
			destroyElement ( playersWeapons[player].element )
		end
		playersWeapons[player] = nil
		return true
	end
	return false
end

function checkPlayerTargeting (player)
	if isElement ( player ) then
		local currentWeapon = getElementData ( player, "currentWeapon" )
		if currentWeapon and weaponStats[currentWeapon] then
			local aim = getPedControlState (player,"aim_weapon")
			if aim or weaponStats[currentWeapon].shoot_fast then
				return true
			end
		end
	end
	return false
end

function getPlayerTargetCoords(player)
	local startX,startY,startZ,targetX,targetY,targetZ
	--local boneX,boneY,boneZ = getPedBonePosition ( player, 25 )
	
	
	--local boneX,boneY,boneZ = getPedTargetStart(player) backup
	local boneX,boneY,boneZ = getElementPosition ( playersWeapons[localPlayer].element )
	
	
	--startX,startY,startZ = getPedWeaponMuzzlePosition ( player )
	startX,startY,startZ = getPedTargetEnd(player)
	--outputDebugString ( boneX .. " " .. boneY.. " "..boneZ .." "..startX.." "..startY.." "..startZ )
	if boneX and startX then
		-- if getPedControlState(source, "aim_weapon") then
			-- targetX, targetY, targetZ = getPedTargetEnd(source)
		-- else
			targetX,targetY,targetZ = extendLine ( boneX,boneY,boneZ,startX,startY,startZ,500 )
		--end
	end
	return targetX,targetY,targetZ
end

function recievedFireStart()
	startFiringManually ( source )
end

addEvent("startFiringCustomPlayerWeapon", true)
addEventHandler("startFiringCustomPlayerWeapon",getRootElement(),recievedFireStart )

function startFiringManually ( player )
	if playersWeapons[player] and playersWeapons[player].element and checkPlayerTargeting (player) and getPlayerAmmoAmount (player) > 0 then
		--local sx, sy, sz = getPedTargetEnd(player)
		local aim = getElementData ( player, "cweap.aim" )
		local sx, sy, sz = aim[1], aim[2], aim[3]
		if not sx then
			sx, sy, sz = getPedTargetEnd(player)
		end
		setWeaponTarget (playersWeapons[player].element,sx, sy,sz)
		setWeaponState(playersWeapons[player].element, "firing")
	end
end

function startFiringPressed ()
	if checkPlayerTargeting ( localPlayer ) and getPedMoveState ( localPlayer ) ~= "sprint" and getPedMoveState ( localPlayer ) ~= "fall" and checkPassedWeapon(getPedWeapon(localPlayer)) and getElementData(localPlayer,"fireAllowed") then
		setElementData ( localPlayer,"cweap.firing", true )
	end
end

bindKey ("fire", "down", startFiringPressed)
bindKey ("fire", "up", function () setElementData (localPlayer, "cweap.firing", false ) end)

function setPlayerTargetPos ()
	if getControlState ( "aim_weapon" ) then
		local weapon = getPedWeapon (localPlayer) 
		if checkPassedWeapon(weapon) then
			local x,y,z = getPlayerTargetCoords(localPlayer)
			local xp,yp,zp = getElementPosition ( playersWeapons[localPlayer].element )
			--outputChatBox(tostring(xp))
			setElementData ( localPlayer, "cweap.aim", {x,y,z} )
			setElementData ( localPlayer, "cweap.pos", {xp,yp,zp} )
		end
	end
end

setTimer ( setPlayerTargetPos, 200, 0 )

playersWeapons = {}

function playWeaponSound (config)
	local sound
	if config.dim then
		sound = playSound3D("sounds/"..config.folder.."/"..soundTypes[config.sound]..".wav",unpack(config.coords))
		setSoundMaxDistance ( sound, config.noise and 50*config.noise or 5 )
	else
		sound = playSound("sounds/"..config.folder.."/"..soundTypes[config.sound]..".wav")
	end
end

function createPlayerNewWeapon (player,weapname,toclip,currentWeaponID)
	local weap = weaponStats[weapname] 
	if weap then
		if weap.defaultweapon then return end
		local x,y,z = getElementPosition ( player )
		local weapon
		local weaponID = currentWeaponID or getPedWeapon(player)
		if not weap.onehand then
			weapon = createWeapon(weap.kind, x,y,z)
			--weapon = createWeapon(31, x,y,z)
			setElementData ( weapon, "cweap.owner", player )
			setElementData ( weapon, "cweap.inclip", toclip or getElementData (player, "cweap.inclip") or weap.clip )
			setElementData ( weapon, "cweap.clipsize", weap.clip )
			setElementData ( weapon, "cweap", weapname )
			setWeaponFlags (weapon,"disable_model",true)
			--colenb = setElementCollisionsEnabled(weapon, false)
			--outputChatBox("colenb "..tostring(colenb))
			setElementAlpha(weapon,0)
			
			exports.bone_attach:attachElementToBone(weapon,player,12,weap.offset.x-0.2, weap.offset.y, weap.offset.z, weap.object_offset.rx, weap.object_offset.ry, weap.object_offset.rz)
			
			if weap.fire_rate then
				setWeaponFiringRate ( weapon, weap.fire_rate )
			end
			for i, v in ipairs (weap.props) do
				local stat = v
				if i == "accuracy" and getElementData(player,"perk13") then
					stat = stat*1.1
					if stat > 1 then
						stat = 1
					end
				end
				setWeaponProperty ( weapon, i, stat )
			end
			
			setWeaponFlags (weapon, "shoot_if_out_of_range", true)
			setWeaponFlags (weapon, "shoot_if_blocked", true)
			setWeaponFlags (weapon, "instant_reload", true)
		end
		local obj = createObject ( weap.object,x,y,z )
		playersWeapons[player] = { element = weapon, name = weapname, object = obj } 
		setElementCollisionsEnabled(obj, false)
		exports.bone_attach:attachElementToBone(obj,player,12,weap.object_offset.x, weap.object_offset.y, weap.object_offset.z, weap.object_offset.rx, weap.object_offset.ry, weap.object_offset.rz)
		
	end
end

function createWeaponOnChange(currentWeaponID,previousWeaponID)
	if isElementStreamedIn ( source ) then
		if playersWeapons[source] then destroyPlayerWeapon ( source ) end
		local weap, wname = getPlayerCurrentWeaponStats ( source )
		if weap and not weap.onehand and weap.id == currentWeaponID then
			if source == localPlayer and not weap.defaultweapon then
				local curammo = getElementData (source,"currAmmoAmount") or 0
				if curammo > weap.clip then
					curammo = weap.clip
				end
				setElementData ( localPlayer, "cweap.inclip", curammo )
			end
			createPlayerNewWeapon (source,wname,curammo,currentWeaponID)
		end
	end
end

addEvent("playerChangedCustomWeapon", true)
addEventHandler("playerChangedCustomWeapon",getRootElement(),createWeaponOnChange )

function stopWeaponOnChange()
	if playersWeapons[source] then
		if not getWeaponState (playersWeapons[source].element) == "reloading" then setWeaponState (playersWeapons[source].element,"ready") end
	end
end

addEvent("stopFiringCustomPlayerWeapon", true)
addEventHandler("stopFiringCustomPlayerWeapon",getRootElement(),stopWeaponOnChange )

local fire_tick = getTickCount()

function forceAnimationOnReload()
	local owner = getElementData ( source, "cweap.owner" )
	if isElement ( owner ) then
		local ammocheck = 0
		local weap = getPlayerCurrentWeaponStats (owner)
		if weap and not weap.onehand then
			local x,y,z = getElementPosition ( source )
			if weap.disable_model then
				local _, _, rotation = getElementRotation(owner)
				local muzzlex, muzzley, muzzlez = x-math.sin(math.rad(rotation)) * 0.1,y+ math.cos(math.rad(rotation)) * 0.1,z+0.01
				--local marker = createMarker ( x,y,z, "corona", 4, 0, 0, 255, 255 )
				local corona = exports.custom_corona:createCorona(muzzlex, muzzley, muzzlez,0.1, 0, 0, 255, 255,false)
				setTimer (function () exports.custom_corona:destroyCorona(corona) end,100,1)
			end
			if owner == localPlayer and weap.camshake then
				createExplosion ( x,y,z + 10,12,false,weap.camshake,false)
			end
			playWeaponSound ({coords={x,y,z},dim = true, folder = weap.sound_folder,sound=1,noise = weap.noise})
			if not weap.noreload then			
				if getElementData ( source, "cweap.inclip" ) <= 1 then
					local anim
					if getPedTask ( owner, "secondary", 1 ) then
						anim = weap.reload_anim[2]
						-- if owner == localPlayer then
							-- setTimer (setControlState,1500,1,"crouch",true)
						-- end
					else
						anim = weap.reload_anim[1]
					end
					local ammo = getElementData (owner,"currAmmoAmount") or 0
					if ammo > weap.clip then ammo = weap.clip end
					if owner == localPlayer then
						setControlState ( "aim_weapon", false)
						--setTimer ( function () if keyPres kend, 1300, 1, "aim_weapon", true)
						setTimer (function () if getKeyState ("mouse1") then setControlState ("aim_weapon",true) end end,1800,1)
						--setTimer (function () outputChatBox (tostring(getKeyState("mouse1"))) if getKeyState ("fire") then setElementData ( localPlayer, "cweap.firing", true ) end end,2000,1)
						setTimer ( setElementData, 2000, 1, localPlayer, "cweap.reloading", false, false )
						--setTimer ( setElementData, 2000, 1, localPlayer, "cweap.firing", true )
						setTimer ( setElementData, 1500, 1, localPlayer, "cweap.inclip", ammo )
						triggerServerEvent ("cweap:playWeaponReloadAnim",localPlayer,anim)
						setElementData (localPlayer,"cweap.reloading",true,false)
						
						setElementData (localPlayer, "cweap.firing", false )
					end
					setTimer ( setElementData, 1500, 1, source, "cweap.inclip", ammo )
					--setTimer ( startFiringManually, 2000, 1, owner )
					playWeaponSound ({coords={x,y,z},dim = true, folder = weap.sound_folder,sound=2})
				else
					if owner == localPlayer then
						setElementData (localPlayer, "cweap.inclip", getElementData (source,"cweap.inclip") - 1 )
					end
					setElementData ( source, "cweap.inclip", getElementData (source,"cweap.inclip") - 1 ) 
				end
			end
		end
	end
end
addEventHandler("onClientWeaponFire", root, forceAnimationOnReload)

function reloadWeapon()
	local weap = getPlayerCurrentWeaponStats (localPlayer)
	if weap and not weap.onehand then
		if weap.clip > 1 and not weap.noreload then
			if not getElementData ( localPlayer, "cweap.reloading" ) then
				setElementData (localPlayer,"cweap.reloading",true,false)
				setTimer ( setElementData, 2000, 1, localPlayer, "cweap.reloading", false, false )
				if weap.defaultweapon then
					setTimer(reloadWeapon, 50, 1)
				elseif isElement(playersWeapons[localPlayer].element) then
					local anim
					if getPedTask ( localPlayer, "secondary", 1 ) then
						anim = weap.reload_anim[2]
					else
						anim = weap.reload_anim[1]
					end
					local ammo = getElementData (localPlayer,"currAmmoAmount") or 0
					if ammo > weap.clip then ammo = weap.clip end
					if getControlState("aim_weapon") then
						setControlState ( "aim_weapon", false)
						setTimer (function () if getKeyState ("mouse1") then setControlState ("aim_weapon",true) end end,1800,1)
					end
					setTimer ( setElementData, 1500, 1, localPlayer, "cweap.inclip", ammo )
					triggerServerEvent ("cweap:playWeaponReloadAnim",localPlayer,anim)
					setElementData (localPlayer, "cweap.firing", false )
					setTimer ( setElementData, 1500, 1, playersWeapons[localPlayer].element, "cweap.inclip", ammo )
				end
				playWeaponSound ({coords={getElementPosition ( localPlayer )},dim = true, folder = weap.sound_folder,sound=2})
			end
		end
	end
end
bindKey("r","down",reloadWeapon)

function onQuitGame()
	destroyPlayerWeapon(source)
end
addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )

function destroyWeaponOnDeath ()
	destroyPlayerWeapon(source)
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), destroyWeaponOnDeath ) 

addEventHandler( "onClientElementStreamIn", getRootElement( ),
    function ( )
        if getElementType( source ) == "player" and source ~= localPlayer then
			if not playersWeapons[source] then
				local weap, wname = getPlayerCurrentWeaponStats (source)
				if weap and not weap.onehand and not weap.defaultweapon then
					createPlayerNewWeapon (source,wname,getElementData(source,"cweap.inclip"))
				end
            end 
        end
    end
)

addEventHandler( "onClientElementStreamOut", getRootElement( ),
    function ( )
        if getElementType( source ) == "player" and source ~= localPlayer then
			destroyPlayerWeapon(source)
        end
    end
)

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName, old )
	if getElementType ( source ) == "player" and dataName == "currAmmoAmount" and playersWeapons[source] then
		local newamount = getPlayerAmmoAmount (source)
		if newamount <= 0 then
			if getWeaponState (playersWeapons[source].element) == "firing" then
				setWeaponState (playersWeapons[source].element,"ready")
			end
			setElementData (playersWeapons[source].element, "cweap.inclip",0)
		else
			if ( not old or old == 0 ) and newamount > 0 then
				local giveClip = newamount
				local clipSize = getElementData (playersWeapons[source].element,"cweap.clipsize") or 30
				if newamount > clipSize then
					giveClip = clipSize
				end
				setElementData (playersWeapons[source].element, "cweap.inclip",giveClip)
				if source == localPlayer then
					setElementData (localPlayer, "cweap.inclip",giveClip)
				end
			end
		end
	end
end )

function createFiringEffects()
	local owner = getElementData ( source,"cweap.owner" )
	if playersWeapons[owner].element == source then
		local xp,yp,zp = getElementPosition(source)
		local x,y,z = getPedTargetEnd(owner)
		local currentPosition = Vector3(xp,yp,zp)
		local targetPosition = Vector3(x,y,z)
		local direction = Vector3(x,y,z) - Vector3(xp,yp,zp)
		direction:normalize()
		--local effectFlash = createEffect ( "gunflash", xp,yp,zp-0.2 )
		--attachElements(effectFlash,playersWeapons[owner].object)
		--setTimer(function() destroyElement(effectFlash) end,2000,1)
		fxAddGunshot ( xp,yp,zp-0.2, direction )
    end
end
addEventHandler("onClientWeaponFire", root, createFiringEffects)

function defaultWeaponFire(weaponID)
	local wname = getPlayerCurrentWeapon(localPlayer)
	if wname then
		local stats = getWeaponStats(wname)
		if stats and stats.id == weaponID then
			local inclip = getPedAmmoInClip ( localPlayer )
			local ammo = exports.inventory:getItemAmount(stats.ammo_id)
			if ammo > 0 then
				if inclip == 0 then
					setElementData(localPlayer,"cweap.inclip",stats.clip)
				else
					setElementData(localPlayer,"cweap.inclip",getPedAmmoInClip(localPlayer))
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), defaultWeaponFire )

-- сделать ручную перезарядку на r