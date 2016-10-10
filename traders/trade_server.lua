function attemptToBuyItem (trader,item,discount)
	if source == client then
		local caps = exports.inventory:getPlayerCaps(source)
		local finalprice = math.floor(tradeItems[item].prices[trader]*(1-discount/100))
		if caps >= finalprice then
			exports.inventory:removePlayerItemServer ( source, 51, finalprice )
			exports.inventory:givePlayerItemServerWW ( source, tradeItems[item].item_id, tradeItems[item].quant, tradeItems[item].qty, true )
			exports.pipboy:addInfoBox("Вы купили "..item.." за "..finalprice.." Кр.",3,source)
			tradeLogPost(source,2,item,trader,finalprice,discount)
			triggerClientEvent(source,"trade_new:purchaseCompleted",source,true)
			return
		end
		triggerClientEvent(source,"trade_new:purchaseCompleted",source,false)
		exports.pipboy:addInfoBox("Вам не хватает крышек.",3,source)
	else
		outputDebugString("Client/source trading mismatch "..getPlayerName(client))
	end
end

addEvent("trade_new:attemptToBuyItem",true)
addEventHandler("trade_new:attemptToBuyItem",root,attemptToBuyItem)

function goodBoughtServer ( name, quant, price, country )
	tradeLogPost(source, 2, quant, name, country, price )
end

addEvent("goodBoughtServerC",true)
addEventHandler("goodBoughtServerC",root,goodBoughtServer)

stringName = {
	"moneyNC",
	"moneySU",
	"moneyNV",

}

function goodSoldServer ( name, quant, price, country )
	setElementData ( source, stringName[country], getElementData ( source, stringName[country] ) - price )
	tradeLogPost(source, 1, quant, name, country, price )
end

addEvent("goodSoldServerC",true)
addEventHandler("goodSoldServerC",root,goodSoldServer)


function tradeLogPost(thePlayer, lType, arg1, arg2, arg3, arg4 )
	local lDate = getRealTime( )
	if lDate.minute < 10 then lDate.minute = "0"..lDate.minute end
	if lDate.second < 10 then lDate.second = "0"..lDate.second end
	local currDate = "["..lDate.hour..":"..lDate.minute..":"..lDate.second.."] "..lDate.monthday.."/"..(lDate.month+1).."/2013"
    hFile = fileOpen("tradeLog.txt", false)
    if hFile then
        local temp
        while not fileIsEOF(hFile) do
			temp = fileRead(hFile, 500)
		end
		if lType == 1 then
			fileWrite(hFile,currDate..' '..getPlayerName(thePlayer)..' продал ' .. tostring(arg1) .. ' у ' .. arg2 .. ' за ' ..arg3.. ' ск ' .. tostring(arg4) .. '\n')
		else
			fileWrite(hFile,currDate..' '..getPlayerName(thePlayer)..' купил ' .. tostring(arg1) .. ' у ' .. arg2 .. ' за ' ..arg3.. ' ск ' .. tostring(arg4) .. '\n')
		end
    else
        hFile = fileCreate("tradeLog.txt")
    end
    fileClose(hFile)
end