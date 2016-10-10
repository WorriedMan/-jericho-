UPDATE_INTERVAL_MS = 2000 -- 2000
UPDATE_INTERVAL_MS_INV = 1/UPDATE_INTERVAL_MS
UPDATE_INTERVAL_S = UPDATE_INTERVAL_MS*0.001
UPDATE_INTERVAL_S_INV = 1/UPDATE_INTERVAL_S

function initNPCControl()
	addEvent("npc_hlc:onNPCTaskDone",false)
	setTimer(cycleNPCs,UPDATE_INTERVAL_MS,0)
end

function cycleNPCs()
	check_cols = get("npc_hlc.server_colchecking") == "true" and "true" or nil
	if check_cols then
		server_coldata = getResourceFromName("server_coldata")
		if server_coldata and getResourceState(server_coldata) == "running" then
			call(server_coldata,"generateColData")
		else
			check_cols = nil
		end
	end

	for npc,exists in pairs(all_npcs) do
		if isHLCEnabled(npc) then
			local syncer = getElementSyncer(getPedOccupiedVehicle(npc) or npc)
			local thistask = getElementData(npc,"npc_hlc:thistask")
			if thistask then
				local task = getElementData(npc,"npc_hlc:task."..thistask)
				if task and #task > 0 then
					if checkPedStuck(npc,task) then
						local weap = getPedWeaponSlot(npc)
						if weap == 1 or weap == 7 then
							setPedWeaponSlot(npc, 0 )
							triggerClientEvent("npc_hlc:npcJump",npc)
							setTimer ( setPedWeaponSlot, 850, 1, npc, weap)
						else
							triggerClientEvent("npc_hlc:npcJump",npc)
						end
					end
					if task[1] == "killPed" then
						if not syncer and isElement ( task[2] ) and getElementType(task[2]) == "player" then
							setElementSyncer ( npc, task[2] )
						end
					end
				end
			end
			if syncer then
				if unsynced_npcs[npc] then
					removeNPCFromUnsyncedList(npc)
				end
			else
				if not unsynced_npcs[npc] then
					addNPCToUnsyncedList(npc)
				end
			end
		else
			if unsynced_npcs[npc] then
				removeNPCFromUnsyncedList(npc)
			end
		end
	end
	local this_time = getTickCount()
	local gamespeed = getGameSpeed()
	for npc,unsynced in pairs(unsynced_npcs) do
		if getElementHealth(getPedOccupiedVehicle(npc) or npc) >= 1 then
			local time_diff = (this_time-getNPCLastUpdateTime(npc))*gamespeed
			while time_diff > 1 do
				local thistask = getElementData(npc,"npc_hlc:thistask")
				if thistask then
					local task = getElementData(npc,"npc_hlc:task."..thistask)
					if not task then
						removeElementData(npc,"npc_hlc:thistask")
						removeElementData(npc,"npc_hlc:lasttask")
						break
					else
						if task[1] == "killPed" and isElement ( task[2] ) and getElementType(task[2]) == "player" then
							setElementSyncer ( npc, task[2] )
							removeNPCFromUnsyncedList(npc)
							break
						else
							local prev_time_diff,prev_task = time_diff,task
							time_diff = time_diff-performTask[task[1]](npc,task,time_diff)
							--if math.floor(prev_time_diff) ~= math.floor(time_diff) then -- тут было без floor
							if prev_time_diff ~= time_diff then
								break
							end
							if time_diff > 1 then
								setNPCTaskToNext(npc)
							end
						end
					end
				else
					break
				end
			end
			updateNPCLastUpdateTime(npc,this_time)
		end
	end
end

local movingTasks = {
	["walkToPos"] = true,
	["walkAlongLine"] = true,
	["walkAroundBend"] = true,
	["killPed"] = true,
}

function checkPedStuck ( ped, task )
	if not task[1] or not movingTasks[task[1]] then
		return false
	end
	local oldPos = getElementData (ped,"npc_hlc:oldposition")
	local x,y,z = getElementPosition ( ped )
	local stuck = false
	if oldPos then
		local maxRange = 0.5
		local target_distance = false
		if task[1] == "killPed" then
			maxRange = task[3]
			local target = task[2]
			if isElement(target) then
				local x,y,z = getElementPosition(target)
				if getDistanceBetweenPoints3D (oldPos[1], oldPos[2], oldPos[3], x,y,z) <= maxRange then
					target_distance = true
				end
			end
		end
		local distance = (getDistanceBetweenPoints3D (oldPos[1], oldPos[2], oldPos[3], x,y,z))
		if distance <= maxRange and not target_distance then
			stuck = true
		end
	end
	setElementData (ped,"npc_hlc:oldposition",{x,y,z},false)
	return stuck
end

-- function checkPedStuck(ped,task)
	-- local bPathClear = true
    -- local t_Matrix = getElementMatrix (t_Data.ped)
 
    -- -- Calculate a position 1m ahead of ped
    -- local int_RayX = t_Matrix[2][1] + t_Matrix[4][1]
    -- local int_RayY = t_Matrix[2][2] + t_Matrix[4][2]
    -- local int_RayZ = t_Matrix[2][3] + t_Matrix[4][3]
 
    -- -- We cast 10 rays 1m ahead of the ped
    -- for i = 1, 10 do
        -- local intSourceX, intSourceY, intSourceZ = t_PedPos[1], t_PedPos[2], t_PedPos[3]
 
        -- -- The target position height is identical to the center of the ped (1m above ground) 
        -- -- We lower this value by 0.5m to detect short obstacles
        -- local intTargetX, intTargetY, intTargetZ = int_RayX, int_RayY, int_RayZ - 0.5 + i*0.2
 
        -- bPathClear = isLineOfSightClear (intSourceX, intSourceY, intSourceZ, intTargetX, intTargetY, intTargetZ, true, true, false, true)
        -- dxDrawLine3D (intSourceX, intSourceY, intSourceZ, intTargetX, intTargetY, intTargetZ, bPathClear and tocolor(255,255,255,255) or tocolor(255,0,0,255))
 
        -- if (not bPathClear) then
            -- break
        -- end
    -- end
-- end

function setNPCTaskToNext(npc)
	local thistask = getElementData(npc,"npc_hlc:thistask")
	setElementData(npc,"npc_hlc:thistask",thistask+1)
end

function cleanUpDoneTasks(dataname,oldval)
	if notrigger then return end
	if not oldval or dataname ~= "npc_hlc:thistask" then return end
	local newval = getElementData(source,dataname)
	if not newval then return end
	if newval < oldval then
		notrigger = true
		setElementData(source,dataname,oldval)
		notrigger = nil
	end
	for tasknum = oldval,newval-1 do
		local taskstr = "npc_hlc:task."..tasknum
		local task = getElementData(source,taskstr)
		if task then
			triggerEvent("npc_hlc:onNPCTaskDone",source,task)
			--removeElementData(source,taskstr)
			setElementData(source,taskstr,false)
		end
	end
end

