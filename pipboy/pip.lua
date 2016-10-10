screenWidth,screenHeight = guiGetScreenSize()
local pipShowed = false
local color = tocolor ( 255, 182, 66 )

myFont = dxCreateFont( "media/14046.ttf", 15 )

local mTable = {}

xPip = screenWidth/2-320
yPip = screenHeight/2-240
--local mapX, mapY = xPip+440, yPip+220
local mapX, mapY = xPip+255, yPip+50
local boyView = false
local showAvailable = true
showStats = false
showInventory = false
showMap = false
showQuest = false
local lastViewed = 1
local pipSound

local rTime = getRealTime()
local ghoulKilled = 0
local level = 1
local radi = 0
local nfc = 0
alarm = true
local radioCh = nil
selMapIcon = nil
mapIconSelStage = false
invsel = false
radiosel = false
showInv = false
additIcons = {}
selectedType = 1
local createdIcons = 0

local groupIcons = {}

function checkMainTexture ()
	if not texture then
		texture = dxCreateTexture ( ':players/inter.dds', "argb", false )
		setTimer ( checkMainTexture, 30000, 1 )
	end
end

checkMainTexture ()

map_iconsLinks = {
	'settlement',
	'encamp',
	'undiscovered',
	'military',
}

function pipBoyMenus ()
	if boyView == false then
		if showAvailable then
			pipSound = playSound ( "media/pip_use.wav", true )
			executeCommandHandler ( "showhude", "1" )
			boyView = true
			showAvailable = false
			setTimer ( function () showAvailable = true end, 2000, 1 )
			alarmBut = guiCreateLabel(xPip+124, yPip+13, 28, 24, "", false)			
			but1 = guiCreateLabel(xPip+60, yPip+340, 81, 21, "", false)
			but2 = guiCreateLabel(xPip+60, yPip+390, 81, 21, "", false)
			but3 = guiCreateLabel(xPip+60, yPip+420, 96, 18, "", false)
			but4 = guiCreateLabel(xPip+60, yPip+445, 96, 18, "", false)
			showCursor ( true )
			addEventHandler ( "onClientGUIClick", alarmBut, playRadioNV, false ) -- радио
			addEventHandler ( "onClientGUIClick", but1, pipShowStats, false ) -- статус
			addEventHandler ( "onClientGUIClick", but2, pipShowMap, false ) -- карты
			addEventHandler ( "onClientGUIClick", but3, pipShowQuests, false ) -- архив
			addEventHandler ( "onClientGUIClick", but4, pipClose, false ) -- закрыть
			addEventHandler ( "onClientHUDRender", root, renderPipBoy )
			addEventHandler ( "onClientRender", root, drawPipShadows )
			if lastViewed == 1 then
				pipShowStats ()
			elseif lastViewed == 2 then
				pipShowMap ()
			elseif lastViewed == 4 then
				pipShowInventory ()
			else
				pipShowQuests ()
			end
		end
	else
		stopSound ( pipSound )
		boyView = false
		removeEventHandler ( "onClientHUDRender", root, renderPipBoy )
		removeEventHandler ( "onClientRender", root, drawPipShadows )
		showCursor ( false )
		pipUnShowAll ()
		executeCommandHandler ( "showhude", "0" )
	end
end

function createPipBoyInv ()
	if showAvailable and not getElementData ( localPlayer, "norLiveKilled" ) then
		local pipState = boyView
		pipBoyMenus ()
		if not pipState then
			pipShowInventory ()
		end
	end
end

function closePipBoy ()
	boyView = false
	if isElement(pipSound) then
		stopSound ( pipSound )
	end
	removeEventHandler ( "onClientHUDRender", root, renderPipBoy )
	removeEventHandler ( "onClientRender", root, drawPipShadows )
	showCursor ( false )
	pipUnShowAll ()
	executeCommandHandler ( "showhude", "0" )
end

