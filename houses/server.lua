-- MySQL Housesystem created & released by Noneatme(MuLTi), Do not remove credits! --
-- All Rights go to Noneatme --

--[[ Total time token: 
	- 3 hour
	- 1.5 hour
	________
	4.5 hours
]]

------------------------
-- CONNECTION HANDLER --
------------------------

-- Here you can change some settings --

local dbpTime = 500 -- How many Miliseconds will use the dbPoll function for waiting for a result

local max_player_houses = 1 -- Define the buyable houses per player
local sellhouse_value = 80 -- The ammount in percent that you get back if you sell a house
local open_key = "F5" -- Define the key for the infomenue and the housepanel
local leave_key = "E"

-- I don't know whats the right time for that --

-----------------------------------------------------------------
-- IF YOU CAN'T WRITE IN LUA, DO NOT EDIT ANYTHING ABOVE HERE! --
-----------------------------------------------------------------

-- EVENTS --

addEvent("onHouseSystemHouseCreate", true)
addEvent("onHouseSystemHouseLock", true)
addEvent("onHouseSystemHouseDeposit", true)
addEvent("onHouseSystemHouseWithdraw", true)
addEvent("onHouseSystemWeaponDeposit", true)
addEvent("onHouseSystemWeaponWithdraw", true)
addEvent("onHouseSystemRentableSwitch", true)
addEvent("onHouseSystemRentalprice", true)
addEvent("onHouseSystemTenandRemove", true)
addEvent("onHouseSystemInfoBuy", true)
addEvent("onHouseSystemInfoRent", true)
addEvent("onHouseSystemInfoEnter", true)

local handler -- local only, we don't need a global handler

local saveableValues = {
	["MONEY"] = "MONEY",
	["WEAP1"] = "WEAP1",
	["WEAP2"] = "WEAP2",
	["WEAP3"] = "WEAP3",
	["LOCKED"] = "LOCKED",
	["OWNER"] = "OWNER",
	["RENTABLE"] = "RENTABLE",
	["RENTALPRICE"] = "RENTALPRICE",
	["RENT1"] = "RENT1",
	["RENT2"] = "RENT2",
	["RENT3"] = "RENT3",
	["RENT4"] = "RENT4",
	["RENT5"] = "RENT5",
	["PLAYERID"] = "PLAYERID",
}


local created = false -- DONT EDIT
local houseid = 0 -- Define the Houseid, 

local house = {} -- The House array
local houseData = {} -- The House Data arry
local houseInt = {} -- The House Interior array
local houseIntData = {} -- The House Interior Data Array xD

local buildStartTick
local buildEndTick

local rentTimer
-- STARTUP EVENT HANDLER --

addEventHandler("onResourceStart", getResourceRootElement(), function()
	handler = exports.players:askMysqlHandler ()

	-- If the Handler 1 dont work
	if not(handler) then	
		outputServerLog("[HOUSESYSTEM]MySQL handler 1 not accepted! Trying secondary handler...")	
	else
		outputServerLog("[HOUSESYSTEM]MySQL handler 1 accepted!")
		housesys_startup()
	end
end)

-- SHUTDOWN EVENT HANDLER --
addEventHandler("onResourceStop", getResourceRootElement(), function()
	-- Free the arrays --
	for index, houses in pairs(house) do
		houses = nil
	end
	for index, houseDatas in pairs(houseData) do
		houseDatas = nil
	end
	for index, houseInts in pairs(houseInt) do
		houseInts = nil
	end
	for index, houseIntDatas in pairs(houseIntData) do
		houseIntDatas = nil
	end
	
	houseid = 0
	created = false
end)

--------------
-- COMMANDS --
--------------

-- /unrent --

addCommandHandler("unrent", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local id = tonumber(getElementData(thePlayer, "house:lastvisit"))
		if(isPlayerRentedHouse(thePlayer, id) == false) then
			outputChatBox("Вы не арендатор этого дома!", thePlayer, 255, 0, 0)
			return
		end
		local sucess = removeHouseTenand(id, thePlayer)
		if(sucess == true) then
			outputChatBox("Вы больше не арендуете комнату!", thePlayer, 0, 255, 0)
		else
			outputChatBox("Ошибка! Обратитесь к администратору.", thePlayer, 255, 0, 0)
		end
	end
end)

-- /rent --

addCommandHandler("rent", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local id = tonumber(getElementData(thePlayer, "house:lastvisit"))
		if(houseData[id]["OWNER"] == getPlayerName(thePlayer) or houseData[id]["PLAYERID"] == getElementData(thePlayer,"playerid")) then
			outputChatBox("Это твой дом!", thePlayer, 255, 0, 0)
			return
		end
		if(tonumber(houseData[id]["RENTABLE"]) ~= 1) then
			outputChatBox("В этом доме нет комнат на аренду!", thePlayer, 255, 0, 0)
			return
		end
		if(getPlayerRentedHouse(thePlayer) ~= false) then
			outputChatBox("Вы уже арендуете комнату! Используйте /unrent сперва.", thePlayer, 255, 0, 0)
			return
		end
		local sucess = addHouseTenand(thePlayer, id)
		if(sucess == true) then
			outputChatBox("Теперь вы арендуете комнату в этом доме!", thePlayer, 0, 255, 0)
		else
			outputChatBox("Вы не можете арендовать команту в этом доме!", thePlayer, 255, 0, 0)
		end
	end
end)

