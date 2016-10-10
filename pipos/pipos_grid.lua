pipGrids = {}
selectedGridItem = false

local default_line_height = 50

function createPipList ( config )
	if config.name and config.x and config.y and config.width and config.height and config.parent then
		if not pipWindowses[config.parent] then
			error ( 'Window with name \"'..config.parent..'\" does not exist!' )
			return false
		end
		if pipWindowses[config.parent].child[config.name] then
			error ( 'Child with name \"'..config.name..'\" was already created.' )
			return false
		end
		local grid = {}
		grid.line_size = config.line_size or default_line_height
		grid.maxlines = math.floor(config.height/grid.line_size)
		grid.name = config.name
		grid.x = config.x
		grid.y = config.y
		grid.width = config.width
		grid.height = config.height
		grid.abs_x = pipWindowses[config.parent].x+grid.x
		grid.abs_y = pipWindowses[config.parent].y+grid.y
		grid.offset = 0
		grid.visible = true
		grid.listView = true
		grid.color = config.color
		grid.hide_background = config.hide_background
		
		
		grid.LinesList = {}
		grid.selectedRow = nil
		
		function grid:destroyMe()
			pipWindowses[config.parent].child[config.name] = nil
			imageButtons[config.name] = nil
			return true
		end
		function grid:setVisible(state)
			grid.visible = state
			return true
		end
		
		function grid:drawSelf()
			if not grid.visible then return end
			local basex, basey = pipWindowses[config.parent].x+grid.x, pipWindowses[config.parent].y+grid.y
			local selected = nil
			for num = 1, grid.maxlines do
				if not grid.LinesList[num+grid.offset] then break end
				local line = grid.LinesList[num+grid.offset]
				local size = 1
				while size > 0.3 and dxGetTextWidth ( line.label, size, font ) > grid.width-6 do
					size = size-0.05
				end
				dxDrawText ( line.label, basex+3, basey+(num-1)*grid.line_size, basex+grid.width-3, basey+num*grid.line_size, grid.color or tocolor ( 255, 182, 66 ), size, font, "center", "center", true )
				if isCursorInPosition ( basex, basey+(num-1)*grid.line_size, grid.width, grid.line_size ) then
					selected = num+grid.offset
					if not grid.hide_background then
						dxDrawRectangle ( basex, basey+(num-1)*grid.line_size, grid.width, grid.line_size, tocolor ( 255, 182, 66, 30 ) )
					end
					if num ~= 1 then
						dxDrawLine ( basex, basey+(num-1)*grid.line_size, basex+grid.width, basey+(num-1)*grid.line_size, grid.color or tocolor ( 255, 182, 66 ), 1.5 )
					end
					if num ~= grid.maxlines then
						dxDrawLine ( basex, basey+num*grid.line_size, basex+grid.width, basey+num*grid.line_size, grid.color or tocolor ( 255, 182, 66 ), 1.5 )
					end
				end
			end
			grid.selectedRow = selected
			dxDrawLine ( basex, basey+grid.height, basex+grid.width, basey+grid.height, grid.color or tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawLine ( basex, basey, basex+grid.width, basey, grid.color or tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawLine ( basex, basey, basex, basey+grid.height, grid.color or tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawLine ( basex+grid.width, basey, basex+grid.width, basey+grid.height, grid.color or tocolor ( 255, 182, 66 ), 1.5 )
		end
		
		pipGrids[config.name] = grid
		pipWindowses[config.parent].child[config.name] = pipGrids[config.name]
		return grid
	else
		error ( 'Failed creating list! Missed some arguments.' )
	end
end

function pipListAddItem(config)
	if config.parent and pipGrids[config.parent] and config.label then
		local line = {}
		line.label = config.label
		line.data = config.data or {}
		table.insert(pipGrids[config.parent].LinesList,line)
		return #pipGrids[config.parent].LinesList
	end
	return false
end

function pipListClear(list)
	if list and pipGrids[list] then
		pipGrids[list].LinesList = {}
	end
end

function pipListSetItemData(list,count,dataName,data)
	if list and pipGrids[list] and pipGrids[list].LinesList and pipGrids[list].LinesList[count] then
		pipGrids[list].LinesList[count].data[dataName] = data
		return true
	end
	return false
end

function pipListGetItemData(list,count,dataName)
	if list and pipGrids[list] and pipGrids[list].LinesList and pipGrids[list].LinesList[count] then
		return pipGrids[list].LinesList[count].data[dataName]
	end
	return false
end

function playerScrolledGrid (key,keyState,arg)
	if ( keyState == "down" ) then
		if arg == "up" then
			for i, v in pairs (pipGrids) do
				if v.visible then
					if v.offset > 0 then
						v.offset = v.offset-1
					end
				end
			end
		elseif arg == "down" then
			for i, v in pairs (pipGrids) do
				if v.visible then
					if v.LinesList[v.maxlines+v.offset+1] then
						v.offset = v.offset+1
					end
				end
			end
		end
	end
end
bindKey ( "mouse_wheel_up", "down", playerScrolledGrid, "up" )
bindKey ( "mouse_wheel_down", "down", playerScrolledGrid, "down" )