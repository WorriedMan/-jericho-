govs = {
	"Мэр Новой Деревни",
	"Комендант Союза Ученых",
	"Мэр Сэм Смит",
}

heads = {
	"мародера",
	"убицы",
	"насильника",
	"бандита",
	"краба"
}

continue = {
	" продолжает бесчинствовать",
	" нашел новую жертву",
	" ушатал очередного человека",
	" - его кто нибуть вообще может остановить?!",
	" мерзкий мародер",
}

alreadyRewardedBounty = {}

function killPlayerReward ( ammo, attacker, weapon, bodypart )
	if getElementData ( source, "indmzone" ) == 0 then
		local killer = attacker
		if exports.inventory:getPlayerCaps ( source ) > 3 then
			if getElementData ( source, "nat" ) ~= 2 then
				if getElementData ( source, "rplvl" ) > 4 then
					createMoney ( source )
				end
			end
		end
		if isElement(attacker) then 
			if getElementType ( attacker ) == "vehicle" then
				if getVehicleOccupant ( attacker ) then
					killer = getVehicleOccupant ( attacker )
				end
			end
			if getElementType ( killer ) == "player" then
				if killer ~= source then
					if getElementData ( killer, "perk19" ) then
						--local xp = getElementData()
					end
					if getElementData ( source, "indmzone" ) == 0 then
						if getElementData ( killer, "perk21" ) then
							outputChatBox ( govs[math.random ( 1, 3 )].." не будет объявлять награду за вашу голову, ведь вы для них свой в доску!", killer, 255,50,50 )
						else
							if getElementData ( source, "killer" ) > 0 then
								local id_dead = getElementData ( source, "playerid" )
								local id_killer = getElementData ( killer, "playerid" )
								if alreadyRewardedBounty[id_dead] then
									if alreadyRewardedBounty[id_dead][id_killer] then
										return true
									else
										alreadyRewardedBounty[id_dead][id_killer] = true
										setTimer ( function (id1, id2) if alreadyRewardedBounty[id1] then alreadyRewardedBounty[id1][id2] = false end end, 345600000, 1, id_dead, id_killer )
									end
								end
								exports.inventory:givePlayerItemServer ( killer, 51, getElementData ( source, "killer" ) )
								outputChatBox (getPlayerName ( killer ).." прикончил "..heads[math.random(1,5)].." "..getPlayerName ( source ).." и получил награду в размере "..tostring (getElementData ( source, "killer" )).." крышек", getRootElement(), 255,50,50 )
								setElementData ( source, "killer", 0 )
								setPlayerNametagColor ( source, 255, 255, 255 )
								triggerClientEvent ( source, "stopKillerTimer", getRootElement() )
							else
								if getElementData ( killer, "killer" ) == 0 then
									local reward = math.random ( 2000, 3000 )
									local gov = math.random ( 1, 3 )
									setElementData ( killer, "killer", reward )
									outputChatBox (govs[gov].." обьявляет награду за голову "..heads[math.random(1,5)].." "..getPlayerName ( killer ).." в размере "..tostring (reward).." крышек", getRootElement(), 255,50,50 )
									triggerClientEvent ( killer, "startKillerTimer", getRootElement() )
									setPlayerNametagColor ( killer, 255, 50, 50 )
								else
									outputChatBox (getPlayerName ( killer ) ..continue[math.random(1,5)], getRootElement(), 255,50,50 )
								end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), killPlayerReward )

function headRewardCanceledServer ()
	outputChatBox ("Никто не получает награду за голову "..heads[math.random(1,5)].." "..getPlayerName ( source ), getRootElement(), 255,50,50 )
	setElementData ( source, "killer", 0 )
	setPlayerNametagColor ( source, 255, 255, 255 )
end

addEvent( "headRewardCanceled", true )
addEventHandler( "headRewardCanceled", getRootElement(), headRewardCanceledServer )

function killPlayerFromC (attacker)
	killPed ( source, attacker )
end

addEvent( "killPlayerFromClient", true )
addEventHandler( "killPlayerFromClient", getRootElement(), killPlayerFromC )

function stopSafezoneDamage ()
	if not getElementData ( client, "nodamagetimer" ) then
		setElementData ( client, "nodamagetimer", true, false )
		setTimer ( function ( client ) setElementData ( client, "nodamagetimer", false, false ) end, 4000, 1, client )
		outputChatBox("Вы не можете атаковать в этой зоне!",client,255,20,20)
	else
		kickPlayer ( client, "Запрещено атаковать других игроков в зеленых зонах" )
	end
