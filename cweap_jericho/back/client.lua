addEvent("startFiringCustomPlWeapon", true)
addEventHandler("startFiringCustomPlWeapon",getRootElement(),function(weap)
	outputChatBox ( "start fire "..tostring(weap.shoot_fast).." getControlState: "..tostring (getPedControlState ( source, "aim_weapon" )) )
	if ( weap.shoot_fast or getPedControlState ( source, "aim_weapon" ) ) then
		local x,y,z = getElementPosition ( source )
		local weaponReal = createWeapon(weap.kind, x,y,z)
		setElementAlpha(weaponReal,0)
		local atach = exports.bone_attach:attachElementToBone(weaponReal,localPlayer,12,0,0,0,0,0,0)
		outputChatBox (tostring ( atach ) )
		--attachElements ( weaponReal, getElementData ( source, "weaponModel" ), weap.offset.x, weap.offset.y, weap.offset.z )
		setWeaponFiringRate ( weaponReal, weap.fire_rate or 1 )
		for i, v in ipairs (weap.props) do
			setWeaponProperty ( weaponReal, "pro", i, v )
			setWeaponProperty ( weaponReal, "poor", i, v )
			setWeaponProperty ( weaponReal, "std", i, v )
		end
		setElementCollisionsEnabled(weaponReal, false)
		setElementData ( weaponReal, "owner", source )
		local aim_x,aim_y,aim_z = getPedTargetEnd ( source )
		setWeaponTarget(weaponReal, aim_x,aim_y,aim_z)
		fireWeapon ( weaponReal )
		setWeaponState(weaponReal, "firing")
		--outputChatBox ("weapon created ")
		--setElementPosition ( localPlayer, aim_x, aim_y, saim_z )
	end
end)


local laserWeapons = {}
function drawLasers()
	for k,player in ipairs(getElementsByType"player") do
		--local playerWeapon = getPedWeapon ( player )
		--if ( laserWeapons[playerWeapon] ) then
			local startX,startY,startZ,targetX,targetY,targetZ
			local boneX,boneY,boneZ = getPedBonePosition ( player, 25 )
			startX,startY,startZ = getPedWeaponMuzzlePosition ( player )
			if boneX and startX then
				if getPedControlState(player, "aim_weapon") then
					targetX, targetY, targetZ = getPedTargetEnd(player)
				else
					targetX,targetY,targetZ = extendLine ( boneX,boneY,boneZ,startX,startY,startZ - 0.1,500 )
				end
				
				local bool,hitX,hitY,hitZ = processLineOfSight ( startX,startY,startZ,targetX,targetY,targetZ, true, true, true, true, true, false, false, true )
				if not bool or not hitX then
					hitX,hitY,hitZ = targetX,targetY,targetZ
				end
				dxDrawLine3D ( startX,startY,startZ, hitX,hitY,hitZ, tocolor(255,0,0,50), 1, false, 1 )
			end
		--end
	end
end

function extendLine ( x,y,z,x2,y2,z2,length )
	local vx = x2 - x
	local vy = y2 - y
	local vz = z2 - z
	local ratio = length/(getDistanceBetweenPoints3D ( x,y,z,x2,y2,z2 ))
	vx = vx*ratio
	vy = vy*ratio
	vz = vz*ratio
	return (x + vx),(y + vy),(z + vz)
end

--addEventHandler("onClientRender",getRootElement(),drawLasers)

function fireWeapOnClientRender()
	for i, v in ipairs ( getElementsByType ("weapon", true) ) do
		if getElementData ( v, "cweap" ) then
			local owner = getElementData ( v, "cweap.owner" )
			local targetSuccess = false
			local sx, sy, sz = getPedTargetEnd(owner)
			setWeaponTarget (v,sx, sy, 10)
			setWeaponState (v,"firing")
			if not isElement (owner) or not playersWeapons[owner] then
				--playersWeapons[owner] = nil
				--destroyElement ( v )
			elseif playersWeapons[owner].element ~= v then
				--destroyElement ( playersWeapons[owner].element )
				--destroyElement ( v )
				--playersWeapons[owner] = nil
			elseif getWeaponState (v,"firing") and ( not getElementData (owner, "cweap.firing" ) or not checkPlayerTargeting (owner) ) then
				--setWeaponState (v,"ready")
			end
		end
	end
