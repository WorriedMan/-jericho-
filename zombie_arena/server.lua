local arenaUser
local arenaRoundNum
local exitarenapickup
local exitarenacolshape
local zombiesInArena = {}
local timerNextRound
local arenaZombieKills

local arenaSpawns = {
	{ 0, -231.3916015625,2734.6083984375,62.6875 },
	{ 0, -241.2158203125,2727.6748046875,62.6875 },
	{ 0, -233.5302734375,2723.796875,62.6875 },
	{ 10, -229.501953125,2722.4921875,62.6875 },
	{ 10, -218.2666015625,2725.8642578125,62.6875 },
	{ 10, -221.1220703125,2732.85546875,62.6875 },
	{ 20, -230.7919921875,2732.8916015625,62.6875 },
	{ 20, -240.119140625,2734.296875,62.6875 },
	{ 20, -240.251953125,2722.47265625,62.6875 },

}

local zstats = {
--	{ раунд, здоровье, урон, количество }
	{ 0, 30, 20, 3 },
	{ 4, 60, 40, 3 },
	{ 8, 80, 50, 6 },
	{ 12, 110, 55, 7 },
	{ 16, 130, 90, 9 },
}

function loadArenaLeaders()
	executeSQLQuery("CREATE TABLE IF NOT EXISTS `zombieLeadersAllTime` (`name` TEXT, `kills` INTEGER, `taken` INTEGER)")
	executeSQLQuery("CREATE TABLE IF NOT EXISTS `zombieLeadersWeek` (`name` TEXT, `kills` INTEGER)")
	executeSQLQuery("CREATE TABLE IF NOT EXISTS `lastWeekChampion` (`name` TEXT, `kills` INTEGER, `taken` INTEGER)")
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Андрей Кочепопкин",2310)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Xzibit",211)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Иван",3141)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Сэм",478)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Боб",782)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Джей",56)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Смит",10)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Адам",12)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Иисус",79)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Механик",245)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Мэр",324)
	-- executeSQLQuery("INSERT INTO `zombieLeadersAllTime` (`name`, `kills`) values(?,?)","Супермутант",321)
	
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Андрей Кочепопкин",2310)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Вася",211)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Иван",3141)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Сэм",478)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Боб",782)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Джей",56)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Смит",10)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Адам",12)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Иисус",79)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Механик",245)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Мэр",324)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","Супермутант",321)
	-- executeSQLQuery("INSERT INTO `zombieLeadersWeek` (`name`, `kills`) values(?,?)","PrettySweetie",3)
	
	-- executeSQLQuery("INSERT INTO `lastWeekChampion` (`name`, `kills`, `taken`) values(?,?,?)","Пьяница Боб",999,0)
	setTimer (checkArenaLeader,3600000,0)
end

addEventHandler ( "onResourceStart", getResourceRootElement(), loadArenaLeaders )

function checkArenaLeader ()
	local now = getRealTime()
	if day == 0 and hour == 23 then
		local weekLeaderQuery = executeSQLQuery( "SELECT * FROM `zombieLeadersWeek` ORDER BY `kills` DESC LIMIT 1" )
		if weekLeaderQuery and weekLeaderQuery[1] then
			leader, leader_kills = weekLeaderQuery[1].name, tonumber(weekLeaderQuery[1].kills)
			if leader and leader_kills and leader_kills > 0 then		
				executeSQLQuery("CREATE TABLE IF NOT EXISTS `lastWeekChampion` (`name` TEXT, `kills` INTEGER, `taken` INTEGER)")
				executeSQLQuery("INSERT INTO `lastWeekChampion`(name,kills,taken) VALUES(?,?,?)", leader, leader_kills,0 )
			end
		end
		executeSQLQuery("DROP TABLE `zombieLeadersWeek`" )
		executeSQLQuery("CREATE TABLE IF NOT EXISTS `zombieLeadersWeek` (`name` TEXT, `kills` INTEGER)")
	end
end

