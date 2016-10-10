pipEdits = {}
selectedButton = false

function createPipEdit ( config )
	if config.name and config.x and config.y and config.width and config.height and config.itext and config.parent then
		if not pipWindowses[config.parent] then
			error ( 'Window with name \"'..config.parent..'\" does not exist!' )
			return false
		end
		if pipEdits[config.name] then
			error ( 'edit with name \"'..config.name..'\" was already created.' )
			return false
		end
		local edit = {}
		edit.name = config.name
		edit.x = config.x
		edit.y = config.y
		edit.width = config.width
		edit.height = config.height
		edit.text = config.itext
		edit.state = 1
		if not font then config.fontSize = 1.5 end
		edit.font = config.fontSize or 1
		edit.font_n = config.fontName or font or "default"
		edit.r = config.r or 255
		edit.showInitial = true
		edit.resetInitial = config.resetInitial
		edit.g = config.g or 182
		edit.b = config.b or 66
		edit.visible = true
		edit.masked = config.masked
		if edit.masked then
			edit.lastWordShow = getTickCount()
		end
		edit.max = config.max or 10
		edit.tick_time = getTickCount()
		edit.tick = false
		edit.label = guiCreateLabel ( pipWindowses[config.parent].x+config.x, pipWindowses[config.parent].y+config.y, config.width, config.height, '', false )
		addEventHandler ( "onClientGUIClick", edit.label, editLabelClicked, false )
		addEventHandler( "onClientMouseEnter", edit.label, editLabelEntered, false )
		addEventHandler( "onClientMouseLeave", edit.label, editLabelLeaved, false )
		setElementData ( edit.label, 'pipEdit', true )
		setElementData ( edit.label, 'parent', config.parent )
		function edit:destroyMe()
			destroyElement ( edit.label )
			pipWindowses[config.parent].child[config.name] = nil
			pipEdits[config.name] = nil
			return true
		end
		function edit:setVisible()
			edit.visible = not edit.visible
			return true
		end
		
		function edit:drawSelf()
			local basex, basey = pipWindowses[config.parent].x, pipWindowses[config.parent].y
			if edit.tick_time+500 < getTickCount() then
				edit.tick = not edit.tick
				edit.tick_time = getTickCount()
			end
			dxDrawLine ( basex+edit.x, basey+edit.y+edit.height/2,  basex+edit.x, basey+edit.y+edit.height, tocolor ( edit.r, edit.g, edit.b ), 2 )	
			dxDrawLine ( basex+edit.x, basey+edit.y+edit.height,  basex+edit.x+edit.width, basey+edit.y+edit.height, tocolor ( edit.r, edit.g, edit.b ), 2 )			
			dxDrawLine ( basex+edit.x+edit.width, basey+edit.y+edit.height/2,  basex+edit.x+edit.width, basey+edit.y+edit.height, tocolor ( edit.r, edit.g, edit.b ), 2 )	
			if edit.state == 2 then
				dxDrawRectangle ( basex+edit.x, basey+edit.y, edit.width, edit.height, tocolor ( 255, 182, 66, 100 ) )
			end
			local low = ""
			if selectedEdit and selectedEdit.name == config.name and not edit.showInitial then
				if edit.tick then
					low = "_"
				end
			end
			if edit.masked and not edit.showInitial then
				local drawWords = string.len(edit.text)
				local lastWord = ""
				local textString = ""
				if edit.lastWordShow + 800 > getTickCount() then
					lastWord = string.sub(edit.text,drawWords)
					drawWords = drawWords-1
				end
				for i = 1, drawWords do
					textString = textString.."*"
				end
				textString = textString..lastWord..low
				dxDrawText ( textString, basex+edit.x+3, basey+edit.y+3, basex+edit.x+edit.width-3, basey+edit.y+edit.height-3, tocolor ( edit.r, edit.g, edit.b ), edit.font, edit.font_n, "left", "center" )
			else
				dxDrawText ( edit.text..low, basex+edit.x+3, basey+edit.y+3, basex+edit.x+edit.width-3, basey+edit.y+edit.height-3, tocolor ( edit.r, edit.g, edit.b ), edit.font, edit.font_n, "left", "center" )
			end
		end
		
		setElementData ( edit.label, 'elementLink', config.name )
		pipEdits[config.name] = edit
		pipWindowses[config.parent].child[config.name] = edit
		return edit
	else
		error ( 'Failed creating button! Missed some arguments.' )
	end
end

function editLabelEntered ( )
	if getElementData ( source, 'pipEdit' ) and getElementData ( source, 'elementLink' ) then
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

