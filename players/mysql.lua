local dbpTime = 250

function startAccountSystem ()
	database = dbConnect ( "mysql", "dbname=mtadb;host=82.146.60.207", "mtauser", "4jUDWsT9YGEjrW28" )
	if database then
		outputDebugString ('Connect')
		dbExec ( database, "SET NAMES 'utf8'" )
		--setTimer(restartMysqlConnection,10800000,0)
		--setTimer (loadMysqlVehicles, 3000, 1 )
	else
		outputDebugString ("Trouble")
	end
end


addEventHandler ( "onResourceStart",  getResourceRootElement(getThisResource()), startAccountSystem )

function askMysqlHandler ()
	return database
end

function restartMysqlConnection ()
	--if database then destroyElement(database) end
	--database = dbConnect ( "mysql", "dbname=mtadb;host=82.146.60.207", "mtauser", "4jUDWsT9YGEjrW28" )
	-- if database then
		-- outputDebugString ('Mysql reconnect')
		-- dbExec ( database, "SET NAMES 'utf8'" )
	-- else
		-- outputDebugString ("Trouble with mysql reconnect")
	-- end
end

-- загрузка авто
function loadMysqlVehicles ()
	local qh = dbQuery(database, "SELECT * FROM vehicles") -- Execute the query
	if qh then
		local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
		if num_affected_rows > 0 then
			for result, row in pairs ( result ) do
				exports.cars:carsLoaded ( row )
			end
		end
	end
end

local saveableValues = {
	["id"] = "id",
	["model"] = "model",
	["x"] = "x",
	["y"] = "y",
	["z"] = "z",
	["ax"] = "anglex",
	["ay"] = "angley",
	["az"] = "anglez",
	["color1"] = "color1",
	["color2"] = "color2",
	["color3"] = "color3",
	["color4"] = "color4",
	["color5"] = "color5",
	["color6"] = "color6", 	
	["vType"] = "vType",
	["price"] = "price",
	["owner"] = "owner",
	["lock"] = "lock",
	["tun1"] = "tun1",
	["tun2"] = "tun2",
	["tun3"] = "tun3",
	["tun4"] = "tun4",
	["tun5"] = "tun5",
	["tun6"] = "tun6",
	["tun7"] = "tun7",
	["tun8"] = "tun8",
	["tun9"] = "tun9",
	["tun10"] = "tun10",
	["tun11"] = "tun11",
	["tun12"] = "tun12",
	["tun13"] = "tun13",
	["tun14"] = "tun14",
	["tun15"] = "tun15",
	["tun16"] = "tun16",
	["tun0"] = "tun0",
	["antirad"] = "antirad",
}

function updateVehiclesDB(ID, typ, value)
	-- Security array -- 
	if(saveableValues[typ]) then
		local result = dbQuery ( database, "UPDATE `vehicles` SET `"..saveableValues[typ].."` = "..value.." WHERE `id` = "..ID.."" )
		if(result) then
			  dbFree ( result )
		else
			--outputDebugString("Error executing the query: (" .. mysql_errno(database) .. ") " .. mysql_error(database))
			error("Can't save Data: "..typ.." with the value: "..value.." for veh ID "..ID.."!")
		end
	end
end

function createVehiclesRow (model, x, y, z, anglex, angley, anglez, color1, color2, color3, color4, color5, color6, price)
	local result = dbQuery( database, "INSERT INTO  `vehicles` (  `model` ,  `x` ,  `y` ,  `z` ,  `anglex` ,  `angley` ,  `anglez` ,  `color1` ,  `color2` ,  `color3` ,  `color4` ,  `color5` ,  `color6` ,  `price`  ) VALUES ('"..model.."', '"..x.."', '"..y.."', '"..z.."', '"..anglex.."', '0', '"..anglez.."', '"..color1.."', '"..color2.."', '"..color3.."', '"..color4.."', '"..color5.."', '"..color6.."', '"..price.."');")
	if (not result) then
		outputDebugString("Error creating vehicle")
	else
		outputDebugString("Vehicle created")
		dbFree (result)
	end
