function giveTradersMoney ( amount )
	givePlayerMoney ( source, amount )
	return true
end

addEvent("giveTradersMoneyC",true)
addEventHandler("giveTradersMoneyC",root,giveTradersMoney)

function takeTradersMoney ( amount )
	takePlayerMoney ( source, amount )
	return true
end

addEvent("takeTradersMoneyC",true)
addEventHandler("takeTradersMoneyC",root,takeTradersMoney)

function getWeaponsForSellS ( slot, id, country, quant, name, price )
	local ammo = getPedTotalAmmo ( source, slot )
	local quant = tonumber(quant)
	local name = string.lower(name)
	if ammo > 0 then
		if ammo >= quant then
			outputChatBox ( "Вы успешно продали "..quant.." "..name.." за "..price*quant.."$", source, 255, 255, 255 )
			givePlayerMoney ( source, price*quant )
			local weaponID = getPedWeapon ( source, slot )
			setWeaponAmmo ( source, weaponID, ammo-quant )
			--tradeLogPost(source, 1, quant, getWeaponNameFromID ( weaponID ), country, price*quant )
		else
			outputChatBox ( "У вас нет столько патрон", source, 255, 255, 255 )
		end
	end
end

addEvent("getWeaponsForSell",true)
addEventHandler("getWeaponsForSell",root,getWeaponsForSellS)

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

placeLog = { 
	"Новой Деревне",
	"Союзе Ученых",
	"Новом Вегасе",
	"Посту",
	"Вест Сайде",
	"Ривете",
	"Кламате"
}


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
			fileWrite(hFile,currDate..' '..getPlayerName(thePlayer)..' продал ' .. tostring(arg1) .. ' ' .. tostring(arg2) .. ' в ' ..placeLog[arg3].. ' за ' .. tostring(arg4) .. '$\n')
		else
			fileWrite(hFile,currDate..' '..getPlayerName(thePlayer)..' купил ' .. tostring(arg1) .. ' ' .. tostring(arg2) .. ' в ' ..placeLog[arg3].. ' за ' .. tostring(arg4) .. '$\n')
		end
    else
        hFile = fileCreate("tradeLog.txt")
    end
    fileClose(hFile)
end