function editLabelLeaved ( )
	if getElementData ( source, 'pipEdit' ) and getElementData ( source, 'elementLink' ) then
		local parent = getElementData ( source, "parent" )
		local buttonLink = getElementData ( source, 'elementLink' )
		if pipWindowses[parent] then
			local buttonElement = pipWindowses[parent].child[buttonLink]
			if buttonElement then
				if buttonElement.visible then 
					--selectedEdit = false
					buttonElement.state = 1
				end
			end
		end
	end
end

function editLabelClicked ()
	if getElementData ( source, 'pipEdit' ) and getElementData ( source, 'elementLink' ) then
		local buttonLink = getElementData ( source, 'elementLink' )
		local parent = getElementData ( source, "parent" )
		if pipWindowses[parent] then
			local buttonElement = pipWindowses[parent].child[buttonLink]
			if buttonElement then
				if buttonElement.visible then 
					selectedEdit = buttonElement
					triggerEvent ( 'pipEditClicked', source, selectedEdit )
					playSound ( "media/sound/ui_pipboy_mode.wav" )
					if selectedEdit.showInitial then 
						if selectedEdit.resetInitial then
							selectedEdit.text = "" 
						end
						selectedEdit.showInitial = false
					end
					-- if buttonElement.imageClick then
						-- if buttonElement.imageOn then
							-- buttonElement.state = 2
						-- else
						guiSetInputMode ( "no_binds" )
							buttonElement.state = 1
						-- end
					-- end
				end
			end
		end
	end
end

function getPipEditText (name)
	for i, v in ipairs ( pipWindowses ) do
		if v.child[name] then
			return v.child[name].text
		end
	end
	return false
end

function getSelectedEdit ()
	return selectedEdit
end

allowedCharacters = {
	["q"] = true,
	["w"] = true,
	["e"] = true,
	["r"] = true,
	["t"] = true,
	["y"] = true,
	["u"] = true,
	["i"] = true,
	["o"] = true,
	["p"] = true,
	["["] = true,
	["]"] = true,
	["|"] = true,
	["/"] = true,
	["a"] = true,
	["s"] = true,
	["d"] = true,
	["f"] = true,
	["g"] = true,
	["h"] = true,
	["j"] = true,
	["k"] = true,
	["l"] = true,
	[";"] = true,
	["'"] = true,
	[":"] = true,
	['"'] = true,
	["z"] = true,
	["x"] = true,
	["c"] = true,
	["v"] = true,
	["b"] = true,
	["n"] = true,
	["m"] = true,
	[","] = true,
	["."] = true,
	["<"] = true,
	[">"] = true,
	["?"] = true,
	["1"] = true,
	["2"] = true,
	["3"] = true,
	["4"] = true,
	["5"] = true,
	["6"] = true,
	["7"] = true,
	["8"] = true,
	["9"] = true,
	["0"] = true,
	["-"] = true,
	["="] = true,
	["_"] = true,
	["+"] = true,
	["*"] = true,
	["#"] = true,
	["~"] = true,
	["@"] = true,
	["$"] = true,
	["%"] = true,
	["^"] = true,
	["&"] = true,
	["*"] = true,
	["("] = true,
	[")"] = true,
}

additButtons = {
	["1"] = "!",
	["2"] = "@",
	["3"] = "#",
	["4"] = "$",
	["5"] = "%",
	["6"] = "^",
	["7"] = "&",
	["8"] = "*",
	["9"] = "(",
	["0"] = ")",
	["-"] = "_",
	["="] = "+",
}

function playerPressedKey(button, press)
    if press and selectedEdit then
		if button == "backspace" then
			playSound ( "charenter.wav" )
			if selectedEdit.text ~= "" then
				selectedEdit.text = string.sub(selectedEdit.text,1,string.len(selectedEdit.text)-1)
			end
		elseif button == "mouse1" then
			selectedEdit = nil
			guiSetInputMode ( "allow_binds" )
		elseif allowedCharacters[button] and string.len(selectedEdit.text) < selectedEdit.max then
			playSound ( "charenter.wav" )
			if getKeyState ( "lshift" ) or getKeyState ( "rshift" ) then
				if additButtons[button] then
					button = additButtons[button]
				else
					button = string.upper(button)
				end
			end
			selectedEdit.text = selectedEdit.text..button
			if selectedEdit.masked then
				selectedEdit.lastWordShow = getTickCount()
			end
		end
    end
end
addEventHandler("onClientKey", root, playerPressedKey)