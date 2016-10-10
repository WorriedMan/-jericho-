function paySuccess(name,amount)
	outputDebugString("Donat "..tostring(name).." money: "..tostring(amount).."")
	local acc = getAccount(name)
	if acc then
		local player = getAccountPlayer(acc)
		if player then
			setElementData(player,"points",(getElementData(player,"points") or 0)+amount)
			exports.pipboy:addInfoBox ( "Вы получили "..amount.." Сувенирные Монеты РобКо", 3, player )
		else
			local id = getAccountData(acc,"playerid")
			if id then
				local qh = dbQuery(exports.players:askMysqlHandler(), "SELECT * FROM `accounts` WHERE `id` = "..id)
				if qh then
					local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
					if result[1] and tonumber(result[1].points) then
						local query = dbQuery(exports.players:askMysqlHandler(), "UPDATE `accounts` SET `points` = "..tonumber(result[1].points)+amount.." WHERE `id` = "..id )
						if(query) then
							dbFree(query)
						else
							return false, "unable to save"
						end
					end
				else
					return false, "unable to save"
				end
			else
				return false, "account not found"
			end
		end
		return true
	end
	return false, "account not found"
end