-- /createhouse --

addCommandHandler("createhouse", function(thePlayer)
	if(hasObjectPermissionTo ( thePlayer, "function.kickPlayer", false ) ) then
		if(getElementInterior(thePlayer) ~= 0) then
			outputChatBox("Вы не снаружи!", thePlayer, 255, 0, 0)
			return
		end
		if(isPedInVehicle(thePlayer) == true) then
			outputChatBox("Выйдите из авто.", thePlayer, 255, 0, 0)
			return
		end
		-- INSERT SECURITY OPTIONS LIKE ADMINLEVEL HERE( if(adminlevel > shit) then ...)
		triggerClientEvent(thePlayer, "onClientHouseSystemGUIStart", thePlayer)
	else
		outputChatBox("Вы не админ!", thePlayer, 255, 0, 0)
	end
end)

-- /in --

addCommandHandler("in", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisit")
		if(house) then
			local id = tonumber(house)
			if(tonumber(houseData[id]["LOCKED"]) == 0) or (houseData[id]["OWNER"] == getPlayerName(thePlayer)) or (houseData[id]["PLAYERID"] == tonumber(getElementData(thePlayer, "playerid"))) or isObjectInACLGroup ( "user." .. getPlayerName ( thePlayer), aclGetGroup ( "Admin" ) ) or playersWithPin[thePlayer] then
				playersWithPin[thePlayer] = nil
				local int, intx, inty, intz, dim = houseIntData[id]["INT"], houseIntData[id]["X"], houseIntData[id]["Y"], houseIntData[id]["Z"], id
				setElementData(thePlayer, "house:in", true)
				setInPosition(thePlayer, intx, inty, intz, int, false, dim)
				unbindKey(thePlayer, open_key, "down", togglePlayerInfomenue, id)
				setElementData(thePlayer, "house:lastvisitINT", id)
				bindKey(thePlayer, leave_key, "down", bindLeaveHouse )
				if(houseData[id]["OWNER"] == getPlayerName(thePlayer)) or (isPlayerRentedHouse(thePlayer, id) == true) or (houseData[id]["PLAYERID"] == tonumber(getElementData(thePlayer, "playerid"))) then
					bindKey(thePlayer, open_key, "down", togglePlayerHousemenue, id)
				end
			else
				outputChatBox("У вас нету ключей от этого дома!", thePlayer, 255, 0, 0)
			end
		end
	end
end)

-- /out --

function bindLeaveHouse ( player )
	executeCommandHandler("out", player)
end

addCommandHandler("out", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisitINT")) and (getElementData(thePlayer, "house:lastvisitINT") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisitINT")
		if(house) then
			local id = tonumber(house)
			local x, y, z = houseData[id]["X"], houseData[id]["Y"], houseData[id]["Z"]
			setElementData(thePlayer, "house:in", false)
			setInPosition(thePlayer, x, y, z, 0, true, 0)
			setElementFrozen ( thePlayer, true )
			unbindKey(thePlayer, leave_key, "down", bindLeaveHouse)
		end
	end
end)

function getPlayerHouse ( thePlayer )
	local houses = 0
	for index, col in pairs(getElementsByType("colshape")) do
		if(getElementData(col, "house") == true) and (houseData[getElementData(col, "ID")]["PLAYERID"] ~= 0) then
			if houseData[getElementData(col, "ID")]["PLAYERID"] == tonumber(getElementData ( thePlayer, "playerid" )) then
				houses = getElementData(col, "ID")
				return houses
			end
		else
			if(getElementData(col, "house") == true) and (houseData[getElementData(col, "ID")]["OWNER"] == getPlayerName(thePlayer)) then
				houses = getElementData(col, "ID")
				setHouseData(getElementData(col, "ID"), "PLAYERID", tonumber(getElementData(thePlayer,"playerid")))
				return houses
			end
		end
	end
	return 0
end

function enterHouse ( thePlayer, house )
	setElementData(thePlayer, "house:lastvisit", house)
	executeCommandHandler("in", thePlayer)
end
-- /buyhouse --

addCommandHandler("buyhouse", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisit")
		if(house) then
			local id = house
			local owner = houseData[id]["OWNER"]
			local playerid = houseData[id]["PLAYERID"]
			if(owner ~= "no-one") then
				outputChatBox("Вы не можете купить этот дом!", thePlayer, 255, 0, 0)
			else
				local houses = 0
				for index, col in pairs(getElementsByType("colshape")) do
					if(getElementData(col, "house") == true) and (houseData[getElementData(col, "ID")]["OWNER"] == getPlayerName(thePlayer)) then
						houses = houses+1
						if(houses == max_player_houses) then
							outputChatBox("У вас уже есть "..max_player_houses.." дом! Сперва продайте предыдщий дом.", thePlayer, 255, 0, 0)
							return
						end
					end
				end
				local money = exports.inventory:getItemAmountServer ( thePlayer, 51 )
				local price = houseData[id]["PRICE"]
				if(money < price) then outputChatBox("Недостаточно крышек! Необходимо еще "..(price-money), thePlayer, 255, 0, 0) return end
				setHouseData(id, "OWNER", getPlayerName(thePlayer))
				setHouseData(id, "PLAYERID", tonumber(getElementData(thePlayer,"playerid")))
				exports.inventory:removePlayerItemServer ( thePlayer, 51, price )
				outputChatBox("Подзравляю! Вы купили дом!", thePlayer, 0, 255, 0)
				setElementModel(houseData[id]["PICKUP"], 1272)
				setElementModel(houseData[id]["BLIP"], 32)
			end
		end
	end
end)

