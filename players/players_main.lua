local lg = 1

local playersSuicided = {}

function killMyself(player,cmd)
	local acc = getPlayerAccount(player)
	if not isGuestAccount(acc) then
		if playersSuicided[getAccountName(acc)] then
			exports.pipboy:addInfoBox("Суицид можно использовать 1 раз в 60 минут!",2,player )
		else
			if isTimer(playersJustGotDamage[player]) then
				exports.pipboy:addInfoBox("Подождите немного.",2,player )
			else
				playersSuicided[getAccountName(acc)] = true
				setTimer(function() playersSuicided[getAccountName(acc)] = nil end,3600000,1)
				triggerEvent ( "killPlayerFromClient", player ) 
			end
		end
	end
end

addCommandHandler("kill",killMyself)
addCommandHandler("suicide",killMyself)

function isLoggedIn( player )
	return getElementData(player,"online") and true or false
end

function givePlayerXPS ( quant )
    givePlayerXP ( source, quant )
end
addEvent( "givePlayerXPC", true )
addEventHandler( "givePlayerXPC", getRootElement(), givePlayerXPS )

local xpPower = 1

addEvent ( "settingsChanged", true )

function recievePowerXP ( setTable )
	xpPower = setTable['xpPower']
	outputChatBox ( "Множитель опыта на сервере: "..tostring(xpPower), root, 200, 150, 100 )
end

addEventHandler ( "settingsChanged", root, recievePowerXP )

