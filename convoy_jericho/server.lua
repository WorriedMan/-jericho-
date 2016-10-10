-- Настройки
time_between_starts = 500 -- количество милисекунд между стартами машин из одного конвоя друг за другом. Если хочешь одновременный старт, то ставь 0
convoy_start_time = 1000 -- через сколько милисекунд конвой стартует после своего создания

-- Настройка конвоев:
convoysConfig = {
	{id="Groove Стрит",seqid = 1, speed = 10, destroy_convoy_time = 1000, check_hp = false, check_tires = true, hp_to_stop = 400, damage_proof = true, tires_quant = 2, peds={{skin=0,x=2477,y=-1660,z=13.34,a=86.5,vehmodel=492,col_size=2,items={{"Объедки",5},{"Остатки пиццы",1},{"Канистра с топливом",10}}},{skin=0,x=2488,y=-1660,z=13.34,a=86.5,vehmodel=492,col_size=2},{skin=0,x=2506,y=-1660,z=13.34,a=86.5,vehmodel=492,items={{"M1911",10}}},col_size=2},},
	{id="Groove Стрит 2",seqid = 1, speed = 10, destroy_convoy_time = 10000, check_hp = true, check_tires = false, hp_to_stop = 400, damage_proof = true, tires_quant = 2, peds={{skin=0,x=2477,y=-1660,z=13.34,a=86.5,vehmodel=541,col_size=2,items={{"Объедки",5},{"Остатки пиццы",1},{"Канистра с топливом",10}}},{skin=0,x=2488,y=-1660,z=13.34,a=86.5,vehmodel=498,col_size=2},},},
	{id="Караванщики в НВ",seqid = 1, speed = 50, destroy_convoy_time = 10000, check_hp = true, check_tires = false, hp_to_stop = 400, damage_proof = true, tires_quant = 2, peds={{skin=0,x=1070.6,y=1371.15,z=11,a=269,vehmodel=482,col_size=2,items={}},{skin=0,x=1079,y=1371.15,z=11,a=269,vehmodel=438,col_size=2,items={}},{skin=0,x=1090.6,y=1371.15,z=11,a=269,vehmodel=427,col_size=2,items={}},},},
	{id="Караванщики в НВ2",seqid = 1, speed = 50, destroy_convoy_time = 10000, check_hp = true, check_tires = false, hp_to_stop = 400, damage_proof = true, tires_quant = 2, peds={{skin=0,x=1070.6,y=1371.15,z=11,a=269,vehmodel=482,col_size=2,items={}},},},
	{id="НВ-Караван",seqid = 1, backwards = true, speed = 50, destroy_convoy_time = 10000, check_hp = true, check_tires = false, hp_to_stop = 400, damage_proof = true, tires_quant = 2, peds={{skin=0,x=-363.25,y=2687,z=63.14,a=58.44,vehmodel=482,col_size=2,items={}},},},
}
-- Расшифровка:
-- id = "название", seqid = номер маршрута, speed = скорость (не ставь слишком большую, а то машины начнут врезаться куда попало), destroy_convoy_time = через сколько милисекунд машина уничтожается в случае остановки из за урона
-- check_hp = останавливать ли автомобиль, если у него мало здоровья, check_tires = останавливать ли автомобиль, если у него разрушены колеса, hp_to_stop = при каком количестве ХП машина останавливается (при меньше 300 она загорается)
-- damage_proof = делать ли машину неуязвимой при остановке из за урона, tires_quant = сколько колес должно быть уничтожено у автомобиля для остановки (все машины имеют 4 колеса, даже если внешне их 6, то некоторые из них просто дублируются)
-- peds = {список нпц в ковое}
-- Настройка одного нпц:
-- skin = ид скина, x,y,z = координаты спавна, a = поворот при спавне (нпц должен смотреть на первую точку в маршруте), vehmodel = ид модели автомобиля, items = {список предметов в автомобиле}
-- Список предметов: {"Название", количество}
-- col_size = размер зоны открытия инвентаря автомобиля
-- Если у тебя автомобиль без вещей будет, то можешь items={} и colsize не добавлять в настройку нпц
-- P.S. порядок указания всех этих настроек не важен

tasks = {}
convoys = {}
tasks_reverse = {}