function playRadioNV ()
	playSound ( "media/sound/ui_pipboy_mode.wav" )
	if alarm then
		addInfoBox ( 'Радио включается, подождите', 2 )
		-- if currentlyPlaying > 0 then
			-- radioCh = playSound ( radioChannels[id] )
		-- else
			-- radioCh = playSound ( "http://je-ho.ru:8000/play.m3u" )
		-- end
		-- setSoundVolume ( radioCh, soundVolume )
		-- setElementData ( localPlayer, "radioNV", true )
		alarm = false
		-- startRadio(currentlyPlaying)
	else
		alarm = true
		-- stopSound ( radioCh )
		-- setElementData ( localPlayer, "radioNV", false )
	end
	startRadio(currentlyPlaying)
end

function turnOffRadio()
	playSound ( "media/sound/ui_pipboy_mode.wav" )
	alarm = true
	if isElement(radioCh) then
		stopSound ( radioCh )
	end
	setElementData ( localPlayer, "radioNV", false )
end

function pipClose ()
	boyView = false
	stopSound ( pipSound )
	removeEventHandler ( "onClientHUDRender", root, renderPipBoy )
	removeEventHandler ( "onClientRender", root, drawPipShadows )
	showCursor ( false )
	playSound ( "media/sound/ui_pipboy_mode.wav" ) 
	pipUnShowAll ()
	executeCommandHandler ( "showhude", "0" )
end

function infoButtonClicked (button)
	if button.name == 'inv' then
		pipShowInventory ()
	elseif button.name == 'radio' then
		pipShowRadio()
	elseif button.name == 'person' then
		pipShowFullStats()
	end
end

addEvent ( "pipButtonClicked", true )
addEventHandler ( 'pipButtonClicked', root, infoButtonClicked)


function pipShowStats ()
	if showStats == false then
		pipUnShowAll ()
		showStats = true
		createPipButton ( "radio", xPip+500, yPip+365, 70, 30, "РАДИО", 1.5, 255, 182, 66, "default" )
		createPipButton ( "inv", xPip+300, yPip+365, 115, 30, "ИНВЕНТАРЬ", 1.5, 255, 182, 66, "default" )
		createPipButton ( "person", xPip+300, yPip+395, 115, 30, "ПЕРСОНАЖ", 1.5, 255, 182, 66, "default" )
		--invLabel = guiCreateLabel ( xPip+300, yPip+365, 105, 25, "", false ) -- проверка в inventory.lua
		--radioLabel = guiCreateLabel ( xPip+500, yPip+365, 105, 25, "", false )
		--addEventHandler ( "onClientGUIClick", invLabel, pipShowInventory, false )
		--addEventHandler ( "onClientGUIClick", radioLabel, pipShowRadio, false )
		playSound ( "media/sound/ui_pipboy_mode.wav" )
	end
end

local myBlipCreated = false

function pipShowMap ()
	if showMap == false then
		pipUnShowAll ()
		showMap = true
		selMapIcon = nil
		creatingMapBlip = false
		playSound ( "media/sound/ui_pipboy_mode.wav" )
		if getElementData(localPlayer,"gang") then
			pipWindow = exports.pipos:createPipWindow ( {x = xPip+255, y = yPip+400, width = 350, height = 50, name = "mapWindow", not_render = true } )
			if myBlipCreated then
				exports.pipos:createPipButton ( {x=10,y=10,width = 190,height = 30,name = "deleteGroupBlip",parent="mapWindow",itext="Удалить маркер группы",showBack = true} )
			else
				exports.pipos:createPipButton ( {x=10,y=10,width = 190,height = 30,name = "createGroupBlip",parent="mapWindow",itext="Добавить маркер группы",showBack = true} )
			end
			addEventHandler ( 'pipos:buttonClicked', root, mapBlipCreateClicked)
		end
	end
end
addEvent ( "pipos:buttonClicked", true )