end

-- регистрация

local playersRegistered = {}

function getFreeID()
	local result = dbPoll(dbQuery(database, "SELECT MAX(id) AS maxID FROM `accounts`;"), -1)
	return result[1].maxID+1
end

function registerPlayer ( login, password, mail )
	if ( login ~= "" and password ~= "" and password ~= nil ) and not playersRegistered[source] then
		playersRegistered[source] = true
		if getAccount (login) then
			outputChatBox ("Аккаунт с таким именем уже существует",source,255,10,10)
			return true
		end
		local mdpass1 = string.reverse ( password )
		local mdpass2 = mdpass1 .. "3f2jr"
		local mdpass = md5 ( mdpass2 )
		local idn = getFreeID()
		local serial = getPlayerSerial ( source )
		if not serial then serial = "error" end
		local result = dbQuery( database, "INSERT INTO accounts (name, password, id, origin, icq, email, serial) values ( '"..getPlayerName(source).."', '"..mdpass.."', '"..idn.."', 'rus','0', '"..mail.."', '"..serial.."') " )
		dbFree ( result )
		local result2 = dbQuery( database, "INSERT INTO  `newinv` (  `id` ,  `inv` ) VALUES ('"..tostring(idn).."', '[ [ [ 51, 200 ] ] ]');")
		dbFree ( result2 )
		local accountAdded = addAccount( login, password )
		if accountAdded then
			setAccountData ( accountAdded, "playerid", idn )
			triggerClientEvent (source,"players:registerSuccess",source)
			outputChatBox ( "Вы успешно зарегистрировались на нашем сервере!",source )
			exports.inventory:givePlayerItemServerWW ( source, 51, 200, nil, true )
		else
			outputChatBox ( "Ошибка, аккаунт не зарегистрирован. Обратитесь к администрации.",source,255,10,10 )
		end
	else
		outputChatBox ( "Ошибка", source,255,10,10 )
	end
end

addEvent( "finRegisterPlayer", true )
addEventHandler( "finRegisterPlayer", getRootElement(), registerPlayer )