function createConvoy (config)
	if not convoys[config.id] then
		convoys[config.id] = {}
		convoys[config.id].npcs = {}
		convoys[config.id].config = {config.check_hp,config.check_tires,config.hp_to_stop,config.damage_proof,config.tires_quant}
		convoys[config.id].destroy_convoy_time = config.destroy_convoy_time
		convoys[config.id].name = config.id
		convoys[config.id].backwards = config.backwards
		convoys[config.id].seq = config.seqid
		for i, ped in ipairs (config.peds) do
			local npc = createPed(ped.skin,ped.x,ped.y,ped.z,ped.a)
			if not npc then
				outputDebugString("Convoy: Failed to create ped",2)
				return
			end
			exports.npc_hlc:enableHLCForNPC(npc,"run",1,config.speed/180)
			local vehicle = createVehicle(ped.vehmodel,ped.x,ped.y,ped.z,0,0,ped.a)
			if not vehicle then
				destroyElement(npc)
				outputDebugString("Convoy: Failed to create vehicle",2)
				return
			end
			setElementData(npc,"convoy:vehicle",vehicle,false)
			setElementData(npc,"convoy:selfid",i,false)
			setElementData(npc,"convoy:id",config.id,false)
			setElementData(vehicle,"convoy:id",config.id)
			setElementData(vehicle,"convoy:selfid",i,false)
			local col
			if ped.col_size then
				col = createColSphere(ped.x,ped.y,ped.z,ped.col_size)
				if not col then
					destroyElement(npc)
					destroyElement(vehicle)
					outputDebugString("Convoy: Failed to create colshape",2)
					return
				end
				setElementData(col,"itemloot",true)
				setElementData(col,"MAX_Slots",0)
				attachElements ( col, vehicle )
				
				if ped.items then
					for _, item in ipairs ( ped.items ) do
						setElementData ( col, item[1], item[2] )
					end
				end
			end
			
			addEventHandler("onVehicleDamage", vehicle, convoyVehicleDamage) 
			convoys[config.id].npcs[i] = {npc=npc,vehicle=vehicle,done_tasks = 0,col=col}
			addEventHandler("npc_hlc:onNPCTaskDone",npc,convoyVehicleTaskDone)
			warpPedIntoVehicle(npc,vehicle)
		end
		convoys[config.id].start_timer = setTimer ( startConvoy, convoy_start_time, 1, config.id )
		outputChatBox("Конвой "..config.id.." начался! Номер маршрута: "..config.seqid..". Старт через: "..(math.floor(convoy_start_time/1000)).." секунд.",root,30,255,30)
	else
		outputChatBox("Конвой с таким ИД уже запущен!",root,255,10,10)
	end
end

function convoyVehicleTaskDone ()
	local convoyID = getElementData (source,"convoy:id")
	local id = getElementData (source,"convoy:selfid")
	if convoys[convoyID] then
		if convoys[convoyID].npcs[id] then
			convoys[convoyID].npcs[id].done_tasks = convoys[convoyID].npcs[id].done_tasks+1
			--outputChatBox(tostring(convoys[convoyID].npcs[id].done_tasks+1)..": "..tasks[convoys[convoyID].seq][convoys[convoyID].npcs[id].done_tasks+1][6])
			if convoys[convoyID].npcs[id].done_tasks == #((convoys[convoyID].backwards and tasks_reverse or tasks)[convoys[convoyID].seq])-1 then
				destroyConvoyVehicle (getElementData(source,"convoy:vehicle"))
			else
				exports.npc_hlc:setNPCDriveSpeed (source, tasks[convoys[convoyID].seq][convoys[convoyID].npcs[id].done_tasks+1][6]/180)	
			end
		end
	end
end

function startConvoy(id)
	if convoys[id] then
		local seq_id = convoys[id].seq
		if (convoys[id].backwards and tasks_reverse or tasks)[seq_id] then
			for i, ped in ipairs (convoys[id].npcs) do
				if isElement ( ped.npc ) then
					exports.npc_hlc:clearNPCTasks(ped.npc)
					for taskid,task in ipairs((convoys[id].backwards and tasks_reverse or tasks)[seq_id]) do
						if task[1] ~= "(no action)" then
							if taskid > 1 then
								if time_between_starts > 0 then
									setTimer ( function() exports.npc_hlc:addNPCTask(ped.npc,task) end, i*time_between_starts, 1 )
								else
									exports.npc_hlc:addNPCTask(ped.npc,task)
								end
							end
						end
					end
					setElementData(getPedOccupiedVehicle(ped.npc),"convoy:going",true,false)
				else
					outputDebugString ("Convoy: NPC not found, cancelling convoy",2)
					return true
				end
			end
		else
			outputDebugString ("Convoy: TASK not found, cancelling convoy",2)
		end
	end
end

function convoyVehicleDamage(loss)
	local convoyID = getElementData (source,"convoy:id")
	if convoys[convoyID] then
		if convoys[convoyID].config[1] then
			if getElementHealth ( source ) < convoys[convoyID].config[3] then
				stopConvoyVehicle(source)
				return true
			end
		end
	end
end

