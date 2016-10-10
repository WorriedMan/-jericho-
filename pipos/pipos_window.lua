pipWindowses = {}
--showCursor ( true )

font = dxCreateFont ( "font.ttf", 12 )

function renderPipWindowses ( )
	for i, v in pairs ( pipWindowses ) do
		if not v.not_render then
			dxDrawRectangle ( v.x, v.y, v.width, v.height, tocolor ( 0, 10, 0, v.alpha ) )
			
			dxDrawLine ( v.x+5, v.y+5, v.x+50, v.y+5, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( v.x+5, v.y+5, v.x+5, v.y+50, tocolor ( 255, 182, 66 ), 2 )
			
			dxDrawLine ( v.x+v.width-5, v.y+5, v.x+v.width-50, v.y+5, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( v.x+v.width-5, v.y+5, v.x+v.width-5, v.y+50, tocolor ( 255, 182, 66 ), 2 )
			
			dxDrawLine ( v.x+5, v.y+v.height-5, v.x+50, v.y+v.height-5, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( v.x+5, v.y+v.height-5, v.x+5, v.y+v.height-50, tocolor ( 255, 182, 66 ), 2 )
			
			dxDrawLine ( v.x+v.width-5, v.y+v.height-5, v.x+v.width-50, v.y+v.height-5, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( v.x+v.width-5, v.y+v.height-5, v.x+v.width-5, v.y+v.height-50, tocolor ( 255, 182, 66 ), 2 )
		end
		for i, child in pairs (v.child) do
			child:drawSelf()
		end		
	end
end
addEventHandler ( "onClientRender", root, renderPipWindowses )

function createPipWindow ( config )
	--pipWindowses = {} -- убрать
	if config.name and config.x and config.y and config.width and config.height  then
		if pipWindowses[config.name] then
			error ( 'Pip window with name \"'..config.name..'\" was already created.' )
			return false
		end
		local window = {}
		window.name = config.name
		window.x = config.x
		window.y = config.y
		window.width = config.width
		window.height = config.height
		window.alpha = config.alpha or 150
		window.visible = true
		window.not_render = config.not_render
		window.child = {}
		function window:destroyMe()
			for i, v in pairs (window.child) do
				v:destroyMe()
			end
			pipWindowses[config.name] = nil
			return true
		end
		function window:setVisible()
			window.visible = not window.visible
			return true
		end
		pipWindowses[config.name] = window
		return window
	else
		error ( 'Failed creating window! Missed some arguments.' )
	end
end

function destroyPipWindow(name)
	if pipWindowses[name] then
		pipWindowses[name]:destroyMe()
	end
	return false
end

function isCursorInPosition ( x, y, w, h )
	if not isCursorShowing () then return false end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	if ( cx > x and cx < x + w ) and ( cy > y and cy < y + h ) then
		return true  
	else
		return false
	end
end

function setItemVisible(name,state)
	if pipGrids[name] then
		pipGrids[name]:setVisible(state)
		outputDebugString('set '..name..' visible '..tostring(state))
		return true
	end
	return false
end

function playerClickedCheckPip ( button, state, cx, cy )
	if state ~= 'down' then
		if selectedButton then
			selectedButton.state = 1
			triggerEvent("pipos:buttonClicked",root,selectedButton)
		end
		return
	end
	for i, list in pairs ( pipGrids ) do
		if list.visible then
			if isCursorInPosition ( list.abs_x, list.abs_y, list.width, list.height ) then
				triggerEvent("pipos:listClicked",root,i,list,list.selectedRow)
				--outputDebugString("pip list "..tostring(i).." clicked: "..tostring(list.selectedRow))
			end
		end
	end
	-- for i, button in pairs ( imageButtons ) do
		-- if button.visible then
			-- if isCursorInPosition ( button.abs_x, button.abs_y, button.width, button.height ) then
				-- triggerEvent("pipos:buttonClicked",root,i,button)
			-- end
		-- end
	-- end
end
addEventHandler ( 'onClientClick', root, playerClickedCheckPip )

--createPipWindow ( {x = 200, y = 200, width = 300, height = 400, alpha = 150, name = "test" } )
--local testList = pipList:createPipList ( {x=10,y=10,width = 200,height = 300,name = "testgrid",parent="test"} )
--testList:addItem({parent="testgrid",label="Магазин для АК-47 (покупка) 14 кцуфееуф"})
--testList:addItem({parent="testgrid",label="Магазин для АК-47 (покупка) 13 кцуфееуф"})
--showCursor(true)