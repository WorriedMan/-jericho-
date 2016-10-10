function loadServProp ()
	local xmlFile = xmlLoadFile ( "ServerProp.xml" ) -- Open a file that we have already created
	setGameType("RPG")
	if xmlFile then -- If it's indeed opened
		local node = xmlFindChild ( xmlFile, "sname", 0 )
		success = xmlNodeGetValue ( node )
		local serveradmin = xmlFindChild ( xmlFile, "admin", 0 )
		serveradmin1 = xmlNodeGetValue ( serveradmin )                              
		local scripter = xmlFindChild (xmlFile, "scripter", 0 )
		scripter1 = xmlNodeGetValue ( scripter )
		local site = xmlFindChild (xmlFile, "site", 0 )
		site1 = xmlNodeGetValue ( site )
		local vers = xmlFindChild (xmlFile, "version", 0 )
		version = xmlNodeGetValue ( vers )
		local tax1 = xmlFindChild (xmlFile, "tax", 0 )
		tax = xmlNodeGetValue ( tax1 )
		    setWeather ( 20 )
		setMinuteDuration(30000)
		--setFarClipDistance ( 80 )
		setTrafficLightState("disabled")
		setTime ( 15, 0 )
		--setSkyGradient ( 0, 0, 0, 0, 0, 0 )
		-- создание пикапов
		
		-- новая деревня
		ncSpawn = createPickup ( -943.38671875,1953.1123046875,5, 3, 1277 )
		ncSpawnText = exports.dtext:create3DText ( -943.38671875,1953.1123046875,6, "Встаньте для появления в Новой Деревне", 255, 255, 255, 255, "spawn" )
		setElementInterior ( ncSpawn, 17 )
		setElementInterior ( ncSpawnText, 17 )
		
		ncCloth = createPickup ( -944.2978515625,1860.0947265625,5, 3, 1275 )
		ncClothText = exports.dtext:create3DText ( -944.2978515625,1860.0947265625,6, "Сменить скин игрока", 255, 255, 255, 255, "spawn" )
		setElementInterior ( ncCloth, 17 )
		setElementInterior ( ncClothText, 17 )
		
		suSpawn = createPickup ( 243, 1855, 9, 3, 1277 )
		suSpawnText = exports.dtext:create3DText ( 243, 1855, 10, "Встаньте для появления в Союзе Ученых", 255, 255, 255, 255, "spawn" )

		
		nvSpawn = createPickup ( -259.3125,2607.81640625,62.858154296875, 3, 1277 )
		nvSpawnText = exports.dtext:create3DText (-259.3125,2607.81640625,63.858154296875, "Встаньте для появления в Новом Вегасе", 255, 255, 255, 255, "spawn" )
				
	--	nvSpawn = createPickup ( -3014.5947265625,458.1416015625,9.5142688751221, 3, 1277 )
	--	nvSpawnText = exports.dtext:create3DText (-3014.5947265625,458.1416015625,10.5142688751221, "Встаньте, для появления в Гостиннице Ривет Сити", 255, 255, 255, 255, "spawn" )
		
		createPickup ( -645.921875,1282.6513671875,11.050584793091, 3, 1318, 3000 )
		
		-- создание пикапов
		copbarrier = createObject ( 968, 2238.2, 2450.4064, 10.6131, 0, 90, 90 )
		outputServerLog( "  #####         ######  ######       #        #####  " )
		outputServerLog( " #     # #    # #     # #     #     ##       #     # " )
		outputServerLog( " #       #    # #     # #     #    # #             # " )
		outputServerLog( "  #####  #    # ######  ######       #        #####  " )
		outputServerLog( "       # # ## # #   #   #            #   ### #      " )
		outputServerLog( " #     # ##  ## #    #  #            #   ### #       " )
		outputServerLog( "  #####  #    # #     # #          ##### ### ####### " )
		setTrafficLightState ( "disabled" )
		removeWorldModel ( 1226, 4000, 0, 0, 0 )
		removeWorldModel ( 1232, 4000, 0, 0, 0 )
		removeWorldModel ( 1297, 4000, 0, 0, 0 )
		removeWorldModel ( 1294, 4000, 0, 0, 0 )
		removeWorldModel ( 1290, 4000, 0, 0, 0 )
		removeWorldModel ( 1215, 4000, 0, 0, 0 )
		removeWorldModel ( 1351, 4000, 0, 0, 0 )
		removeWorldModel ( 1278, 4000, 0, 0, 0 )
		removeWorldModel ( 1350, 4000, 0, 0, 0 )
		removeWorldModel ( 3460, 4000, 0, 0, 0 )
		setTimer( SeeThePlayers, 1000, 0 )
		--setWaterLevel ( -50 )
	end
end

addEventHandler ( "onResourceStart", getResourceRootElement(), loadServProp )

--addCommandHandler ( "regist", registerPlayer ) -- add the command handler


