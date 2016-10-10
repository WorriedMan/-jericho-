imageButtons = {}
selectedButton = false

function createPipButton ( config )
	if config.name and config.x and config.y and config.width and config.height and config.itext and config.parent then
		if not pipWindowses[config.parent] then
			error ( 'Window with name \"'..config.parent..'\" does not exist!' )
			return false
		end
		if pipWindowses[config.parent].child[config.name] then
			error ( 'Button with name \"'..config.name..'\" was already created.' )
			return false
		end
		local button = {}
		button.name = config.name
		button.x = config.x
		button.y = config.y
		button.width = config.width
		button.height = config.height
		button.text = config.itext
		button.alignX = config.alignX or "left"
		button.alignY = config.alignY or "top"
		button.state = 1
		button.font = config.fontSize or 1.0
		button.font_n = config.fontName or font or "default"
		button.r = config.r or 255
		button.g = config.g or 182
		button.b = config.b or 66
		button.visible = true
		button.showBack = config.showBack
		button.label = guiCreateLabel ( pipWindowses[config.parent].x+config.x, pipWindowses[config.parent].y+config.y, config.width, config.height, '', false )
		addEventHandler ( "onClientGUIClick", button.label, buttonLabelClicked, false )
		addEventHandler( "onClientMouseEnter", button.label, buttonLabelEntered, false )
		addEventHandler( "onClientMouseLeave", button.label, buttonLabelLeaved, false )
		setElementData ( button.label, 'pipButton', true )
		setElementData ( button.label, 'parent', config.parent )
		function button:destroyMe()
			destroyElement ( button.label )
			pipWindowses[config.parent].child[config.name] = nil
			imageButtons[config.name] = nil
			return true
		end
		function button:setVisible()
			button.visible = not button.visible
			return true
		end
		
		function button:drawSelf()
			local basex, basey = pipWindowses[config.parent].x, pipWindowses[config.parent].y
			
			--if button.state > 1 then
				dxDrawLine ( basex+button.x, basey+button.y,  basex+button.x+button.width, basey+button.y, tocolor ( button.r, button.g, button.b ), 2 )
				dxDrawLine ( basex+button.x, basey+button.y,  basex+button.x, basey+button.y+button.height, tocolor ( button.r, button.g, button.b ), 2 )	
				dxDrawLine ( basex+button.x, basey+button.y+button.height,  basex+button.x+button.width, basey+button.y+button.height, tocolor ( button.r, button.g, button.b ), 2 )			
				dxDrawLine ( basex+button.x+button.width, basey+button.y,  basex+button.x+button.width, basey+button.y+button.height, tocolor ( button.r, button.g, button.b ), 2 )	
				dxDrawRectangle ( basex+button.x, basey+button.y, button.width, button.height, tocolor ( 255, 182, 66, 30 ) )
				if button.showBack then
					if button.state == 2 then
						dxDrawRectangle ( basex+button.x, basey+button.y, button.width, button.height, tocolor ( 255, 182, 66, 50 ) )
					elseif button.state > 1 then
						dxDrawRectangle ( basex+button.x, basey+button.y, button.width, button.height, tocolor ( 255, 182, 66, 100 ) )
					end
				end
			--end
			dxDrawText ( button.text, basex+button.x+3, basey+button.y+3, basex+button.x+button.width-3, basey+button.y+button.height-3, tocolor ( button.r, button.g, button.b ), button.font, button.font_n, button.alignX, button.alignY )
		end
		
		setElementData ( button.label, 'elementLink', config.name )
		imageButtons[config.name] = button
		pipWindowses[config.parent].child[config.name] = button
		return button
	else
		error ( 'Failed creating button! Missed some arguments.' )
	end
end

function buttonLabelEntered ( )
	if getElementData ( source, 'pipButton' ) and getElementData ( source, 'elementLink' ) then
		local parent = getElementData ( source, "parent" )
		local buttonLink = getElementData ( source, 'elementLink' )
		if pipWindowses[parent] then
			local buttonElement = pipWindowses[parent].child[buttonLink]
			if buttonElement then
				if buttonElement.visible then
					selectedButton = buttonElement
					buttonElement.state = 2
					playSound ( "media/sound/ui_menu_focus.wav" )
				end
			end
		end
	end
end

function buttonLabelLeaved ( )
	if getElementData ( source, 'pipButton' ) and getElementData ( source, 'elementLink' ) then
		local parent = getElementData ( source, "parent" )
		local buttonLink = getElementData ( source, 'elementLink' )
		if pipWindowses[parent] then
			local buttonElement = pipWindowses[parent].child[buttonLink]
			if buttonElement then
				if buttonElement.visible then 
					selectedButton = false
					buttonElement.state = 1
				end
			end
		end
	end
end

function checkOnButton ()
	if selectedButton then
		if selectedButton.visible then
			selectedButton.state = 3
		end
	end
end

bindKey ( 'mouse1', 'down', checkOnButton )

function buttonLabelClicked ()
	if getElementData ( source, 'pipButton' ) and getElementData ( source, 'elementLink' ) then
		local parent = getElementData ( source, "parent" )
		local buttonLink = getElementData ( source, 'elementLink' )
		if pipWindowses[parent] then
			local buttonElement = pipWindowses[parent].child[buttonLink]
			if buttonElement then
				if buttonElement.visible then 
					selectedButton = buttonElement
					selectedEdit = nil
					guiSetInputMode ( "allow_binds" )
					triggerEvent ( 'pipButtonClicked', source, selectedButton )
					playSound ( "media/sound/ui_pipboy_mode.wav" )
					buttonElement.state = 1
					local parent = getElementData ( source, "parent")
					--pipWindowses[parent]:destroyMe()
				end
			end
		end
	end
end

function destroyPipButtonByName (name)
	if imageButtons[name] then
		imageButtons[name] = nil
		return true
	else
		return false
	end
end

function getPipButtonByName (name)
	if imageButtons[name] then
		return imageButtons[name]
	else
		return false
	end
end

function setPipButtonVisible (name,state)
	if imageButtons[name] then
		imageButtons[name].visible = state
		return true
	else
		return false
	end
end

function getSelectedButton ()
	return selectedButton
end