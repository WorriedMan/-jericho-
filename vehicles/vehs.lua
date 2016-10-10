cars = {}

function loadMysqlVehicles ()
	-- for theKey,theVehicle in ipairs(getElementsByType('vehicle')) do
		-- if not getElementData ( theVehicle, "npc-ped" ) then 
			-- destroyElement ( theVehicle )
		-- end
	-- end
	database = exports.players:askMysqlHandler ()
	setTimer ( function () database = exports.players:askMysqlHandler () end, 3600000, 0 )
	local qh = dbQuery(database, "SELECT * FROM cars")
	if qh then
		local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
		if num_affected_rows > 0 then
			for result, row in pairs ( result ) do
				carsLoaded ( row )
			end
		end
	end
	setTimer ( waterCheck, 900000, 0 )
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), loadMysqlVehicles )

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
	["money"] = "money"
}

function updateVehiclesDB(ID, typ, value)
	-- Security array -- 
	if(saveableValues[typ]) then
		local result = dbQuery ( database, "UPDATE `cars` SET `"..saveableValues[typ].."` = "..value.." WHERE `id` = "..ID.."" )
		if(result) then
			  dbFree ( result )
		else
			database = exports.players:askMysqlHandler ()
			local result = dbQuery ( database, "UPDATE `cars` SET `"..saveableValues[typ].."` = "..value.." WHERE `id` = "..ID.."" )
			if(result) then
				dbFree ( result )
			else
				error("Can't save Data: "..typ.." with the value: "..value.." for veh ID "..ID.."!")
			end
		end
	end
end

function createVehiclesRow (model, x, y, z, anglex, angley, anglez, color1, color2, color3, color4, color5, color6)
	local result = dbQuery( database, "INSERT INTO  `cars` (  `model` ,  `x` ,  `y` ,  `z` ,  `anglex` ,  `angley` ,  `anglez` ,  `color1` ,  `color2` ,  `color3` ,  `color4` ,  `color5` ,  `color6`, `xor` ,  `yor` ,  `zor` ,  `xror` ,  `yror` ,  `zror`   ) VALUES ('"..model.."', '"..x.."', '"..y.."', '"..z.."', '"..anglex.."', '0', '"..anglez.."', '"..color1.."', '"..color2.."', '"..color3.."', '"..color4.."', '"..color5.."', '"..color6.."', '"..x.."', '"..y.."', '"..z.."', '"..anglex.."', '0', '"..anglez.."');")
	if (not result) then
		  outputDebugString("Error creating vehicle")
	else
		outputDebugString("Vehicle created")
		 dbFree (result)
	end
end

addEventHandler( "onPlayerJoin", root,
	function( )
		bindKey( source, "l", "down", "togglelights" )
	end
)

addCommandHandler( "togglelights",
	function( player, commandName )
		if exports.players:isLoggedIn( player ) then
			local vehicle = getPedOccupiedVehicle( player )
			if vehicle and getVehicleOccupant( vehicle ) == player then
				setVehicleOverrideLights( vehicle, getVehicleOverrideLights( vehicle ) == 2 and 1 or 2 )
			end
		end
	end
)

function waterCheck()
	for theKey,theVehicle in ipairs(getElementsByType ( "vehicle" )) do 
		if isElementInWater(theVehicle) and getElementData ( theVehicle, "saveable" ) and not getElementData ( theVehicle, "respawnSheulded" ) and not getVehicleOccupant ( theVehicle, 0 ) and not getVehicleOccupant ( theVehicle, 1 ) then
			local model = getElementModel ( theVehicle )
			if model ~= 472 and model ~= 473 and model ~= 493 and model ~= 595 and model ~= 484 and model ~= 430 and model ~= 453 and model ~= 452 and model ~= 446 and model ~= 454 then
				setElementData ( theVehicle, "respawnSheulded", true )
				setTimer(customRespawnVehicle, 3600000, 1, theVehicle)	
			end
		end
	end
end

function customRespawnVehicle ( vehicle )
	respawnVehicle ( vehicle )	
	setElementData ( vehicle, "respawnSheulded", false )
end

function vehicleExploded ()
	if not getElementData ( source, "respawnSheulded" ) then
		setElementData ( source, "respawnSheulded", true )
		setTimer(customRespawnVehicle, 3600000, 1, source)	
	end