function onPlayerJoin ( )
	outputChatBox("Добро пожаловать на " .. tostring ( success ) .. " сервер", source, 51,51,255)
	outputChatBox("Игровой модератор: " .. tostring ( serveradmin1 ) .. " ", source, 153,102,255)
	outputChatBox("Скриптер: " .. tostring ( scripter1 ) .. " ", source, 204,153,255)
	outputChatBox("Сайт: vk.com/jehorpg", source, 204,153,204)
	outputChatBox("Версия мода: " .. tostring ( version ) .. " ", source, 204,153,204)
end
addEventHandler ( "onPlayerJoin", getRootElement ( ), onPlayerJoin )

function savePos(thePlayer,command,comment)
    local x, y, z = getElementPosition(thePlayer)
    local xr,yr,zr = getElementRotation ( thePlayer )
    hFile = fileOpen("pos.txt", false)
    if hFile then
        local temp
        while not fileIsEOF(hFile) do
        temp = fileRead(hFile, 500)
    end
        fileWrite(hFile,x .. ',' .. y .. ',' .. z .. ',' .. xr .. ',' .. yr .. ',' .. zr .. ',' .. comment .. '\n')
    else
        hFile = fileCreate("pos.txt")
        fileWrite(hFile,x .. ',' .. y .. ',' .. z .. ',' .. xr .. ',' .. yr .. ',' .. zr .. ',' .. comment .. '\n')
    end
    outputChatBox("Saved!", thePlayer)
    fileClose(hFile)
end
--addCommandHandler ("pos", savePos)

adMessages = {
	"Посетите сайт samp-rus.com - один из лучших сайтов о МТА и сампе!",
	"Сайт - forum.je-ho.ru",
	"Задать вопрос по игре -  /report (вопрос)",
	"За каждый найденный баг вы получаете 1500 крышек!",
	"За нахождение бункера вы получите приятные бонусы",
	"vk.com/jehorpg - наша группа во вконтакте",
	"Купите VIP аккаунт! Для подробностей нажмите кнопку F9",
	"Будьте круче всех! Для подробностей нажмите кнопку F9",
	"Повысьте свой уровень! Для подробностей нажмите кнопку F9",
	"Получите броню! Для подробностей нажмите кнопку F9",
	"Получите оружие! Для подробностей нажмите кнопку F9",
	"Получите патроны! Для подробностей нажмите кнопку F9",
	"Получите шпинат! Для подробностей нажмите кнопку F9",
	"Для ввода команд используйте локальный чат (кнопка T)",
	"Введите в чат T команду /suicide для самоубийства",
	"Вы поймали радиостанцию Нового Вегаса. Нажмите колокольчик в верху PIPBOY для подключения."
}