function vehicleConvoyTireDamage (tyreid)
	local convoyID = getElementData (source,"convoy:id")
	local vehicleID = getElementData (source,"convoy:selfid")
	if convoyID and vehicleID then
		if convoys[convoyID] and convoys[convoyID].config[2] then
			local frontLeft, rearLeft, frontRight, rearRight = getVehicleWheelStates ( source )
			local broken_tyres = 1
			if frontLeft == 1 and tyreid ~= 0 then
				broken_tyres = broken_tyres+1
			end
			if rearLeft == 1 and tyreid ~= 1 then
				broken_tyres = broken_tyres+1
			end
			if frontRight == 1 and tyreid ~= 2 then
				broken_tyres = broken_tyres+1
			end
			if rearRight == 1 and tyreid ~= 3 then
				broken_tyres = broken_tyres+1
			end 
			if broken_tyres >= convoys[convoyID].config[5] then
				stopConvoyVehicle(source)
			end
		end
	end
end

addEvent("convoy:vehicleTireDamage", true)
addEventHandler("convoy:vehicleTireDamage", root, vehicleConvoyTireDamage )

function onConvoyStartClicked (id, start)
	if convoysConfig[id] then
		local name = convoysConfig[id].id
		if start then
			if not convoys[name] then
				createConvoy(convoysConfig[id])
			else
				outputChatBox ("Этот конвой уже запущен",source,255,10,10)
			end	
		else
			if convoys[name] then
				if convoys[name].npcs then
					for i, v in ipairs ( convoys[name].npcs ) do
						if isElement ( v.vehicle ) then
							destroyElement (v.vehicle)
						end
						if isElement ( v.npc ) then
							destroyElement (v.npc)
						end
						if isElement ( v.col ) then
							destroyElement (v.col)
						end
					end
				end
				if isTimer ( convoys[name].start_timer ) then
					killTimer ( convoys[name].start_timer )
				end
				outputChatBox ("Конвой "..name.." отменен администратором "..getPlayerName ( source ),root,255,150,150)
				convoys[name] = nil
			else
				outputChatBox ("Этот конвой не запущен.",source,255,10,10)
			end
		end
	end
end

addEvent("convoy:onConvoyStartClicked", true)
addEventHandler("convoy:onConvoyStartClicked", root, onConvoyStartClicked )
 
function stopConvoyVehicle(vehicle)
	local convoyID = getElementData (vehicle,"convoy:id")
	local vehicleID = getElementData (vehicle,"convoy:selfid")
	if convoyID and vehicleID then
		if convoys[convoyID] and getElementData ( vehicle, "convoy:going" ) then
			outputChatBox("Машина "..vehicleID.." конвоя "..convoys[convoyID].name.." остановилась.")
			exports.npc_hlc:clearNPCTasks(convoys[convoyID].npcs[vehicleID].npc)
			setElementData ( vehicle, "convoy:going", false, false )
			if convoys[convoyID].config[4] then
				setElementHealth ( source, convoys[convoyID].config[3] )
				setVehicleDamageProof ( source, true )
			end
			setTimer ( destroyConvoyVehicle, convoys[convoyID].destroy_convoy_time, 1, vehicle )
		end
	end
end

function destroyConvoyVehicle (vehicle)
	if isElement ( vehicle ) then
		local vehicleID = getElementData (vehicle,"convoy:selfid")
		local convoyID = getElementData (vehicle,"convoy:id")
		if convoyID and vehicleID then
			if convoys[convoyID] then
				if isElement ( vehicle ) then
					destroyElement (vehicle)
				end
				if isElement ( convoys[convoyID].npcs[vehicleID].npc ) then
					destroyElement (convoys[convoyID].npcs[vehicleID].npc)
				end
				if isElement ( convoys[convoyID].npcs[vehicleID].col ) then
					destroyElement (convoys[convoyID].npcs[vehicleID].col)
				end
				checkConvoyDeadVehicles(convoyID)
			end
		end
	end
end

function checkConvoyDeadVehicles (convoyID)
	if convoys[convoyID] then
		local quant = 0
		local dead = 0
		for i, v in ipairs ( convoys[convoyID].npcs ) do
			quant = quant+1
			if not isElement (v.npc) then
				dead = dead+1
			end
		end
		if dead == quant then
			outputChatBox ("Все автомобили конвоя "..convoys[convoyID].name.." уничтожены или достигли цели.",root,255,255,255)
			convoys[convoyID] = nil
		end
	end
end

function showConvoysMenu(thePlayer)
    if isObjectInACLGroup ("user."..getAccountName ( getPlayerAccount ( thePlayer ) ), aclGetGroup ( "Admin" ) ) then
		triggerClientEvent ( thePlayer, "convoy:showConvoyMenu", thePlayer, convoysConfig, convoys )
	end
end
addCommandHandler ("convoys", showConvoysMenu)

addEventHandler("onResourceStart",resourceRoot,loadTaskSequences)