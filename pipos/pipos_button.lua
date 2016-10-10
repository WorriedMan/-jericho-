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
		button.abs_x = pipWindowses[config.parent].x+button.x
		button.abs_y = pipWindowses[config.parent].y+button.y
		button.showBack = config.showBack
		button.drawLines = not config.notDrawLines
		function button:destroyMe()
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
			if button.drawLines then
				dxDrawLine ( basex+button.x, basey+button.y,  basex+button.x+button.width, basey+button.y, tocolor ( button.r, button.g, button.b ), 2 )
				dxDrawLine ( basex+button.x, basey+button.y,  basex+button.x, basey+button.y+button.height, tocolor ( button.r, button.g, button.b ), 2 )	
				dxDrawLine ( basex+button.x, basey+button.y+button.height,  basex+button.x+button.width, basey+button.y+button.height, tocolor ( button.r, button.g, button.b ), 2 )			
				dxDrawLine ( basex+button.x+button.width, basey+button.y,  basex+button.x+button.width, basey+button.y+button.height, tocolor ( button.r, button.g, button.b ), 2 )	
				dxDrawRectangle ( basex+button.x, basey+button.y, button.width, button.height, tocolor ( 255, 182, 66, 30 ) )
			end
			if button.showBack then
				if isCursorInPosition ( basex+button.x, basey+button.y, button.width, button.height ) then
					selectedButton = button
					if button.state == 3 then
						dxDrawRectangle ( basex+button.x, basey+button.y, button.width, button.height, tocolor ( 255, 182, 66, 70 ) )
					else
						dxDrawRectangle ( basex+button.x, basey+button.y, button.width, button.height, tocolor ( 255, 182, 66, 30 ) )
					end
				else
					if button.state == 3 then
						button.state = 1
					end
					if selectedButton == button then
						selectedButton = nil
					end
				end
			end
			dxDrawText ( button.text, basex+button.x+3, basey+button.y+3, basex+button.x+button.width-3, basey+button.y+button.height-3, tocolor ( button.r, button.g, button.b ), button.font, button.font_n, button.alignX, button.alignY )
		end
		
		imageButtons[config.name] = button
		pipWindowses[config.parent].child[config.name] = button
		return button
	else
		error ( 'Failed creating button! Missed some arguments.' )
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

function destroyPipButtonByName (name)
	if imageButtons[name] then
		if selectedButton == imageButtons[name] then
			selectedButton = nil
		end
		imageButtons[name]:destroyMe()
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
		if selectedButton == imageButtons[name] then
			selectedButton = nil
		end
		return true
	else
		return false
	end
end

function getSelectedButton ()
	return selectedButton
end