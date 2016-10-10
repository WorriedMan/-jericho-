function givePoint ( playerid, quant )
	for i, v in ipairs ( getElementsByType ( 'player' ) ) do
		if getElementData ( v, "playerid" ) == playerid then
			setElementData ( v, "points", getElementData(v, "points")+quant )
			if quant == 1 then
				exports.pipboy:addInfoBox("Вы получили "..quant.." сувенирную монету РобКО", 3, v )
			elseif quant < 4 then
				exports.pipboy:addInfoBox("Вы получили "..quant.." сувенирные монеты РобКО", 3, v )
			else
				exports.pipboy:addInfoBox("Вы получили "..quant.." сувенирных монет РобКО", 3, v )
			end
			return true
		end
	end
end