end


addEventHandler ( "onVehicleExplode", getRootElement(), vehicleExploded )

function carsLoaded ( row )
			local id = tonumber(row['id'])
			local model = tonumber(row['model'])
			local x, y, z = tonumber(row['x']), tonumber(row['y']), tonumber(row['z'])+0.5
			local ax, ay, az = tonumber(row['anglex']), tonumber(row['angley']), tonumber(row['anglez'])
			local color1, color2, color3, color4, color5, color6 = tonumber(row['color1']), tonumber(row['color2']), tonumber(row['color3']), tonumber(row['color4']), tonumber(row['color5']), tonumber(row['color6'])
			local vType, price, owner, lock = tonumber(row['type']), tonumber(row['price']), tonumber(row['owner']), tonumber(row['lock'])
			local tun1, tun2, tun3, tun4, tun5, tun6, tun7, tun8, tun9, tun10, tun11, tun12, tun13, tun14, tun15, tun16, tun0 = tonumber(row['tun1']), tonumber(row['tun2']), tonumber(row['tun3']), tonumber(row['tun4']), tonumber(row['tun5']), tonumber(row['tun6']), tonumber(row['tun7']), tonumber(row['tun8']), tonumber(row['tun9']), tonumber(row['tun10']), tonumber(row['tun11']), tonumber(row['tun12']), tonumber(row['tun13']), tonumber(row['tun14']), tonumber(row['tun15']), tonumber(row['tun16']), tonumber(row['tun0'])
			local antirad = tonumber(row['antirad'])
			local money = tonumber(row['money'])
			local other = tonumber(row['other'])
			local createdVehicle = createVehicle(model, x, y, z, ax, ay, az)
			cars[id] = createdVehicle
			setVehicleRespawnPosition ( createdVehicle, tonumber(row['xor']), tonumber(row['yor']), tonumber(row['zor']), tonumber(row['xror']), tonumber(row['yror']), tonumber(row['zror']) )
			--setVehicleRespawnDelay ( createdVehicle, 3600000 )
			--toggleVehicleRespawn ( createdVehicle, true )
		--	local result = dbQuery ( database, "UPDATE `cars` SET `xor` = "..row['x']..", `yor` = "..row['y']..", `zor` = "..row['z']..", `xror` = "..row['anglex']..", `yror` = "..row['angley']..", `zror` = "..row['anglez'].." WHERE `id` = "..row['id'].."" )
		--	dbFree ( result )
			setVehicleColor ( createdVehicle, color1, color2, color3, color4, color5, color6 )
			setElementData ( createdVehicle, "saveable", true )
			setElementData (createdVehicle,"vehid",id)
			setElementData (createdVehicle,"xpos",x)
			setElementData (createdVehicle,"ypos",y)
			setElementData (createdVehicle,"zpos",z)
			setElementData (createdVehicle,"anglex",ax)
			setElementData (createdVehicle,"angley",ay)
			setElementData (createdVehicle,"anglez",az)
			setElementData (createdVehicle,"owner",owner)
			setElementData (createdVehicle,"price",price)
			setElementData (createdVehicle,"type",vType)
			setElementData (createdVehicle,"lock",lock)
			setElementData (createdVehicle,"antirad",antirad)
			for i = 0, 16 do
				if row['tun'..tostring(i)] ~= 0 then
					addVehicleUpgrade ( createdVehicle, row['tun'..tostring(i)] )
				end
			end
			maxcars = id
end

function setVehicleData ( ID, typ, value )
	setElementData ( cars[ID], saveableValues[typ], value )
	updateVehiclesDB ( ID, typ, value )
end

function onVehicleRespawn ( exploded )
	if getElementData ( source, "saveable" ) then
		local x,y,z = getElementPosition ( source )
		local ax, ay, az = getElementRotation ( source )
		setVehicleData ( getElementData ( source, "vehid" ), "x", x )
		setVehicleData ( getElementData ( source, "vehid" ), "y", y )
		setVehicleData ( getElementData ( source, "vehid" ), "z", z )
		setVehicleData ( getElementData ( source, "vehid" ), "ax", ax )
		setVehicleData ( getElementData ( source, "vehid" ), "ay", ay )
		setVehicleData ( getElementData ( source, "vehid" ), "az", az )
	end
