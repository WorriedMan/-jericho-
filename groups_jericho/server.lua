local deletingGroups = {}
local playerInvites = {}
local timeoutedPlayers = {}
local gangsIcons = {}

local playerTeam = createTeam ("Игроки")
function updateGangTable()
	setPlayerTeam(source,playerTeam)
end
addEventHandler("onPlayerJoin",getRootElement(),updateGangTable)

function loadGroupsTable()
	database = exports.players:askMysqlHandler ()
	setTimer ( function () database = exports.players:askMysqlHandler () end, 3600000, 0 )
	dbExec ( database, "CREATE TABLE IF NOT EXISTS `newGroupsList` (`name` TEXT, `owner` TEXT, `players` INTEGER, `rating` INTEGER)" )
	dbExec ( database, "CREATE TABLE IF NOT EXISTS `newGroupsPlayersList` (`name` TEXT, `group` TEXT, `rank` INTEGER, `nick` TEXT)" )
	for i, v in ipairs ( getElementsByType ("player") ) do
		setPlayerTeam(v,playerTeam)
	end
end

addEventHandler ( "onResourceStart", getResourceRootElement(), loadGroupsTable )

function isPlayerTimeouted(player)
	return timeoutedPlayers[player]
end

function setPlatyerTimeout(player)
	timeoutedPlayers[player] = true
	setTimer(function() timeoutedPlayers[player] = nil end,1000,1)
end

function queryResult(query)
	local qh = dbQuery( database, query )
	local result = dbPoll( qh, -1 )
	return result
end

function askGroupsList(secondpage)
	if not isPlayerTimeouted(source) then
		setPlatyerTimeout(source)
		local result = queryResult( "SELECT * FROM `newGroupsList`")
		local playersInGroup = false
		local gang = getElementData ( source, "gang")
		local groupdeleting = false
		if gang then
			playersInGroup = getGroupPlayers(gang)
			if deletingGroups[gang] then
				groupdeleting = true
			end
		end
		triggerClientEvent(source,"groups:showGroupsWindow",source,result,playerInvites[source],playersInGroup,secondpage,groupdeleting,getPlayerRank(source))
	else
		outputChatBox("Система групп: Подождите немного!",source,255,100,100)
	end
end

addEvent("groups:askGroupsList",true)
addEventHandler("groups:askGroupsList",getRootElement(),askGroupsList)

function sendPlayerInvite(playername)
	if not isPlayerTimeouted(source) then
		local gang = getElementData(source,"gang")
		if not gang or not getGroupByName(gang) then
			exports.pipboy:addInfoBox("Вы не состоите в группе",3,source)
			return
		end
		setPlatyerTimeout(source)
		local player = getPlayerFromName(playername)
		if not playerInvites[player] then
			playerInvites[player] = {}
		end
		if player then
			local gang = getElementData(source,"gang")
			if not playerInvites[player][gang] then
				playerInvites[player][gang] = getPlayerName(source)
				addInfoBox( text, time, player, image )
				exports.pipboy:addInfoBox("Вы выслали приглашение игроку "..playername,3,source)
				exports.pipboy:addInfoBox("Вы были приглашены в группу. Нажмите F3.",3,player)
			else
				exports.pipboy:addInfoBox("Игрок уже имеет приглашение от вашей группы!",3,source)
			end
		else
			exports.pipboy:addInfoBox("Игрок не найден!",3,source)
		end
	else
		exports.pipboy:addInfoBox("Подождите!",3,source)
	end
end

addEvent("groups:sendPlayerInvite",true)
addEventHandler("groups:sendPlayerInvite",getRootElement(),sendPlayerInvite)

function inviteToGroupAccepted(name)
	if not isPlayerTimeouted(source) then
		setPlatyerTimeout(source)
		if playerInvites[source] and playerInvites[source][name] then
			if getElementData(source,"gang") then
				exports.pipboy:addInfoBox("Сначала покиньте свою текущую группу!",3,source)
				return
			end
			playerInvites[source] = {}
			addGroupMember(source,name,1)
			outputChatBox(getPlayerName(source).." вступил в группу "..name,root,100,255,100)
		end
	else
		exports.pipboy:addInfoBox("Подождите!",3,source)
	end
