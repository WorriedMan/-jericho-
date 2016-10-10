function zombiedamaged ( attacker, weapon, bodypart, loss )
	if getElementData(source,"shZ") then return end -- гули по квесту "Вижу землю!"
	if getElementType ( source ) == "ped" and getElementData(source,"class") then
		if attacker then
			if getElementType ( attacker ) == "vehicle" then
				cancelEvent()
				return true
			end
			--if getElementData (source, "zombie") or getElementData (source, "arenaZombie") then
				cancelEvent()
				-- if ( bodypart == 9 ) then
					-- if not getElementData ( source, "zombieBoom" ) and not getElementData ( source, "zombieFast" ) and not getElementData ( source, "zombieRad" ) and not getElementData ( source, "arenaZ" ) then
						-- triggerServerEvent ("headboom", source, source, attacker, weapon, bodypart )
						-- return true
					-- end
				-- end
				if attacker == localPlayer then
					local weap = exports.cweap_jericho:getPlayerCurrentWeaponStats(attacker)
					if weap then loss = weap.damage
					else loss = 10 end
					if weapon == 0 then
						loss = 10 + getElementData(attacker,"rplvl")
						if getElementData(attacker,"perk14") then
							loss = loss*2
						end
					end
					if weapon >= 0 and weapon <= 9 then
						loss = loss+getElementData ( localPlayer, 'strenght' )*3+getElementData ( localPlayer, 'tempstrenght' )*3
						if getElementData ( localPlayer, "perk32" ) then
							if math.random ( 1, 100 ) < 8 then
								loss = loss*5
							end
						end
					elseif weapon ~= 37 then
						loss = loss+getElementData ( attacker, 'accuracy' )*2
					end
					if getElementData ( attacker, "perk4" ) then
						loss = loss+loss*0.1
					end
					--outputChatBox('ped damage '..tostring(loss).." "..tostring(weap.damage).." "..tostring(weapon))
					triggerServerEvent ( "casePedDamage", getLocalPlayer(), source, attacker, loss, getElementData(source,"health") ) 
				elseif getElementType(attacker) == "ped" and ( getElementData(source,"class") or "ped" ) ~= ( getElementData(attacker,"class") or "ped" ) then
					local damage = getElementData(attacker,"zDamage") or 10
					local weapon = getElementData(attacker,"customped:weapon_name")
					if weapon then
						damage = exports.cweap_jericho:getWeaponStats(weapon).damage+2*(getElementData(attacker,"accuracy_stat") or 0)
					end
					triggerServerEvent ( "casePedDamage", getLocalPlayer(), source, attacker, damage, getElementData(source,"health") ) 					
				end
			--end
		else
			cancelEvent()
		end
	end
end
addEventHandler ( "onClientPedDamage", getRootElement(), zombiedamaged )

function noDamageToPlayersFromCustomWeapons(target)
    if target and getElementData(source,"cweap.owner") == localPlayer and getElementType ( target ) == "ped" and getElementType ( target ) ~= "player" then
		local weap = exports.cweap_jericho:getPlayerCurrentWeaponStats(localPlayer)
		if weap then loss = weap.damage
		else loss = 10 end
		loss = loss+getElementData ( localPlayer, 'accuracy' )*2+getElementData ( localPlayer, 'tempaccuracy' )*2
		if getElementData ( localPlayer, "perk4" ) then
			loss = loss+(loss/10)
		end
		triggerServerEvent ( "casePedDamage", getLocalPlayer(), target, localPlayer, loss, getElementData(source,"health") ) 
    end
end
addEventHandler("onClientWeaponFire", root, noDamageToPlayersFromCustomWeapons)

function checkStillCrouching ()
	local x, y, z = getElementPosition( localPlayer )
	for i,ped in ipairs(getElementsByType("ped",getResourceRootElement())) do
		if not getElementData(ped,"target") then
			if getElementData(ped,"customped:aggresive") then
				local class = getElementData(ped, "class")
				local zx,zy,zz = getElementPosition (ped)
				local zfrontx, zfronty, zfrontz = getPositionInfrontOfElement(ped, 3)
				local crouching = getPedMoveState ( localPlayer ) == "crawl" or getPedMoveState ( localPlayer ) == "crouch"
				local visioncheck = getElementData(ped,"customped:visioncheck")
				local vect1X, vect1Y =  zx-x, zy-z
				local vect2X, vect2Y = zfrontx-zx, zfronty - zy
				
				local scal = vect2X*vect1X+vect2Y*vect1Y
				
				local distance = getDistanceBetweenPoints3D ( x,y,z, zx,zy,zz )

				local ready = true
				
				if ( ( crouching or getElementData ( localPlayer, "perk31" ) ) and scal <= 0 and visioncheck ) or ( not isLineOfSightClear ( zx,zy,zz+1.5, x,y,z+1.5 ) ) or ( ( crouching or getElementData ( localPlayer, "perk31") ) and distance > 20 ) or ( getElementAlpha ( localPlayer ) < 255 and visioncheck ) then
					ready = false
				end
				
				if ready then
					if distance < 70 then
						if class == "mutant" or class == "zombie" or class == "robot" then
							triggerServerEvent ( "chasedStartAttackC", getLocalPlayer(), ped )
							return
						elseif class == "boss" then
							triggerServerEvent ( "chasedBossStartAttackC", getLocalPlayer(), ped )
							return
						elseif class == "band" then
							triggerServerEvent ( "chasedBandStartAttackC", getLocalPlayer(), ped )
							return
						end
					end
				end
				-- if class == "zombie" then
					-- for k, bandit in ipairs(getElementsByType("ped",getResourceRootElement(peds))) do
						-- local nz_x, nz_y, nz_z = getElementPosition(bandit)
						-- if getDistanceBetweenPoints3D(nz_x, nz_y, nz_z, zx, zy, zz) < 20 and getElementData(bandit,"class") == "band" then
							-- if isLineOfSightClear ( zx,zy,zz+0.5, nz_x, nz_y, nz_z+0.5, true, true, false ) then
								--triggerServerEvent ( "chasedStartAttackC", bandit, ped )
								-- return
							-- end
						-- end
					-- end			
				-- end			
			end
		end
	end
end

setTimer(checkStillCrouching, 2000, 0)

function getPositionInfrontOfElement(element, meters)
    if not element or not isElement(element) then
        return false
    end
    if not meters then
        meters = 3
    end
    local posX, posY, posZ = getElementPosition(element)
    local _, _, rotation = getElementRotation(element)
    posX = posX - math.sin(math.rad(rotation)) * meters
    posY = posY + math.cos(math.rad(rotation)) * meters
    return posX, posY, posZ
end