end
 
-- Add the Event Handler
addEventHandler ( "onVehicleRespawn", getRootElement(), onVehicleRespawn )


function savePosOnExit ( thePlayer, seat, jacked )
    if seat == 0 and getElementData ( source, "saveable" ) then
		saveVehicleUpgrades ( source )
		local x,y,z = getElementPosition ( source )
		local ax, ay, az = getElementRotation ( source )
		setVehicleData ( getElementData ( source, "vehid" ), "x", x )
		setVehicleData ( getElementData ( source, "vehid" ), "y", y )
		setVehicleData ( getElementData ( source, "vehid" ), "z", z )
		setVehicleData ( getElementData ( source, "vehid" ), "ax", ax )
		setVehicleData ( getElementData ( source, "vehid" ), "ay", ay )
		setVehicleData ( getElementData ( source, "vehid" ), "az", az )
		return true
	end
end
addEventHandler ( "onVehicleExit", getRootElement(), savePosOnExit )

function saveVehicleUpgrades ( vehicle )
	local color1, color2, color3, color4, color5, color6 = getVehicleColor ( vehicle,true )
	setVehicleData ( getElementData ( vehicle, "vehid" ), "color1", color1 )
	setVehicleData ( getElementData ( vehicle, "vehid" ), "color2", color2 )
	setVehicleData ( getElementData ( vehicle, "vehid" ), "color3", color3 )
	setVehicleData ( getElementData ( vehicle, "vehid" ), "color4", color4 )
	setVehicleData ( getElementData ( vehicle, "vehid" ), "color5", color5 )
	setVehicleData ( getElementData ( vehicle, "vehid" ), "color6", color6 )
	for i=0, 16 do
        local upgrade = getVehicleUpgradeOnSlot ( vehicle, i )
        if ( upgrade ) then
			setVehicleData ( getElementData ( vehicle, "vehid" ), "tun"..tostring(i), upgrade )
        else
			setVehicleData ( getElementData ( vehicle, "vehid" ), "tun"..tostring(i), 0 )
		end
    end
	return true
end

function adminCreateVehicle ( source, cmd, model )
	local accName = getAccountName ( getPlayerAccount ( source ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
		if isPedInVehicle ( source ) then
			local exVehicle = getPedOccupiedVehicle ( source )
			if exVehicle then
				local x,y,z = getElementPosition( exVehicle )
				local ax,ay,az = getElementRotation ( exVehicle )
				setTimer ( createNewVehicle, 3000, 1, x, y, z, ax, ay, az, tonumber(model), tonumber(price) )
			end
		else
			local x,y,z = getElementPosition( source )
			local ax,ay,az = getElementRotation ( source )
			createNewVehicle ( x,y,z,ax,ay,az, tonumber(model), tonumber(price) )
		end
	else
		outputChatBox ("Ошибка: вы не можете использовать эту команду",source, 255,255,127 )
	end
end

addCommandHandler ("acarcreate", adminCreateVehicle)

function createNewVehicle (x,y,z,ax,ay,az, model)
	cars[maxcars+1] = createVehicle ( model,x,y,z,ax,ay,az )
	local color1, color2, color3, color4, color5, color6 = math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255)
	createVehiclesRow (model, x,y,z,ax,ay,az, color1, color2, color3, color4, color5, color6)
	setVehicleColor ( cars[maxcars+1], color1, color2, color3, color4, color5, color6 )
	setElementData (cars[maxcars+1],"vehid",maxcars+1)
	setElementData (cars[maxcars+1],"xpos",x)
	setElementData (cars[maxcars+1],"ypos",y)
	setElementData (cars[maxcars+1],"zpos",z)
	setElementData (cars[maxcars+1],"anglex",ax)
	setElementData (cars[maxcars+1],"angley",ay)
	setElementData (cars[maxcars+1],"anglez",az)
    setElementData (cars[maxcars+1],"owner",0)
	setElementData (cars[maxcars+1],"price",0)
	setElementData (cars[maxcars+1],"type",8)
	setElementData (cars[maxcars+1],"lock",0)
	setElementData (cars[maxcars+1],"antirad",0)
	setElementData (cars[maxcars+1],"money",0)
	maxcars = maxcars+1
end