pValues = {
	["bmoney"] = "bmoney",
	["faction"] = "faction",
	["rank"] = "rank",
	["phone"] = "phone",
	["work"] = "work",
	["age"] = "age",
	["origin"] = "origin",
	["house"] = "house",
	["icq"] = "icq",
	["email"] = "email",
	["intel"] = "intel",
	["luck "] = "luck",
	["vision"] = "vision",
	["sex"] = "sex",
	["nat"] = "nat",
	["nwkey"] = "nwkey",
	["sckey"] = "sckey",
	["virus"] = "virus",
	["av1"] = "av1",
	["av2"] = "av2",
	["rad"] = "rad",
	["bunk1"] = "bunk1",
	["bunk2"] = "bunk2",
	["bunk3"] = "bunk3",
	["bunk4"] = "bunk4",
	["bunk5"] = "bunk5",
	["bunk6"] = "bunk6",
	["bunk7"] = "bunk7",
	["bunk8"] = "bunk8",
	["bunk9"] = "bunk9",
	["bunk10"] = "bunk10",
	["bunk11"] = "bunk11",
	["bunk12"] = "bunk12",
	["bunk13"] = "bunk13",
	["bunk14"] = "bunk14",
	["bunk15"] = "bunk15",
	["bunk16"] = "bunk16",
	["bunk17"] = "bunk17",
	["bunk18"] = "bunk18",
	["bunk19"] = "bunk19",
	["bunk20"] = "bunk20",
	["totalbunks"] = "totalbunks",
	["points"] = "points",
	["quest_main"] = "quest_main",
	["quest_main_st"] = "quest_main_st",
	["quest_main_sex"] = "quest_main_sex",
	["katy_perry"] = "katy_perry",
	["big_bill"] = "big_bill",
	["stan_marsh"] = "stan_marsh",
	["tim_kuck"] = "tim_kuck",
	["vagner"] = "vagner",
	["suarez"] = "suarez",
	["quest_nvinsane"] = "quest_nvinsane",
	["rplvl"] = "rplvl",
	--["Zombie kills"] = "Zombiekills",
	["curr_task"] = "curr_task",
	["world_quest"] = "world_quest",
	["xp"] = "xp",
	["eat"] = "eat",
	["detective_quest"] = "detective_quest",
	["killer"] = "killer",
	["quest_vehicle"] = "quest_vehicle",
	["xzbt_s"] = "xzbt_s",
	["quest_meh"] = "quest_meh",
	["meh_need"] = "meh_need",
	["quest_fire"] = "quest_fire",
	["perkSl1"] = "perkSl1",
	["perkSl2"] = "perkSl2",
	["perkSl3"] = "perkSl3",
	["perkSl4"] = "perkSl4",
	["perkSl5"] = "perkSl5",
	["perkSl6"] = "perkSl6",
	["perkSl7"] = "perkSl7",
	["perkSl8"] = "perkSl8",
	["perkSl9"] = "perkSl9",
	["perkSl10"] = "perkSl10",
	["perkSl11"] = "perkSl11",
	["perkSl12"] = "perkSl12",
	["perkSl13"] = "perkSl13",
	["perkSl14"] = "perkSl14",
	["perkSl15"] = "perkSl15",
	["perkSl16"] = "perkSl16",
	["perkSl17"] = "perkSl17",
	["perkSl18"] = "perkSl18",
	["perkSl19"] = "perkSl19",
	["perkSl20"] = "perkSl20",
	["quest_prob"] = "quest_prob",
	["died"] = "died",
	["blocked"] = "blocked",
	["quest_militia"] = "quest_militia",
	["ncType"] = "ncType",
	["ncTasksDone"] = "ncTasksDone",
	["ncRank"] = "ncRank",
	["ncTarg"] = "ncTarg",
	["ncAmount"] = "ncAmount",
	["ncAddit"] = "ncAddit",
	["ncLastTask"] = "ncLastTask",
	["dmkills"] = "dmkills",
	["dmdeaths"] = "dmdeaths",
	["quest_robert"] = "quest_robert",
	["quest_her"] = "quest_her",
	["quest_ring"] = "quest_ring",
	["strenght"] = "strenght",
	["accuracy"] = "accuracy",
	["breath"] = "breath",
	["quest_whiskey"] = "quest_whiskey",
	["quest_check"] = "quest_check",
	["use_mrhandy"] = "mrhandy",
}

function mysqlChange(dataName,oldValue)
	if getElementType(source) == "player" then
		if getElementData ( source, "online" ) == 1 then
			if pValues[dataName] and dataName ~= 'health' then
				sourceAccount = getPlayerAccount ( source )
				local query = dbQuery(database, "UPDATE `accounts` SET "..pValues[dataName].." = '"..tostring(getElementData ( source, dataName )).."' WHERE `id` = '"..getAccountData ( sourceAccount, "playerid" ).."';" )
				if(query) then
					dbFree(query)
					--outputChatBox ( dataName )
				else
					error("Can't save Data: "..dataName.." with the value: "..getElementData ( source, dataName ).." for player ID "..getAccountData ( sourceAccount, "playerid" ).."!")
				end
			elseif dataName == 'health' then
				if getElementData ( source, 'health' ) <= 0 and not getElementData ( source, 'norLiveKilled' ) then
					killPed ( source )
				end
			end
		end
	end
end
addEventHandler("onElementDataChange",getRootElement(),mysqlChange)