end

addEvent("groups:inviteToGroupAccepted",true)
addEventHandler("groups:inviteToGroupAccepted",getRootElement(),inviteToGroupAccepted)

function kickSelectedPlayer(playerName)
	if not isPlayerTimeouted(source) then
		setPlatyerTimeout(source)
		deletePlayerFromGroup(playerName,getPlayerGang(source))
		exports.pipboy:addInfoBox("Вы успешно выгнали игрока из группы",3,source)
		local acc = getAccount(playerName)
		local player = getAccountPlayer(acc)
		if player then
			setElementData(player,"gang",nil)
			setElementData(player,"gang:rank",nil)
			exports.pipboy:addInfoBox(getPlayerName(source).." выгнал вас из группы",3,player)
		end
	else
		exports.pipboy:addInfoBox("Подождите!",3,source)
	end
end

addEvent("groups:kickSelectedPlayer",true)
addEventHandler("groups:kickSelectedPlayer",getRootElement(),kickSelectedPlayer)

function leaveMyGroup()
	if not isPlayerTimeouted(source) then
		setPlatyerTimeout(source)
		local gang = getElementData(source,"gang")
		local rank = getPlayerRank(source)
		if gang and rank then
			if rank == leaderRank then
				local result = queryResult( "SELECT * FROM `newGroupsPlayersList` WHERE `group` = '"..gang.."' AND `rank` = "..leaderRank)
				if result and #result < 2 then
					exports.pipboy:addInfoBox("В группе должен быть хотя бы один лидер!",3,source)
					return
				end
			end
			--local gangTable = getGroupByName(gang)
			--if gangTable then
				-- if gangTable.owner == getAccountName(getPlayerAccount(source)) then
					-- outputChatBox("Система групп: Вы не можете покинуть группу",source,255,100,100)
					-- return
				-- end
				setElementData(source,"gang",nil)
				setElementData(source,"gang:rank",nil)
				deletePlayerFromGroup(getAccountName(getPlayerAccount(source)),gang)
			--end
		end
		exports.pipboy:addInfoBox("Вы успешно вышли из группы",3,source)
	else
		exports.pipboy:addInfoBox("Подождите!",3,source)
	end
end

addEvent("groups:leaveMyGroup",true)
addEventHandler("groups:leaveMyGroup",getRootElement(),leaveMyGroup)

function deleteMyGroup()
	if not isPlayerTimeouted(source) then
		setPlatyerTimeout(source)
		local gang = getPlayerGang(source)
		if gang then
			local rank = getPlayerRank(source)
			if rank and rank == leaderRank then
				if deletingGroups[gang] then
					if isTimer(deletingGroups[gang][1]) then
						killTimer(deletingGroups[gang][1])
					end
					deletingGroups[gang] = nil
					exports.pipboy:addInfoBox("Вы отменили удаление вашей группы.",3,source)
				else		
					deletingGroups[gang] = {setTimer(deleteGroup,groupDeleteTimeout,1,gang), getAccountName(getPlayerAccount(source))}
					exports.pipboy:addInfoBox("Вы запустили таймер уничтожения группы! Она удалится через минуту.",3,source)
				end
				return
			end
		end
		exports.pipboy:addInfoBox("Вы не можете сделать этого.",2,source)
	else
		exports.pipboy:addInfoBox("Подождите!",3,source)
	end
end

addEvent("groups:deleteMyGroup",true)
addEventHandler("groups:deleteMyGroup",getRootElement(),deleteMyGroup)

function updatePlayerRank(playerName,rank)
	if not isPlayerTimeouted(source) then
		setPlatyerTimeout(source)
		setPlayerRank(playerName,rank)
		exports.pipboy:addInfoBox("Вы изменили ранг игрока.",3,source)
	else
		exports.pipboy:addInfoBox("Подождите!",3,source)
	end
end

addEvent("groups:updatePlayerRank",true)
addEventHandler("groups:updatePlayerRank",getRootElement(),updatePlayerRank)

