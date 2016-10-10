arenause = 0

function LoadAccountS( pass )
	local SQLTable = executeSQLSelect("players", "*", "name = '"..getPlayerName(source).."'")
	if(SQLTable[1].password == pass) then
		setElementData ( source, "password", tonumber(SQLTable[1].password ) )
		setElementData ( source, "playerid", tonumber(SQLTable[1].id ) )
		local playermoney = tonumber(SQLTable[1].money)
		if playermoney < 0 then
		    setPlayerMoney ( source, 0 )
		else
			setPlayerMoney (source, playermoney)
		end
		setElementData ( source, "bmoney", tonumber(SQLTable[1].bmoney ) )
		setElementData ( source, "faction", tonumber(SQLTable[1].faction ) )
		setElementData ( source, "rank", tonumber(SQLTable[1].rank ) )
		setElementData ( source, "phone", tonumber(SQLTable[1].phone ) )
		setElementData ( source, "work", tonumber(SQLTable[1].work ) )
		setElementData ( source, "age", tonumber(SQLTable[1].age ) )
		setElementData ( source, "skin", tonumber(SQLTable[1].skin ) )
		setElementData ( source, "origin", tonumber(SQLTable[1].origin ) )
		setElementData ( source, "house", tonumber(SQLTable[1].house ) )
		setElementData ( source, "icq", tonumber(SQLTable[1].icq ) )
		setElementData ( source, "email", tonumber(SQLTable[1].email ) )
		setElementData ( source, "intel", tonumber(SQLTable[1].intel ) )
		setElementData ( source, "luck", tonumber(SQLTable[1].luck ) )
		setElementData ( source, "vision", tonumber(SQLTable[1].vision ) )
		setElementData ( source, "sex", tonumber(SQLTable[1].sex ) )
		setElementData ( source, "nat", tonumber(SQLTable[1].nat ) )
		setElementData ( source, "sckey", tonumber(SQLTable[1].sckey ) )
		setElementData ( source, "nation", tonumber(SQLTable[1].nation ) )
		setElementData ( source, "nwkey", tonumber(SQLTable[1].nwkey ) )
		setElementData ( source, "virus", tonumber(SQLTable[1].virus ) )
		setElementData ( source, "av1", tonumber(SQLTable[1].av1 ) )
		setElementData ( source, "av2", tonumber(SQLTable[1].av2 ) )
		setElementData ( source, "rad", tonumber(SQLTable[1].radiation ) )
		
		playerskin = tonumber(getElementData ( source, "skin" ))
		spawnPlayer(source, 1666.3212890625,1473.9931640625,10.775390625, playerskin)
		
		giveWeapon ( source, tonumber(SQLTable[1].weap1) , tonumber(SQLTable[1].ammo1), true )
		giveWeapon ( source, tonumber(SQLTable[1].weap2) , tonumber(SQLTable[1].ammo2), true )
		giveWeapon ( source, tonumber(SQLTable[1].weap3) , tonumber(SQLTable[1].ammo3), true )
		giveWeapon ( source, tonumber(SQLTable[1].weap4) , tonumber(SQLTable[1].ammo4), true )
		giveWeapon ( source, tonumber(SQLTable[1].weap5) , tonumber(SQLTable[1].ammo5), true )
		giveWeapon ( source, tonumber(SQLTable[1].weap6) , tonumber(SQLTable[1].ammo6), true )
		giveWeapon ( source, tonumber(SQLTable[1].weap7) , tonumber(SQLTable[1].ammo7), true )
		giveWeapon ( source, tonumber(SQLTable[1].weap8) , tonumber(SQLTable[1].ammo8), true )
		giveWeapon ( source, tonumber(SQLTable[1].weap9) , tonumber(SQLTable[1].ammo9), true )
		giveWeapon ( source, tonumber(SQLTable[1].weap10) , tonumber(SQLTable[1].ammo10), true )
		
		setElementData ( soruce, "weap1", tonumber(SQLTable[1].weap1) )
		setElementData ( soruce, "weap2", tonumber(SQLTable[1].weap2) )
		setElementData ( soruce, "weap3", tonumber(SQLTable[1].weap3) )
		setElementData ( soruce, "weap4", tonumber(SQLTable[1].weap4) )
		setElementData ( soruce, "weap5", tonumber(SQLTable[1].weap5) )
		setElementData ( soruce, "weap6", tonumber(SQLTable[1].weap6) )
		setElementData ( soruce, "weap7", tonumber(SQLTable[1].weap7) )
		setElementData ( soruce, "weap8", tonumber(SQLTable[1].weap8) )
		setElementData ( soruce, "weap9", tonumber(SQLTable[1].weap9) )
		setElementData ( soruce, "weap10", tonumber(SQLTable[1].weap10) )
		
		setElementData ( soruce, "ammo1", tonumber(SQLTable[1].ammo1) )
		setElementData ( soruce, "ammo2", tonumber(SQLTable[1].ammo2) )
		setElementData ( soruce, "ammo3", tonumber(SQLTable[1].ammo3) )
		setElementData ( soruce, "ammo4", tonumber(SQLTable[1].ammo4) )
		setElementData ( soruce, "ammo5", tonumber(SQLTable[1].ammo5) )
		setElementData ( soruce, "ammo6", tonumber(SQLTable[1].ammo6) )
		setElementData ( soruce, "ammo7", tonumber(SQLTable[1].ammo7) )
		setElementData ( soruce, "ammo8", tonumber(SQLTable[1].ammo8) )
		setElementData ( soruce, "ammo9", tonumber(SQLTable[1].ammo9) )
		setElementData ( soruce, "ammo10", tonumber(SQLTable[1].ammo10) )
		
  		setElementData ( source, "bunk1", tonumber(SQLTable[1].bunk1 ) )
       	setElementData ( source, "bunk2", tonumber(SQLTable[1].bunk2 ) )
       	setElementData ( source, "bunk3", tonumber(SQLTable[1].bunk3 ) )
       	setElementData ( source, "bunk4", tonumber(SQLTable[1].bunk4 ) )
       	setElementData ( source, "bunk5", tonumber(SQLTable[1].bunk5 ) )
       	setElementData ( source, "bunk6", tonumber(SQLTable[1].bunk6 ) )
       	setElementData ( source, "bunk7", tonumber(SQLTable[1].bunk7 ) )
       	setElementData ( source, "bunk8", tonumber(SQLTable[1].bunk8 ) )
       	setElementData ( source, "bunk9", tonumber(SQLTable[1].bunk9 ) )
       	setElementData ( source, "bunk10", tonumber(SQLTable[1].bunk10 ) )
       	setElementData ( source, "bunk11", tonumber(SQLTable[1].bunk11 ) )
       	setElementData ( source, "bunk12", tonumber(SQLTable[1].bunk12 ) )
       	setElementData ( source, "bunk13", tonumber(SQLTable[1].bunk13 ) )
       	setElementData ( source, "bunk14", tonumber(SQLTable[1].bunk14 ) )
       	setElementData ( source, "bunk15", tonumber(SQLTable[1].bunk15 ) )
       	setElementData ( source, "bunk16", tonumber(SQLTable[1].bunk16 ) )
       	setElementData ( source, "bunk17", tonumber(SQLTable[1].bunk17 ) )
       	setElementData ( source, "bunk18", tonumber(SQLTable[1].bunk18 ) )
       	setElementData ( source, "bunk19", tonumber(SQLTable[1].bunk19 ) )
       	setElementData ( source, "bunk20", tonumber(SQLTable[1].bunk20 ) )
       	setElementData ( source, "totalbunks", tonumber(SQLTable[1].totalbunks ) )
      		setElementData ( source, "ach1", tonumber(SQLTable[1].ach1 ) )
           	setElementData ( source, "ach2", tonumber(SQLTable[1].ach2 ) )
           	setElementData ( source, "ach3", tonumber(SQLTable[1].ach3 ) )
           	setElementData ( source, "ach4", tonumber(SQLTable[1].ach4 ) )
           	setElementData ( source, "ach5", tonumber(SQLTable[1].ach5 ) )
           	setElementData ( source, "ach6", tonumber(SQLTable[1].ach6 ) )
           	setElementData ( source, "ach7", tonumber(SQLTable[1].ach7 ) )
           	setElementData ( source, "ach8", tonumber(SQLTable[1].ach8 ) )
           	setElementData ( source, "ach9", tonumber(SQLTable[1].ach9 ) )
           	setElementData ( source, "ach10", tonumber(SQLTable[1].ach10 ) )
           	setElementData ( source, "ach11", tonumber(SQLTable[1].ach11 ) )
           	setElementData ( source, "ach12", tonumber(SQLTable[1].ach12 ) )
           	setElementData ( source, "ach13", tonumber(SQLTable[1].ach13 ) )
           	setElementData ( source, "ach14", tonumber(SQLTable[1].ach14 ) )
           	setElementData ( source, "ach15", tonumber(SQLTable[1].ach15 ) )
           	setElementData ( source, "ach16", tonumber(SQLTable[1].ach16 ) )
           	setElementData ( source, "ach17", tonumber(SQLTable[1].ach17 ) )
           	setElementData ( source, "ach18", tonumber(SQLTable[1].ach18 ) )
           	setElementData ( source, "ach19", tonumber(SQLTable[1].ach19 ) )
           	setElementData ( source, "ach20", tonumber(SQLTable[1].ach20 ) )
           	setElementData ( source, "ach21", tonumber(SQLTable[1].ach21 ) )
           	setElementData ( source, "ach22", tonumber(SQLTable[1].ach22 ) )
           	setElementData ( source, "ach23", tonumber(SQLTable[1].ach23 ) )
           	setElementData ( source, "points", tonumber(SQLTable[1].points ) )
		
		setElementData ( source, "quest_main", tonumber(SQLTable[1].quest_main ) )
		setElementData ( source, "quest_main_st", tonumber(SQLTable[1].quest_main_st ) )
       	setElementData ( source, "quest_main_sex", tonumber(SQLTable[1].quest_main_sex ) )
       	setElementData ( source, "katy_perry", tonumber(SQLTable[1].katy_perry ) )
       	setElementData ( source, "big_bill", tonumber(SQLTable[1].big_bill ) )
       	setElementData ( source, "stan_marsh", tonumber(SQLTable[1].stan_marsh ) )
       	setElementData ( source, "tim_kuck", tonumber(SQLTable[1].tim_kuck ) )
		setElementData ( source, "vanger", tonumber(SQLTable[1].vagner ) )
		setElementData ( source, "suarez", tonumber(SQLTable[1].suarez ) )
		
		setElementData ( source, "quest_nvinsane", tonumber(SQLTable[1].quest_nvinsane ) )
		
		setElementData ( source, "duty", 0)
		setElementData ( source, "logged", true )
		setCameraTarget (source, source)
		outputChatBox ( "Ваш ИД: " .. tostring(getElementData ( source, "playerid" )) .. " ", source)
		outputChatBox ( "" .. getPlayerName(source) .. " зашел на наш сервер ", getRootElement(), 102,204,204)
		bindKey ( source, "space", "up", spaceEvents )
		bindKey ( source, "horn", "down", openBarriers )
