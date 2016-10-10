pipWindowses = {}
showCursor ( true )

font = dxCreateFont ( "font.ttf", 12 )

function renderPipWindowses ( )
	for i, v in pairs ( pipWindowses ) do
		dxDrawRectangle ( v.x, v.y, v.width, v.height, tocolor ( 0, 10, 0, v.alpha ) )
		
		dxDrawLine ( v.x+5, v.y+5, v.x+50, v.y+5, tocolor ( 255, 182, 66 ), 2 )
		dxDrawLine ( v.x+5, v.y+5, v.x+5, v.y+50, tocolor ( 255, 182, 66 ), 2 )
		
		dxDrawLine ( v.x+v.width-5, v.y+5, v.x+v.width-50, v.y+5, tocolor ( 255, 182, 66 ), 2 )
		dxDrawLine ( v.x+v.width-5, v.y+5, v.x+v.width-5, v.y+50, tocolor ( 255, 182, 66 ), 2 )
		
		dxDrawLine ( v.x+5, v.y+v.height-5, v.x+50, v.y+v.height-5, tocolor ( 255, 182, 66 ), 2 )
		dxDrawLine ( v.x+5, v.y+v.height-5, v.x+5, v.y+v.height-50, tocolor ( 255, 182, 66 ), 2 )
		
		dxDrawLine ( v.x+v.width-5, v.y+v.height-5, v.x+v.width-50, v.y+v.height-5, tocolor ( 255, 182, 66 ), 2 )
		dxDrawLine ( v.x+v.width-5, v.y+v.height-5, v.x+v.width-5, v.y+v.height-50, tocolor ( 255, 182, 66 ), 2 )
		
		for i, child in pairs (v.child) do
			child:drawSelf()
		end		
	end
end

function createPipWindow ( config )
	if config.name and config.x and config.y and config.width and config.height and config.alpha then
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
		window.alpha = config.alpha
		window.visible = true
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