end

--setTimer (fireWeapOnClientRender,1000,0)

addEventHandler('onClientRender', root, fireWeapOnClientRender )

function checkPlayerTargeting (player)
	if isElement ( player ) then
		local currentWeapon = getElementData ( player, "currentWeapon" )
		if currentWeapon and weaponStats[currentWeapon] then
			local aim = getPedControlState (player,"aim_weapon")
			if ( not aim and not weaponStats[currentWeapon].shoot_fast ) or aim then
				return true
			end
		end
	end
	return false
end

function getPlayerCurrentWeaponStats (player)
	if isElement ( player ) then
		local currentWeapon = getElementData ( player, "currentWeapon" )
		if currentWeapon and weaponStats[currentWeapon] then
			return weaponStats[currentWeapon], currentWeapon
		end
	end
	return false
end

function recievedFireStart()
	outputChatBox ( tostring ( playersWeapons[source] ))
	if playersWeapons[source].element then
		local sx, sy, sz = getPedTargetEnd(source)
		
		outputChatBox ("SZ "..sz)
			local startX,startY,startZ,targetX,targetY,targetZ
			local boneX,boneY,boneZ = getPedBonePosition ( source, 25 )
			startX,startY,startZ = getPedWeaponMuzzlePosition ( source )
			if boneX and startX then
				if getPedControlState(source, "aim_weapon") then
					targetX, targetY, targetZ = getPedTargetEnd(source)
				else
					targetX,targetY,targetZ = extendLine ( boneX,boneY,boneZ,startX,startY,startZ - 0.1,500 )
				end
			end
			local targ = setWeaponTarget (playersWeapons[source].element,sx, sy, 10)
			outputChatBox ( "taarg: "..tostring ( targ ) )
		setWeaponState(playersWeapons[source].element, "firing")
		--	setWeaponState(playersWeapons[source].element, "ready")
		--fiire = fireWeapon (playersWeapons[source].element)
		--	outputChatBox ( "fiire: "..tostring ( fiire ) )
		--setTimer(setWeaponState,1000,1,playersWeapons[source].element, "firing")
	end
end

addEvent("startFiringCustomPlayerWeapon", true)
addEventHandler("startFiringCustomPlayerWeapon",getRootElement(),recievedFireStart )

function cancelPedDamage ( attacker )
	outputChatBox ( " hit by "..tostring (attacker) )
end
addEventHandler ( "onClientPedDamage", getRootElement(), cancelPedDamage )

function noDamageToPlayersFromCustomWeapons(target)
    local owner = getElementData ( source, "owner" )
	if isElement ( owner ) and owner == localPlayer then
		local ammoName,_ = exports.dayz:getWeaponAmmoType2(weapon,getElementData(localPlayer,"currentweapon_1"),getElementData(localPlayer,"currentweapon_2"),getElementData(localPlayer,"currentweapon_3"))
        outputChatBox ( tostring ( ammoName ) )
		if getElementData(getLocalPlayer(),ammoName) > 0 then
            setElementData(getLocalPlayer(),ammoName,getElementData(getLocalPlayer(),ammoName)-1)
        end
	end
end
--addEventHandler("onClientWeaponFire", root, noDamageToPlayersFromCustomWeapons)

function checkFiring ()
	if not getKeyState ("fire") then
		setElementData (localPlayer,"cweap.firing", false)
		removeEventHandler('onClientRender', root, checkFiring )
	end
end

function startFiringPressed ()
	setElementData ( localPlayer,"cweap.firing", true )
	--addEventHandler('onClientRender', root, checkFiring )
end

bindKey ("fire", "down", startFiringPressed)
bindKey ("fire", "up", function () setElementData (localPlayer, "cweap.firing", false ) end)

