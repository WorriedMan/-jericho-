function ripairs(t)
	local max = 1
	while t[max] ~= nil do
		max = max + 1
	end
	local function ripairs_it(t, i)
		i = i-1
		local tt = t[i]
		if tt then
			if tt[1] == "driveAroundBend" then
				local x, y, z = tt[4], tt[5], tt[6]
				tt[4], tt[5], tt[6] = tt[7], tt[8], tt[9]
				tt[7], tt[8], tt[9] = x, y, z
			end
			if tt[1] == "drivetoPos" then
				if tt[6] > 50 then
					tt[6] = math.floor(tt[6]*0.5)
				elseif tt[6] < 30 then
					tt[6] = math.floor(tt[6]*1.5)
				end
			end
		end
		local v = tt
		if v ~= nil then
			return i,v
		else
			return nil
		end
	end
	--outputChatBox(tostring(ripairs_it).. " ".. tostring(t).." "..tostring(max))
	return ripairs_it, t, max
end

function ripairs_b(t)
	local function ripairs_it(t,i)
		i=i-1
		if t[i] and t[i][1] == "driveAroundBend" then
			local x, y, z = t[i][3], t[i][4], t[i][5]
			t[i][3], t[i][4], t[i][5] = t[i][6], t[i][7], t[i][8]
			t[i][6], t[i][7], t[i][8] = x, y, z
		end
		
		local v=t[i]
		if v==nil then return v end
		return i,v
	end
	return ripairs_it, t, #t+1
end

function ReverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do
		if t[k][1] == "driveAroundBend" then
			local x, y, z = t[k][3], t[k][4], t[k][5]
			t[k][3], t[k][4], t[k][5] = t[k][6], t[k][7], t[k][8]
			t[k][6], t[k][7], t[k][8] = x, y, z
		end
        reversedTable[itemCount + 1 - k] = v
    end
    return reversedTable
end

function loadTaskSequences()
	local ts_file = xmlLoadFile("sequences.xml","sequences")
	if not ts_file then return end
	local ts_nodes = xmlNodeGetChildren(ts_file)
	for ts_num,ts_node in ipairs(ts_nodes) do
		local id = tonumber(xmlNodeGetAttribute(ts_node,"id"))
		local name = xmlNodeGetAttribute(ts_node,"name")
		tasks[id] = {}
		local task_nodes = xmlNodeGetChildren(ts_node)
	--	local temptable = {}
		for task_num,task_node in ipairs(task_nodes) do
				local taskid = tonumber(xmlNodeGetAttribute(task_node,"id"))
				local task = {}
				local par_nodes = xmlNodeGetChildren(task_node)
				for par_num,par_node in ipairs(par_nodes) do
					local parid = tonumber(xmlNodeGetAttribute(par_node,"id"))
					local partype = xmlNodeGetAttribute(par_node,"type")
					local parameter = xmlNodeGetAttribute(par_node,"value")
					if partype == "number" then parameter = tonumber(parameter) end
					task[parid] = parameter
				end
				table.insert (tasks[id],task)
				--table.insert (temptable,task)
		end
		-- local rev_task = {}
		-- for i, v in ripairs(temptable) do
			-- table.insert ( rev_task, v )
		-- end
		-- tasks_reverse[id] = rev_task
	end
	xmlUnloadFile(ts_file)
end