function wantToStartArena()
	local weekLeaderQuery = executeSQLQuery( "SELECT * FROM `zombieLeadersWeek` ORDER BY `kills` DESC LIMIT 1" )
	local leader, leader_kills = "Пьяница Боб", 1
	if weekLeaderQuery and weekLeaderQuery[1] then
		leader, leader_kills = weekLeaderQuery[1].name, weekLeaderQuery[1].kills
	end
	local weekPlayerLeaderQuery = executeSQLQuery( "SELECT * FROM `zombieLeadersWeek` WHERE `name` = ?", getAccountName ( getPlayerAccount ( source ) ) )
	local player_kills = 0
	if weekPlayerLeaderQuery and weekPlayerLeaderQuery[1] then
		player_kills = tonumber(weekPlayerLeaderQuery[1].kills)
	end
	local lastweekChampionQuery = executeSQLQuery( "SELECT * FROM `lastWeekChampion`")
	local last_week_leader, last_week_kills = "-", 0
	if lastweekChampionQuery and lastweekChampionQuery[1] then
		last_week_leader, last_week_kills = lastweekChampionQuery[1].name, tonumber(lastweekChampionQuery[1].kills)
	end
	local alltimeLeaderQuery = executeSQLQuery( "SELECT * FROM `zombieLeadersAllTime` ORDER BY `kills` DESC LIMIT 10" )
	local alltimePlayerLeaderQuery = executeSQLQuery( "SELECT * FROM `zombieLeadersAllTime` WHERE `name` = ?", getAccountName ( getPlayerAccount ( source ) ) )
	local player_kills_alltime = 0
	if alltimePlayerLeaderQuery and alltimePlayerLeaderQuery[1] then
		player_kills_alltime = tonumber(alltimePlayerLeaderQuery[1].kills)
	end
	
	triggerClientEvent(source,"zombie_arena:showMenu",source,{leader,leader_kills},player_kills,alltimeLeaderQuery,{last_week_leader, last_week_kills},player_kills_alltime)
end

addEvent("zombie_arena:wantToStartArena",true)
addEventHandler("zombie_arena:wantToStartArena",getRootElement(),wantToStartArena)

function checkPlayerReward()
	local reward = false
	local lastweekChampionQuery = executeSQLQuery( "SELECT * FROM `lastWeekChampion`")
	if lastweekChampionQuery and lastweekChampionQuery[1] then
		local last_week_leader, taken = lastweekChampionQuery[1].name, tonumber(lastweekChampionQuery[1].taken)
		if last_week_leader and last_week_leader == getAccountName ( getPlayerAccount ( source ) ) and taken == 0 then
			executeSQLQuery("UPDATE `lastWeekChampion` SET taken=1 WHERE name=?", getAccountName ( getPlayerAccount ( source ) ) )
			outputChatBox ("Распорядитель арены: Ты же чемпион прошедшей недели! Вот твой набор.",source,255,255,255)
			exports.inventory:givePlayerItemServerWW ( source, 146, 100)
			exports.inventory:givePlayerItemServerWW ( source, 1, 5)
			reward = true
		end
	end
	local alltimePlayerLeaderQuery = executeSQLQuery( "SELECT * FROM `zombieLeadersAllTime` WHERE `name` = ?", getAccountName ( getPlayerAccount ( source ) ) )
	if alltimePlayerLeaderQuery and alltimePlayerLeaderQuery[1] then
		if tonumber(alltimePlayerLeaderQuery[1].kills) > 49 then
			local taken = tonumber(alltimePlayerLeaderQuery[1].taken)
			if taken == 0 then
				executeSQLQuery("UPDATE `zombieLeadersAllTime` SET taken=1 WHERE name=?", getAccountName ( getPlayerAccount ( source ) ) )
				outputChatBox ("Распорядитель арены: Вот твой револьвер за 50 убитых гулей на арене.",source,255,255,255)
				exports.inventory:givePlayerItemServerWW ( source, 145, 1)
				reward = true
			end
		end
	end
	if not reward then
		outputChatBox ("Распорядитель арены: У меня не записано, что ты что то выиграл.",source,255,255,255)
	end
end

addEvent("zombie_arena:checkPlayerReward",true)
addEventHandler("zombie_arena:checkPlayerReward",getRootElement(),checkPlayerReward)