-- сохранение данных игрока
function savePlayerAccount (source)
	sourceAccount = getPlayerAccount ( source )
	if getElementData ( source, "online" ) == 1 then
		local x,y,z = getElementPosition ( source )
		local land = '1'
		if getElementInterior ( source ) > 0 or getElementDimension ( source ) > 0 or getElementData ( source, "onArena" ) then
			land = '0'
		end
		local model = nil
		if getElementData ( source, "antiRadWear" ) == 1 or getElementData ( source, 'useArmor' ) > 0 then
			model = getElementData ( source, "modelid" )
		else
			model = getElementModel ( source ) -- координаты, деньги, здоровье
		end
		local shortcuts = getElementData ( source, "cutsTable" ) or {}
		for i, v in ipairs ( shortcuts ) do
			if v[1] > 0 then
				local newpos = exports.inventory:getPlayerItemPosFromNull (source, v[1], v[2]) or 0
				shortcuts[i] = { newpos, v[2] }
			end
		end	
		local cutsT = tableToString (shortcuts, 2)
		local craftT = tableToString (getElementData ( source, "knownRecipes" ), 1)
		local res3 = dbQuery ( database, "UPDATE `accounts` SET skin = " ..tostring(model).. ", zombie_kills="..tostring(getElementData ( source, "Zombie kills" ))..", x = "..tostring (x)..", y = "..tostring (y)..", z = "..tostring (z)..", land = '"..land.."', newcuts = '"..cutsT.."', health = '"..tostring(getElementData(source,'health')).."', craft = '"..craftT.."' WHERE `id` = "..getAccountData ( sourceAccount, "playerid" ).."" )
		dbFree ( res3 )
	end
	
end

blockReasons = {
	"Регистрация дополнительных аккаунтов."
}

function loadLoginPlayerAccount(player,row)
	loadPlayerAccount ( player, row )
	loadPlayerInventory (player)
end

