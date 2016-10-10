local localPlayer = getLocalPlayer ()
local killerTimer = nil

armorStats = {
	5,
	15,
	5, 
	22,
	1,
	1,
	25,
	1,
}

weaponsDamage = {}

addEvent ( "weaponsDamageSendClient", true )

function recieveWeaponsDamage ( dmgTable )
	weaponsDamage = dmgTable
end

addEventHandler ( "weaponsDamageSendClient", root, recieveWeaponsDamage )

function noDamageToPlayersFromCustomWeapons(target,posX, posY, posZ, normalX, normalY, normalZ, materialType, lighting, pieceHit)
    if target and target == localPlayer then
		if exports.safezones:getPlayerZoneConfig(localPlayer).noFight then
			if isElement(getElementData(source,"cweap.owner")) then
				triggerServerEvent("players:stopSafezoneDamage", getElementData(source,"cweap.owner") )
			end
			return true
		end
        --cancelEvent()
		checkPlayerDamageDealt(getElementData(source,"cweap.owner"),exports.cweap_jericho:getPlayerCurrentWeaponStats (getElementData(source,"cweap.owner")).id,pieceHit,0)
    end
end
addEventHandler("onClientWeaponFire", root, noDamageToPlayersFromCustomWeapons)

function checkPlayerDamageDealt ( attacker, weapon, bodypart, loss )
	if getElementData(localPlayer,"onsatmission") then cancelEvent() return end
	if not getElementData ( localPlayer, "norLiveKilled" ) then
		cancelEvent()
		triggerServerEvent("players:playerGotDamage", getLocalPlayer(), attacker, weapon, bodypart, loss)
	end
end

function stopMinigunDamage ( attacker, weapon, bodypart, loss )
	if source == localPlayer then
		cancelEvent ()
		if exports.safezones:getPlayerZoneConfig(localPlayer).noFight then
			if attacker and getElementType ( attacker ) == "player" then
				triggerServerEvent("players:stopSafezoneDamage", attacker )
			end
			return true
		end
		checkPlayerDamageDealt(attacker, weapon, bodypart, loss)
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopMinigunDamage )

function startKillerTimerClient ()
	killerTimer = setTimer ( cancelHeadReward, 900000, 1 )
end

addEvent( "startKillerTimer", true )
addEventHandler( "startKillerTimer", getRootElement(), startKillerTimerClient )

function stopKillerTimerClient ()
	killTimer ( killerTimer )
end

addEvent( "stopKillerTimer", true )
addEventHandler( "stopKillerTimer", getRootElement(), stopKillerTimerClient )

function cancelHeadReward ()
	triggerServerEvent ( "headRewardCanceled", localPlayer )
end