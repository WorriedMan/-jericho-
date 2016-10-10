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
		grid.abs_x = pipWindowses[config.parent].x+grid.x
		grid.abs_y = pipWindowses[config.parent].y+grid.y
		grid.width = config.width
		grid.height = config.height
		grid.text = config.itext
		grid.alignX = config.alignX or "left"
		grid.alignY = config.alignY or "top"
		grid.state = 1
		grid.offset = 0
		grid.font = config.fontSize or 1.0
		grid.font_n = config.fontName or font or "default"
		grid.r = config.r or 255
		grid.g = config.g or 182
		grid.b = config.b or 66
		grid.visible = true
		grid.showBack = config.showBack
		
		
		grid.LinesList = {}
		grid.selectedRow = nil
		
		function grid:destroyMe()
			pipWindowses[config.parent].child[config.name] = nil
			imageButtons[config.name] = nil
			return true
		end
		function grid:setVisible()
			grid.visible = not grid.visible
			return true
		end
		
		function grid:drawSelf()
			local basex, basey = pipWindowses[config.parent].x+grid.x, pipWindowses[config.parent].y+grid.y
				if isCursorInPosition ( grid.x, grid.y, grid.width, grid.height ) then
				
				end
				local selected = nil
				for num = 1, grid.maxlines do
					if not grid.LinesList[num+grid.offset] then break end
					local line = grid.LinesList[num+grid.offset]
					local size = 1
					while size > 0.3 and dxGetTextWidth ( line.label, size, font ) > grid.width-6 do
						size = size-0.05
					end
					dxDrawText ( line.label, basex+3, basey+(num-1)*grid.line_size, basex+grid.width-3, basey+num*grid.line_size, tocolor ( 255, 182, 66 ), size, font, "center", "center", true )
					if isCursorInPosition ( basex, basey+(num-1)*grid.line_size, grid.width, grid.line_size ) then
						selected = num+grid.offset
						dxDrawRectangle ( basex, basey+(num-1)*grid.line_size, grid.width, grid.line_size, tocolor ( 255, 182, 66, 30 ) )
						if num ~= 1 then
							dxDrawLine ( basex, basey+(num-1)*grid.line_size, basex+grid.width, basey+(num-1)*grid.line_size, tocolor ( 255, 182, 66 ), 1.5 )
						end
						if num ~= grid.maxlines then
							dxDrawLine ( basex, basey+num*grid.line_size, basex+grid.width, basey+num*grid.line_size, tocolor ( 255, 182, 66 ), 1.5 )
						end
					end
				end
				grid.selectedRow = selected
			--if button.state > 1 then
			dxDrawLine ( basex, basey+grid.height, basex+grid.width, basey+grid.height, tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawLine ( basex, basey, basex+grid.width, basey, tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawLine ( basex, basey, basex, basey+grid.height, tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawLine ( basex+grid.width, basey, basex+grid.width, basey+grid.height, tocolor ( 255, 182, 66 ), 1.5 )
			--end
			--dxDrawText ( button.text, basex+button.x+3, basey+button.y+3, basex+button.x+button.width-3, basey+button.y+button.height-3, tocolor ( button.r, button.g, button.b ), button.font, button.font_n, button.alignX, button.alignY )
		end
		
		pipGrids[config.name] = grid
		--grid = pipGrids[config.name]
		pipWindowses[config.parent].child[config.name] = pipGrids[config.name]
		return grid
	else
		error ( 'Failed creating list! Missed some arguments.' )
	end
end

function pipListAddItem(list,config)
	if config.parent and pipGrids[config.parent] and config.label then
		local line = {}
		line.label = config.label
		table.insert(pipGrids[config.parent].LinesList,line)
	end
end

function playerScrolledGrid (key,keyState,arg)
	if ( keyState == "down" ) then
		if arg == "up" then
			for i, v in pairs (pipGrids) do
				if v.visible then
					if v.offset > 0 then
						v.offset = v.offset-1
						outputDebugString(v.offset)
					end
				end
			end
		elseif arg == "down" then
			for i, v in pairs (pipGrids) do
				if v.visible then
				if v.LinesList[v.maxlines+v.offset+1] then
					v.offset = v.offset+1
					outputDebugString(v.offset)
				end
				end
			end
		end
	end
end
bindKey ( "mouse_wheel_up", "down", playerScrolledGrid, "up" )
bindKey ( "mouse_wheel_down", "down", playerScrolledGrid, "down" )