--        triggerClientEvent ( "showMainGUI", source)
		setElementModel ( source, tonumber(SQLTable[1].skin)  )
		setElementData (source, "robcomplete", 0 )
		setElementData (source, "taxipas", 0 )
		setElementData (source, "call", 0 )
		setElementData (source, "mehduty", 0 )
		setElementData (source, "trydo", 0 )
		setElementData ( source, "workfindtype", 0 )
		setElementData ( source, "online", 1 )
		setElementData ( source, "buyinprogress", 0 )
		setElementData ( source, "inarena", 0 )
		setElementData ( source, "indmzone", 0 )
		setElementData ( source, "mefind", 0 )
		setElementData ( source, "group", 0 )
		setElementData ( source, "group-owner", 0 )
		if getElementData ( source, "rplvl" ) == 0 then
			setElementData ( source, "rplvl", 1 ) 
		end
		--showPlayerHudComponent ( source, "radar", true )
		toggleControl ( source, "chatbox", true )
		showPlayerHudComponent ( source, "clock", false )
	--	giveWeapon ( source, 31, 200 ) -- Gives the M4 weapon with 200 ammo
		setElementData ( source, "ID", getElementData ( source, "playerid" ) )
		call(getResourceFromName("scoreboard"), "addScoreboardColumn", "ID")
		setElementData ( source, "Level", getElementData ( source, "rplvl" ) )
		call(getResourceFromName("scoreboard"), "addScoreboardColumn", "Level")
		setElementData ( source, "Zombie kills", 0 )
		call(getResourceFromName("scoreboard"), "addScoreboardColumn", "Zombie kills")
		triggerClientEvent ( source, "showLevelLabel", getRootElement() )
		triggerClientEvent ( source, "loadAllTasksS", getRootElement() )
		local spawnsucces
		if getElementData ( source, "quest_main" ) == 0 then
			setElementPosition ( source, -943.38671875,1953.1123046875,5 )
			setElementInterior ( source, 17)
			setPedRotation ( source, 181 )
			outputChatBox ("Информация: Пока вы не начнете прохождение сюжета, вы будете поялвяться на дамбе.", source, 0,153,51 )
			outputChatBox ("Подсказка: Поговорите с Джоном Початком, нажав пробел рядом с ним.", source, 255,255,255 )
			spawnsucces = 1
		end
		local account = getAccount ( getPlayerName(source), password ) -- Return the account
		if ( account ~= false ) then -- If the account exists.
			logIn ( source, account, password )
		end
		local house = tonumber(getElementData ( source, "house" ))
		if tonumber(getElementData ( source, "house" )) > 0 then
		    exports.houses:enterHouse ( source, house )
		    spawnsucces = 1
		    setElementData ( source, "inhouse", 1 )
			return true
  		end
		if(getElementData ( source, "faction" ) > 0) then
			local pfact = getElementData ( source, "faction" )
			local x = exports.factions:getFactionInfo( pfact, 4 )
			local y = exports.factions:getFactionInfo( pfact, 5 )
			local z = exports.factions:getFactionInfo( pfact, 6 )
			setElementPosition ( source, x, y, z )
	    	setElementData (source, "facttype", exports.factions:getFactionInfo( pfact, 17 ))
