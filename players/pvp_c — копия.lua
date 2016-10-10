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

function stopMinigunDamage ( attacker, weapon, bodypart, loss )
	if source == localPlayer then
		cancelEvent ()
		if exports.safezones:getPlayerZoneConfig(localPlayer).noFight then
			if attacker and getElementType ( attacker ) == "player" then
				triggerServerEvent("players:stopSafezoneDamage", attacker )
			end
			return true
		end
		if not getElementData ( source, "norLiveKilled" ) and then
			local health = getElementData ( localPlayer, 'health' )
			if attacker then 
				if weapon then
					if weapon == 37 then
						-- if getElementData ( localPlayer, "mayTakeFireDamage" ) then
							-- setElementData ( localPlayer, "mayTakeFireDamage", false )
							-- setTimer ( function () setElementData ( localPlayer, "mayTakeFireDamage", true ) end, 1500, 1 ) 
						-- else
							return true
						--end
					end
					local weap = exports.cweap_jericho:getPlayerCurrentWeaponStats(attacker)
					if weap then loss = weap.damage
					else loss = 10 end
					-- 0,5 * МаксимальныйУрон * (1 + %Состояние/100)
					if getElementType ( attacker ) == 'player' then
						if weapon >= 0 and weapon <= 9 then
							loss = loss+getElementData ( attacker, 'strenght' )*3+getElementData ( attacker, 'tempstrenght' )*3
							if getElementData ( attacker, "perk32" ) then
								if math.random ( 1, 100 ) < 8 then
									loss = loss*5
								end
							end
						elseif weapon ~= 37 then
							loss = loss+getElementData ( attacker, 'accuracy' )*2+getElementData ( attacker, 'tempaccuracy' )*2
						end
						if weapon == 0 then
							if getElementData ( attacker, "perk14" ) then 
								loss = loss*2
							end
						elseif weapon == 38 then
							if getElementType ( attacker ) == 'player' then
								loss = loss/1.5
								return true
							end
						elseif weapon > 20 then 
							if getElementData ( attacker, "perk4" ) then
								loss = loss+(loss/10)
							end
						end
					end
				end
				if getElementData ( attacker, "group" ) ~= 0 then
					if getElementData ( attacker, "group" ) == getElementData ( source, "group" ) then
						cancelEvent()
						return true
					end
				end
				if getElementType ( attacker ) == "player" or getElementType ( attacker ) == "vehicle" then
					if getElementData ( localPlayer, "indmzone" ) == 0 then
						if getElementData ( localPlayer, "rplvl" ) < 3 and getElementData ( localPlayer, 'inNewbieZone' ) then
							cancelEvent()
							return true
						end
					end
				end
			else
				loss = loss*getElementData(source,'rplvl')*0.5
				if getElementData ( localPlayer, "perk20" ) or getElementData ( localPlayer, "useArmor" ) == 5 then
					cancelEvent ()
					return true
				end
			end
			local attZ = false
			if attacker then
				if getElementType ( attacker ) == "ped" then
					if getElementData ( attacker, "zombie" ) then
						if getElementData ( attacker, "tyran" ) then
							if weapon == 38 then
								loss = math.random ( 40, 60 )
							else
								loss = 20 
							end
						else
							loss = getElementData ( attacker, "zDamage" )
						end
						attZ = true
					elseif getElementData ( attacker, "boss" ) then
						loss = getElementData ( attacker, "zDamage" ) or 20
					end
				end
			end
			if getElementData ( localPlayer, "overWeight" ) then loss = loss*1.5 end
			if usefulPerks['botan'][2] then
				if health < 30 and health > 0 then
					local loss = loss/2
				end
			end
			if usefulPerks['live1'][2] then loss = loss*0.95 end
			if usefulPerks['live2'][2] then loss = loss*0.95 end
			if usefulPerks['live3'][2] then loss = loss*0.95 end
			if usefulPerks['night'][2] then 
				local hour, minutes = getTime ()
				if hour > 20 or hour < 7 then
					loss = loss*0.80
				else
					loss = loss*1.10
				end
			end
			if usefulPerks['day'][2] then 
				local hour, minutes = getTime ()
				if hour > 20 or hour < 7 then
					loss = loss*1.10
				else
					loss = loss*0.85
				end
			end
			-- local armor = getElementData ( localPlayer, 'useArmor' ) or 0
			-- if armor > 0 and armor <= #armorStats then
				-- local perc = loss/100
				-- loss = loss-perc*armorStats[armor]
			-- end
			loss = loss - (getElementData ( localPlayer, "tempdt") or 0 )
			if eat >= 100 then
				local perc = loss/100
				loss = loss+perc*20
			end-- конец
			if getElementData ( localPlayer, "useArmor" ) > 0 then
				exports.inventory:reduceItemHealth(getElementData ( localPlayer, "armorSlotID"),loss/1000)
			end
				if loss <= 0 then
					if attZ then
						loss = 0.1
					else
						loss = 1
					end
				end
				local armor = getPedArmor ( localPlayer ) 
				if armor > 0 then
					if armor - loss > 0 then
						triggerServerEvent ( "givePlayerSkinArmor", getLocalPlayer(), armor - loss ) 
						loss = 0
						return true
					elseif armor - loss == 0 then
						triggerServerEvent ( "givePlayerSkinArmor", getLocalPlayer(), 0 ) 
						loss = 0
						return true
					else
						triggerServerEvent ( "givePlayerSkinArmor", getLocalPlayer(), 0 ) 
						loss = loss - armor
					end
				end
			
				if isElement ( attacker ) then
					if getElementType ( attacker ) == 'player' and loss >= health then
						triggerServerEvent ( "killPlayerFromClient", getLocalPlayer(), attacker ) 
					else
						setElementData ( localPlayer, 'health', health - loss )
					end
				else
					if loss >= health then
						triggerServerEvent ( "killPlayerFromClient", getLocalPlayer() ) 
					else
						setElementData ( localPlayer, 'health', health - loss )
					end
				end
		end
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