local arenause = 0
exports.scoreboard:scoreboardAddColumn ( "playerid", getRootElement(), 70, "ID" )
exports.scoreboard:scoreboardAddColumn ( "rplvl", getRootElement(), 70, "Уровень" )
exports.scoreboard:scoreboardAddColumn ( "Zombie kills", getRootElement(), 90, "Убито гулей" )
function LoadAccountS( source )
		toggleControl ( source, "chatbox", true )
		local playerskin = getElementData ( source, "skin" )
		setElementData ( source, "logged", true )
		setCameraTarget (source, source)
		outputChatBox ( "Ваш ИД: " .. tostring(getElementData ( source, "playerid" )), source)
		outputChatBox ( getPlayerName(source) .. " зашел на наш сервер ", getRootElement(), 102,204,204)
		bindKey ( source, "E", "up", spaceEvents )
		--bindKey ( source, "horn", "down", openBarriers )
		setElementModel ( source, playerskin )
		setElementData (source, "robcomplete", 0 )
		setElementData (source, "taxipas", 0 )
		setElementData (source, "call", 0 )
		setElementData (source, "mehduty", 0 )
		setElementData (source, "trydo", 0 )
		setElementData ( source, "workfindtype", 0 )
		setElementData ( source, "online", 1 )
		setElementData ( source, "buyinprogress", 0 )
		setElementData ( source, "useArmor", 0 )
		setElementData ( source, "group", 0 )
		setElementData ( source, "tempaccuracy", 0 )
		setElementData ( source, "tempbreath", 0 )
		setElementData ( source, "tempstrenght", 0 )
		setElementData ( source, "group-owner", 0 )
		setElementData ( source, "group-c", 0 )
		setElementData ( source, "mission", 0 )
		setElementData ( source, "antiRadWear", 0 )
		setElementData ( source, "inventoryAllowed", 1 )
		setElementData ( source, "blueEssence", 0 )
		setElementData ( source, "quest_prob_oy", 0 )
		setElementData ( source, "currAmmoAmount", 0 )
		setElementData ( source, "useArmor", 0 )
		setElementData ( source, "mayTakeFireDamage", true )
		if getElementData ( source, "rplvl" ) == 0 then
			setElementData ( source, "rplvl", 1 ) 
		end
		toggleControl ( source, "chatbox", true )
		setElementData ( source, "ID", getElementData ( source, "playerid" ) )
		setElementData ( source, "Level", getElementData ( source, "rplvl" ) )
		local spawnsucces = 0
		triggerClientEvent (source, "calculatePlayerHP", source )
		triggerClientEvent (source, 'calculatePlayerAPS', source, true)
		calculatePlayerDamage()
		if getElementData ( source, "quest_main_st" ) == 0 then
			outputChatBox ( "Для написания сообщения в глобальный чат, используйте U", source)
			setElementPosition ( source, -943.38671875,1953.1123046875,5 )
			setElementInterior ( source, 17)
			setPedRotation ( source, 181 )
			outputChatBox ("Информация: Пока вы не начнете прохождение сюжета, вы будете повляться на дамбе.", source, 0,153,51 )
			exports.pipboy:addInfoBox("Поговорите с Джоном Початком, нажав E рядом с ним.", 4, source )
			spawnsucces = 1
			return true
		else
			exports.quests:questLoadAllTasksS(source)
		end
		if getElementData ( source, "died" ) == 1 and getElementData ( source, "land" ) == 1 then
			exports.reborn:resumeRebornChallenge (source)
			if getElementData ( source, "restoreLeave" ) then
				setElementData ( source, "restoreLeave", false )
			end
			return true
		end
		if getElementData ( source, "land" ) == 1 then
			setElementData ( source, "restoreLeave", false )
			setElementPosition ( source, getElementData ( source, "x" ), getElementData ( source, "y" ), getElementData ( source, "z" ) )
			return true
		end
		local playerHouse = exports.houses:getPlayerHouse ( source )
		if playerHouse then
			if playerHouse > 0 then
				exports.houses:enterHouse ( source, playerHouse )
				return true
			elseif playerHouse == 0 then
				playerHouse = exports.houses:getPlayerRentedHouse(source)
				return true
			end
		end
		if spawnsucces ~= 1 then
			local nation = getElementData ( source, "nat" )
			if nation == 1 then
				setElementPosition ( source, -943.38671875,1953.1123046875,5 )
				setElementInterior ( source, 17)
				setPedRotation ( source, 181 )
				return true
			elseif nation == 2 then 
				setElementPosition ( source, 243, 1855, 9 )	
				return true
			elseif nation == 3 then
				setElementPosition ( source, -259.3125,2607.81640625,62.858154296875 )
				return true
			elseif nation == 6 then
				if exports.inventory:getPlayerCaps(source) >= 100 then
					setElementPosition ( source, -3014.3125,451.275390625,9.5512075424194)
					outputChatBox ("Вера Уизерли: Спасибо, что арендуете койку. С вас 100 крышек.", source, 255,255,255 )
					exports.inventory:removePlayerItemServer ( source, 51, 100 )
				else
					setElementPosition ( source, -2860.646484375,461.9091796875,4.4419951438904)
					setElementData ( source, 'health', 20 )
					outputChatBox ("Вера Уизерли: Проваливай из моей гостинницы, нищий", source, 255,255,255 )
				end
				return true
			elseif nation == 7 then
				if exports.inventory:getPlayerCaps(source) >= 80 then
					setElementPosition ( source, 2940.62890625,-1532.408203125,1932.7952880859)
					setElementRotation ( source, 0,0,95.046936035156 )
					outputChatBox ("Салли Уилсон: С вас 80 крышек за аренду комнаты", source, 255,255,255 )
					exports.inventory:removePlayerItemServer ( source, 51, 80 )
				else
					setElementPosition ( source, 2318.88671875,8.412109375,26.484375)
					setElementData ( source, 'health', 10 )
					outputChatBox ("Салли Уилсон: Крышек нет? Ну тогда вали отсюда.", source, 255,255,255 )
				end
				return true
			end
			setElementPosition ( source, -943.38671875,1953.1123046875,5 )
			setElementInterior ( source, 17)
			setPedRotation ( source, 181 )
			setElementData ( source, "nat", 1 )
		end