--			if (( tonumber(exports.factions:getFactionInfo( pfact, 17 )) == 1 ) or (tonumber(exports.factions:getFactionInfo( pfact, 17 )) == 4)) then
--				setElementInterior( source, 3)
--			end
			outputChatBox ( "Вы состоите во фракции "..tostring(exports.factions:getFactionInfo( pfact, 1 )).." ", source, 255,51,0 )
			outputChatBox ( "Ваш ранг: "..tostring(exports.factions:getFactionInfo( pfact, 6+tonumber(getElementData ( source,"rank")))).." ", source )
			spawnsucces = 1
		end
  		if spawnsucces ~= 1 then
  			local nation = getElementData ( source, "nation" )
  			if nation == 1 then
		--		setElementPosition ( source, -1453, -1575, 103 )
				setElementPosition ( source, -943.38671875,1953.1123046875,5 )
				setElementInterior ( source, 17)
				setPedRotation ( source, 181 )
    		--	setElementDimension ( source, 3 )
			end
			if nation == 2 then 
				setElementPosition ( source, 243, 1855, 9 )	
			end
			if nation == 3 then
				setElementPosition ( source, -259.3125,2607.81640625,62.858154296875 )
			end
		end
	else
		triggerClientEvent ( source, "showLoginPlayerS", getRootElement() )
	    outputChatBox ("Ошибка: Пароль не верный ",source, 255,255,127 )
	end
end

addEvent("LoadAccountС",true)
addEventHandler("LoadAccountС",root,LoadAccountS)