function loadPlayerAccount ( source, row )
	local blocked = tonumber(row.blocked)
	if row.serial ~= "" then
		qh = dbQuery( database, "SELECT * FROM `accounts` WHERE `serial` = '"..row.serial.."'")
		local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
		if num_affected_rows > 3 then
			if row.serial ~= "6CFB25DDE8CF492A7D1FB1F6F841FD43" then
				for result, nrow in pairs ( result ) do
					if nrow.id ~= row.id then
						local res3 = dbQuery ( database, "UPDATE `accounts` SET blocked = '1' WHERE `id` = "..nrow.id.."" )
						dbFree ( res3 )
					end
				end
			end
		end
	else
		local serial = getPlayerSerial ( source )
		if not serial then serial = "error" end
		local res3 = dbQuery ( database, "UPDATE `accounts` SET serial = '"..serial.."' WHERE `id` = "..row.id.."" )
		dbFree ( res3 )
		qh = dbQuery( database, "SELECT * FROM `accounts` WHERE `serial` = '"..serial.."'")
		local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
		if num_affected_rows > 3 then
			if serial ~= "6CFB25DDE8CF492A7D1FB1F6F841FD43" then
				for result, nrow in pairs ( result ) do
					if nrow.id ~= row.id then
						local res3 = dbQuery ( database, "UPDATE `accounts` SET blocked = '1' WHERE `id` = "..nrow.id.."" )
						dbFree ( res3 )
					end
				end
			end
		end
	end
	if blocked > 0 then
		outputChatBox ("Ваш аккаунт заблокирован, обратитесь к администрации.", source, 255, 50, 50)
		if blockReasons[blocked] then
			outputChatBox ("Причина: "..blockReasons[blocked], source, 255, 50, 50)
		else
			outputChatBox ("Причина неизвестна", source, 255, 50, 50)
		end
	else
		setElementData ( source, "cameraFly", false)
		setElementData ( source, "online", 0 )
		local password = row.password
		setElementData ( source, "password", row.password )
		setElementData ( source, "playerid", row.id )
		setElementData ( source, "bmoney", tonumber(row.bmoney ) )
		setElementData ( source, "faction", tonumber(row.faction ) )
		setElementData ( source, "rank", tonumber(row.rank ) )
		setElementData ( source, "phone", tonumber(row.phone ) )
		setElementData ( source, "work", tonumber(row.work ) )
		setElementData ( source, "age", tonumber(row.age ) )
		setElementData ( source, "skin", tonumber(row.skin ) )
		setElementData ( source, "origin", tonumber(row.origin ) )
		setElementData ( source, "house", tonumber(row.house ) )
		setElementData ( source, "icq", tonumber(row.icq ) )
		setElementData ( source, "email", row.email )
		setElementData ( source, "intel", tonumber(row.intel ) )
		setElementData ( source, "luck", tonumber(row.luck ) )
		setElementData ( source, "vision", tonumber(row.vision ) )
		setElementData ( source, "sex", tonumber(row.sex ) )
		setElementData ( source, "nat", tonumber(row.nat ) )
		setElementData ( source, "sckey", tonumber(row.sckey ) )
		setElementData ( source, "nation", tonumber(row.nation ) )
		setElementData ( source, "nwkey", tonumber(row.nwkey ) )
		setElementData ( source, "virus", tonumber(row.virus ) )
		setElementData ( source, "av1", tonumber(row.av1 ) )
		setElementData ( source, "av2", tonumber(row.av2 ) )
		setElementData ( source, "rad", tonumber(row.rad ) )
		--setElementData ( source, "rad", 0 ) -- ПОМЕНЯЙ!!!!!!!!!
		setElementData ( source, "bunk1", tonumber( row.bunk1 ) )
		setElementData ( source, "bunk2", tonumber( row.bunk2 ) )
		setElementData ( source, "bunk3", tonumber( row.bunk3 ) )
		setElementData ( source, "bunk4", tonumber( row.bunk4 ) )
		setElementData ( source, "bunk5", tonumber( row.bunk5 ) )
		setElementData ( source, "bunk6", tonumber( row.bunk6 ) )
		setElementData ( source, "bunk7", tonumber( row.bunk7 ) )
		setElementData ( source, "bunk8", tonumber( row.bunk8 ) )
		setElementData ( source, "bunk9", tonumber( row.bunk9 ) )
		setElementData ( source, "bunk10", tonumber( row.bunk10 ) )
		setElementData ( source, "bunk11", tonumber( row.bunk11 ) )
		setElementData ( source, "bunk12", tonumber( row.bunk12 ) )
		setElementData ( source, "bunk13", tonumber( row.bunk13 ) )
		setElementData ( source, "bunk14", tonumber( row.bunk14 ) )
		setElementData ( source, "bunk15", tonumber( row.bunk15 ) )
		setElementData ( source, "bunk16", tonumber( row.bunk16 ) )
		setElementData ( source, "bunk17", tonumber( row.bunk17 ) )
		setElementData ( source, "bunk18", tonumber( row.bunk18 ) )
		setElementData ( source, "bunk19", tonumber( row.bunk19 ) )
		setElementData ( source, "bunk20", tonumber( row.bunk20 ) )
		setElementData ( source, "totalbunks", tonumber( row.totalbunks ) )
		setElementData ( source, "points", tonumber( row.points ) )

		setElementData ( source, "quest_main", tonumber( row.quest_main ) )
		setElementData ( source, "quest_main_st", tonumber( row.quest_main_st ) )
		setElementData ( source, "quest_main_sex", tonumber( row.quest_main_sex ) )
		setElementData ( source, "katy_perry", tonumber( row.katy_perry ) )
		setElementData ( source, "big_bill", tonumber( row.big_bill ) )
		setElementData ( source, "stan_marsh", tonumber( row.stan_marsh ) )
		setElementData ( source, "tim_kuck", tonumber( row.tim_kuck ) )
		setElementData ( source, "vagner", tonumber( row.vagner ) )
		setElementData ( source, "suarez", tonumber( row.suarez ) )
		setElementData ( source, "curr_task", tonumber( row.curr_task) )
		
		setElementData ( source, "quest_nvinsane", tonumber( row.quest_nvinsane ) )
		
		setElementData ( source, "eat", tonumber( row.eat ) )
		
		setElementData ( source, "detective_quest", tonumber( row.detective_quest) )
		
		setElementData ( source, "quest_vehicle", tonumber( row.quest_vehicle) )
		setElementData ( source, "xzbt_s", tonumber( row.xzbt_s) )
		
		setElementData ( source, "quest_meh", tonumber( row.quest_meh) )
		setElementData ( source, "meh_need", tonumber( row.meh_need) )
		
		
		setElementData ( source, "quest_her", tonumber( row.quest_her) )
		setElementData ( source, "quest_ring", tonumber( row.quest_ring) )
		
		setElementData ( source, "quest_fire", tonumber( row.quest_fire) )
		setElementData ( source, "blocked", tonumber(row.blocked) )
		
		spawnPlayer(source, -586.5969, 2035.554, 60.1875, 1)	
		setElementData ( source, "killer", tonumber( row.killer) )
		
		setElementData ( source, "quest_findtp", tonumber( row.quest_findtp) )
		setElementData ( source, "quest_coins", tonumber( row.quest_coins) )
		setElementData ( source, "quest_check", tonumber( row.quest_check) )
		setElementData ( source, "quest_whiskey", tonumber( row.quest_whiskey) )
		if tonumber(row.killer) > 0 then
			outputChatBox ( getPlayerName ( source ).." не уйдет от правосудия, за его голову назначена награда - "..row.killer.." крышек", getRootElement(), 255,50,50 )
			setPlayerNametagColor ( source, 255, 50, 50 )
			triggerClientEvent ( source, "startKillerTimer", getRootElement() )
		end
		if tonumber(row.rplvl) == 0 then
			setElementData ( source, "rplvl", 1 )
		else
			setElementData ( source, "rplvl", tonumber( row.rplvl ) )
		end
		setElementData ( source, "world_quest", tonumber( row.world_quest ) )
		setElementData ( source, "xp", tonumber( row.xp ) )
		
		for i = 1, 20 do
			--outputChatBox ( row['perkSl'..i] )
			setElementData ( source, 'perkSl'..i, tonumber(row['perkSl'..i]) )
			if tonumber(row['perkSl'..i]) > 0 then
				setElementData ( source, 'perk'..tonumber(row['perkSl'..i]), true )
			end
		end
		setElementData ( source, "quest_prob", tonumber( row.quest_prob) )
		setElementData ( source, "died", tonumber( row.died) )
		setElementData ( source, "x", tonumber( row.x) )
		setElementData ( source, "y", tonumber( row.y) )
		setElementData ( source, "z", tonumber( row.z) )
		setElementData ( source, "land", tonumber( row.land) )
		setElementData ( source, 'health', tonumber( row.health) )
		
		setElementData ( source, "dmkills", tonumber( row.dmkills) )
		setElementData ( source, "dmdeaths", tonumber( row.dmdeaths) )
		--outputChatBox ( row.newcuts)
		exports.pipboy:loadShortCuts(source, stringToTable(row.newcuts, 2),  stringToTable(row.craft, 1) )
		loadPlayerInventory (source)
		exports.perks:loadPlayerPerks ( source )
		local year = gettok ( row.lastlogin, 1, "-")
		local month = gettok ( row.lastlogin, 2, "-")
		local dayt = gettok ( row.lastlogin, 3, "-")
		local temp = gettok ( dayt, 1, ":")
		local day = gettok ( dayt, 1, " ")
		local hour = gettok ( string.gsub(temp, " ", ":"), 2, ":" )
		local minute = gettok ( dayt, 2, ":")
		local seconds = gettok ( dayt, 3, ":")
		local timestamp = getTimestamp ( year, month, day, hour, minute, seconds )
		local curtime = getRealTime( )
		setElementData ( source, "timestampVip", tonumber( row.vipTimestamp ) )
		
		
		setElementData ( source, "quest_militia", tonumber( row.quest_militia) )
		setElementData ( source, "ncType", tonumber( row.ncType) )
		setElementData ( source, "ncTasksDone", tonumber( row.ncTasksDone) )
		setElementData ( source, "ncRank", tonumber( row.ncRank) )
		setElementData ( source, "ncTarg", tonumber( row.ncTarg) )
		setElementData ( source, "ncAmount", tonumber( row.ncAmount) )
		
		setElementData ( source, "ncAddit", tonumber( row.ncAddit) )
		
		
		setElementData ( source, "breath", tonumber( row.breath) )
		setElementData ( source, "accuracy", tonumber( row.accuracy) )
		setElementData ( source, "strenght", tonumber( row.strenght) )
		
		setElementData ( source, "use_mrhandy", tonumber( row.mrhandy) or 0 )
		
		setElementData ( source, "quest_robert", tonumber( row.quest_robert) )
		local year = gettok ( row.lastlogin, 1, "-")
		local month = gettok ( row.lastlogin, 2, "-")
		local dayt = gettok ( row.lastlogin, 3, "-")
		local temp = gettok ( dayt, 1, ":")
		local day = gettok ( dayt, 1, " ")
		local hour = gettok ( string.gsub(temp, " ", ":"), 2, ":" )
		local minute = gettok ( dayt, 2, ":")
		local seconds = gettok ( dayt, 3, ":")
		local timestamp = getTimestamp ( year, month, day, hour, minute, seconds )
		setElementData ( source, "ncLastTask", timestamp )
		if tonumber( row.vipTimestamp ) > 0 then
			if curtime['timestamp'] - tonumber( row.vipTimestamp ) < 0 then
				setElementData ( source, "vip", true )
				local date = math.ceil((tonumber( row.vipTimestamp )-curtime['timestamp'])/86400)
				local text = "Ваш VIP аккаунт заканчивается сегодня"
				if date > 0 then
					local dayName = "дня"
					if date == 1 or date == 21 or date == 31 then
						dayName = "день"
					elseif date > 4 and date < 21 or date == 30 then
						dayName = "дней"
					end
					text = "Ваш VIP аккаунт действует еще "..tostring(date).." "..dayName
				end
				exports.pipboy:addInfoBox ( text, 5, source )
			end
		end
		setElementData ( source, "online", 1 )
		triggerClientEvent ( source, "showLevelLabel", getRootElement(), getElementData ( source, "rplvl" ), row.xp, row.radiation, row.virus, row.eat )
		setElementData ( source, "Zombie kills", tonumber(row.zombie_kills) )
		if tonumber(row.eat) < 70 then
			setElementData ( source, "foodTimer", 1 )
			triggerClientEvent ( source, "startHungerTimerS", getRootElement(), 1 )
		else
			setElementData ( source, "foodTimer", 2 )
			triggerClientEvent ( source, "startHungerTimerS", getRootElement(), 2 )
		end
		LoadAccountS ( source )
	end
