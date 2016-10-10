function sendToPlayer( player, radius, x, y, z )
    if isElement( player ) and radius and x and y and z then
        return getDistanceBetweenPoints3D( x, y, z, getElementPosition( player ) ) <= radius
    end
    return false
end

function sendMessageToPoint( source, x, y, z, points, type, r,g,b, text )
	for id, player in ipairs ( getElementsByType ( "player" ) ) do
		if ( playerToPoint ( player, points, x, y, z ) ) then outputChatBox ( " " .. getPlayerName(source) .. " ".. tostring(type) ..": " .. tostring(text) .. " ", player, r,g,b ) end
	end
end

function sendNonRPMessage( source, x, y, z, points, type, r,g,b, text )
	for id, player in ipairs ( getElementsByType ( "player" ) ) do
		if ( playerToPoint ( player, points, x, y, z ) ) then outputChatBox ( " (( " .. getPlayerName(source) .. " ".. tostring(type) ..": " .. tostring(text) .. " )) ", player, r,g,b ) end
	end
end

function rollingChat(thePlayer, cmd, arg1, arg2)
	if not arg1 or not arg2 or tonumber(arg1) > tonumber(arg2) then
		outputChatBox("Правильно: /roll [от] [до]",player,255,100,100)
		return
	end
	local x,y,z = getElementPosition(thePlayer)
	local points = 15
	local result = math.random(tonumber(arg1),tonumber(arg2))
	local message = getPlayerName(thePlayer) .. " бросает кости! Результат: "..result.." ("..arg1.."/"..arg2..")."
	for id, player in ipairs ( getElementsByType ( "player" ) ) do
		if ( playerToPoint ( player, points, x, y, z ) ) then outputChatBox ( message, player, 255,255,255 ) end
	end	
end

addCommandHandler ("roll", rollingChat)

function tryingChat(thePlayer, cmd, ...)
	local parametersTable = {...}
   	local text = table.concat(parametersTable, " ")
	if not text then
		outputChatBox("Правильно: /try [действие]",player,255,100,100)
		return
	end
	local result = math.random(1,2) == 1 and "(успешно)" or "(неудачно)"
	local x,y,z = getElementPosition(thePlayer)
	local points = 15
	local message = getPlayerName(thePlayer) .. " пытается "..text.." "..result
	for id, player in ipairs ( getElementsByType ( "player" ) ) do
		if ( playerToPoint ( player, points, x, y, z ) ) then outputChatBox ( message, player, 255,255,255 ) end
	end	
end

addCommandHandler ("try", tryingChat)

function blockChatMessage( message, messageType )
	if messageType == 0 then
		cancelEvent()
		setElementData ( source, "chatNear", true )
	elseif messageType == 1 then
		MeChat ( source, message )
		cancelEvent()
	end
end
addEventHandler( "onPlayerChat", getRootElement(), blockChatMessage )

function globalOOC(thePlayer, commandName, ...)
	local parametersTable = {...}
   	local text = table.concat(parametersTable, " ")
	if (text) then
		if exports.admin:isPlayerMuted(thePlayer) then return true end
		chatLogPost ( thePlayer, "OOC", text )
		local accName = getAccountName ( getPlayerAccount ( thePlayer ) )
		local x,y,z = getElementPosition( thePlayer )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) )then
			outputChatBox ( "(( ADM "..getPlayerName(thePlayer)..": "..text.." ))", getRootElement(), 0,127,255 )
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Helper" ) )then
			local msg = checkSwear ( text )
			outputChatBox ( "(( Хелпер "..getPlayerName(thePlayer)..": "..msg.." ))", getRootElement(), 0,127,255 )
		else
			if getElementData ( thePlayer, "chattedO" ) == false then
				setElementData ( thePlayer, "chattedO", true )
				setTimer ( setElementData, 3000, 1, thePlayer, "chattedO", false )
				local msg = checkSwear ( text )
				outputChatBox ( "(( "..getPlayerName(thePlayer)..": "..msg.." ))", getRootElement(), 51,204,255 )
			else
				outputChatBox ( "В чат можно писать раз 3 секунды", thePlayer )
			end
		end
	else
	  	outputChatBox ("Правильно: /o(oc) текст ", thePlayer, 255,255,127 )
	end

end
addCommandHandler("Чат", globalOOC)