quit_Type = {Unknown = "Неизвестно", Quit = "Выход", Kicked = "Кикнут", Banned = "Забанен", ["Bad Connection"] = "Плохое соединение", ["Timed out"] = "Тайм-аут"}
function outputChatBoxTypeQuitPlayer(quitType, reason, ResponsibleElement)
	local xmlPlayers = xmlLoadFile ( ":players/Accounts/"..tostring(getPlayerName(source))..".xml" )
	if(getElementData(source, "online" ) == 1) then
		if getElementData ( source, "inarena" ) > 0 then
		    exports.zombies:finishArenaFight()
		    arenause = 0
		end
	
		if getElementData ( source, "inarena" ) ~= 1 and getElementData ( source, "indmzone" ) ~= 1 then
			 setElementData ( source, "weap1", getPedWeapon ( source, 1 ))
			 setElementData ( source, "weap2", getPedWeapon ( source, 2 ))
			 setElementData ( source, "weap3", getPedWeapon ( source, 3 ))
			 setElementData ( source, "weap4", getPedWeapon ( source, 4 ))
			 setElementData ( source, "weap5", getPedWeapon ( source, 5 ))
			 setElementData ( source, "weap6", getPedWeapon ( source, 6 ))
			 setElementData ( source, "weap7", getPedWeapon ( source, 7 ))
			 setElementData ( source, "weap8", getPedWeapon ( source, 8 ))
			 setElementData ( source, "weap9", getPedWeapon ( source, 9 ))
			 setElementData ( source, "weap10", getPedWeapon ( source, 10 ))
			 setElementData ( source, "ammo1", getPedTotalAmmo ( source, 1 ))
			 setElementData ( source, "ammo2", getPedTotalAmmo ( source, 2 ))
			 setElementData ( source, "ammo3", getPedTotalAmmo ( source, 3 ))
			 setElementData ( source, "ammo4", getPedTotalAmmo ( source, 4 ))
			 setElementData ( source, "ammo5", getPedTotalAmmo ( source, 5 ))
			 setElementData ( source, "ammo6", getPedTotalAmmo ( source, 6 ))
			 setElementData ( source, "ammo7", getPedTotalAmmo ( source, 7 ))
			 setElementData ( source, "ammo8", getPedTotalAmmo ( source, 8 ))
			 setElementData ( source, "ammo9", getPedTotalAmmo ( source, 9 ))
			 setElementData ( source, "ammo10", getPedTotalAmmo ( source, 10 ))
		end
		executeSQLUpdate ( "players", "name = '" .. getPlayerName(source) .. "', password = '" .. getElementData(source,"password") .. "', id = '" .. tostring(getElementData(source,"playerid")) .. "', money = '" .. tostring(getPlayerMoney(source)) .. "', bmoney = '" .. tostring(getElementData(source,"bmoney")) .. "', faction = '" .. tostring(getElementData(source,"faction")) .. "', rank = '" .. tostring(getElementData(source,"rank")) .. "', phone = '" .. tostring(getElementData(source,"phone")) .. "', work = '" .. tostring(getElementData(source,"work")) .. "', age = '" .. tostring(getElementData(source,"age")) .. "', skin = '" .. tostring(getElementModel ( source )) .. "', origin = '" .. tostring(getElementData(source,"origin")) .. "', house = '" .. tostring(getElementData(source,"house")) .. "', icq = '" .. tostring(getElementData(source,"icq")) .. "', email = '" .. tostring(getElementData(source,"email")) .. "', intel = '" .. tostring(getElementData(source,"intel")) .. "', luck  = '" .. tostring(getElementData(source,"luck")) .. "', vision = '" .. tostring(getElementData(source,"vision")) .. "', sex = '" .. tostring(getElementData(source,"sex")) .. "', nat = '" .. tostring(getElementData(source,"nat")) .. "', nwkey = '" .. tostring(getElementData(source,"nwkey")) .. "', sckey = '" .. tostring(getElementData(source,"sckey")) .. "', virus = '" .. tostring(getElementData(source,"virus")) .. "', av1 = '" .. tostring(getElementData(source,"av1")) .. "', av2 = '" .. tostring(getElementData(source,"av2")) .. "', radiation = '" .. tostring(getElementData(source,"rad")) .. "', weap1 = '" .. tostring(getElementData(source,"weap1")) .. "', weap2 = '" .. tostring(getElementData(source,"weap2")) .. "', weap3 = '" .. tostring(getElementData(source,"weap3")) .. "', weap4 = '" .. tostring(getElementData(source,"weap4")) .. "', weap5 = '" .. tostring(getElementData(source,"weap5")) .. "', weap6 = '" .. tostring(getElementData(source,"weap6")) .. "', weap7 = '" .. tostring(getElementData(source,"weap7")) .. "', weap8 = '" .. tostring(getElementData(source,"weap8")) .. "', weap9 = '" .. tostring(getElementData(source,"weap9")) .. "', weap10 = '" .. tostring(getElementData(source,"weap10")) .. "'", "name = '" .. getPlayerName(source) .. "'")
		executeSQLUpdate ( "players", "ammo1 = '" .. tostring(getElementData(source,"ammo1")) .. "', ammo2 = '" .. tostring(getElementData(source,"ammo2")) .. "', ammo3 = '" .. tostring(getElementData(source,"ammo3")) .. "', ammo4 = '" .. tostring(getElementData(source,"ammo4")) .. "', ammo5 = '" .. tostring(getElementData(source,"ammo5")) .. "', ammo6 = '" .. tostring(getElementData(source,"ammo6")) .. "', ammo7 = '" .. tostring(getElementData(source,"ammo7")) .. "', ammo8 = '" .. tostring(getElementData(source,"ammo8")) .. "', ammo9 = '" .. tostring(getElementData(source,"ammo9")) .. "', ammo10 = '" .. tostring(getElementData(source,"ammo10")) .. "', bunk1 = '" .. tostring(getElementData(source,"bunk1")) .. "', bunk2 = '" .. tostring(getElementData(source,"bunk2")) .. "', bunk3 = '" .. tostring(getElementData(source,"bunk3")) .. "', bunk4 = '" .. tostring(getElementData(source,"bunk4")) .. "', bunk5 = '" .. tostring(getElementData(source,"bunk5")) .. "', bunk6 = '" .. tostring(getElementData(source,"bunk6")) .. "', bunk7 = '" .. tostring(getElementData(source,"bunk7")) .. "', bunk8 = '" .. tostring(getElementData(source,"bunk8")) .. "', bunk9 = '" .. tostring(getElementData(source,"bunk9")) .. "', bunk10 = '" .. tostring(getElementData(source,"bunk10")) .. "', bunk11 = '" .. tostring(getElementData(source,"bunk11")) .. "', bunk12 = '" .. tostring(getElementData(source,"bunk12")) .. "', bunk13 = '" .. tostring(getElementData(source,"bunk13")) .. "', bunk14 = '" .. tostring(getElementData(source,"bunk14")) .. "', bunk15 = '" .. tostring(getElementData(source,"bunk15")) .. "', bunk16 = '" .. tostring(getElementData(source,"bunk16")) .. "', bunk17 = '" .. tostring(getElementData(source,"bunk17")) .. "', bunk18 = '" .. tostring(getElementData(source,"bunk18")) .. "', bunk19 = '" .. tostring(getElementData(source,"bunk19")) .. "', bunk20 = '" .. tostring(getElementData(source,"bunk20")) .. "', totalbunks = '" .. tostring(getElementData(source,"totalbunks")) .. "', ach1 = '" .. tostring(getElementData(source,"ach1")) .. "', ach2 = '" .. tostring(getElementData(source,"ach2")) .. "', ach3 = '" .. tostring(getElementData(source,"ach3")) .. "', ach4 = '" .. tostring(getElementData(source,"ach4")) .. "', ach5 = '" .. tostring(getElementData(source,"ach5")) .. "', ach6 = '" .. tostring(getElementData(source,"ach6")) .. "', ach7 = '" .. tostring(getElementData(source,"ach7")) .. "', ach8 = '" .. tostring(getElementData(source,"ach8")) .. "', ach9 = '" .. tostring(getElementData(source,"ach9")) .. "', ach10 = '" .. tostring(getElementData(source,"ach10")) .. "', ach12 = '" .. tostring(getElementData(source,"ach12")) .. "', ach13 = '" .. tostring(getElementData(source,"ach13")) .. "', ach14 = '" .. tostring(getElementData(source,"ach14")) .. "', ach15 = '" .. tostring(getElementData(source,"ach15")) .. "', ach16 = '" .. tostring(getElementData(source,"ach16")) .. "', ach17 = '" .. tostring(getElementData(source,"ach17")) .. "', ach18 = '" .. tostring(getElementData(source,"ach18")) .. "', ach19 = '" .. tostring(getElementData(source,"ach19")) .. "', ach20 = '" .. tostring(getElementData(source,"ach20")) .. "', ach21 = '" .. tostring(getElementData(source,"ach21")) .. "', ach22 = '" .. tostring(getElementData(source,"ach22")) .. "', ach23 = '" .. tostring(getElementData(source,"ach23")) .. "', points = '" .. tostring(getElementData(source,"points")) .. "', quest_main = '" .. tostring(getElementData(source,"quest_main")) .. "', quest_main_st = '" .. tostring(getElementData(source,"quest_main_st")) .. "', quest_main_sex = '" .. tostring(getElementData(source,"quest_main_sex")) .. "', katy_perry = '" .. tostring(getElementData(source,"katy_perry")) .. "', big_bill = '" .. tostring(getElementData(source,"big_bill")) .. "', stan_marsh = '" .. tostring(getElementData(source,"stan_marsh")) .. "', tim_kuck = '" .. tostring(getElementData(source,"tim_kuck")) .. "', vagner = '" .. tostring(getElementData(source,"vagner")) .. "', suarez = '" .. tostring(getElementData(source,"suarez")) .. "', quest_nvinsane = '" .. tostring(getElementData(source,"quest_nvinsane")) .. "' ", "name = '" .. getPlayerName(source) .. "'" )
	end
	if((tonumber(getElementData ( source, "mefind" )) ~= nil) and (tonumber(getElementData(source, "mefind")) > 0)) then
		for id, player in ipairs ( getElementsByType ( "player" ) ) do
			if(getElementData ( source,"mefind") == getElementData ( player, "playerid" )) then
				exports.factions:clearFindPlayers ( source )
				outputChatBox("Спутник: Обьект покинул игру, поиск окончен",player)
				setElementData(source,"mefind", 0)
				setElementData(player,"find", 0)
			end
		end
	end
 if (quit_Type[quitType] == "Выход") or (quit_Type[quitType] == "Неизвестно") or (quit_Type[quitType] == "Плохое соединение") or (quit_Type[quitType] == "Тайм-аут") then
  outputChatBox("Игрок "..getPlayerName(source).." покинул наш сервер. Причина: "..quit_Type[quitType].."",getRootElement(), 204, 0, 0)
 else
  if reason then
   theReason = reason
  else
   theReason = "Неизвестно"
  end
 end
