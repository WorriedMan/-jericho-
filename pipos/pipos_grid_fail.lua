pipGrids = {}
selectedGridItem = false

local default_line_height = 50

pipList = { };
pipList.__index = pipList;

function createPipList(config)
	return pipList:create(config)
end

function getListTable ()
	return pipList
end

function pipListAddItem(list,config)
	outputDebugString(tostring(list))
	for i, v in pairs (list) do
		outputDebugString(tostring(i).." "..tostring(v))
	end
	list:addItem(config)
end

function pipList:create(config)
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
		grid.parent = config.parent
				
		grid.LinesList = {}
		grid.selectedRow = nil
				
		pipGrids[config.name] = grid
		--grid = pipGrids[config.name]
		pipWindowses[config.parent].child[config.name] = pipGrids[config.name]
		
		self.__index = self;
		setmetatable( grid, self );
		return grid;
	else
		error ( 'Failed creating list! Missed some arguments.' )
	end
end

function pipList:drawSelf()
	local basex, basey = pipWindowses[self.parent].x+self.x, pipWindowses[self.parent].y+self.y
	local selected = nil
	for num = 1, self.maxlines do
		if not self.LinesList[num+self.offset] then break end
		local line = self.LinesList[num+self.offset]
		local size = 1
		while size > 0.3 and dxGetTextWidth ( line.label, size, font ) > self.width-6 do
			size = size-0.05
		end
		dxDrawText ( line.label, basex+3, basey+(num-1)*self.line_size, basex+self.width-3, basey+num*self.line_size, tocolor ( 255, 182, 66 ), size, font, "center", "center", true )
		if isCursorInPosition ( basex, basey+(num-1)*self.line_size, self.width, self.line_size ) then
			selected = num+self.offset
			dxDrawRectangle ( basex, basey+(num-1)*self.line_size, self.width, self.line_size, tocolor ( 255, 182, 66, 30 ) )
			if num ~= 1 then
				dxDrawLine ( basex, basey+(num-1)*self.line_size, basex+self.width, basey+(num-1)*self.line_size, tocolor ( 255, 182, 66 ), 1.5 )
			end
			if num ~= self.maxlines then
				dxDrawLine ( basex, basey+num*self.line_size, basex+self.width, basey+num*self.line_size, tocolor ( 255, 182, 66 ), 1.5 )
			end
		end
	end
	self.selectedRow = selected
	dxDrawLine ( basex, basey+self.height, basex+self.width, basey+self.height, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( basex, basey, basex+self.width, basey, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( basex, basey, basex, basey+self.height, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( basex+self.width, basey, basex+self.width, basey+self.height, tocolor ( 255, 182, 66 ), 1.5 )
end

function pipList:destroyMe()
	pipWindowses[self.parent].child[self.name] = nil
	imageButtons[self.name] = nil
	return true
end

function pipList:setVisible()
	self.visible = not self.visible
	return true
end
	

function pipList:addItem(config)
	if config.label then
		local line = {}
		line.label = config.label
		table.insert(self.LinesList,line)
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