end

function stringToTable ( itString, items )
	i = 1
	local total = 0
	local lastnum = 0
	local tmpTable = {}
	while gettok ( itString, i, string.byte(',') ) do
		if items == 1 then
			table.insert ( tmpTable, tonumber(gettok ( itString, i, string.byte(',') )) )
		else
			local pos = math.ceil (i/items) 
			if pos ~= lastnum then table.insert ( tmpTable, pos, {} ) end
			lastnum = pos
			table.insert ( tmpTable[pos], tonumber(gettok ( itString, i, string.byte(',') )) )
		end
		i = i+1
	end
	return tmpTable
end

function tableToString (itemsT, items)
	local itString = ''
	if itemsT then
		for i = 1, #itemsT do
			if items == 1 then
				itString=itString..tostring(itemsT[i])..','
			else
				for b = 1, items do
					itString=itString..tostring(itemsT[i][b])..','
				end
			end
		end
		return itString
	else
		return ""
	end
end


function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
 
    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
 
    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end
 
    return timestamp
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end


-- загрузка инвентрая

function loadPlayerInventory (player)
	sourceAccount = getPlayerAccount ( player )
	local qh = dbQuery ( database ,"SELECT * FROM `newinv` WHERE `id` = "..getAccountData ( sourceAccount, "playerid" ).."")
	--local qh = dbQuery ( database ,"SELECT * FROM `newinv` WHERE `id` = 21")
	if qh then
		local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
		if num_affected_rows > 0 then
			for result, row in pairs ( result ) do
				exports.inventory:inventoryLoaded ( player, row )
				return true
			end
		end
	else
		outputChatBox ( 'Невозможно загрузить инвентарь, обратитесь к администрации', player, 255, 0, 0)
	end
