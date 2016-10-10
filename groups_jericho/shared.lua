rankNames = { "Новичок", "Проверенный", "Свой", "Руководитель", "Создатель" }
leaderRank = 5
groupDeleteTimeout = 60000 -- через сколько милисекунд удалять группу

function getPlayerGang(player)
	if not player and localPlayer then
		return getElementData ( localPlayer, "gang" ) or false
	else
		if isElement ( player ) then
			return getElementData ( player, "gang" ) or false
		end
	end
	return false
end

function getPlayerRank(player)
	if not player and localPlayer then
		return getElementData ( localPlayer, "gang:rank" ) or false
	else
		if isElement ( player ) then
			return getElementData ( player, "gang:rank" ) or false
		end
	end
	return false
end