end

addEvent( "players:stopSafezoneDamage", true )
addEventHandler( "players:stopSafezoneDamage", getRootElement(), stopSafezoneDamage )

playersJustGotDamage = {}

function playerGotDamage(attacker, weapon, bodypart, loss)
	local health = getElementData ( client, 'health' )
	local max_health = getElementData ( client, 'maxHealth' )
	local level = getElementData(client,"rplvl")
	--outputChatBox(health.." "..max_health.. " "..tostring(attacker).." "..tostring(weapon))
	if attacker and getElementType(attacker) == "player" then 
		if weapon then
			if weapon == 37 then
				-- if getElementData ( localPlayer, "mayTakeFireDamage" ) then
					-- setElementData ( localPlayer, "mayTakeFireDamage", false )
					-- setTimer ( function () setElementData ( localPlayer, "mayTakeFireDamage", true ) end, 1500, 1 ) 
				-- else
					return true
				--end
			end
			if weapon == 0 then
				loss = 10 + getElementData(attacker,"rplvl")
			else
				local weap = exports.cweap_jericho:getPlayerCurrentWeaponStats(attacker)
				if weap then loss = weap.damage
				else loss = 10 end
			end
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
					end
				elseif weapon > 20 then 
					if getElementData ( attacker, "perk4" ) then
						loss = loss+loss*0.1
					end
				end
			end
		end
		-- if getElementData ( client, "gang" ) and getElementData ( attacker, "gang" ) and getElementData ( attacker, "gang" ) == getElementData ( client, "gang" ) then
			-- return true
		-- end
		if getElementType ( attacker ) == "player" or getElementType ( attacker ) == "vehicle" then
			if exports.safezones:checkIfPlayerInsideNewbieZone(client) then
				return true
			end
		end
	else
		loss = loss*level*0.5
		if getElementData ( client, "perk20" ) or getElementData ( client, "useArmor" ) == 5 then
			return true
		end
	end
	if attacker then
		if getElementType ( attacker ) == "ped" then
			loss = getElementData(attacker,"zDamage") or 10
			local weapon_name = getElementData(attacker,"customped:weapon_name")
			if weapon_name then
				loss = exports.cweap_jericho:getWeaponStats(weapon_name).damage
			end
			if weapon >= 0 and weapon <= 9 then
				loss = loss+(getElementData ( attacker, 'strenght' ) or 0)*3
			elseif weapon ~= 37 then
				loss = loss+(getElementData ( attacker, 'accuracy' ) or 0)*2
			end
		end
	end
	if getElementData ( client, "overWeight" ) then loss = loss*1.5 end
	if getElementData(client,"perk5") then
		if health/max_health <= 0.1 then
			loss = loss/2
		end
	end
	if getElementData(client,"perk10") then loss = loss*0.95 end
	if getElementData(client,"perk12") then loss = loss*0.95 end
	if getElementData(client,"perk18") then loss = loss*0.95 end
	if getElementData(client,"perk2") then 
		local hour, minutes = getTime ()
		if hour > 20 or hour < 7 then
			loss = loss*0.80
		else
			loss = loss*1.10
		end
	end
	if getElementData(client,"perk17") then 
		local hour, minutes = getTime ()
		if hour > 20 or hour < 7 then
			loss = loss*1.10
		else
			loss = loss*0.85
		end
	end
	loss = loss - (getElementData ( client, "tempdt") or 0 )
	if getElementData ( client, "useArmor" ) > 0 then
		triggerClientEvent("reduceItemHealth",client,getElementData ( client, "armorSlotID"),loss/1000,2)
	end
	if loss <= 0 then
		loss = 1
	end
	--outputChatBox('final loss '..tostring(loss))
	if isElement ( attacker ) then
		if getElementType ( attacker ) == 'player' and loss >= health then
			triggerEvent ( "killPlayerFromClient", client, attacker ) 
		else
			setElementData ( client, 'health', health - loss )
		end
	else
		if loss >= health then
			triggerEvent ( "killPlayerFromClient", client ) 
		else
			setElementData ( client, 'health', health - loss )
		end
	end
	if isTimer(playersJustGotDamage[client]) then
		killTimer(playersJustGotDamage[client])
	end
	playersJustGotDamage[client] = setTimer(function() end, 10000, 1)
end

addEvent( "players:playerGotDamage", true )
addEventHandler( "players:playerGotDamage", getRootElement(), playerGotDamage )