function createNewGroup(groupname)
	if not isPlayerTimeouted(source) then
		setPlatyerTimeout(source)
		local gang = getElementData(source,"gang")
		if gang then
			outputChatBox("Система групп: Сначала выйдите из текущей группы!",source,255,100,100)
			return
		end
		if not getGroupByName(groupname) then
			dbExec(database,"INSERT INTO `newGroupsList` (`name`, `owner`, `players`, `rating`) values(?,?,?,?)", groupname, getAccountName(getPlayerAccount(source)), 0, 0 )
			addGroupMember(source,groupname,leaderRank)
			exports.pipboy:addInfoBox("Вы создали новую группу и автоматически вступили в нее!",3,source)
		else
			exports.pipboy:addInfoBox("Система групп: Группа с таким названием уже существует!",3,source)
		end		
	else
		exports.pipboy:addInfoBox("Подождите!",3,source)
	end
end

addEvent("groups:createNewGroup",true)
addEventHandler("groups:createNewGroup",getRootElement(),createNewGroup)

addEventHandler("onPlayerLogin", root,
	function(_,acc)
		local accName = getAccountName(acc)
		playerInvites[source] = {}
		if accName then
			dbExec(database,"UPDATE `newGroupsPlayersList` SET `nick` = '"..getPlayerName(source).."' WHERE `name` = '"..accName.."'" )
			local gang_name, gang_rank = getPlayerGroupSql(source)
			if gang_name and gang_rank then
				setElementData ( source, "gang",gang_name)
				setElementData ( source, "gang:rank",gang_rank)
				if deletingGroups[gang_name] then
					outputChatBox("ВНИМАНИЕ! Ваша группа скоро удалится. Вы можете отменить это действие.",source,255,0,0)
					outputChatBox("Запустил удаление: "..deletingGroups[gang_name][2],source,255,0,0)
				end
			end
		end
	end
)

function quitPlayer ( quitType )
	if playerInvites[source] then
		playerInvites[source] = nil
	end
	local gang = getElementData(source,"gang")
	if gang then
		if gangsIcons[gang] then
			local acc = getAccountName(getPlayerAccount(source))
			if gangsIcons[gang][acc] then
				gangsIcons[gang][acc] = nil
				refreshGroupIcons(gang)
			end
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )

function groupChat( message, messageType )
	cancelEvent()
    if (messageType == 2) then
		local mygang = getElementData(source,"gang")
		if not mygang then return end
		for i, player in ipairs(getElementsByType("player")) do
			local gang = getElementData(player,"gang")
			if gang and mygang == gang then
				outputChatBox("[Группа]"..getPlayerName(source)..": "..message,player,255,255,255,true)
			end	
		end
	end	
end
addEventHandler( "onPlayerChat", getRootElement(), groupChat )

function pipIconAdded(x,y)
	local gang = getElementData(source,"gang")
	if gang then
		if not gangsIcons[gang] then
			gangsIcons[gang] = {}
		end
		local acc = getAccountName(getPlayerAccount(source))
		gangsIcons[gang][acc] = {x,y,getPlayerName(source)}
		refreshGroupIcons(gang)
	end
end

addEvent("groups:pipIconAdded",true)
addEventHandler("groups:pipIconAdded",getRootElement(),pipIconAdded)

function removeGangIcon()
	local gang = getElementData(source,"gang")
	if gang then
		if gangsIcons[gang] then
			local acc = getAccountName(getPlayerAccount(source))
			gangsIcons[gang][acc] = nil
			refreshGroupIcons(gang)
		end
	end
end

addEvent("groups:removeGangIcon",true)
addEventHandler("groups:removeGangIcon",getRootElement(),removeGangIcon)

function refreshGroupIcons(gang)
	if gangsIcons[gang] then
		for i, player in ipairs(getElementsByType("player")) do
			local pgang = getElementData(player,"gang")
			if pgang and pgang == gang then
				triggerClientEvent(player,"pipboy:refreshGroupIcons",player,gangsIcons[gang])
			end	
		end
	end
end