end
addEventHandler("onPlayerQuit", getRootElement(), outputChatBoxTypeQuitPlayer)

function preLoadPlayerAccountS ( )
--	triggerClientEvent ( "remotePlayerJoined", source )
	local SQLTable = executeSQLSelect("players", "name", "name = '"..getPlayerName(source).."'")
	
	if(SQLTable[1] == getPlayerName(source)) then
		outputChatBox ( "Данный аккаунт уже зарегистрирован! Введите свой пароль",source )
		triggerClientEvent ( source, "showLoginPlayerS", getRootElement() )
	else
		outputChatBox ( "Данный аккаунт не зарегистрирован! Нажмите на кнопку Registration",source )
		triggerClientEvent ( source, "showRegisterPlayerS", getRootElement() )
	end
	showPlayerHudComponent ( source, "radar", false )
	toggleControl ( source, "chatbox", false )
--	toggleAllControls ( source, true, false, true, false )
end

addEvent("preLoadPlayerAccountC",true)
addEventHandler("preLoadPlayerAccountC",root,preLoadPlayerAccountS)
--addEventHandler ( "onPlayerJoin", getRootElement ( ), onPlayerJoin )

function spaceEvents ( source )
	local x, y, z = getElementPosition ( source )
	local dim = getElementDimension ( source )
	local entsucces = 0
	if(exports.sweetyRP:playerToPoint(source, 1, 221.5,185.1396,1003.0312)) then
    	if ( getElementData ( source, "facttype" ) == 1 ) then
    		triggerClientEvent ( source, "showEquip", source )
    	end
    end
    if exports.sweetyRP:playerToPoint(source, 3, 351.3447265625,212.03125,1008.3828125) then
    	if ( getElementData ( source, "facttype" ) == 4 ) then
         	if ( tonumber(getElementData ( source, "rank" )) < 3) then
    			triggerClientEvent ( source, "showMayorEquip", source)
			end
    	end
    end
    if(exports.sweetyRP:playerToPoint(source, 3, 358.267578125,169.15234375,1008.3828125)) then
    	if ( tonumber(getElementData ( source, "passport" ) ) ~= 1 ) then
        	outputChatBox ( "Секретарь: Это ведь вы нам звонили? Вот ваш пасспорт",  source, 255,204,0 )
			setElementData ( source, "passport", 1 )
			sendActionMessage( source, x, y, z, 6, "берет пасспорт" )
     	else
     	    outputChatBox ( "Секретарь: Да, что вам?", source, 255,204,0 )
		end
    end
--    if playerToPoint ( source, 30, 6.0780,-28.6330,1003.5490 ) then
--    	triggerClientEvent ( source, "workAcceptWindow", getRootElement(), 1 )
--    end
    if exports.sweetyRP:playerToPoint ( source, 1, -954.0029296875,1867.703125,5 ) then
    	triggerClientEvent ( source, "showBankSystem", source, getElementData ( source, "bmoney" ) )
    end
