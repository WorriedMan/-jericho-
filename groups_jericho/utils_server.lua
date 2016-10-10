function getGroupByName(groupName)
	local group = queryResult("SELECT * FROM `newGroupsList` WHERE `name` = '"..groupName.."'")
	if group and group[1] then
		return group[1]
	else
		return false
	end
end

function checkIfPlayerGroupMember(player,groupName)
	if isElement ( player ) then
		local result = queryResult( "SELECT * FROM `newGroupsPlayersList` WHERE `group` = '"..groupName.."' AND `name` = '"..getAccountName(getPlayerAccount(player)).."'")
		return result and #result > 0 or false
	end
	return false
end

function getGroupPlayers(groupName)
	return queryResult( "SELECT * FROM `newGroupsPlayersList` WHERE `group` = '"..groupName.."'")
end

function getPlayerGroupSql(player)
	if isElement ( player ) then
		local result = queryResult( "SELECT * FROM `newGroupsPlayersList` WHERE `name` = '"..getAccountName(getPlayerAccount(player)).."'")
		if result and result[1] then
			return result[1].group, result[1].rank
		end
	end
	return false
end

function addGroupMember(player,groupName,rank)
	if getGroupByName(groupName) then
		if not checkIfPlayerGroupMember(player,groupName) then
			dbExec(database,"INSERT INTO `newGroupsPlayersList` (`name`, `group`, `rank`, `nick`) values(?,?,?,?)", getAccountName(getPlayerAccount(player)), groupName, rank, getPlayerName(player) )
			dbExec(database,"UPDATE `newGroupsList` SET `players` = "..(#getGroupPlayers(groupName)).." WHERE `name` = '"..groupName.."'" )
			setElementData ( player, "gang",groupName)
			setElementData ( player, "gang:rank",rank)
			return true
		end
	end
	return false
end

function deletePlayerFromGroup(playerAccName,groupName)
	dbExec(database,"DELETE FROM `newGroupsPlayersList` WHERE `name`='"..playerAccName.."'")
	if groupName then
		dbExec(database,"UPDATE `newGroupsList` SET `players` = "..(#getGroupPlayers(groupName)).." WHERE `name` = '"..groupName.."'" )
	end
end

function deleteGroup(groupName)
	if groupName then
		local players = getGroupPlayers(groupName)
		if players then
			for i, v in ipairs ( players ) do
				local acc = getAccount (v.name)
				local player = getAccountPlayer(acc)
				if player then
					setElementData ( player, "gang",nil)
					setElementData ( player, "gang:rank",nil)
				end
			end
		end
		dbExec(database,"DELETE FROM `newGroupsList` WHERE `name`='"..groupName.."'")
		dbExec(database,"DELETE FROM `newGroupsPlayersList` WHERE `group`='"..groupName.."'")
	end
end

function setPlayerRank(accName,rank)
	local acc = getAccount(accName)
	local player = getAccountPlayer(acc)
	if player then
		setElementData ( player, "gang:rank",rank)
		dbExec(database,"UPDATE `newGroupsPlayersList` SET `rank` = "..rank.." WHERE `name` = '"..accName.."'" )
		outputChatBox ("Вам был изменен ранг. Теперь вы: "..rankNames[rank],player,100,255,100)
	end
end

function getGroupRating(groupName)
	local result = queryResult( "SELECT * FROM `newGroupsList` WHERE `name` = '"..groupName.."'")
	if result and #result > 0 then
		return result[1].rating
	end	
	return 0
end

function setGroupRating(groupName,rating)
	if getGroupByName(groupName) then
		dbExec(database,"UPDATE `newGroupsList` SET `rating` = "..rating.." WHERE `name` = '"..groupName.."'" )
		return true
	else
		return false
	end
end

function givePlayerGroupRating(player,give)
	local gang = getElementData ( player, "gang")
	if gang and getGroupByName(gang) then
		local rating = getGroupRating(gang)
		if rating then
			if rating+give < 0 then
				rating = 0
			else
				rating = rating+give
			end
			local ratingset = setGroupRating(gang,rating)
			if ratingset then
				return true
			end
		end
	end
	return false
end

function tempGivePlayerGroupRating(rating)
	if source == client then
		givePlayerGroupRating(source,rating)
	end
end

addEvent( "givePlayerGroupRating", true )
addEventHandler( "givePlayerGroupRating", getRootElement(), tempGivePlayerGroupRating )
