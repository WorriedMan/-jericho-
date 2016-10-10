function givePoint ( quant )
	setElementData ( localPlayer, "points", getElementData(localPlayer, "points")+quant )
	if quant == 1 then
		exports.pipboy:addInfoBox("Вы получили "..quant.." сувенирную монету РобКО", 3 )
	elseif quant < 4 then
		exports.pipboy:addInfoBox("Вы получили "..quant.." сувенирные монеты РобКО", 3 )
	else
		exports.pipboy:addInfoBox("Вы получили "..quant.." сувенирных монет РобКО", 3 )
	end
end