function SayChat( ... )
	if getElementData ( source, "chatNear" ) then
		if getElementData ( source, "chatted" ) == false then
			setElementData ( source, "chatted", true )
			setTimer ( setElementData, 3000, 1, source, "chatted", false )
			setElementData ( source, "chatNear", false )
			local parametersTable = {...}
			table.remove(parametersTable,#parametersTable)
			local text = table.concat(parametersTable, " ")
			chatLogPost ( source, "рядом", text )
			local x,y,z = getElementPosition( source )
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if(getElementData ( source, "clap" ) == 1) then
					if ( playerToPoint ( player, 15, x, y, z ) ) then outputChatBox ( " " .. getPlayerName(source) .. " сказал: мм-мм-мм ", player, 204,204,255 ) end
					return true
				else
					if ( playerToPoint ( player, 15, x, y, z ) ) then outputChatBox ( " " .. getPlayerName(source) .. " сказал: " .. tostring(text) .. " ", player, 204,204,255 ) end
				end
			end
		else
			outputChatBox ( "В чат можно писать раз 3 секунды", source )
		end
	end
end

addEventHandler( "onPlayerChat", getRootElement(), SayChat )

function WhisperChat( source, commandName, ident, ... )
	if getElementData ( source, "chattedW" ) == false then
		setElementData ( source, "chattedW", true )
		setTimer ( setElementData, 3000, 1, source, "chattedW", false )
		local parametersTable = {...}
		local text = table.concat(parametersTable, " ")
		if (text) then
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if getElementData ( player, "playerid" ) == ident then
					outputChatBox ("PM " .. getPlayerName(source) .. " (ID "..getElementData ( source, "playerid" ).."): "..text.." ",player, 255,255,127 )
					outputChatBox ("PM для " .. getPlayerName(player) .. ": "..text.." ",source, 255,255,127 )
					chatLogPost ( source, getPlayerName(player), text )
					return true
				end
			end
		else
			outputChatBox ("Правильно: /w [ид игрока] текст ", source, 255,255,127 )
		end
	else
		outputChatBox ( "В чат можно писать раз 3 секунды", source )
	end
end

addCommandHandler ("w", WhisperChat)

function OOChat( player, cmd, ... )
	local parametersTable = {...}
   	local text = table.concat(parametersTable, " ")
	if (text) then
		chatLogPost ( player, "OOC", text )
		local accName = getAccountName ( getPlayerAccount ( player ) )
		local x,y,z = getElementPosition( player )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) )then
			outputChatBox ( "(( ADM "..getPlayerName(player)..": "..text.." ))", getRootElement(), 0,127,255 )
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "Helper" ) )then
			local msg = checkSwear ( text )
			outputChatBox ( "(( Хелпер "..getPlayerName(player)..": "..msg.." ))", getRootElement(), 0,127,255 )
		else
			if getElementData ( player, "chattedO" ) == false then
				setElementData ( player, "chattedO", true )
				setTimer ( setElementData, 3000, 1, player, "chattedO", false )
				local msg = checkSwear ( text )
				outputChatBox ( "(( "..getPlayerName(player)..": "..msg.." ))", getRootElement(), 51,204,255 )
			else
				outputChatBox ( "В чат можно писать раз 3 секунды", player )
			end
		end
	else
	  	outputChatBox ("Правильно: /o(oc) текст ", player, 255,255,127 )
	end
end

--addCommandHandler ("o", OOChat)
--addCommandHandler ("ooc", OOChat)

swearWords = {
	"хуй",
	"блять",
	"пизда",
	"сасай",
	"соси",
	"еблан",
	"ебан",
	"сука",
	"ХУЙ",
	"БЛЯТЬ",
	"ПИЗДА",
	"СОСИ",
	"ЕБЛАН",
	"ЕБАН",
	"СУКА",
	"БЛЯЯТЬ",
	"бляять",
	"МИР",
	"мир",
	"ВЫЕБАЛ",
	"выебал",
	"БЛЯДЬ",
	"блядь"
}

function checkSwear ( msg )
	local new = ""
	local iter = 0
	for word in msg:gmatch("%S+") do
		iter = iter + 1
		for i,swr in ipairs(swearWords) do
		local src = word:lower():gsub("%s","")
		local src = src:gsub("#%x%x%x%x%x%x","")
		local src = src:gsub("%c","")
		local src = src:gsub("%p","")
		local pat = swr:lower():gsub("%s","")
		if src:find(pat) then
			local replaceString = ""
			for x=1,word:gsub("#%x%x%x%x%x%x",""):len() do
			replaceString = replaceString.."*"
			end
			word = word:gsub(word,replaceString)
		end
		end
		if iter == 1 and word:len() > 2 then
		word = word:gsub("%a",string.upper,1)
		end
		new = new..word.." "
	end
	if new ~= "" then msg = new end

	-- Get appropriate team colors and output the clean message
	return msg