function mapBlipCreateClicked(button) 
	if button.name == "createGroupBlip" then
		if not creatingMapBlip then
			creatingMapBlip = true
			addEventHandler ( 'onClientClick', root, createMapBlip )
			exports.pipos:destroyPipButtonByName ("createGroupBlip")
		end
	elseif button.name == "deleteGroupBlip" then
		triggerServerEvent("groups:removeGangIcon",localPlayer)
		exports.pipos:destroyPipButtonByName ("deleteGroupBlip")
		exports.pipos:createPipButton ( {x=10,y=10,width = 190,height = 30,name = "createGroupBlip",parent="mapWindow",itext="Добавить маркер группы",showBack = true} )
		myBlipCreated = false
	end
end

function createMapBlip(button, state, cx, cy)
	if button == "left" then
		if isCursorInPosition(xPip+255, yPip+50, 350, 350) then
			removeEventHandler ( 'onClientClick', root, createMapBlip )
			triggerServerEvent("groups:pipIconAdded",localPlayer,cx,cy)
			exports.pipos:createPipButton ( {x=10,y=10,width = 190,height = 30,name = "deleteGroupBlip",parent="mapWindow",itext="Удалить маркер группы",showBack = true} )
			creatingMapBlip = false
			myBlipCreated = true
		end
	end
end

function refreshGroupIcons(icons)
	for i, v in ipairs(groupIcons) do
		deleteMapIconByText(v)
	end
	groupIcons = {}
	for i, v in pairs(icons) do
		local x,y = mapToWorldPosition(v[1],v[2])
		addMapIcon ( x, y, 0, 4, v[3] )
		table.insert(groupIcons,v[3])
	end
end

addEvent ( "pipboy:refreshGroupIcons", true )
addEventHandler ( 'pipboy:refreshGroupIcons', root, refreshGroupIcons)


function mapToWorldPosition(absoluteX,absoluteY)
	local relX = (absoluteX - mapX)/350
	local relY = (absoluteY - mapY)/350
	
	local lx = relX*6000 - 3000
	local ly = 3000 - relY*6000
	
	return lx, ly
end

-- function check(button, state, cx, cy)
	-- local x,y = mapToWorldPosition(cx,cy)
	-- outputChatBox(x.." "..y)
	-- addMapIcon ( x, y, 0, 4, getPlayerName(localPlayer) )
-- end

-- addEventHandler ( 'onClientClick', root, check )

function pipShowQuests ()
	if showQuest == false then
		pipUnShowAll ()
		showQuest = true
		createQuestPanel ()
		playSound ( "media/sound/ui_pipboy_mode.wav" )
	end
end

function pipShowRadio ()
	pipUnShowAll ()
	createRadioWindow()
end

function pipShowFullStats ()
	pipUnShowAll ()
	createFullStatsWindow()
end

function pipShowInventory ()
	if getElementData ( localPlayer, "inventoryAllowed" ) == 1 and not getElementData ( localPlayer, "norLiveKilled" ) then
		setElementData ( localPlayer, "inventoryAllowed", 0 )
		pipUnShowAll ()
		initializeInventory ()
		--playSound ( "media/sound/ui_pipboy_mode.wav" )
	end
end

function pipUnShowAll ()
	showStats = false
	destroyPipButtonByName ('inv')
	destroyPipButtonByName ('radio')
	destroyPipButtonByName ('person')
	deleteRadioButtons()
	deleteFullStatsButtons()
	hidePerksWindow()
	radioWindowShowing = false
	if showInv then
		closeInventory ()
		lastViewed = 4
		showInv = false
	end
	if showStats then
		lastViewed = 1
		destroyElement ( invLabel )
		removeEventHandler ( "onClientGUIClick", invLabel, pipShowInventory )
	end
	if showMap then
		lastViewed = 2
		showMap = false
		if creatingMapBlip then
			creatingMapBlip = false
			removeEventHandler ( 'onClientClick', root, createMapBlip )
		end
		removeEventHandler ( 'pipos:buttonClicked', root, mapBlipCreateClicked)
		exports.pipos:destroyPipWindow("mapWindow")
	end
	if showQuest then
		lastViewed = 3
		showQuest = false
		destroyQuestPanel ()
	end