-- /sellhouse --

addCommandHandler("sellhouse", function(thePlayer)
	if(getElementData(thePlayer, "house:lastvisit")) and (getElementData(thePlayer, "house:lastvisit") ~= false)  then
		local house = getElementData(thePlayer, "house:lastvisit")
		if(house) then
			local id = house
			local owner = houseData[id]["PLAYERID"]
			if(owner ~= tonumber(getElementData(thePlayer,"playerid"))) then
				outputChatBox("You can't sell this house!", thePlayer, 255, 0, 0)
			else
				local price = houseData[id]["PRICE"]
				setHouseData(id, "OWNER", "no-one")
				setHouseData(id, "PLAYERID", 0)
				setHouseData(id, "RENTABLE", 0)
				setHouseData(id, "RENTALPRICE", 0)
				for i = 1, 5, 1 do
					setHouseData(id, "RENT"..i, "0")
				end
				exports.inventory:givePlayerItemServer ( thePlayer, 51, math.floor(price/100*sellhouse_value) )
				outputChatBox("Вы успешно продали этот дом и заработали "..math.floor(price/100*sellhouse_value).." крышек", thePlayer, 0, 255, 0)
				setElementModel(houseData[id]["PICKUP"], 1273)
				setElementModel(houseData[id]["BLIP"], 31)
			end
		end
	end
end)

-- /deletehouse --

addCommandHandler("deletehouse", function(thePlayer, cmd, id)
	if(hasObjectPermissionTo ( thePlayer, "function.kickPlayer", false ) ) then
		id = tonumber(id)
		if not(id) then return end
		if not(house[id]) then
			outputChatBox("There is no house with the ID "..id.."!", thePlayer, 255, 0, 0)
			return
		end
		local query = dbQuery(handler, "DELETE FROM houses WHERE ID = '"..id.."';")
		local result = dbPoll(query, dbpTime)
		if(result) then
			destroyElement(houseData[id]["BLIP"])
			destroyElement(houseData[id]["PICKUP"])
			destroyElement(houseIntData[id]["PICKUP"])
			houseData[id] = nil
			houseIntData[id] = nil
			destroyElement(house[id])
			destroyElement(houseInt[id])
			outputChatBox("House "..id.." destroyed sucessfully!", thePlayer, 0, 255, 0)
			house[id] = false
		else
			error("House ID "..id.." has been created Ingame, but House is not in the database! WTF")
		end
	else
		outputChatBox("Вы не админ!", thePlayer, 255, 0, 0)
	end
end)

-- /househelp --

addCommandHandler("househelp", function(thePlayer)
	outputChatBox("/buyhouse, /sellhouse, /rent", thePlayer, 0, 255, 255)
	outputChatBox("/unrent, /in, /out", thePlayer, 0, 255, 255)
	outputChatBox("Для админов: /createhouse, /deletehouse [id]", thePlayer, 0, 255, 255)
end)

-- INSERT INTO dbs_housesystem.houses (X, Y, Z, INTERIOR, INTX, INTY, INTZ, MONEY, WEAP1, WEAP2, WEAP3) values("0.1", "0.1", "0.1", "5", "0.2", "0.2", "0.2", "2000", "46,1", "22,200", "25, 200")

--------------------
-- BIND FUNCTIONS --
--------------------

function togglePlayerInfomenue(thePlayer, key, state, id)
	if(id) then
		local locked = houseData[id]["LOCKED"]
		local rentable = houseData[id]["RENTABLE"]
		local rentalprice = houseData[id]["RENTALPRICE"]
		local owner = houseData[id]["OWNER"]
		local price = houseData[id]["PRICE"]
		local playerid = houseData[id]["PLAYERID"]
		local x, y, z = getElementPosition(house[id])
		local house = getPlayerRentedHouse(thePlayer)
		if(house ~= false) then house = true end
		local isrentedin = isPlayerRentedHouse(thePlayer, id)
		triggerClientEvent(thePlayer, "onClientHouseSystemInfoMenueOpen", thePlayer, owner, x, y, z, price, locked, rentable, rentalprice, id, house, isrentedin, playerid, isObjectInACLGroup ( "user." .. getAccountName ( getPlayerAccount ( thePlayer ) ), aclGetGroup ( "Admin" ) ))
	end
end