end

addEvent("LoadAccountС",true)
addEventHandler("LoadAccountС",root,LoadAccountS)

quit_Type = {Unknown = "Неизвестно", Quit = "Выход", Kicked = "Кикнут", Banned = "Забанен", ["Bad Connection"] = "Плохое соединение", ["Timed out"] = "Тайм-аут"}
function outputChatBoxTypeQuitPlayer(quitType, reason, ResponsibleElement)
	if(getElementData(source, "online" ) == 1) then
		savePlayerAccount (source)
		savePlayerInventory (source)
	end
	outputChatBox("Игрок "..getPlayerName(source).." покинул наш сервер. Причина: "..(quit_Type[quitType] or "Неизвестно").."",getRootElement(), 204, 0, 0)
end
addEventHandler("onPlayerQuit", getRootElement(), outputChatBoxTypeQuitPlayer)
--addEventHandler ( "onPlayerJoin", getRootElement ( ), onPlayerJoin )

function preLoadPlayerAccountS ( )
	local result = nil
	if not result then 
		if mysql_errno(database) == 2006 then
			outputDebugString("mysql_query failed: (" .. mysql_errno(database) .. ") " .. mysql_error(database))
			mysql_close ( database )
			database = mysql_connect( "82.146.60.207", "mtauser", "4jUDWsT9YGEjrW28", "mtadb" )
			result = mysql_query ( database ,"SELECT * FROM `accounts` WHERE `name` = '"..getPlayerName(source).."' LIMIT 1")
		end
	end
	mysql_data_seek ( result, 0 )
	
	local row = mysql_fetch_assoc(result)
	if(row) then
		outputChatBox ( "Данный аккаунт уже зарегистрирован!",source )
		triggerClientEvent ( source, "showLoginPlayerS", getRootElement() )
	else
		outputChatBox ( "Данный аккаунт не зарегистрирован!",source )
		triggerClientEvent ( source, "showRegisterPlayerS", getRootElement() )
	end
	showPlayerHudComponent ( source, "radar", false )
	toggleControl ( source, "chatbox", false )
	mysql_free_result ( result )
--	toggleAllControls ( source, true, false, true, false )
end

addEvent("preLoadPlayerAccountC",true)
addEventHandler("preLoadPlayerAccountC",root,preLoadPlayerAccountS)