--    if exports.sweetyRP:playerToPoint ( source, 3, -946.1884765625,1911.6748046875,5 ) then
--    	triggerClientEvent ( source, "sendAramToRes", source)
--    end
    if exports.sweetyRP:playerToPoint ( source, 1, -957.556640625,1887.5341796875,5 ) then
    	exports.busineses:sendBuyBusinessFunction ( source, 1, 1 ) -- Новая Дервеня
		return true
    end 
    if exports.sweetyRP:playerToPoint ( source, 1, -260.20401000977,1539.8863525391,76.3203125 ) then
    	exports.busineses:sendBuyBusinessFunction ( source, 1, 2 ) -- Союз Ученых
		return true
    end 
    if exports.sweetyRP:playerToPoint ( source, 1, -208.0888671875,2713.0947265625,62.979370117188 ) then
    	exports.busineses:sendBuyBusinessFunction ( source, 1, 3 ) -- Новый Вегас
		return true
	end
    if exports.sweetyRP:playerToPoint ( source, 1, -1531.3271484375,2610.763671875,55.8359375 ) or exports.sweetyRP:playerToPoint ( source, 2, -789.703125,2757.30078125,45.854598999023 ) then
    	exports.busineses:sendBuyBusinessFunction ( source, 1, 4 ) -- 1. эль, 2. мотель
		return true
    end
	if exports.sweetyRP:playerToPoint ( source, 1, -946.1884765625,1911.6748046875,5 ) then
    	exports.busineses:sendBuyBusinessFunction ( source, 2, 1 ) -- Новая Дервеня
		return true
    end   
    if exports.sweetyRP:playerToPoint ( source, 1, 263,1855, 9) then
    	exports.busineses:sendBuyBusinessFunction ( source, 2, 2 ) -- Союз Ученых
		return true
    end
    if exports.sweetyRP:playerToPoint ( source, 1, -220.6279296875,2643.9833984375,63.003177642822) then
    	exports.busineses:sendBuyBusinessFunction ( source, 2, 3 ) -- Новый Вегас
		return true
	end
	if exports.sweetyRP:playerToPoint ( source, 1, -1509.583984375,2590.3603515625,55.8359375) or exports.sweetyRP:playerToPoint ( source, 2, -768.375,2765.1845703125,45.855598449707 ) then
		exports.busineses:sendBuyBusinessFunction ( source, 2, 4 ) -- 1. эль, 2. мотель
		return true
	end 
    if exports.sweetyRP:playerToPoint ( source, 1, -941.0302734375,1857.21875,5 ) or exports.sweetyRP:playerToPoint ( source, 2, -269.5908203125,1489.05078125,75.7421875 ) then
    	exports.busineses:sendBuyBusinessFunction ( source, 3, 1 )
		return true
    end   
	if exports.sweetyRP:playerToPoint ( source, 1, -944.619140625,1860.0625,5 ) or exports.sweetyRP:playerToPoint ( source, 2, -261.5,1492.197265625,75.5625 ) or exports.sweetyRP:playerToPoint ( source, 2, -235.9326171875,2711.489257812 ) then
    	exports.nskin:clothShopEvent ( source )
		return true
    end
	if exports.sweetyRP:playerToPoint ( source, 2, -572.5166015625,2022.857421875,60.3828125 ) or exports.sweetyRP:playerToPoint ( source, 2, -168.669921875,2707.10546875,62.525890350342 ) or exports.sweetyRP:playerToPoint ( source, 2, -253.77354431152,1495.8074951172,76.01212310791 ) then
    	exports.dmzones:toDMLobby ( source )
    	setElementData ( source, "weap1", getPedWeapon ( source, 1 ) )
		setElementData ( source, "weap2", getPedWeapon ( source, 2 ) )
		setElementData ( source, "weap4", getPedWeapon ( source, 3 ) )
		setElementData ( source, "weap4", getPedWeapon ( source, 4 ) )
	    setElementData ( source, "weap5", getPedWeapon ( source, 5 ) )
	    setElementData ( source, "weap6", getPedWeapon ( source, 6 ) )
	    setElementData ( source, "weap7", getPedWeapon ( source, 7 ) )
	    setElementData ( source, "weap8", getPedWeapon ( source, 8 ) )
	    setElementData ( source, "weap9", getPedWeapon ( source, 9 ) )
	    setElementData ( source, "weap10", getPedWeapon ( source, 10 ) )

		setElementData ( source, "ammo1", getPedTotalAmmo ( source, 1 ) )
		setElementData ( source, "ammo2", getPedTotalAmmo ( source, 2 ) )
		setElementData ( source, "ammo3", getPedTotalAmmo ( source, 3 ) )
		setElementData ( source, "ammo4", getPedTotalAmmo ( source, 4 ) )
		setElementData ( source, "ammo5", getPedTotalAmmo ( source, 5 ) )
		setElementData ( source, "ammo6", getPedTotalAmmo ( source, 6 ) )
		setElementData ( source, "ammo7", getPedTotalAmmo ( source, 7 ) )
		setElementData ( source, "ammo8", getPedTotalAmmo ( source, 8 ) )
		setElementData ( source, "ammo9", getPedTotalAmmo ( source, 9 ) )
		setElementData ( source, "ammo10", getPedTotalAmmo ( source, 10 ) )
    	return true
    end  
	if exports.sweetyRP:playerToPoint ( source, 2, -235.8759765625,2711.4921875,62.9765625 ) then
		if arenause == 0 then
			arenause = 1
            triggerClientEvent ( source, "showArenaWeapSelect", getRootElement() )
		else
			outputChatBox ("Информация: Извините, арена занята", source, 0,153,51 )
		end
		return true
    end
    if exports.sweetyRP:playerToPoint ( source, 2, -227.751953125,2721.7060546875,62.829372406006 ) then
        if getElementData ( source, "inarena" ) == 3 then
        	--outputChatBox ("Информация: Будем ждать вас на арене еще раз!", 0,153,51 )
    		triggerClientEvent ( source, "showArenaAcceptExit", getRootElement() )
		end
		return true
    end
    if exports.sweetyRP:playerToPoint ( source, 2, -1526.953125,2593.1484375,55.8359375 ) then
		if getElementData ( source, "sckey" ) == 0 then
		    if getElementData ( source, "buyinprogress" ) == 0 then
		        setElementData ( source, "buyinprogress", 1 )
    			triggerClientEvent ( source, "showBuySUPropuskS", getRootElement(), 1 )
    			outputChatBox ("Медик говорит вам: У меня тут завлялся один пропуск в поселение Союза Ученых. Если хочешь, могу продать его тебе за 3000$", source, 204,204,255 )
			end
     	else
     	    outputChatBox ("Медик говорит вам: Чего тебе?", source, 204,204,255 )
		end
		return true
    end
    if exports.sweetyRP:playerToPoint ( source, 2, 244.8212890625,1876.6123046875,8.7578125 ) then
		if getElementData ( source, "nwkey" ) == 0 then
		    if getElementData ( source, "buyinprogress" ) == 0 then
		        setElementData ( source, "buyinprogress", 1 )
    			triggerClientEvent ( source, "showBuySUPropuskS", getRootElement(), 2 )
    			outputChatBox ("Бандит говорит вам: У меня тут завалялся один пропуск в поселение Новый Вегас. Если хочешь, могу продать его тебе за 9000$", source, 204,204,255 )
			end
     	else
     	    outputChatBox ("Бандит говорит вам: Чего тебе?", source, 204,204,255 )
		end
		return true
    end