function togglePlayerHousemenue(thePlayer, key, state, id)
	if(id) then
		if(getElementInterior(thePlayer) ~= 0) then
			local locked = houseData[id]["LOCKED"]
			local money = houseData[id]["MONEY"]
			local weap1 = houseData[id]["WEAPONS"][1]
			local weap2 = houseData[id]["WEAPONS"][2]
			local weap3 = houseData[id]["WEAPONS"][3]
			local rentable = houseData[id]["RENTABLE"]
			local rent = houseData[id]["RENTALPRICE"]
			local tenands = getHouseTenands(id)
			local owner = false
			if(getPlayerName(thePlayer) == houseData[id]["OWNER"]) or (tonumber(getElementData(thePlayer,"playerid")) == houseData[id]["PLAYERID"]) then
				owner = true
			end
			local canadd = canAddHouseTenand(id)
			triggerClientEvent(thePlayer, "onClientHouseSystemMenueOpen", thePlayer, owner, locked, money, weap1, weap2, weap3, id, rentable, rent, tenands, canadd)
		end
	else
		triggerClientEvent(thePlayer, "onClientHouseSystemMenueOpen", thePlayer )
	end
end

-------------------------------
-- HOUSE CREATION ON STARTUP --
-------------------------------

-- BUILDHOUSE FUNCTION --

local function buildHouse(id, x, y, z, interior, intx, inty, intz, money, weapons, locked, price, owner, rentable, rentalprice, rent1, rent2, rent3, rent4, rent5, playerid)
	if(id) and (x) and(y) and (z) and (interior) and (intx) and (inty) and (intz) and (money) and (weapons) then
		houseid = id
		house[id] = createColSphere(x, y, z, 1.5) -- This is the house, hell yeah
		houseData[id] = {} 
		local house = house[id] -- I'm too lazy...
		setElementData(house, "house", true) -- Just for client code only 
		
		local houseIntPickup = createPickup(intx, inty, intz, 3, 1318, 100)
		setElementInterior(houseIntPickup, interior)
		setElementDimension(houseIntPickup, id)
		
		houseInt[id] = createColSphere(intx, inty, intz, 1.5) -- And this is the Exit
		setElementInterior(houseInt[id], interior)
		setElementDimension(houseInt[id], id) -- The House Dimension is the house ID
		setElementData(houseInt[id], "house", false)
		setElementData ( houseInt[id], "action", true )
		setElementData ( houseInt[id], "type", 4 )
		--------------------
		-- EVENT HANDLERS --
		--------------------
	
		-- IN --
		addEventHandler("onColShapeHit", house, function(hitElement)
			if(getElementType(hitElement) == "player") then
				setElementData(hitElement, "house:lastvisit", id)
				bindKey(hitElement, open_key, "down", togglePlayerInfomenue, id)
				outputChatBox("Нажмите "..open_key.." для открытия меню этого дома.", hitElement, 0, 255, 255) 
			end
		end)
		
		addEventHandler("onColShapeLeave", house, function(hitElement)
			if(getElementType(hitElement) == "player") then
				setElementData(hitElement, "house:lastvisit", false)
				unbindKey(hitElement, open_key, "down", togglePlayerInfomenue, id)
				--outputChatBox(id)
			end
		end)
		
		-- OUT --
		
		addEventHandler("onColShapeHit", houseInt[id], function(hitElement, dim)
			if(dim == true) then
				if(getElementType(hitElement) == "player") then
					unbindKey(hitElement, open_key, "down", togglePlayerInfomenue, id)
					setElementData(hitElement, "house:lastvisitINT", id)
					if(houseData[id]["PLAYERID"] == getElementData(hitElement, "playerid")) or (isPlayerRentedHouse(hitElement, id) == true) then
						bindKey(hitElement, open_key, "down", togglePlayerHousemenue, id)
					end
					--outputChatBox(id)
				end
			end
		end)
		
		addEventHandler("onColShapeLeave", houseInt[id], function(hitElement, dim)
			if(dim == true) then
				if(getElementType(hitElement) == "player") then
					setElementData(hitElement, "house:lastvisitINT", false)
					if(houseData[id]["PLAYERID"] == getElementData(hitElement, "playerid")) or (isPlayerRentedHouse(hitElement, id) == true) then
						unbindKey(hitElement, open_key, "down", togglePlayerHousemenue, id)
					end
					--outputChatBox(id)
				end
			end
		end)
		
		-- Set data for HOUSE --
		houseData[id]["HOUSE"] = house
		houseData[id]["DIM"] = id
		houseData[id]["MONEY"] = money
		houseData[id]["WEAPONS"] = weapons
		houseData[id]["INTHOUSE"] = houseInt[id]
		houseData[id]["LOCKED"] = locked
		houseData[id]["PRICE"] = price
		houseData[id]["OWNER"] = owner
		houseData[id]["X"] = x
		houseData[id]["Y"] = y
		houseData[id]["Z"] = z
		houseData[id]["RENTABLE"] = rentable
		houseData[id]["RENTALPRICE"] = rentalprice
		houseData[id]["RENT1"] = rent1
		houseData[id]["RENT2"] = rent2
		houseData[id]["RENT3"] = rent3
		houseData[id]["RENT4"] = rent4
		houseData[id]["RENT5"] = rent5
		houseData[id]["PLAYERID"] = playerid
		-- HOUSE PICKUP --
		local housePickup
		if(owner ~= "no-one") then
			housePickup = createPickup(x, y, z-0.5, 3, 1272, 100)
		else
			housePickup = createPickup(x, y, z-0.5, 3, 1273, 100)
		end
		-- HOUSE BLIP --
		local houseBlip
		if(owner ~= "no-one") then
			--houseBlip = createBlip(x, y, z, 32, 2, 255, 0, 0, 255, 0, 50)
		else
		--	houseBlip = createBlip(x, y, z, 31, 2, 255, 0, 0, 255, 0, 50)
		end
		-- SET THE DATA --
		houseData[id]["PICKUP"] = housePickup
		houseData[id]["BLIP"] = houseBlip
		
		setElementData(house, "PRICE", price)
		setElementData(house, "OWNER", owner)
		setElementData(house, "LOCKED", locked)
		setElementData(house, "ID", id)
		setElementData(house, "RENTABLE", rentable)
		setElementData(house, "RENTALPRICE", rentalprice)
		setElementData(house, "PLAYERID", playerid)
		
		-- SET DATA FOR HOUSEINTERIOR --
		houseIntData[id] = {}
		houseIntData[id]["OUTHOUSE"] = houseData[id]["HOUSE"]
		houseIntData[id]["INT"] = interior
		houseIntData[id]["X"] = intx
		houseIntData[id]["Y"] = inty
		houseIntData[id]["Z"] = intz
		houseIntData[id]["PICKUP"] = houseIntPickup
		--outputServerLog("House with ID "..id.." created sucessfully!")
		buildEndTick = getTickCount()
		-- TRIGGER TO ALL CLIENTS THAT THE HOUSE HAS BEEN CREATEEEEEEEEEEEEEEEEEEEEEEED --
		setTimer(triggerClientEvent, 1000, 1, "onClientHouseSystemColshapeAdd", getRootElement(), house)
	else
		if not(id) then
			error("Arguments @buildHouse not valid! There is no Houseid!")
		else
			error("Arguments @buildHouse not valid! Houseid = "..id)
		end
	end	