--toggleControl ("fire",false)

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName )
	if getElementType ( source ) == "player" and dataName == "cweap.firing" then
		--outputChatBox ( getPlayerName(source).."'s new score is "..getElementData (source, "test").."!" )
	end
end )


fireLines={}
function noDamageToPlayersFromCustomWeapons(target,x,y,z)
    --if target == localPlayer then
		table.insert(fireLines,{x,y,z,getPedWeaponMuzzlePosition ( getElementData(source,"cweap.owner"))})
   -- end
end
addEventHandler("onClientWeaponFire", root, noDamageToPlayersFromCustomWeapons)

addEventHandler("onClientPreRender", root,  -- Adds the Handler
    function ()
		for i,v in ipairs (fireLines) do
			-- dxDrawLine3D ( v[1],v[2],v[3],v[4],v[5],v[6], tocolor (255,0,0), 5 )
		end
      --  if getPedTargetStart(localPlayer) then --Checks if there is a Point to start From.
 
--        local x, y, z = getPedTargetStart(localPlayer) -- Gets the Point to start From
    --    local sx, sy, sz = getPedTargetEnd(localPlayer) -- Gets the Point where the Target Ends
 
        --dxDrawLine3D(x, y, z, sx, sy, sz) -- Draws the Line
   -- end
end
)

playersWeapons = {}

function createWeaponOnChange(currentWeaponID,previousWeaponID)
	if isElementStreamedIn ( source ) then
		if playersWeapons[source] then destroyElement (playersWeapons[source].element) playersWeapons[source] = nil end
		local weap, wname = getPlayerCurrentWeaponStats ( source )
		if weap then
			local x,y,z = getElementPosition ( source )
			local weapon = createWeapon(weap.kind, x,y,z)
			playersWeapons[source] = { element = weapon, name = wname } 
			setElementData ( weapon, "cweap.owner", source )
			setElementData ( weapon, "cweap", true )
			--setWeaponProperty( weapon, "fire_rotation", 0, -8, -1.3 )
			--setWeaponProperty( weapon, "fire_rotation", 0, 0, -3.5 )
			--local obj = createObject ( 352,x,y,z )
			--setElementAlpha(weaponReal,0)
			exports.bone_attach:attachElementToBone(weapon,source,12,weap.offset.x, weap.offset.y, weap.offset.z,weap.offset.rx, weap.offset.ry, weap.offset.rz)
			--exports.bone_attach:attachElementToBone(obj,source,12,0,0,0,0,0,0)
			--attachElements ( weaponReal, getElementData ( source, "weaponModel" ), weap.offset.x, weap.offset.y, weap.offset.z )
			-- setWeaponFiringRate ( weaponReal, weap.fire_rate or 1 )
			-- for i, v in ipairs (weap.props) do
				-- setWeaponProperty ( weaponReal, "pro", i, v )
				-- setWeaponProperty ( weaponReal, "poor", i, v )
				-- setWeaponProperty ( weaponReal, "std", i, v )
			-- end
			-- setElementCollisionsEnabled(weaponReal, false)
			-- setElementData ( weaponReal, "owner", source )
			-- local aim_x,aim_y,aim_z = getPedTargetEnd ( source )
			-- setWeaponTarget(weaponReal, aim_x,aim_y,aim_z)
			--fireWeapon ( weapon )
			setWeaponAmmo ( weapon, 99999 )
	setWeaponProperty ( weapon, "weapon_range", 150 )
	setWeaponProperty ( weapon, "target_range", 150 )
	setElementCollisionsEnabled(weapon, false)
			--setWeaponState(weapon, "ready")
			--outputChatBox ("weapon created ")
			--setElementPosition ( localPlayer, aim_x, aim_y, saim_z )
		end
	end
end

addEvent("playerChangedCustomWeapon", true)
addEventHandler("playerChangedCustomWeapon",getRootElement(),createWeaponOnChange )


--Thank you, but my problem is not that I can't get target position. The problem is that I can't set this target position for custom weapon, because setWeaponTarget (v,sx, sy, sz) cancels weapon firing, and "fire_rotation" property 