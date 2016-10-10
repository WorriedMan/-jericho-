imageButtons = {}
selectedButton = false

function renderImageButtons ()
	for i, button in pairs ( imageButtons ) do
		if button.x and button.y and button.width and button.height and button.visible then
			--if not button.stateImages[button.state] then 
			--	button:destroyMe()
			--else
				dxDrawText ( button.text, button.x+3, button.y+3, button.width, button.height, tocolor ( button.r, button.g, button.b ), button.font, button.font_n )
				if button.state > 1 then
					dxDrawLine ( button.x, button.y,  button.x+button.width, button.y, tocolor ( button.r, button.g, button.b ), 2 )
					dxDrawLine ( button.x, button.y,  button.x, button.y+button.height, tocolor ( button.r, button.g, button.b ), 2 )	
					dxDrawLine ( button.x, button.y+button.height,  button.x+button.width, button.y+button.height, tocolor ( button.r, button.g, button.b ), 2 )			
					dxDrawLine ( button.x+button.width, button.y,  button.x+button.width, button.y+button.height, tocolor ( button.r, button.g, button.b ), 2 )	
				end
			--end
		end
	end
end

function createPipButton ( name, posX, posY, sizeX, sizeY, itext, sizeF, rc, gc, bc, fontN )
	if posX and posY and sizeX and sizeY and itext then
		if imageButtons[name] then
			error ( 'Button with name \"'..name..'\" was already created.' )
			return false
		end
		local button = {}
		button.name = name
		button.x = posX
		button.y = posY
		button.width = sizeX
		button.height = sizeY
		button.text = itext
		button.state = 1
		button.font = sizeF or 1.5
		button.font_n = fontN or "default"
		button.r = rc or 255
		button.g = gc or 182
		button.b = bc or 66
		button.visible = true
		button.label = guiCreateLabel ( posX, posY, sizeX, sizeY, '', false )
		addEventHandler ( "onClientGUIClick", button.label, buttonLabelClicked, false )
		addEventHandler( "onClientMouseEnter", button.label, buttonLabelEntered, false )
		addEventHandler( "onClientMouseLeave", button.label, buttonLabelLeaved, false )
		setElementData ( button.label, 'pipButton', true )
		function button:destroyMe()
			destroyElement ( button.label )
			imageButtons[name] = nil
			return true
		end
		function button:setVisible()
			button.visible = not button.visible
			return true
		end
		setElementData ( button.label, 'elementLink', name )
		imageButtons[name] = button
		return button
	else
		error ( 'Failed creating button! Missed some arguments.' )
	end
end

function buttonLabelEntered ( )
	if getElementData ( source, 'pipButton' ) and getElementData ( source, 'elementLink' ) then
		local buttonLink = getElementData ( source, 'elementLink' )
		local buttonElement = imageButtons[buttonLink]
		if buttonElement then
			if buttonElement.visible then
				selectedButton = buttonElement
				buttonElement.state = 2
				playSound ( "media/sound/ui_menu_focus.wav" )
			end
		end
	end
end

function buttonLabelLeaved ( )
	if getElementData ( source, 'pipButton' ) and getElementData ( source, 'elementLink' ) then
		local buttonLink = getElementData ( source, 'elementLink' )
		local buttonElement = imageButtons[buttonLink]
		if buttonElement then
			if buttonElement.visible then 
				selectedButton = false
				buttonElement.state = 1
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
		local buttonLink = getElementData ( source, 'elementLink' )
		local buttonElement = imageButtons[buttonLink]
		if buttonElement then
			if buttonElement.visible then 
				selectedButton = buttonElement
				triggerEvent ( 'pipButtonClicked', source, selectedButton )
				playSound ( "media/sound/ui_pipboy_mode.wav" )
				-- if buttonElement.imageClick then
					-- if buttonElement.imageOn then
						-- buttonElement.state = 2
					-- else
						buttonElement.state = 1
					-- end
				-- end
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