end

-- TAKE PLAYER RENT --

local function takePlayerRent()
	for index, player in pairs(getElementsByType("player")) do
		if(getPlayerRentedHouse(player) ~= false) then
			local id = getPlayerRentedHouse(player)
			local owner = houseData[id]["OWNER"]
			local rentable = tonumber(houseData[id]["RENTABLE"])
			if(rentable == 1) then
				local rentprice = tonumber(houseData[id]["RENTALPRICE"])
				exports.inventory:removePlayerItemServer ( player, 51, rentprice )
				outputChatBox("Вы заплатили "..rentprice.." крышек за аренду!", player, 255, 255, 0)
				for i, owners in pairs(getElementsByType("player")) do
					if tonumber(getElementData ( owners, "playerid" )) == owner then
						exports.inventory:givePlayerItemServer ( owners, 51, rentprice )
						outputChatBox("Вы получили $"..rentprice.." от арендатора вашего дома!", owners, 255, 255, 0)
					end
				end
			end
		end
	end
end

-- HOUSE DATABASE EXECUTION --

function cleanHouses ()
	local query = dbQuery(handler, "SELECT * FROM houses;" )
	local result, numrows = dbPoll(query, dbpTime)
	local curtime = getRealTime()
	local realTimestamp = curtime.timestamp
	local cleanedhouses = 0
	for index, row in pairs(result) do
		local clear = true
		qh = dbQuery( handler, "SELECT * FROM `accounts` WHERE `id` = '"..row.PLAYERID.."' LIMIT 1")
		if qh then
			local player, num_affected_rows, errmsg = dbPoll ( qh, -1 )
			if num_affected_rows > 0 then
				for id, playerrow in pairs ( player ) do
					local year = gettok ( playerrow.lastlogin, 1, "-")
					local month = gettok ( playerrow.lastlogin, 2, "-")
					local dayt = gettok ( playerrow.lastlogin, 3, "-")
					local temp = gettok ( dayt, 1, ":")
					local day = gettok ( dayt, 1, " ")
					local hour = gettok ( string.gsub(temp, " ", ":"), 2, ":" )
					local minute = gettok ( dayt, 2, ":")
					local seconds = gettok ( dayt, 3, ":")
					local timestamp = getTimestamp ( year, month, day, hour, minute, seconds )
					if realTimestamp-2592000 > timestamp then
						local res3 = dbQuery ( handler, "UPDATE `houses` SET PLAYERID = " ..(0).. ", OWNER = 'no-one', MONEY = "..(0)..", RENT1 = "..(0)..", RENT2 = "..(0)..", RENT3 = "..(0)..", RENT4 = "..(0)..", RENT5 = "..(0).." WHERE `ID` = "..row.ID.."" )
						dbFree(res3)
						--outputDebugString("House "..row.ID.." needs to be deleted "..((realTimestamp-timestamp)/30/24/60))
						outputDebugString("House "..row.ID.." needs to be deleted "..((realTimestamp-timestamp)/60/60/24))
						local lootQuery = dbQuery(handler, "SELECT * FROM tents_new WHERE `dim` = '"..row.ID.."';" )
						cleanedhouses = cleanedhouses + 1
						local lootpool, num_affected_rows, errmsg = dbPoll ( lootQuery, -1 )
						if num_affected_rows > 0 then
							for idloot, lootrow in pairs ( lootpool ) do
								outputDebugString("Loots: "..lootrow.id)
								local qh = dbQuery(handler, "DELETE FROM tents_new WHERE id="..tostring(lootrow.id))
								dbFree(qh)
							end
						end
					end
				end
			end
		end
	end
	outputDebugString("TOTAL CLEANED HOUSES: "..cleanedhouses)
	if cleanedhouses > 0 then
		if curtime.monthday < 10 then curtime.monthday = "0"..curtime.monthday end
		curtime.month = curtime.month+1
		if curtime.month < 10 then curtime.month = "0"..curtime.month end
		
		exports.login_jericho:addNews(curtime.monthday.."."..(curtime.month).."."..(1900+curtime.year).."\nОчищено неиспользуемых домов: "..cleanedhouses)
		restartResource ( getResourceFromName ( "houses" ) )
		restartResource ( getResourceFromName ( "loot" ) )
		restartResource ( getResourceFromName ( "pipboy" ) )
	end