end

-- сообщение действия

actionMessages = {
"ест мясо", -- 1
"использует стимулятор", -- 2
"выпивает бутылку воды", -- 3
"поедает зажаренную во фритюре руку гуля", -- 4
"вкалывает себе лекартсво", -- 5

"хрустит, поедая свежеиспеченную птицу-зомби", -- 6
"выпивает пивка для рывка", -- 7
"выпивает водочки для обводочки", -- 8
"выпивает самогона для обгона", -- 9
"ест баночку шпината и чувствует прилив сил!", -- 10
"открывает банку тушенки", -- 11
"ест консервы", -- 12
"хрустит грекцими орехами", -- 13
"рассматривает странную монету", -- 14
}

function sendActionMessage( source, x, y, z, points, action )
	for id, player in ipairs ( getElementsByType ( "player" ) ) do
		if ( playerToPoint ( player, points, x, y, z ) ) then outputChatBox ( getPlayerName(source) .. " "..action, player,51,204,255 ) end
	end
end

function sendActionMessageServer ( source, nomer )
    local x,y,z = getElementPosition( source )
	sendActionMessage( source, x, y, z, 7, actionMessages[nomer] )
end

function sendTransportActionMessage ( nomer )
    sendActionMessageServer ( source, nomer )
end

addEvent( "sendActionMessageC", true )
addEventHandler( "sendActionMessageC", getRootElement(), sendTransportActionMessage )

function sendTransportActionMessageText ( text )
	local x,y,z = getElementPosition ( source )
    sendActionMessage ( source, x,y,z, 7, text )
end

addEvent( "sendActionMessageTextC", true )
addEventHandler( "sendActionMessageTextC", getRootElement(), sendTransportActionMessageText )

function chatLogPost(thePlayer, arg1, arg2 )
	local lDate = getRealTime( )
	if lDate.minute < 10 then lDate.minute = "0"..lDate.minute end
	if lDate.second < 10 then lDate.second = "0"..lDate.second end
	local currDate = "["..lDate.hour..":"..lDate.minute..":"..lDate.second.."] "..lDate.monthday.."/"..(lDate.month+1).."/2013"
    hFile = fileOpen("chatLog.txt", false)
    if hFile then
        local temp
        while not fileIsEOF(hFile) do
			temp = fileRead(hFile, 500)
		end
		fileWrite(hFile,currDate..' '..getPlayerName(thePlayer)..' ' .. tostring(arg1) .. ': ' .. tostring(arg2) .. '\n')
	else
        hFile = fileCreate("chatLog.txt")
    end
    fileClose(hFile)
end

function MeChat( source, ... )
	local parametersTable = {...}
   	local action = table.concat(parametersTable, " ")
	if (action) then
		local x,y,z = getElementPosition( source )
  		sendActionMessage( source, x, y, z, 6, action )
	else
	  		outputChatBox ("Правильно: /me действие ", source, 255,255,127 )
	end
end

addCommandHandler ("me", MeChat)

function NonRPChat( player, cmd, ... )
	local parametersTable = {...}
   	local text = table.concat(parametersTable, " ")
	if (text) then
		local x,y,z = getElementPosition( player )
		sendNonRPMessage( player, x, y, z, 7, "сказал",175,175,175, text )
	else
	  		outputChatBox ("Правильно: /b текст ", player, 255,255,127 )
	end
end

addCommandHandler ("b", NonRPChat)

function DoChat( source, cmd, ... )
	local parametersTable = {...}
   	local text = table.concat(parametersTable, " ")
	if (text) then
		local x,y,z = getElementPosition( source )
		for id, player in ipairs ( getElementsByType ( "player" ) ) do
			if ( playerToPoint ( player, 7, x, y, z ) ) then outputChatBox ( ""..text.." (( " .. getPlayerName(source) .. " ))", player,51,204,255 ) end
		end
	else
	  		outputChatBox ("Правильно: /do действие ", source, 255,255,127 )
	end
end

addCommandHandler ("do", DoChat)