function giveXPInRange ( xp, players, max_level )
	if players and xp then
		if not max_level then max_level = 99999 end
		if #players > 0 then
			for i, v in ipairs ( players ) do
				if ( getElementData ( v, "rplvl" ) or 999999 ) <= max_level then
					givePlayerXP ( v, math.floor ( xp/#players ) )
				end
			end
		end
	end
end

function givePlayerXP ( source, valve )
	local finalXP = valve*xpPower
	if getElementData ( source, "vip" ) then
		finalXP=finalXP*1.5
	end
	local level = getElementData ( source, "rplvl" ) or 1
	local currXP = getElementData ( source, "xp" )
	local nextXP = 500*level
	if getElementData ( source, "origin" ) == 0 then
		setElementData ( source, "xp", currXP + finalXP )
	else
		finalXP = finalXP*1.5
		setElementData ( source, "xp", currXP + finalXP )
	end
	--outputChatBox ("Информация: Вы получили "..tostring(finalXP).." очков опыта",source, 0,153,51 )
	if currXP+finalXP > nextXP and level < 100 then
		setElementData ( source, "xp", 0 )
		setElementData ( source, "rplvl", level + 1 )
		exports.pipboy:addInfoBox(phrase[lg].new_level,2,source )
		exports.pipboy:addInfoBox(phrase[lg].health_incr,2,source )
		triggerClientEvent ( source, "addNewNotificationS", source, 3 )
		local newlvl = level+1
		if newlvl == 3 then
			outputChatBox ( "Теперь вас могут атаковать другие игроки и при смерти вы теряете все свои деньги", source, 200,200, 200 )
        end
		triggerClientEvent ( source, "changeLabelLevel", getRootElement(), newlvl  )
		triggerClientEvent ( source, "playLVLUpSound", source )
		return true
	end
	--triggerClientEvent ( source, "changeLabelXP", getRootElement(), tostring (currXP + finalXP) )
end

function givePlayerVirus ( source, valve )
	triggerClientEvent ( source, "givePlayerVirusS", getRootElement(), valve )
end

function takePlayerVirus ( source, valve )
	triggerClientEvent ( source, "takePlayerVirusS", getRootElement(), valve )
end

function givePlayerRad ( source, valve )
	triggerClientEvent ( source, "givePlayerRadS", getRootElement(), valve )
end

function takePlayerRad ( source, valve )
	triggerClientEvent ( source, "takePlayerRadS", getRootElement(), valve )
end

function givePlayerSkinArmorS ( amount )
	setPedArmor ( source, amount )
end

addEvent( "givePlayerSkinArmor", true )
addEventHandler( "givePlayerSkinArmor", getRootElement(), givePlayerSkinArmorS )

function takePlayerMoneyS ( amount )
	exports.inventory:removePlayerItemServer ( player, 51, amount )
end

addEvent( "takePlayerMoneyClient", true )
addEventHandler( "takePlayerMoneyClient", getRootElement(), takePlayerMoneyS )

function changePlayerAnimation ( block, anim )
	if block and anim then
		setPedAnimation ( source, block, anim, -1, true, false, false )
	else
		setPedAnimation ( source )
	end
end
addEvent( "changePlayerAnimationC", true )
addEventHandler( "changePlayerAnimationC", getRootElement(), changePlayerAnimation )

local lvPositions = {
	{ 0, 0, 5 },
	{  -760.67, 2051.20, 60.18 },
	{-1508.70703125,2608.349609375,55.8359375 },
	{ -570.0771484375,2011.7421875,60.233222961426 },
	{ 251.294921875,1843.6591796875,8.7734375 },
	{ -242.7666015625,2711.953125,62.6875 },
	{ -3007.109375,397.8818359375,9.5062503814697 },
	{ 2318.88671875,8.412109375,26.484375 },
	{2154,-1533,2.9},
}

function tpMeToLV ( playerSource, cmd, arg )
    -- if isObjectInACLGroup ("user."..getAccountName ( getPlayerAccount ( playerSource ) ), aclGetGroup ( "Admin" ) ) then 
		if arg then
			if #lvPositions >= tonumber ( arg ) then
				if not getElementData ( playerSource, "tpTimerID" ) then setElementData ( playerSource, "tpTimerID", 0 ) end
				if getElementData ( playerSource, "tpTimerID" ) > 0 then return true end
				local timerID = math.random ( 1, 100000 )
				setElementData ( playerSource, "tpTimerID", timerID )
				toggleAllControls ( playerSource, false, true, false )
				setTimer ( completeTeleport, 1000, 1, playerSource, tonumber ( arg ), timerID )
				outputChatBox ( 'Вы будете телепортированы через 2 секунды', playerSource, math.random ( 0,255), math.random ( 0,255), math.random ( 0,255) )
			end
		end
	-- end
end

addCommandHandler ( "tptolv", tpMeToLV )

function completeTeleport ( player, arg, timerID )
	if getElementData ( player, "tpTimerID" ) == timerID then
		setElementData ( player, "tpTimerID", 0 )
		toggleAllControls ( player, true )
		setElementPosition ( player, lvPositions[arg][1], lvPositions[arg][2], lvPositions[arg][3] )
	end
end

function calculatePlayerDamage (player)
	if isElement ( player ) then
		setElementData ( player, 'shootWeaponDamage', getElementData ( player, 'accuracy' ) )
	end
end

function calculatePlayerHP (player)
	if isElement ( player ) then
		additHealth = 0
		if getElementData ( player, 'perk26' ) then
			additHealth = 60
		end	
		if getElementData ( player, 'perk27' ) then
			additHealth = additHealth+120
		end	
		if getElementData ( player, 'perk28' ) then
			additHealth = additHealth+240
		end	
		setElementData ( player, 'maxHealth', getElementData ( player, 'rplvl' )*20+60+getElementData ( player, 'strenght' )*30+additHealth )
	end
end

function kickPlayerOnHighPing ()
	outputChatBox (getPlayerName(source).." кикнут(а) из-за большого пинга",getRootElement(),27, 89, 224,true)	
	kickPlayer(source,"Your Ping was straight too high.")
end
addEvent("kickPlayerOnHighPing",true)
addEventHandler("kickPlayerOnHighPing", getRootElement(),kickPlayerOnHighPing)

function pickupUse ( thePlayer )
    local pickType = getPickupType ( source )
    local pickAmount = getPickupAmount ( source )
	if pickType and pickAmount then
		if pickType == 0 then
			givePlayerNewHealth ( thePlayer, getElementData ( thePlayer, "maxHealth" )/100*pickAmount )
		end
	end
end
addEventHandler ( "onPickupUse", getRootElement(), pickupUse )

function givePlayerNewHealth ( player, amount )
	local health = getElementData ( player, 'health' )
	local maxHealth = getElementData ( player, 'maxHealth' )
	if health + amount >= maxHealth then
		setElementData ( player, 'health', maxHealth )
		return true
	else
		setElementData ( player, 'health', health+amount )
		return true
	end
end

setTimer(function() setElementData(root,"timestamp",getRealTime().timestamp) end,1000,0)