end

function cleanHousesCMD(thePlayer)
    if isObjectInACLGroup ("user."..getAccountName ( getPlayerAccount ( thePlayer ) ), aclGetGroup ( "Admin" ) ) then
		cleanHouses()
	end
end
addCommandHandler ("cleanhouses", cleanHousesCMD)


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


function housesys_startup()
	if(created == true) then
		error("Houses Allready created!")
		return
	end
	buildStartTick = getTickCount()
	local query = dbQuery(handler, "SELECT * FROM houses;" )
	local result, numrows = dbPoll(query, dbpTime)
	if (result and numrows > 0) then
		for index, row in pairs(result) do
			local id = row['ID']
			local x, y, z = row['X'], row['Y'], row['Z']
			local int, intx, inty, intz = row['INTERIOR'], row['INTX'], row['INTY'], row['INTZ']
			local money, weap1, weap2, weap3 = row['MONEY'], row['WEAP1'], row['WEAP2'], row['WEAP3']
			local locked = row['LOCKED']
			local price = row['PRICE']
			local owner = row['OWNER']
			local rentable = row['RENTABLE']
			local rentalprice = row['RENTALPRICE']
			local playerid = row['PLAYERID']
			local rent1, rent2, rent3, rent4, rent5 = row['RENT1'],row['RENT2'], row['RENT3'], row['RENT4'], row['RENT5']
			local weapontable = {}
			weapontable[1] = weap1
			weapontable[2] = weap2
			weapontable[3] = weap3
			buildHouse(id, x, y, z, int, intx, inty, intz, money, weapontable, locked, price, owner, rentable, rentalprice, rent1, rent2, rent3, rent4, rent5, playerid)
		end
		dbFree(query)
	else
		error("Houses Table not Found/empty!")
	end
	setTimer ( cleanHouses, 1209600000, 0 )
	created = true
	setTimer(function()
		local elapsed = (buildEndTick-buildStartTick)
		outputServerLog("It took "..(elapsed/1000).." seconds to build all houses.")
	end, 1000, 1)
	-- local numero = 0
	-- for i, house in pairs ( houseData ) do
		-- numero = numero+1
		-- if numero < 3 then
			-- if house.PLAYERID > 0 then
				-- query = dbQuery(handler, "SELECT * FROM `accounts` WHERE `id` = '"..PLAYERID.."';" )
				-- local result, numrows = dbPoll(query, dbpTime)
				-- if (result and numrows > 0) then
					-- for index, row in pairs(result) do
						-- outputDebugString ( row.lastlogin )
					-- end
				-- else
					-- outputChatBox ( 'wrong owner' )
				-- end
				-- outputDebugString ( house.PLAYERID )
			-- else
				-- outputChatBox ( 'empty house' )
			-- end
		-- else
			-- outputDebugString ( 'break' )
			-- break
		-- end
	-- end

	rentTimer = setTimer(takePlayerRent, 60*60*1000, -1)
end

-- House Data array set --

function setHouseData(ID, typ, value)
	-- Security array -- 
	houseData[ID][typ] = value
	setElementData(house[ID], typ, value)
	if(saveableValues[typ]) then
		local query = dbQuery(handler, "UPDATE houses SET "..saveableValues[typ].." = '"..value.."' WHERE ID = '"..ID.."';" )
		local result = dbPoll(query, dbpTime)
		if(result) then
			dbFree(query)
		else
			error("Can't save Data: "..typ.." with the value: "..value.." for house ID "..ID.."!")
		end
	end
end


--------------------
-- EVENT HANDLERS --
--------------------

-- INFO RENT -

addEventHandler("onHouseSystemInfoRent", getRootElement(), function(id, value)
	if(houseData[id]) then
		if(value == true) then
			executeCommandHandler("rent", source)
		else
			executeCommandHandler("unrent", source)
		end
	end
end)


-- INFO ENTER --

playersWithPin = {}

addEventHandler("onHouseSystemInfoEnter", getRootElement(), function(id,withpin)
	if(houseData[id]) then
		if withpin then
			playersWithPin[source] = true
		end
		executeCommandHandler("in", source)
	end
end)

-- INFO BUY --
addEventHandler("onHouseSystemInfoBuy", getRootElement(), function(id, value)
	if(houseData[id]) then
		if(value == true) then
			executeCommandHandler("buyhouse", source)
		else
			executeCommandHandler("sellhouse", source)
		end
	end
end)


-- TENAND REMOVE --

