pipLabels = {}

function createPipLabel ( config )
	if config.name and config.x and config.y and config.width and config.height and config.itext and config.parent then
		if not pipWindowses[config.parent] then
			error ( 'Window with name \"'..config.parent..'\" does not exist!' )
			return false
		end
		if pipWindowses[config.parent].child[config.name] then
			error ( 'Label with name \"'..config.name..'\" was already created.' )
			return false
		end
		local button = {}
		label.name = config.name
		label.x = config.x
		label.y = config.y
		label.width = config.width
		label.height = config.height
		label.text = config.itext
		label.alignX = config.alignX or "left"
		label.alignY = config.alignY or "top"
		label.state = 1
		label.font = config.fontSize or 1.0
		label.font_n = config.fontName or font or "default"
		label.r = config.r or 255
		label.g = config.g or 182
		label.b = config.b or 66
		label.visible = true
		label.abs_x = pipWindowses[config.parent].x+label.x
		label.abs_y = pipWindowses[config.parent].y+label.y
		label.showBack = config.showBack
		label.draw = config.draw
		function button:destroyMe()
			pipWindowses[config.parent].child[config.name] = nil
			pipLabels[config.name] = nil
			return true
		end
		function button:setVisible()
			label.visible = not label.visible
			return true
		end
		
		function button:drawSelf()
			local basex, basey = pipWindowses[config.parent].x, pipWindowses[config.parent].y
			if label.draw then
				dxDrawLine ( basex+label.x, basey+label.y,  basex+label.x+label.width, basey+label.y, tocolor ( label.r, label.g, label.b ), 2 )
				dxDrawLine ( basex+label.x, basey+label.y,  basex+label.x, basey+label.y+label.height, tocolor ( label.r, label.g, label.b ), 2 )	
				dxDrawLine ( basex+label.x, basey+label.y+label.height,  basex+label.x+label.width, basey+label.y+label.height, tocolor ( label.r, label.g, label.b ), 2 )			
				dxDrawLine ( basex+label.x+label.width, basey+label.y,  basex+label.x+label.width, basey+label.y+label.height, tocolor ( label.r, label.g, label.b ), 2 )	
				dxDrawRectangle ( basex+label.x, basey+label.y, label.width, label.height, tocolor ( 255, 182, 66, 30 ) )
			end
			dxDrawText ( label.text, basex+label.x+3, basey+label.y+3, basex+label.x+label.width-3, basey+label.y+label.height-3, tocolor ( label.r, label.g, label.b ), label.font, label.font_n, label.alignX, label.alignY )
		end
		
		pipLabels[config.name] = button
		pipWindowses[config.parent].child[config.name] = button
		return button
	else
		error ( 'Failed creating button! Missed some arguments.' )
	end
end

function destroyPipLabelByName (name)
	if pipLabels[name] then
		pipLabels[name] = nil
		return true
	else
		return false
	end
end

function getPipLabelByName (name)
	if pipLabels[name] then
		return pipLabels[name]
	else
		return false
	end
end

function setPipLabelVisible (name,state)
	if pipLabels[name] then
		pipLabels[name].visible = state
		return true
	else
		return false
	end
end