end

--addCommandHandler ( "loadi", loadPlayerInventory )

function setInventoryData (player, row)
	setElementData ( player, 'oldInventoryLoaded', true )
	setElementData ( player, "item1_t", tonumber(row.item1_t))
	setElementData ( player, "item1_q", tonumber(row.item1_q))
	setElementData ( player, "item2_t", tonumber(row.item2_t))
	setElementData ( player, "item2_q", tonumber(row.item2_q))
	setElementData ( player, "item3_t", tonumber(row.item3_t))
	setElementData ( player, "item3_q", tonumber(row.item3_q))
	setElementData ( player, "item4_t", tonumber(row.item4_t))
	setElementData ( player, "item4_q", tonumber(row.item4_q))
	setElementData ( player, "item5_t", tonumber(row.item5_t))
	setElementData ( player, "item5_q", tonumber(row.item5_q))
	setElementData ( player, "item6_t", tonumber(row.item6_t))
	setElementData ( player, "item6_q", tonumber(row.item6_q))
	setElementData ( player, "item7_t", tonumber(row.item7_t))
	setElementData ( player, "item7_q", tonumber(row.item7_q))
	setElementData ( player, "item8_t", tonumber(row.item8_t))
	setElementData ( player, "item8_q", tonumber(row.item8_q))
	setElementData ( player, "item9_t", tonumber(row.item9_t))
	setElementData ( player, "item9_q", tonumber(row.item9_q))
	setElementData ( player, "item10_t", tonumber(row.item10_t))
	setElementData ( player, "item10_q", tonumber(row.item10_q))
	setElementData ( player, "item11_t", tonumber(row.item11_t))
	setElementData ( player, "item11_q", tonumber(row.item11_q))
	setElementData ( player, "item12_t", tonumber(row.item12_t))
	setElementData ( player, "item12_q", tonumber(row.item12_q))
	setElementData ( player, "item13_t", tonumber(row.item13_t))
	setElementData ( player, "item13_q", tonumber(row.item13_q))
	setElementData ( player, "item14_t", tonumber(row.item14_t))
	setElementData ( player, "item14_q", tonumber(row.item14_q))
	setElementData ( player, "item15_t", tonumber(row.item15_t))
	setElementData ( player, "item15_q", tonumber(row.item15_q))
	setElementData ( player, "item16_t", tonumber(row.item16_t))
	setElementData ( player, "item16_q", tonumber(row.item16_q))
	setElementData ( player, "item17_t", tonumber(row.item17_t))
	setElementData ( player, "item17_q", tonumber(row.item17_q))
	setElementData ( player, "item18_t", tonumber(row.item18_t))
	setElementData ( player, "item18_q", tonumber(row.item18_q))
	setElementData ( player, "item19_t", tonumber(row.item19_t))
	setElementData ( player, "item19_q", tonumber(row.item19_q))
	setElementData ( player, "item20_t", tonumber(row.item20_t))
	setElementData ( player, "item20_q", tonumber(row.item20_q))
	exports.inventory:inventoryLoadedOldWay ( player )
	local result = dbQuery( database, "INSERT INTO  `newinv` (  `id` ,  `inv` ) VALUES ('"..tostring(getElementData ( player, 'playerid')).."', '');")
	if (not result) then
		outputChatBox ( 'Инвентарь не создан, обратитесь к администратору', player, 255, 0, 0 )
	else
		dbFree (result)
	end
end

-- сохранение инвентаря
function savePlayerInventory (source)
	sourceAccount = getPlayerAccount ( source )
	if getElementData ( source, "online" ) == 1 then
		local invItems = exports.inventory:getItemsLargeNull ( source )
		-- for i,v in ipairs ( invItems ) do
			-- if #v > 2 then
				-- outputDebugString ( v[3])
			-- end
		-- end
		local jsonTable = toJSON ( invItems )
		local res1 = dbQuery ( database, "UPDATE `newinv` SET inv = '"..jsonTable.."' WHERE `id` = '"..getAccountData ( sourceAccount, "playerid" ).."'" )
		dbFree ( res1 )
	end
end