addEventHandler("onHouseSystemTenandRemove", getRootElement(), function(id, value)
	if(houseData[id]) then
		local sucess = removeHouseTenand(id, value)
		if(sucess == true) then
			outputChatBox("Вы выкинули арендатора "..value.."!", source, 0, 255, 0)
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "TENANDS", getHouseTenands(id))
		end
	end
end)

-- SET RENTALPRICE --

addEventHandler("onHouseSystemRentalprice", getRootElement(), function(id, value)
	if(houseData[id]) then
		local oldvalue = tonumber(houseData[id]["RENTALPRICE"])
		if(oldvalue < value) then
			local tenands = getHouseTenands(id)
			local users = {}
			for i = 1, 5, 1 do
				if(tenands[i] ~= "no-one") then
					users[i] = tenands[i]
				end
			end
			if(#users > 0) then
				outputChatBox("Вы не можете поставить такую большую цену из за арендаторов!", source, 255, 0, 0)
				return
			end
		end
		setHouseData(id, "RENTALPRICE", value)
		outputChatBox("Вы успешно изменили цену аренды дома. Она теперь "..value.."$", source, 0, 255, 0)
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "RENTALPRICE", value)
	end
end)

-- RENTABLE SWITCH --
addEventHandler("onHouseSystemRentableSwitch", getRootElement(), function(id)
	if(houseData[id]) then
		local state = tonumber(houseData[id]["RENTABLE"])
		if(state == 0) then
			setHouseData(id, "RENTABLE", 1)
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "RENTABLE", true)
			outputChatBox("Вы разрешили аренду комнат в доме!", source, 0, 255, 0)
		else
			setHouseData(id, "RENTABLE", 0)
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "RENTABLE", false)
			outputChatBox("Вы запретили аренду комнат в доме!", source, 0, 255, 0)
		end
	end
end)


-- CREATE HOUSE --

addEventHandler("onHouseSystemHouseCreate", getRootElement(), function(x, y, z, int, intx, inty, intz, price)
	local query = dbQuery(handler, "INSERT INTO houses (X, Y, Z, INTERIOR, INTX, INTY, INTZ, PRICE) values ('"..x.."', '"..y.."', '"..z.."', '"..int.."', '"..intx.."', '"..inty.."', '"..intz.."', '"..price.."');")
	local result, numrows = dbPoll(query, dbpTime)
	if(result) then
		local newid = houseid+1
		--outputChatBox("House "..newid.." created sucessfully!", source, 0, 255, 0)
		local weapontable = {}
		weapontable[1] = 0
		weapontable[2] = 0
		weapontable[3] = 0
		buildHouse(newid, x, y, z, int, intx, inty, intz, 0, weapontable, 0, price, "no-one", 0, 0, "no-one", "no-one", "no-one", "no-one", "no-one", 0)
	else
		outputChatBox("An Error occurred while creating the house!", source, 255, 0, 0)
		error("House "..(houseid+1).." could not create!")
	end
end)

-- WITHDRAW WEAPON --

addEventHandler("onHouseSystemWeaponWithdraw", getRootElement(), function(id, value)
	local weapons = houseData[id]["WEAPONS"]
	if(gettok(weapons[value], 1, ",")) then
		local weapon, ammo = gettok(weapons[value], 1, ","), gettok(weapons[value], 2, ",")
		giveWeapon(source, weapon, ammo, true)
		outputChatBox("You sucessfull withdraw your weapon slot "..value.."!", source, 0, 255, 0)
		weapons[value] = 0
		setHouseData(id, "WEAPONS", weapons)
		setHouseData(id, "WEAP1", weapons[1])
		setHouseData(id, "WEAP2", weapons[2])
		setHouseData(id, "WEAP3", weapons[3])
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "WEAPON", value, 0)
	end
end)

-- DEPOSIT WEAPON --


addEventHandler("onHouseSystemWeaponDeposit", getRootElement(), function(id, value)
	local weapons = houseData[id]["WEAPONS"]
	if(tonumber(weapons[value]) == 0) then
		local weapon = getPedWeapon(source)
		local ammo = getPedTotalAmmo(source)
		if(weapon) and (ammo) and(weapon ~= 0) and (ammo ~= 0) then 
			weapons[value] = weapon..", "..ammo
			takeWeapon(source, weapon)
			outputChatBox("Вы успешно положили оружие "..getWeaponNameFromID(weapon).." в свой дом!", source, 0, 255, 0)
			setHouseData(id, "WEAPONS", weapons)
			setHouseData(id, "WEAP1", weapons[1])
			setHouseData(id, "WEAP2", weapons[2])
			setHouseData(id, "WEAP3", weapons[3])
			triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "WEAPON", value, weapons[value])
		else
			outputChatBox("У вас нет оружия!", source, 255, 0, 0)
		end
	else
		outputChatBox("Тут уже лежит оружие!", source, 255, 0, 0)
	end
end)

-- LOCK HOUSE --

addEventHandler("onHouseSystemHouseLock", getRootElement(), function(id)
	local state = tonumber(houseData[id]["LOCKED"])
	if(state == 1) then
		setHouseData(id, "LOCKED", 0)
		outputChatBox("Вы открыли дом.", source, 0, 255, 0)
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "LOCKED", 0)
	else
		setHouseData(id, "LOCKED", 1)
		outputChatBox("Вы закрыли дом!", source, 0, 255, 255)
		triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "LOCKED", 1)
	end
