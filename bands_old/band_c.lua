local crouchingTimer = nil
local crouching = false

function updateCrouch ()
	if not isPedInVehicle ( localPlayer ) then 
		toggleControl ( "forwards", false )
		toggleControl ( "backwards", false )
		toggleControl ( "left", false )
		toggleControl ( "right", false )
		setTimer ( function () 
							local state = getPedMoveState ( localPlayer )
							--outputChatBox ( state )
							toggleControl ( "forwards", true )
							toggleControl ( "backwards", true )
							toggleControl ( "left", true )
							toggleControl ( "right", true )
							if state then
								if state == "crouch" then
									crouching = true
								else
									crouching = false
								end
							end
						end, 300, 1 )
	end
end
bindKey ( "crouch", "down", updateCrouch )

function playerBanditChasedC (bandID, shape, band )
	checkStillCrouching (bandID, shape, band)
end

addEvent( "playerBandChased", true )
addEventHandler( "playerBandChased", getRootElement(), playerBanditChasedC )

function checkStillCrouching (bandID, shape, band)
	local x,y,z = getElementPosition ( localPlayer )
	local ready = false
	for i,ped in ipairs(getElementsByType("ped")) do
		if getElementData(ped, "bandit") then
			local zx,zy,zz = getElementPosition (ped)
			local zfrontx, zfronty, zfrontz = getPositionInfrontOfElement(ped, 3)
			
			local vect1X, vect1Y =  zx-x, zy-z
			local vect2X, vect2Y = zfrontx-zx, zfronty - zy
			
			local scal = vect2X*vect1X+vect2Y*vect1Y
			
			local distance = getDistanceBetweenPoints3D ( x,y,z, zx,zy,zz )
			
			ready = true
			
			if ( crouching and scal <= 0 ) or ( not isLineOfSightClear ( zx,zy,zz+1.5, x,y,z+1.5 ) ) or ( crouching and distance > 30 ) then
				ready = false
			end
			if ready then
				if distance < 70 then
					if not getElementData ( localPlayer, 'perk23' ) then
						triggerServerEvent ( "chasedBandStartAttackC", getLocalPlayer(), getElementData ( ped, 'bandID'), band )
					end
					return true
				end
			end
		end
	end
end

setTimer ( checkStillCrouching, 2000, 0 )


function banditDamaged ( attacker, weapon, bodypart, loss )
	if getElementType ( source ) == "ped" then
		if getElementData (source, "bandit") then
			if attacker and attacker == localPlayer then
				cancelEvent()
				local weap = exports.cweap_jericho:getPlayerCurrentWeaponStats(attacker)
				if weap then loss = weap.damage
				else loss = 10 end
				if getElementData ( attacker, "perk4" ) then
					loss = loss+(loss/10)
				end
				triggerServerEvent ( "caseBanditDamageC", getLocalPlayer(), source, attacker, loss ) 
			end
		end
	end
end
addEventHandler ( "onClientPedDamage", getRootElement(), banditDamaged )

function noDamageToPlayersFromCustomWeapons(target)
    if getElementData(source,"cweap.owner") == localPlayer and getElementType ( target ) == "ped" and getElementData (target, "bandit") then
		local weap = exports.cweap_jericho:getPlayerCurrentWeaponStats(localPlayer)
		if weap then loss = weap.damage
		else loss = 10 end
		if getElementData ( localPlayer, "perk4" ) then
			loss = loss+(loss/10)
		end
		triggerServerEvent ( "caseBanditDamageC", getLocalPlayer(), target, localPlayer, loss ) 
    end
end
addEventHandler("onClientWeaponFire", root, noDamageToPlayersFromCustomWeapons)

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