--    if playerToPoint ( source, 3, 1174.314453125,1351.1201171875,10.921875 ) then
--    	triggerClientEvent ( source, "instructionPDDMemoShow", getRootElement() )
--    end
	if exports.sweetyRP:playerToPoint ( source, 5, -284.72265625,2655.4208984375,62.756195068359 ) then
		exports.jobs:startTripPost ( source )
	end
	if exports.sweetyRP:playerToPoint ( source, 5, -728.4619140625,2069.6240234375,60.334732055664 ) then
	    outputChatBox ("Информация: Толстушке Бэтси нужен человек, который привезет ей несколько пачек чая для похудания", source, 0,153,51 )
	    outputChatBox ("Подсказка: Чтобы принять эту работу, введите /jtw", source, 255,255,255 )
	elseif exports.sweetyRP:playerToPoint ( source, 5, -271.740234375,2691.828125,62.6875 ) then
	    outputChatBox ("Информация: Старый Генри ищет смелого парня, который смог бы найти для него пару колод карт", source, 0,153,51 )
	    outputChatBox ("Подсказка: Чтобы принять эту работу, введите /jtw", source, 255,255,255 )
	elseif exports.sweetyRP:playerToPoint ( source, 5, -289.326171875,1493.103515625,76.124565124512 ) then
	    outputChatBox ("Информация: Отец Фифан ищет помошника, который добудет для него несколько библий", source, 0,153,51 )
	    outputChatBox ("Подсказка: Чтобы принять эту работу, введите /jtw", source, 255,255,255 )
	end
	if exports.sweetyRP:playerToPoint ( source, 1, 2526.8134765625,-1315.6943359375,1031.421875 ) then
	    if getElementData ( source, "lobby" ) == 1 then
	    	setElementPosition ( source, -572.5166015625,2022.857421875,60.3828125 )
		elseif getElementData ( source, "lobby" ) == 2 then
		    setElementPosition ( source, -168.669921875,2707.10546875,62.525890350342 )
		elseif getElementData ( source, "lobby" ) == 3 then
		    setElementPosition ( source, -253.77354431152,1495.8074951172,76.01212310791 )
		end
		setElementInterior  ( source, 0 )
		giveWeapon ( source, getElementData ( source, "weap1" ), getElementData ( source, "ammo1" ) )
		giveWeapon ( source, getElementData ( source, "weap2" ), getElementData ( source, "ammo2" ) )
		giveWeapon ( source, getElementData ( source, "weap3" ), getElementData ( source, "ammo3" ) )
		giveWeapon ( source, getElementData ( source, "weap4" ), getElementData ( source, "ammo4" ) )
		giveWeapon ( source, getElementData ( source, "weap5" ), getElementData ( source, "ammo5" ) )
		giveWeapon ( source, getElementData ( source, "weap6" ), getElementData ( source, "ammo6" ) )
		giveWeapon ( source, getElementData ( source, "weap7" ), getElementData ( source, "ammo7" ) )
		giveWeapon ( source, getElementData ( source, "weap8" ), getElementData ( source, "ammo8" ) )
		giveWeapon ( source, getElementData ( source, "weap9" ), getElementData ( source, "ammo9" ) )
		giveWeapon ( source, getElementData ( source, "weap10" ), getElementData ( source, "ammo10" ) )
		return true
	end
	if exports.sweetyRP:playerToPoint ( source, 1, 2528.2880859375,-1293.9384765625,1031.421875 ) then
		exports.dmzones:toDMFromLobby ( source )
		return true
	end
    openBarriers ( source )
	exports.busineses:toBuisnes ( dim, source )
	exports.buildings:toBuilding ( source )
    exports.houses:toHouse ( dim, source )
    exports.jobs:toWork ( source )
    toBunker ( source )
end

function entSucces ( source )
	if getElementData ( source, "mefind" ) ~= nil then
		if tonumber(getElementData ( source, "mefind" )) > 0 then
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if(getElementData ( source,"mefind") == getElementData ( player, "playerid" )) then
					exports.factions:clearFindPlayers(source)
					outputChatBox("Спутник: Обьект зашел в здание, поиск окончен",player)
					setElementData(source,"mefind", 0)
					setElementData(player,"find", 0)
				end
			end
		end
	end
end

function createBarriers ()
    copbarrier = createObject ( 968, 2238.2, 2450.4064, 10.6131, 0, 90, 90 )
    nwbar1 = createObject ( 988, -141.02021789551, 2640.1567382813, 62.923156738281, 0, 0, 84 )
    nwbar2 = createObject ( 988, -141.58647155762, 2634.7651367188, 62.923156738281, 0, 0, 83.995971679688 )
	nwbar3 = createObject ( 988, -141.36465454102, 2629.3696289063, 62.923156738281, 0, 0, 99.995971679688 )
    nwbar4 = createObject ( 988, -332.62139892578, 2702.9057617188, 61.617412567139, 0, 0, 276 )
    nwbar5 = createObject ( 988, -332.66088867188, 2697.5327148438, 61.617412567139, 0, 0, 263.99853515625 )
    nderbar = createObject ( 988, -881.45446777, 1948.03564453, 59.3273925, 0, 0, 14)
    scbarrier = createObject ( 989, -353.33688354492, 1398.4868164063, 59.038162231445, 0, 0, 284)
    elquebar = createObject ( 988, -1506.2106933594, 2598.5710449219, 53.587036132813, 0, 0, 90.25)
    hostelbar = createObject ( 988, -778.16046142578, 2744.3488769531, 43.246982574463, 0, 0, 0 )
end
addEventHandler ( "onResourceStart", getResourceRootElement(), createBarriers )

