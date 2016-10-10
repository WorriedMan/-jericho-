tasks = {}
local bandsPoints = {}

local respawnTime = 10 -- минуты

function createBands ()
	loadTaskSequences()
	for i,v in ipairs ( npcSpawns ) do
		spawnBand(i)
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(), createBands )

local bands = {}

function spawnBand(id)
	local cfg = npcSpawns[id]
	local starting_pos = math.random(#tasks[cfg.path]-1)
	--local starting_pos = 30
	local pos = {tasks[cfg.path][starting_pos][2],tasks[cfg.path][starting_pos][3],tasks[cfg.path][starting_pos][4]}
	bands[id] = {}
	for i, v in ipairs (cfg.soldiers) do
		spawnBandit(pos,id,i)
	end
	setTimer(resumeGangTask,2000,1,id,starting_pos+1)
end

function spawnBandit(pos,band_id,id)
	local cfg = npcSpawns[band_id]
	local v = cfg.soldiers[id]
	local offX, offY = math.random ( -2, 2 ), math.random ( -2, 2 )
	local bandit = exports.peds:createCustomPed({class = "band", model = v.skin, visioncheck = true, pos = Vector3(pos[1]+offX, pos[2]+offY, pos[3]), weapon = v.weapon, health = v.health or cfg.health, xp = v.xp_reward or cfg.xp_reward, accuracy_stat = v.accuracy_s or 0})
	exports.npc_hlc:enableHLCForNPC (bandit, 'walk', 1)
	--createBlipAttachedTo(bandit)
	setElementData ( bandit, "attS", 30, false )
	setElementData ( bandit, "attD", 30, false )
	setElementData ( bandit, "band:id", band_id, false )
	setElementData ( bandit, "path_ped", true )
	setElementData ( bandit, "path_ped:id", id, false )
	setElementData ( bandit, "path_ped:path_id", cfg.path, false )
	setElementData ( bandit, "path_ped:point", starting_pos, false )
	setElementData ( bandit, "path_ped:speed", "walk", false )
	setElementData ( bandit, "path_ped:attack_speed", "run", false )
	addEventHandler("npc_hlc:onNPCTaskDone",bandit,pathPedTaskDone)
	addEventHandler("onPedWasted",bandit,banditWasted)
	bands[band_id][id] = bandit
	return bandit
end

function respawnBandit(bandit,loot)
	if isElement(bandit) then
		destroyElement(bandit)
	end
	if isElement(loot) then
		destroyElement(loot)
	end
end

function banditWasted()
	local band_id = getElementData(source,"band:id")
	local id = getElementData(source,"path_ped:id")
	local x,y,z = getElementPosition(source)
	local loot = exports.loot:createCustomLoot (x,y,z,0,0,npcSpawns[band_id].soldiers[id].items or npcSpawns[band_id].items,true)
	setTimer(respawnBandit,respawnTime*60000,1,source,loot)
	--setTimer(respawnBandit,10000,1,source,loot)
end

function resumeGangTask(id,point,resume)
	for i, v in ipairs (bands[id]) do
		if not isElement(v) then
			spawnBandit({tasks[npcSpawns[id].path][point][2],tasks[npcSpawns[id].path][point][3],tasks[npcSpawns[id].path][point][4]},id,i)
		end
		local offX, offY = math.random ( -2, 2 ), math.random ( -2, 2 )
		exports.npc_hlc:clearNPCTasks(v)
		if not resume then
			setElementPosition(v,tasks[npcSpawns[id].path][point][2]+offX,tasks[npcSpawns[id].path][point][3]+offY,tasks[npcSpawns[id].path][point][4])
		end
		setTimer(assignPedTasks,math.random(100,2000), 1, v,tasks[npcSpawns[id].path],point,resume)
	end
end

function assignPedTasks (ped,taskTable,id,resume)
	if isElement ( ped ) then
		exports.npc_hlc:clearNPCTasks(ped)
		setElementData(ped,"target",false)
		local firsttask = resume
		for i = id, #taskTable do
			local offX, offY = math.random ( -2, 2 ), math.random ( -2, 2 )
			if taskTable[i][1] ~= "(no action)" then
				if not firsttask then
					firsttask = true
					setElementPosition(ped,taskTable[i][2],taskTable[i][3],taskTable[i][4])
				end
				local ped_task = taskTable[i]
				ped_task[2], ped_task[3] = ped_task[2]+offX, ped_task[3]+offY
				setTimer ( function () exports.npc_hlc:addNPCTask(ped,ped_task) end, 1000, 1 )
			end
		end
		if getElementData ( ped, "leave_position" ) then
			setElementData ( ped, "leave_position", nil, false )
		end
		setElementData ( ped, "path_ped:point", id, false )
		exports.npc_hlc:setNPCWalkSpeed (ped, getElementData(ped,"path_ped:speed"))
	end
end

function pathPedTaskDone (done_task)
	local id = getElementData (source,"path_ped:id")
	local path_id = getElementData (source,"path_ped:path_id")
	local done = getElementData (source,"path_ped:point")
	local task = tasks[path_id]
	if task then
		if done_task[1] == "walkToPos" then
			if done == #task then
				bandsPoints[id] = 1
				resumeGangTask(getElementData(source,"band:id"),1)
			else
				if bandsPoints[id] ~= done+1 then
					for i, v in ipairs (bands[getElementData (source,"band:id")]) do
						if not isElement(v) then
							spawnBandit({tasks[npcSpawns[id].path][done][2],tasks[npcSpawns[id].path][done][3],tasks[npcSpawns[id].path][done][4]},getElementData (source,"band:id"),i)
						end
					end
				end
				bandsPoints[id] = done+1
				setElementData ( source, "path_ped:point", done+1, false )
			end
			
		elseif done_task[1] == "killPed" then
			exports.npc_hlc:clearNPCTasks(source)
			setElementData(source,"target",false)
			setElementData(source,"band:was_firing",true)
		end
	end
end

function checkBandsAway()
	for i, v in pairs(bands) do
		local somebodyFound = true
		local resume_point
		local respawning = {}
		local noonealive = true
		for k, ped in ipairs (v) do
			if isElement(ped) then
				noonealive = false
				if getElementData(ped,"band:was_firing") and not isElement(getElementData(ped,"target")) then
					local x,y,z = getElementPosition(ped)
					local shape = createColSphere(x,y,z,100)	
					outputChatBox(tostring(#getElementsWithinColShape(shape,"player")))
					if #getElementsWithinColShape(shape,"player") == 0 then
						setElementData(ped,"band:was_firing",false)
						somebodyFound = false
						resume_point = getElementData(ped,"path_ped:point")
					end
					destroyElement(shape)
				end
			end
		end
		if noonealive then
			spawnBand(i)
		elseif not somebodyFound then
			resumeGangTask(i,resume_point)
		end
	end
end

setTimer(checkBandsAway,5000,0)

function chasedStartAttack (ped)	
	local band_id = getElementData(ped,"band:id")
	for i, v in pairs(bands[band_id]) do
		if isElement(v) then
			if not isPedDead ( v ) then
				setElementData ( v, "target", source )
				exports.npc_hlc:clearNPCTasks ( v )
				exports.npc_hlc:setNPCWalkSpeed (v, "run")
				local attS, attD = getElementData ( v, "attS" ), getElementData ( v, "attD" )
				exports.npc_hlc:addNPCTask ( v, {"killPed", source, attS, attD} )
				local x,y,z = getElementPosition (v)
				setElementData(v,"leave_position",{x,y,z})
				--	setTimer ( checkBandTarget, 1000, 1, v )
			end
		end
	end
end

addEvent( "chasedBandStartAttackC", true )
addEventHandler( "chasedBandStartAttackC", getRootElement(), chasedStartAttack )