end


function addMapIcon ( x, y, z, icon, text )
	x = math.floor((x + 3000) * 350 / 6000)+3
	y = math.floor((3000 - y) * 350 / 6000)+3
	createdIcons = createdIcons+1
	table.insert ( additIcons, { mapX+x, mapY+y, icon, text, x, y, z, createdLabel, createdIcons } )
	return createdIcons
end

addEvent( "addMapIconServer", true )
addEventHandler( "addMapIconServer", getRootElement(), addMapIcon )

function deleteMapIcon ( id )
	for i, icon in ipairs ( additIcons ) do
		if icon[9] == id then
			if isElement ( icon[8] ) then
				destroyElement ( icon[8] )
			end
			table.remove ( additIcons, i )
			return true
		end
	end
	return false
end

addEvent( "deleteMapIconServer", true )
addEventHandler( "deleteMapIconServer", getRootElement(), deleteMapIcon )

function deleteMapIconByText ( text )
	for i, icon in ipairs ( additIcons ) do
		if icon[4] == text then
			table.remove ( additIcons, i )
			return true
		end
	end
	return false
end

addEvent( "deleteMapIconServerText", true )
addEventHandler( "deleteMapIconServerText", getRootElement(), deleteMapIconByText )

function renderPipBoy ()
	local hours, minutes = getTime ()
	local posx, posy = getElementPosition ( localPlayer )
	local hourNum1 = math.floor ( hours/10 )
	local hourNum2 = hours%10
	local num1 = math.floor ( minutes/10 )
	local num2 = minutes%10
	local monthNum1 = math.floor ( rTime.monthday/10 )
	local monthNum2 = rTime.monthday%10
	
	dxDrawImage ( xPip, yPip, 640, 480, t.boyTex, 0, 0, 0 )
	
	if alarm == true then
		dxDrawImage ( xPip+124, yPip+13, 28, 24, "media/alarmOUT.bmp" )
	else
		dxDrawImage ( xPip+124, yPip+13, 28, 24, "media/alarmIN.bmp" )
	end
	
	-- отрисовка даты
	dxDrawImageSection ( xPip+20, yPip+16.5, 9, 17, monthNum1*9, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	dxDrawImageSection ( xPip+29, yPip+16.5, 9, 17, monthNum2*9, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	if rTime.month == 0 then
		dxDrawImageSection ( xPip+46, yPip+18, 29, 13, 0, 0, 29, 13, t.monTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	else
		dxDrawImageSection ( xPip+46, yPip+18, 29, 13, 0, rTime.month*15+1, 29, 13, t.monTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	end
	dxDrawImageSection ( xPip+83, yPip+16.5, 9, 17, 18, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	dxDrawImageSection ( xPip+92, yPip+16.5, 9, 17, 0, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	dxDrawImageSection ( xPip+101, yPip+16.5, 9, 17, 63, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	dxDrawImageSection ( xPip+110, yPip+16.5, 9, 17, 63, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	dxDrawImageSection ( xPip+155.5, yPip+16.5, 9, 17, hourNum1*9, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	dxDrawImageSection ( xPip+164.5, yPip+16.5, 9, 17, hourNum2*9, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	dxDrawImageSection ( xPip+173.5, yPip+16.5, 9, 17, num1*9, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	dxDrawImageSection ( xPip+182.5, yPip+16.5, 9, 17, num2*9, 0, 9, 17, t.timeTex, 0, 0, 0, tocolor ( 255, 255, 255, 255 ) )
	-- отрисовка даты
	renderImageButtons()
	if showInv then
		renderInventory()
	end
	if radioWindowShowing  then
		renderRadioWindow()
	end
	if fullStatsWindowShowing  then
		renderFullStatsWindow()
	end
	if perksStatsWindowShowing  then
		renderPerksWindow()
	end
	if showMap == true then
		local rotX, rotY, rotZ = getElementRotation ( localPlayer )
		-- tmpX = (posx/100)-15
		-- tmpY = posy/100
		-- local finX, finY = mapX+(posx/20)+tmpX,mapY-(posy/20)-tmpY
		
		dxDrawImage ( xPip+255, yPip+50, 350, 350, "media/servmap.png" )
		local iconFound = false
		for i = 1, #mapIcons do
			if isCursorInPosition(xPip+mapIcons[i][1], yPip+mapIcons[i][2], 40, 40) then
				selMapIcon = i
				iconFound = true
				selectedType = 2
				local textX = xPip+mapIcons[i][1]
				if i == 6 then textX = textX + 10 end
				if i == 1 then textX = textX - 60 end
				if mapIconSelStage then
					dxDrawImage ( xPip+mapIcons[i][1], yPip+mapIcons[i][2], 40, 40, mapIcons[i][4], 0, 0, 0, color )
				else
					dxDrawImage ( xPip+mapIcons[i][1], yPip+mapIcons[i][2], 40, 40, mapIcons[i][3], 0, 0, 0, color )
				end
				dxDrawText ( mapIcons[i][6], textX, yPip+mapIcons[i][2]-10, screenWidth, screenHeight, tocolor(201, 192, 187), 0.7, myFont )
			else
				if selMapIcon and selMapIcon == i and selectedType == 2 then
					selMapIcon = nil
					selectedType = nil
				end
				dxDrawImage ( xPip+mapIcons[i][1], yPip+mapIcons[i][2], 32, 32, mapIcons[i][3], 0, 0, 0, color )
			end
		end	
		for i, icon in ipairs(additIcons) do
			if isCursorInPosition(icon[1]-20, icon[2]-20, 40, 40) and not iconFound then
				selMapIcon = i
				iconFound = true
				selectedType = 1
				dxDrawImage ( icon[1]-20, icon[2]-20, 40, 40, t[map_iconsLinks[icon[3]]], 0, 0, 0, color )
				local textPosX = icon[1]-20
				if icon[1]-40 < xPip+255 then
					textPosX = textPosX+60
				end
				if icon[1]+dxGetTextWidth ( icon[4], 0.7, myFont ) > xPip+605 then
					textPosX = textPosX-60
				end
				dxDrawText ( icon[4], textPosX, icon[2]-26, screenWidth, screenHeight, tocolor(201, 192, 187), 0.7, myFont )
			else
				if selMapIcon and selMapIcon == i and selectedType == 1 then
					selMapIcon = nil
					selectedType = nil
				end
				dxDrawImage ( icon[1]-16, icon[2]-16, 32, 32, t[map_iconsLinks[icon[3]]], 0, 0, 0, color )
			end
		end	
		if selMapIcon and not iconFound then
			selMapIcon = nil
			selectedType = nil
		end
		x = math.floor((posx + 3000) * 350 / 6000) - 6
		y = math.floor((3000 - posy) * 350 / 6000) - 9
		dxDrawImageSection ( mapX+x, mapY+y, 12, 18, 324, 838, 22, 28, texture, -rotZ, 0, 0, tocolor(255,255,255) )
		if creatingMapBlip then
			dxDrawText ( "Нажмите на участок карты, на котором хотите добавить маркер.", xPip+255, yPip+400, xPip+505, yPip+450, color, 1, "default-bold", "left","top",false,true )
		end
	end
	if showStats then
		if not myFont then myFont = "default" end
		dxDrawText ( 'Радиация: '..radi..'/'..(100*level), xPip+300, yPip+40, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, myFont )
		dxDrawLine( xPip+270, yPip+70, xPip+600, yPip+70, color, 4 )
		dxDrawText ( 'Сила: '..getElementData ( localPlayer, 'strenght' ).." (+"..getElementData ( localPlayer, 'tempstrenght' )..")", xPip+380, yPip+85, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, myFont )
		dxDrawText ( 'Выносливость: '..getElementData ( localPlayer, 'breath' ).." (+"..getElementData ( localPlayer, 'tempbreath' )..")", xPip+380, yPip+125, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, myFont )
		dxDrawText ( 'Меткость: '..getElementData ( localPlayer, 'accuracy' ).." (+"..getElementData ( localPlayer, 'tempaccuracy' )..")", xPip+380, yPip+165, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, myFont )
		dxDrawText ( 'S\nT\nA\nT', xPip+320, yPip+75, screenWidth, screenHeight, color, 1.1, myFont )
		dxDrawLine( xPip+270, yPip+200, xPip+600, yPip+200, color, 4 )
		local level = getElementData (localPlayer,"rplvl") or 1
		dxDrawText ( 'Уровень: '..level, xPip+300, yPip+200, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, myFont )
		dxDrawText ( 'Опыт: '..getElementData(localPlayer,"xp")..'/'..(500*level), xPip+300, yPip+230, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, myFont )
		
		dxDrawText ( 'Здоровье: '..gettok ( tostring(getElementData ( localPlayer, 'health' )), 1, '.')..'/'..gettok ( tostring(getElementData ( localPlayer, 'maxHealth' )), 1, '.'), xPip+300, yPip+290, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, myFont )
		dxDrawText ( 'Уведомлений: '..nfc, xPip+300, yPip+330, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, myFont )
		--dxDrawText ( "ИНВЕНТАРЬ", xPip+300, yPip+365, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default" )
	--	dxDrawText ( "РАДИО", xPip+500, yPip+365, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default" )
		-- if invSel then -- проверка в inventory.lua
			-- dxDrawLine ( xPip+300, yPip+365, xPip+405, yPip+365, tocolor ( 255, 182, 66 ), 2 )
			-- dxDrawLine ( xPip+300, yPip+365, xPip+300, yPip+390, tocolor ( 255, 182, 66 ), 2 )	
			-- dxDrawLine ( xPip+300, yPip+390, xPip+405, yPip+390, tocolor ( 255, 182, 66 ), 2 )			
			-- dxDrawLine ( xPip+405, yPip+365, xPip+405, yPip+390, tocolor ( 255, 182, 66 ), 2 )	
		-- end
		-- if radioSel then
			-- dxDrawLine ( xPip+500, yPip+365, xPip+605, yPip+365, tocolor ( 255, 182, 66 ), 2 )
			-- dxDrawLine ( xPip+500, yPip+365, xPip+500, yPip+390, tocolor ( 255, 182, 66 ), 2 )	
			-- dxDrawLine ( xPip+500, yPip+390, xPip+605, yPip+390, tocolor ( 255, 182, 66 ), 2 )			
			-- dxDrawLine ( xPip+605, yPip+365, xPip+605, yPip+390, tocolor ( 255, 182, 66 ), 2 )	
		-- end
		dxDrawText ( 'RobCo Industries (c) 2074', xPip+320, yPip+430, screenWidth, screenHeight, color, 0.8, myFont )
	end
end

function drawPipShadows()
	dxDrawImage ( xPip+241, yPip+27, 385, 326, "media/shadow.png", 0, 0, 0 )
	dxDrawImage ( xPip+241, yPip+23, 387, 446, "media/shadow2.png", 0, 0, 0 )
end

function loadPlayerValues ()
	if getElementData ( localPlayer, "online" ) == 1 then
		radi = getElementData ( localPlayer, "rad" )
		level = getElementData ( localPlayer, "rplvl" )
		xp = getElementData ( localPlayer, "xp" )
		ghoulKilled = getElementData ( localPlayer, "Zombie kills" )
		bindKey ( "F2", "down", pipBoyMenus )
		--pipBoyMenus() -- убрать
		--pipShowMap()
	end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),loadPlayerValues)

function updateRadLabel ( quant )
	radi = quant
end

function updateLevelLabel ( quant )
	level = quant
end

function updateXPLabel ( quant )
	xp = quant
end

function updateGKLabel ( quant )
	ghoulKilled = quant
end


function closeWindowsKilled ( )
	closePipBoy ()
	closeBarterMenu ()
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), closeWindowsKilled )