function spaceEvents ( source )
	if not getElementData ( source, "spaceNotAvailable" ) then 
		setElementData ( source, "spaceNotAvailable", true, false )
		setTimer ( function ( player ) setElementData ( player, "spaceNotAvailable", false, false ) end, 2000, 1, source )
		local x, y, z = getElementPosition ( source )
		local dim = getElementDimension ( source )
		local entsucces = 0
		if exports.sweetyRP:playerToPoint ( source, 1, -645.921875,1282.6513671875,11.050584793091 ) then
			if getElementData ( source, "quest_main_st" ) == 12 and getElementData ( source, "quest_main" ) == 1 then
				setElementPosition ( source, 521.4384765625,-2433.314453125,1204.150390625 )
			else
				outputChatBox ("Вы не знаете, как попасть в подводную лодку.", source, 0,153,51 )
			end
			return true
		end
		if exports.sweetyRP:playerToPoint ( source, 1, 2239.0498046875,1285.396484375,10.8203125 ) then
			if getElementData ( source, "quest_meh" ) == 3 then
				setElementInterior ( source, 1, 2265.9248046875,1647.6630859375,1084.234375 )
			else
				outputChatBox ("Вам незачем туда идти", source, 0,153,51 )
			end
			return true
		end
		if exports.sweetyRP:playerToPoint ( source, 1, 419.1611328125,2477.0849609375,16.492168426514 ) then
			if getElementData ( source, "quest_nvinsane" ) == 2 then
				exports.quests:insanePlayerCreate(source)
				fadeCamera ( source, false )
				setTimer ( function ()
								setElementDimension ( source, getElementData ( source, "playerid" ) )
								setElementPosition ( source, 396.6357421875,2475.189453125,16.5 )
								fadeCamera ( source, true )
							end, 1000, 1 )
			else
				outputChatBox ("Вам незачем туда идти", source, 0,153,51 )
			end
			return true
		end
		if exports.sweetyRP:playerToPoint ( source, 1, 1367.5576171875,248.2109375,19.566932678223 ) then
			if getElementData ( source, "quest_prob" ) == 1 then
				exports.quests:clamPlayerCreate(source)
				fadeCamera ( source, false )
				setTimer ( function ()
								setElementDimension ( source, getElementData ( source, "playerid" ) )
								setElementInterior ( source, 9 )
								setElementPosition ( source, 364.9072265625,-11.7666015625,1001.8515625 )
								fadeCamera ( source, true )
							end, 1000, 1 )
			else
				outputChatBox ("Вам незачем туда идти", source, 0,153,51 )
			end
			return true
		end
		if exports.sweetyRP:playerToPoint ( source, 1, 1276.8935546875,-997.5087890625,6645.7319335938 ) then
			if getElementData ( source, "detective_quest" ) > 0 and getElementData ( source, "detective_quest" ) < 6 then
				exports.quests:openDetectiveDoor ()
			else
				outputChatBox ("У вас нету ключа от этой двери.", source, 0,153,51 )
			end
		end
		if exports.sweetyRP:playerToPoint ( source, 1, -944.619140625,1860.0625,5 ) then
			exports.mxSkinSelector:exportSkinSelect ( source )
			return true
		end
		exports.buildings:toBuilding ( source )
	end
end


function firstArenaRoundStart ( source )
	exports.nz:nextArenaRoundStart( source )
end

function finishArenaFightS ( weaponnum )
	arenause = 0
	exports.safezones:checkPlayerSafezone(source)
	setElementData ( source, 'fireAllowed', false )
	takeAllWeapons ( source )
	setElementData ( source, "inventoryAllowed", 1 )
	setElementData ( source, "inarena", 0 )
	setElementData ( source, "arenaround", 0 )
	setElementData ( source, "arenaweaponnum", 0 )
	setElementData ( source, "arenatype", 0 )
    exports.nz:finishArenaFight()
end

addEvent( "finishArenaFight", true )
addEventHandler( "finishArenaFight", getRootElement(), finishArenaFightS )

function arenaFightFinished ( weaponnum )
	arenause = 0
end


function cancelArenaFightS ( weaponnum )
	arenause = 0
end

addEvent( "cancelArenaFight", true )
addEventHandler( "cancelArenaFight", getRootElement(), cancelArenaFightS )