function prepareArenaFight ()
	if not arenaUser or not isElement ( arenaUser ) or not getElementData ( arenaUser, "onArena" ) then
		arenaZombieKills = 0
		arenaUser = source
		setElementPosition ( source, -227.751953125,2721.7060546875,62.829372406006 )
		setElementData ( source, "fireAllowed", true )
		setElementData ( source, "onArena", true )
		arenaRoundNum = 1
		exports.pipboy:addInfoBox("Через 5 секунд начнется раунд 1", 3, source )
		timerNextRound = setTimer ( nextArenaRoundStart, 5000, 1, source )
		triggerClientEvent (source, "zombie_arena:startArenaFight",source)
		addEventHandler ( "onPlayerQuit", source, finishArenaFight )
		addEventHandler ( "onPlayerWasted", source, wastedArenaPlayer )
	else
		outputChatBox("Распорядитель арены: В данный момент арена занята",source,255,255,255)
	end
end

addEvent("zombie_arena:startClicked",true)
addEventHandler("zombie_arena:startClicked",getRootElement(),prepareArenaFight)

function giveArenaZombieKillerReward ( ammo, player )
	--outputDebugString("kilkled")
	if isElement ( player ) then
		--outputDebugString("checked")
		--givePlayerMoney ( player, 20+arenaRoundNum*1,5 )
		exports.inventory:givePlayerItemServerWW ( player, 51, 20+arenaRoundNum*1.5 )
		for i, ped in ipairs ( zombiesInArena ) do
			if isElement(ped) and ped == source then
				destroyElement ( ped )
			--	outputDebugString("destroyed")
				arenaZombieKills = arenaZombieKills+1
				table.remove(zombiesInArena,i)
				break
			end
		end
		-- outputDebugString(tostring(#zombiesInArena))
		-- outputChatBox (#zombiesInArena)
		if #zombiesInArena == 0 then
			arenaRoundNum = arenaRoundNum+1
			exports.pipboy:addInfoBox("Через 10 секунд начнется раунд "..arenaRoundNum, 4, player)
			timerNextRound = setTimer ( nextArenaRoundStart, 10000, 1, player )
			exitarenapickup = createPickup ( -227.7519,2721.7060,62.8297, 3, 1318 )
			exitarenacolshape = createColSphere(-227.7519,2721.7060,62.8297,1)
			setElementData ( exitarenacolshape, "action", true )
			setElementData ( exitarenacolshape, "type", 4 )
			addEventHandler ( "onColShapeHit", exitarenacolshape, arenaExitShapeHit )
			addEventHandler ( "onColShapeLeave", exitarenacolshape, arenaExitShapeLeave )
			exports.players:givePlayerXP ( player, 100 )
		end
	end
end

function arenaExitShapeHit (player)
	if arenaUser and player == arenaUser then
		bindKey (player,"e","down",playerLeaveArena)
	else
		destroyElement ( source )
		if isElement ( exitarenapickup ) then destroyElement ( exitarenapickup ) end
	end
end

function arenaExitShapeLeave (player)
	if arenaUser and player == arenaUser then
		unbindKey (player,"e","down",playerLeaveArena)
	else
		destroyElement ( source )
		if isElement ( exitarenapickup ) then destroyElement ( exitarenapickup ) end
	end
end

function playerLeaveArena ( player )
	unbindKey (player,"e","down",playerLeaveArena)
	if arenaUser and arenaUser == player then
		exports.safezones:checkPlayerSafezone(player)
		setElementData ( player, 'fireAllowed', false )
		setElementPosition(player,-235.8759765625,2711.4921875,62.9765625)
		finishArenaFight()
	end
end

function finishArenaFight ()
	if isTimer ( timerNextRound ) then 
		killTimer ( timerNextRound ) 
		timerNextRound = nil 
	end
	if isElement ( arenaUser ) then
		local weekPlayerLeaderQuery = executeSQLQuery( "SELECT * FROM `zombieLeadersWeek` WHERE `name` = ?", getAccountName ( getPlayerAccount ( arenaUser ) ) )
		local player_kills = 0
		if weekPlayerLeaderQuery and weekPlayerLeaderQuery[1] then
			player_kills = tonumber(weekPlayerLeaderQuery[1].kills)
			executeSQLQuery("UPDATE `zombieLeadersWeek` SET kills="..tostring(player_kills+arenaZombieKills).." WHERE name=?", getAccountName ( getPlayerAccount ( arenaUser ) ) )
		else
			executeSQLQuery("INSERT INTO `zombieLeadersWeek`(name,kills) VALUES(?,?)", getAccountName ( getPlayerAccount ( arenaUser ) ), arenaZombieKills )
		end
		local alltimePlayerLeaderQuery = executeSQLQuery( "SELECT * FROM `zombieLeadersAllTime` WHERE `name` = ?", getAccountName ( getPlayerAccount ( arenaUser ) ) )
		local player_kills = 0
		if alltimePlayerLeaderQuery and alltimePlayerLeaderQuery[1] then
			player_kills = tonumber(alltimePlayerLeaderQuery[1].kills)
			executeSQLQuery("UPDATE `zombieLeadersAllTime` SET kills="..tostring(player_kills+arenaZombieKills).." WHERE name=?", getAccountName ( getPlayerAccount ( arenaUser ) ) )
		else
			executeSQLQuery("INSERT INTO `zombieLeadersAllTime`(name,kills,taken) VALUES(?,?,?)", getAccountName ( getPlayerAccount ( arenaUser ) ), arenaZombieKills, 0 )
		end
		removeEventHandler ( "onPlayerQuit", arenaUser, finishArenaFight )
		removeEventHandler ( "onPlayerWasted", arenaUser, wastedArenaPlayer )
		setElementData ( arenaUser, "onArena", false )
		triggerClientEvent (arenaUser, "zombie_arena:finishFight",arenaUser)
	end
	arenaUser = nil
	destroyArenaZombies()
	if isElement ( exitarenapickup ) then
		destroyElement ( exitarenapickup )
	end
	if isElement ( exitarenacolshape ) then
		destroyElement ( exitarenacolshape )
	end
end

function destroyArenaZombies()
	for i, v in ipairs ( zombiesInArena ) do
		if isElement ( v ) then 
			destroyElement ( v )
		end
	end
	zombiesInArena = {}
	return true
end

function nextArenaRoundStart ( thePlayer )
	destroyArenaZombies()
	triggerClientEvent (thePlayer, "zombie_arena:updateArenaFightInfo", thePlayer,arenaRoundNum)
	local zHealth 
	local zDamage
	local zombiesNum
	for _, stats in ipairs ( zstats ) do
		if arenaRoundNum > stats[1] then
			zHealth = stats[2]
			zDamage = stats[3]
			zombiesNum = stats[4]
		else
			break
		end
	end
	local createdZombies = 0
	for i = 1, zombiesNum do 
		local zomb = createPed ( 287, arenaSpawns[i][2], arenaSpawns[i][3], arenaSpawns[i][4],math.random(0,360))
		if isElement ( zomb ) then
			setElementData ( zomb, "arenaZombie", true )
			exports.npc_hlc:enableHLCForNPC( zomb, "walk")
			setElementData ( zomb, "zTarget", thePlayer )
			setElementData ( zomb, "zDamage", zDamage )
			setElementData ( zomb, "health", zHealth )
			setElementData ( zomb, "maxHealth", zHealth )
			exports.npc_hlc:addNPCTask ( zomb, {"killPed", thePlayer, 2, 2} )
			addEventHandler("onPedWasted", zomb, giveArenaZombieKillerReward)
			table.insert ( zombiesInArena, zomb )
		end
	end
	zombiesNumInArena = #zombiesInArena
	if isElement ( exitarenapickup ) then
		destroyElement ( exitarenapickup )
	end
	if isElement ( exitarenacolshape ) then
		destroyElement ( exitarenacolshape )
	end
end

function wastedArenaPlayer ()
	if arenaUser and arenaUser == source then
		exports.pipboy:addInfoBox("За смерть на арене вы получаете штраф 100$", 4, source)
   		takePlayerMoney ( source, 100 )
	end
   	finishArenaFight()
end