function SeeThePlayers( )
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
	if math.fmod ( minutes, 5 ) == 0 and seconds == 0 then
		local msgnum = math.random(1,#adMessages)
		local image = 0
		if msgnum == 10 then image = 3 end
		exports.pipboy:addInfoBox(adMessages[msgnum],6, getRootElement (), image)
	end
	if minutes == 0 then
		if seconds == 0 then
			exports.players:restartMysqlConnection ()
			--setTime ( 1, 0 )
			-- for id, player in ipairs ( getElementsByType ( "player" ) ) do
				-- if getElementData ( player, "online" ) == 1 and getElementData ( player, "ontask" ) == false and getElementData ( player, "onmission" ) == false then
					
					-- local prevrad = getElementData ( player, "rad" )
					-- if getElementData ( player, "origin" ) == 0 then
						-- exports.players:givePlayerRad ( player, 20 )
					-- else
					    -- exports.players:givePlayerRad ( player, 10 )
					-- end
					-- exports.players:givePlayerXP ( player, 150 )
	               	-- outputChatBox ("Вы получили отравление радиацией",player, 0,153,51 )
				-- end
			-- end
		end
	end
end

function pickupUse ( thePlayer )
    if source == ncSpawn then
		if getElementData ( thePlayer, "nat" ) ~= 1 then
			exports.pipboy:addInfoBox("Теперь вы будете появлятся в Новой Деревне.", thePlayer, 153,153,204 )
			setElementData ( thePlayer, "nat", 1 )
		end
	elseif source == suSpawn then
		if getElementData ( thePlayer, "nat" ) ~= 2 then
			exports.pipboy:addInfoBox("Теперь вы будете появлятся в Союзе Ученых.", thePlayer, 153,153,204 )
			setElementData ( thePlayer, "nat", 2 )
		end
	elseif source == nvSpawn then
		if getElementData ( thePlayer, "nat" ) ~= 3 then
			exports.pipboy:addInfoBox("Теперь вы будете появлятся в Новом Вегасе.", thePlayer, 153,153,204 )
			setElementData ( thePlayer, "nat", 3 )
		end
	elseif source == rcSpawn then
		if getElementData ( thePlayer, "nat" ) ~= 6 then
			exports.pipboy:addInfoBox("Теперь вы будете появлятся в Гостиннице Ривет Сити за 100 долларов.", thePlayer, 153,153,204 )
			setElementData ( thePlayer, "nat", 6 )
		end
	end
end
addEventHandler ( "onPickupUse", getRootElement(), pickupUse )

-----------------------------

function playerToPoint( player, radius, x, y, z )
    if isElement( player ) and radius and x and y and z then
        return getDistanceBetweenPoints3D( x, y, z, getElementPosition( player ) ) <= radius
    end
    return false
end


addEventHandler( "onPlayerWasted", getRootElement( ),
	function(ammo,killer)
		if getElementData ( source, "indmzone" ) == 1 then
			return true
		end
		if getElementData ( source, "inarena" ) == 1 then
			setTimer( spawnPlayer, 2000, 1, source, -242.7666015625,2711.953125,62.6875, math.random(0,360), getElementModel ( source ) )
			return true
		end
		local xpToSave = getElementData ( source, "xp" )/100*60
		if getElementData ( source, "vip" ) then
			xpToSave = getElementData ( source, "xp" )
		end
		if isElement ( attacker ) and getElementData ( attacker, "perk29" ) then
			if math.random ( 1, 2 ) == 1 then
				local xp_stolen = xpToSave/2 -- перк 29 "Воришка"
				exports.players:givePlayerXP ( attacker, xp_stolen )
				xpToSave = xpToSave/xp_stolen
			end
		end
		exports.groups_jericho:givePlayerGroupRating(source,-10)
		setElementData ( source, "xp", xpToSave )
		if getElementData ( source, "safezone.id" ) or getElementData ( source, "inBuild" ) or getElementDimension ( source ) > 0 or getElementInterior ( source ) > 0 then
			if getElementData ( source, "nat" ) == 1 then
				setTimer( spawnPlayer, 2000, 1, source, -570.0771484375,2011.7421875,60.233222961426, math.random(0,360), getElementModel ( source ) )
			elseif getElementData ( source, "nat" ) == 2 then
				setTimer( spawnPlayer, 2000, 1, source, 251.294921875,1843.6591796875,8.7734375, math.random(0,360), getElementModel ( source ) )
			elseif getElementData ( source, "nat" ) == 3 then
				setTimer( spawnPlayer, 2000, 1, source, -242.7666015625,2711.953125,62.6875, math.random(0,360), getElementModel ( source ) )
			elseif getElementData ( source, "nat" ) == 4 then
				setTimer( spawnPlayer, 2000, 1, source, -242.7666015625,2711.953125,62.6875, math.random(0,360), getElementModel ( source ) )
			elseif getElementData ( source, "nat" ) == 6 then
				setTimer( spawnPlayer, 2000, 1, source, -3007.109375,397.8818359375,9.5062503814697, math.random(0,360), getElementModel ( source ) )
			elseif getElementData ( source, "nat" ) == 7 then
				setTimer( spawnPlayer, 2000, 1, source, 2318.88671875,8.412109375,26.484375, math.random(0,360), getElementModel ( source ) )
			end
			setTimer( function ( player ) exports.safezones:checkPlayerSafezone(player) end, 3500, 1, source )
			setTimer( function ( player ) exports.cweap_jericho:checkPlayerFireAllow(player) end, 4000, 1, source )
			setTimer( setElementData, 4000, 1, source, 'fireAllowed', false)
			setElementData ( source, "health", getElementData ( source, 'maxHealth' ) )
		else
		--	exports.loot:createPlayerLootBox (source)
			exports.reborn:startRebornChallenge (source)
		--	setTimer( spawnPlayer, 20000, 1, source, 2318.88671875,8.412109375,26.484375, math.random(0,360), getElementModel ( source ) )
		end
	end
)

function AskQuestionChat( source, cmd, ... )
	local parametersTable = {...}
   	local text = table.concat(parametersTable, " ")
	if (text) then
		local x,y,z = getElementPosition( source )
		for id, player in ipairs ( getElementsByType ( "player" ) ) do
			if tonumber(getElementData ( player, "admin" ) > 0 ) then
                outputChatBox ("Игрок с ид "..getElementData(source, "playerid").." задал вопрос: "..text.." ", player, 255,255,255)
                outputChatBox ("Подсказка: ответить на его вопрос: /answer "..getElementData(source, "playerid").." ответ", player, 255,204,255 )
                outputChatBox ("Информация: Вы задали вопрос хелперам, если они в сети, то сейчас вам ответят",source, 0,153,51 )
			end
		end
	else
	  	outputChatBox ("Правильно: /que вопрос ", 255,255,255)
	end
end

addCommandHandler ("que", AskQuestionChat)

function AnsQuestionChat( source, cmd, ident, ... )
	local parametersTable = {...}
   	local text = table.concat(parametersTable, " ")
	if (text) then
	    if ident then
			local x,y,z = getElementPosition( source )
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
                outputChatBox ("Хелпер "..getPlayerName ( source ).." отвечает: "..text.." ", 255,255,255)
                outputChatBox ("Подсказка: ответить на его вопрос: /answer "..getElementData(source, "playerid").." ответ", source, 255,204,255 )
                outputChatBox ("Информация: Вы ответили на вопрос игрока",source, 0,153,51 )
			end
  		else
		  	outputChatBox ("Правильно: /answer (ид игрока) вопрос ", 255,255,255)
		end
	else
	  	outputChatBox ("Правильно: /answer (ид игрока) вопрос  ", 255,255,255)
	end
end

addCommandHandler ("answer", AnsQuestionChat)