function openBarriers ( source )
	if(exports.sweetyRP:playerToPoint(source, 10, 2238.2, 2450.4064, 10.6131)) then
    	if ( tonumber(factions[tonumber(getElementData ( source, "faction" ))][17]) == 1 ) then
        	setObjectRotation ( copbarrier, 0, 5, 90 )
         	setTimer ( closeBarriers, 10000, 1, 1 )
    	end
    end
    if(exports.sweetyRP:playerToPoint(source, 10, -141.02021789551, 2640.1567382813, 62.923156738281)) then
        if getElementData ( source, "nwkey" ) > 0 then
			moveObject ( nwbar1, 3000, -141.02021789551, 2640.1567382813, 58.23156738281 )
			moveObject ( nwbar2, 3000, -141.58647155762, 2634.7651367188, 58.23156738281 )
			moveObject ( nwbar3, 3000, -141.36465454102, 2629.3696289063, 58.23156738281 )
	        setTimer ( closeBarriers, 10000, 1, 2 )
		else
		     outputChatBox ( " Бандит кричит вам: Эй, ты кто такой?! А ну ка проваливай остюда, пока жив", source, 204,204,255 )
		end
    end
    if(exports.sweetyRP:playerToPoint(source, 10, -332.62139892578, 2702.9057617188, 61.617412567139)) then
        if getElementData ( source, "nwkey" ) > 0 then
         	moveObject ( nwbar4, 3000, -332.62139892578, 2702.9057617188, 57.17412567139 )
			moveObject ( nwbar5, 3000, -332.66088867188, 2697.5327148438, 57.17412567139 )
	        setTimer ( closeBarriers, 10000, 1, 3 )
		else
		     outputChatBox ( " Бандит кричит вам: Эй, ты кто такой?! А ну ка проваливай остюда, пока жив", source, 204,204,255 )
		end
    end
    if(exports.sweetyRP:playerToPoint(source, 10,  -881.45703125, 1947.9130859375, 59.261734008789)) then
        moveObject ( nderbar, 3000, -881.45446777, 1948.03564453, 55.0308609)
        setTimer ( closeBarriers, 10000, 1, 4 )
    end
    if(exports.sweetyRP:playerToPoint(source, 10, -353.33688354492, 1398.4868164063, 59.038162231445)) then
        if getElementData ( source, "sckey" ) > 0 then
         	moveObject ( scbarrier, 3000, -353.33688354492, 1398.4868164063, 55.038162231445 )
	        setTimer ( closeBarriers, 10000, 1, 5 )
		else
		     outputChatBox ( " Военный кричит вам: Пропуска нет? Проваливай отсюда", source, 204,204,255 )
		end
    end
    if(exports.sweetyRP:playerToPoint(source, 10,  -1506.2106933594, 2598.5710449219, 53.587036132813)) then
        moveObject ( elquebar, 3000, -1506.2106933594, 2598.5710449219, 45.587036132813)
        setTimer ( closeBarriers, 10000, 1, 6 )
    end
    if(exports.sweetyRP:playerToPoint(source, 10,  -778.16046142578, 2744.3488769531, 43.246982574463)) then
        moveObject ( hostelbar, 3000, -778.16046142578, 2744.3488769531, 40 )
        setTimer ( closeBarriers, 10000, 1, 7 )
    end
end

function closeBarriers ( barriernum )
	if ( barriernum == 1 ) then
       	setObjectRotation ( copbarrier, 0, 90, 90 )
    end
	if ( barriernum == 2 ) then
		moveObject ( nwbar1, 3000, -141.02021789551, 2640.1567382813, 62.923156738281 )
		moveObject ( nwbar2, 3000, -141.58647155762, 2634.7651367188, 62.923156738281 )
		moveObject ( nwbar3, 3000, -141.36465454102, 2629.3696289063, 62.923156738281 )
    end
	if ( barriernum == 3 ) then
        moveObject ( nwbar4, 3000, -332.62139892578, 2702.9057617188, 61.617412567139 )
		moveObject ( nwbar5, 3000, -332.66088867188, 2697.5327148438, 61.617412567139 )
    end
    if ( barriernum == 4 ) then
        moveObject ( nderbar, 3000, -881.45446777, 1948.03564453, 59.3273925 )
    end
    if ( barriernum == 5 ) then
        moveObject ( scbarrier, 3000, -353.33688354492, 1398.4868164063, 59.038162231445 )
    end
    if ( barriernum == 6 ) then
        moveObject ( elquebar, 3000, -1506.2106933594, 2598.5710449219, 53.587036132813 )
    end
    if ( barriernum == 7 ) then
        moveObject ( hostelbar, 3000, -778.16046142578, 2744.3488769531, 43.246982574463 )
    end
end

function startArenaFightS ( weaponnum )
	setElementPosition ( source, -227.751953125,2721.7060546875,62.829372406006 )
	takeAllWeapons ( source )
	setElementData ( source, "arenaroundnum", 1 )
    outputChatBox("Информация: Через 5 секунд начнется раунд "..tostring(getElementData ( source, "arenaroundnum" )).."", source, 0,153,51)
    setElementData ( source, "arenaweaponnum", weaponnum )
	setTimer ( firstArenaRoundStart, 5000, 1, source )
	giveWeapon ( source, weaponnum )
	outputChatBox("Информация: Убивайте зомби и получайте за это деньги!", source, 0,153,51)
	outputChatBox ("Подсказка: Подробная информация об арене на форуме, в разделе FAQ ", source, 255,255,255 )
end

addEvent( "startArenaFight", true )
addEventHandler( "startArenaFight", getRootElement(), startArenaFightS )

function firstArenaRoundStart ( source )
	exports.zombies:nextArenaRoundStart( source )
end

function finishArenaFightS ( weaponnum )
	arenause = 0
	takeAllWeapons ( source )
	setElementData ( source, "inarena", 0 )
	giveWeapon ( source, getElementData ( source, "weap1" ), getElementData ( source, "ammo1" ) )
	giveWeapon ( source, getElementData ( source, "weap2" ), getElementData ( source, "ammo2" ) )
	giveWeapon ( source, getElementData ( source, "weap3" ), getElementData ( source, "ammo3" ) )
	giveWeapon ( source, getElementData ( source, "weap4" ), getElementData ( source, "ammo4" ) )
	giveWeapon ( source, getElementData ( source, "weap5" ), getElementData ( source, "ammo5" ) )
	giveWeapon ( source, getElementData ( source, "weap6" ), getElementData ( source, "ammo6" ) )
	giveWeapon ( source, getElementData ( source, "weap7" ), getElementData ( source, "ammo7" ) )
	giveWeapon ( source, getElementData ( source, "weap8" ), getElementData ( source, "ammo8" ) )
	giveWeapon ( source, getElementData ( source, "weap9" ), getElementData ( source, "ammo9" ) )
	giveWeapon ( source, getElementData ( source, "weap10" ), getElementData ( source, "ammo10" ) )
    exports.zombies:finishArenaFight()
end

addEvent( "finishArenaFight", true )
addEventHandler( "finishArenaFight", getRootElement(), finishArenaFightS )

function cancelArenaFightS ( weaponnum )
	arenause = 0
end

addEvent( "cancelArenaFight", true )
addEventHandler( "cancelArenaFight", getRootElement(), cancelArenaFightS )

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		if getElementData ( source, "inarena" ) == 1 then
			arenause = 0
			outputChatBox("Информация: За смерть на арене вы получаете штраф 100$", source, 0,153,51)
   			takePlayerMoney ( source, 100 )
   			setElementData ( source, "inarena", 0 )
   			exports.zombies:finishArenaFight()
		end
	end
)
