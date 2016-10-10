function sendGroupInviteS ( playerid )
	exports.players:startGroupCreation( source, "export", playerid )
end

addEvent( "sendGroupInviteC", true )
addEventHandler( "sendGroupInviteC", getRootElement(), sendGroupInviteS )

function givePlayerItemServer ( playerid, itemid, amount, id, maxItems, qty )
	if amount > 0 then
		local playersTable = getElementsByType ( "player", getRootElement() )
		local playerOnline = 0
		for i,player in ipairs (playersTable) do
			if getElementData ( player, "playerid" ) == playerid then
				playerOnline = 1
				if getElementData ( player, "invWeight" )+maxItems > getElementData ( player, "maxWeight" ) then
					exports.pipboy:addInfoBox ("У игрока достигнут максимум веса вещей.", 2, source )
					return true
				end
				exports.inventory:givePlayerItemServer ( player, itemid, 1, qty, true )
				exports.inventory:removePlayerItemServer ( source, itemid, 1 )
				triggerClientEvent ( player, "recieveSmthServer", getRootElement(), 1, getPlayerName ( source ) )
				triggerClientEvent ( source, "sendSmthServerDone", getRootElement(), 1, getPlayerName ( player ), id, amount-1, itemid, maxItems )
				interLogPost ( source, getPlayerName ( player ), "вещь", tostring(itemid) )
				break
			end
		end
		if playerOnline == 0 then
			outputChatBox ("Игрок не найден, возможно он покинул сервер.", source, 255,255,127 )
		end
	end
end

addEvent( "givePlayerItemClient", true )
addEventHandler( "givePlayerItemClient", getRootElement(), givePlayerItemServer )

function givePlayerWeaponServer ( playerid, weapid, amount, rowID, slot, ammo )
	if amount > 0 then
		local playersTable = getElementsByType ( "player", getRootElement() )
		local playerOnline = 0
		for i,player in ipairs (playersTable) do
			if getElementData ( player, "playerid" ) == playerid then
				playerOnline = 1
				local recievedPlayerWeap = getPedWeapon ( player, slot )
				if recievedPlayerWeap == 0 then
					giveWeapon ( player, weapid, ammo )
				else
					giveWeapon ( player, recievedPlayerWeap, ammo )
				end
				setWeaponAmmo ( source, weapid, amount-ammo )
				outputChatBox ( getPlayerName ( source ).." передал вам патроны", player, 140,140,140 )
				triggerClientEvent ( source, "sendSmthServerDone", getRootElement(), 2, getPlayerName ( player ), rowID, amount-ammo, weapid, slot )
				interLogPost ( source, getPlayerName ( player ), getWeaponNameFromID ( recievedPlayerWeap ), tostring(ammo) )
				break
			end
		end
		if playerOnline == 0 then
			outputChatBox ("Игрок не найден, возможно он покинул сервер.", source, 255,255,127 )
		end
	end
end

addEvent( "givePlayerWeaponClient", true )
addEventHandler( "givePlayerWeaponClient", getRootElement(), givePlayerWeaponServer )

function givePlayerMoneyServer ( playerid, amount )
	if amount > 0 then
		local playersTable = getElementsByType ( "player", getRootElement() )
		local playerOnline = 0
		for i,player in ipairs (playersTable) do
			if getElementData ( player, "playerid" ) == playerid then
				playerOnline = 1
				exports.inventory:removePlayerItemServer ( source, 51, amount )
				exports.inventory:givePlayerItemServer ( player, 51, amount )
				outputChatBox ( getPlayerName ( source ).." передал вам "..tostring(amount).." крышек", player, 140,140,140 )
				outputChatBox ( "Вы передали игроку "..getPlayerName ( player ).." "..tostring(amount).." крышек", source, 140,140,140 )
				interLogPost ( source, getPlayerName ( player ), "деньги", tostring(amount) )
				break
			end
		end
		if playerOnline == 0 then
			outputChatBox ("Игрок не найден, возможно он покинул сервер.", source, 255,255,127 )
		end
	end
end

addEvent( "givePlayerMoneyClient", true )
addEventHandler( "givePlayerMoneyClient", getRootElement(), givePlayerMoneyServer )

function interLogPost(thePlayer, arg1, arg2, arg3 )
	local lDate = getRealTime( )
	if lDate.minute < 10 then lDate.minute = "0"..lDate.minute end
	if lDate.second < 10 then lDate.second = "0"..lDate.second end
	local currDate = "["..lDate.hour..":"..lDate.minute..":"..lDate.second.."] "..lDate.monthday.."/"..(lDate.month+1).."/2013"
    hFile = fileOpen("interLog.txt", false)
    if hFile then
        local temp
        while not fileIsEOF(hFile) do
			temp = fileRead(hFile, 500)
		end
		fileWrite(hFile,currDate..' '..getPlayerName(thePlayer)..' передал ' .. tostring(arg1) .. ' ' .. tostring(arg2) .. ' ' .. tostring(arg3) .. '\n')
	else
        hFile = fileCreate("interLog.txt")
    end
    fileClose(hFile)
end
