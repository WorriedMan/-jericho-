function setPlayerVIP ( player, amount )
	setElementData ( player, "timestampVip", amount )
	setElementData ( player, "vip" )
	local res3 = dbQuery ( database, "UPDATE `accounts` SET vipTimestamp = " .. tostring(amount).. " WHERE `id` = "..getAccountData ( getPlayerAccount ( player ), "playerid"  ) )
	dbFree ( res3 )
end

function addPlayerVIP ( player, amount )
	setElementData ( player, "timestampVip", getElementData ( player, "timestampVip" ) + amount )
	setElementData ( player, "vip" )
	exports.pipboy:addInfoBox ( "Ваш VIP аккаунт продлен на "..tostring(amount), 5, player )
	local res3 = dbQuery ( database, "UPDATE `accounts` SET vipTimestamp = " .. tostring( getElementData ( player, "timestampVip" ) + amount).. " WHERE `id` = "..getAccountData ( getPlayerAccount ( player ), "playerid"  ) )
	dbFree ( res3 )
end