end)

-- DEPOSIT MONEY --

addEventHandler("onHouseSystemHouseDeposit", getRootElement(), function(id, value)
	if(value > getPlayerMoney(source)-1) then return end
	setHouseData(id, "MONEY", tonumber(houseData[id]["MONEY"])+value)
	outputChatBox("Вы положили "..value.." крышек в домашнее хранилище!", source, 0, 255, 0)
	triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "MONEY", tonumber(houseData[id]["MONEY"]))
	givePlayerMoney(source, -value)
end)

-- WITHDRAW MONEY --

addEventHandler("onHouseSystemHouseWithdraw", getRootElement(), function(id, value)
	local money = tonumber(houseData[id]["MONEY"])
	if(money < value) then
		outputChatBox("У вас нет столько денег в домашнем хранилище!", source, 255, 0, 0)
		return
	end
	setHouseData(id, "MONEY", tonumber(houseData[id]["MONEY"])-value)
	outputChatBox("Вы успешно забрали "..value.." крышек из домашнего хранилища!", source, 0, 255, 0)
	triggerClientEvent(source, "onClientHouseSystemMenueUpdate", source, "MONEY", money-value)
	exports.inventory:givePlayerItemServer ( source, 51, value )
end)


----------------------------
-- SETTINGS AND FUNCTIONS --
----------------------------


-- FADE PLAYERS POSITION --
local fadeP = {}
function setInPosition(thePlayer, x, y, z, interior, typ, dim)
	if not(thePlayer) then return end
	if (getElementType(thePlayer) == "vehicle") then return end
	if(isPedInVehicle(thePlayer)) then return end
	if not(x) or not(y) or not(z) then return end
	if not(interior) then interior = 0 end
	if(fadeP[thePlayer] == 1) then return end
	fadeP[thePlayer] = 1
	fadeCamera(thePlayer, false)
	setElementFrozen(thePlayer, true)
	setTimer(
		function()
		fadeP[thePlayer] = 0
		setElementPosition(thePlayer, x, y, z)
		setElementInterior(thePlayer, interior)
		if(dim) then setElementDimension(thePlayer, dim) end
		setTimer ( fadeCamera, 6000, 1, thePlayer, true )
		if not(typ) then
			setElementFrozen(thePlayer, false)
		else
			if(typ == true)  then
				setTimer(setElementFrozen, 6000, 1, thePlayer, false)
			end
		end
	end, 1000, 1)
end


-- canAddHouseTenand
-- Checks if there is a free slot in the house

function canAddHouseTenand(id)
	if not(houseData[id]) then return false end
	for i = 1, 5, 1 do
		local name = houseData[id]["RENT"..i]
		if(name == "0") then
			return true, i
		end
	end
	return false;
end

-- addHouseTenand
-- Adds a player to a house as tenand

function addHouseTenand(player, id)
	if not(houseData[id]) then return false end
	for i = 1, 5, 1 do
		local name = houseData[id]["RENT"..i]
		if(name == "0") or (name == "no-one" ) then
			setHouseData(id,"RENT"..i, getElementData(player, "playerid"))
			return true, i
		end
	end
	return false;
end

-- removeHouseTenand
-- Removes a player from a house

function removeHouseTenand(id, player)
	if not(houseData[id]) then return false end
	if(type(player) == "string") then
		for i = 1, 5, 1 do
			local name = houseData[id]["RENT"..i]
			if(getElementData ( player, "playerid" ) == name) then
				setHouseData(id,"RENT"..i,"no-one")
				return true
			end
		end
	else
		for i = 1, 5, 1 do
			local name = houseData[id]["RENT"..i]
			if(name == getElementData ( player, "playerid" )) then
				setHouseData(id,"RENT"..i,"no-one")
				return true
			end
		end
	end
	return false;
end

-- getHouseTenands(houseid)
-- Returns a table within all tenands in this house 

function getHouseTenands(id)
	if not(houseData[id]) then return false end
	local rent = {}
	for i = 1, 5, 1 do
		rent[i] = houseData[id]["RENT"..i]
	end
	return rent;
end

-- getPlayerRentedHouse
-- Gets the House where a player is rented in --

function getPlayerRentedHouse(thePlayer)
	for index, house in pairs(getElementsByType("colshape")) do
		if(getElementData(house, "house") == true) and (getElementData(house, "ID")) then
			local id = tonumber(getElementData(house, "ID"))
			if not(id) then return false end
			local rent = {}
			for i = 1, 5, 1 do
				rent[i] = houseData[id]["RENT"..i]
			end
			for index, player in pairs(rent) do
				if(player == tostring(getElementData(thePlayer,"playerid"))) then
					return id;
				end
			end
		end
	end
	return false;
end

-- isPlayerRentedHouse
-- Checks if a player is rented in a specific house

function isPlayerRentedHouse(thePlayer, id)
	if not(houseData[id]) then return false end
	local rent = {}
	for i = 1, 5, 1 do
		rent[i] = houseData[id]["RENT"..i]
	end
	for index, player in pairs(rent) do
		if(player == tostring(getElementData(thePlayer,"playerid"))) then
			return true;
		end
	end
	return false;
end