local screenWidth,screenHeight = guiGetScreenSize()
local color = tocolor ( 255, 182, 66 )

sOff = 0
hOff = 0
glowItem = 0
glowL = false
selArrow = 0
bItemSel = 0
closeSel = false
craftShow = false

local xBart = screenWidth/2-350
local yBart = screenHeight/2-240
local bagWeight = 0
local itemDone = false -- поменять на false
local creatingItem = 0 -- поменять на 0
local itemsToCreate = 0
sInv = {}
hInv = {}

craftElements = {}

destroys = { -- основание, { } предметы, { ид, рандомно-ли, мин количество, макс количество,вероятность рандома (1 ко скольки) }
	{ 55, { 52, true, 1, 2, 5 }, { 53, true, 1, 4, 5 }, { 56, true, 1, 3, 4 }, { 60, true, 1, 2, 3 }, { 61, true, 1, 3, 4 }, { 68, true, 1, 4, 5 }, { 70, true, 1, 4, 5 }, { 71, true, 1, 3, 4 }, },
	{ 1, { 56, false, 1 } },
	{ 7, { 56, false, 1 }, { 58, true, 1, 1, 2 }, },
	{ 42, { 63, false, 1 }, { 68, false, 1 }, { 70, true, 1, 1, 2 }, { 71, true, 1, 1, 3 } },
	{ 43, { 64, false, 1 }, { 68, false, 1 }, { 70, true, 1, 1, 2 }, { 71, true, 1, 1, 3 } },
	{ 44, { 65, false, 1 }, { 68, false, 1 }, { 70, true, 1, 1, 2 }, { 71, true, 1, 1, 3 } },
	{ 45, { 64, false, 1 }, { 68, false, 1 }, { 70, true, 1, 1, 2 }, { 71, true, 1, 1, 3 } },
	{ 46, { 62, false, 1 }, { 68, false, 1 }, { 70, true, 1, 1, 2 }, { 71, true, 1, 1, 3 } },
	{ 47, { 66, false, 1 }, { 68, false, 1 }, { 70, true, 1, 1, 2 }, { 71, true, 1, 1, 3 } },
	{ 48, { 67, false, 1 }, { 68, false, 1 }, { 70, true, 1, 1, 2 }, { 71, true, 1, 1, 3 } },
	{ 89, { 92, false, 1 }, },
	
}

recipes = {
	{ 13, 1, true, { 22, 1 }, { 49, 2 } }, 
	{ 15, 1, true, { 6, 1 }, { 12, 1 }, { 17, 1 } },
	{ 4, 1, true, { 22, 1 }, { 7, 1 } }, -- чистая вода
	{ 4, 1, true, { 22, 1 }, { 58, 1 } }, -- чистая вода
	{ 42, 1, true, { 63, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, -- .50 патроны
	--{ 43, 1, true, { 64, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, -- 10 мм авто патроны
	{ 44, 1, true, { 65, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, -- .32
	{ 45, 1, true, { 64, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, -- 10 мм
	{ 46, 1, true, { 62, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, -- дробь
	{ 47, 1, true, { 66, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, -- .308
	{ 48, 1, true, { 67, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, -- 12.7
	{ 23, 1, true, { 72, 1 }, { 73, 1 } }, -- сумка
	{ 30, 1, true, { 75, 1 }, { 77, 1 }, { 80, 1 }, { 81, 1 } }, -- винтовка
	{ 24, 1, true, { 75, 1 }, { 77, 1 }, { 82, 1 }, { 83, 1 }, { 84, 1 } }, -- кит. винтовка
	{ 36, 1, true, { 75, 1 }, { 77, 1 }, { 85, 1 }, { 86, 1 }, { 87, 1 } }, -- американская винтовка
	{ 33, 1, true, { 75, 1 }, { 77, 1 }, { 79, 1 } }, -- шотган
	{ 32, 1, true, { 75, 1 }, { 76, 1 }, { 77, 1 }, { 80, 1 }, { 81, 1 } }, -- винтовка
	{ 90, 1, true, { 91, 1 }, { 92, 1 }, }, -- новые очки
	{ 94, 1, false, { 30, 6 }, { 93, 1 }, { 95, 1 }, { 61, 1 } }, -- миниган 19
	{ 96, 1, false, { 68, 90 }, { 72, 6 }, { 73, 2 }, }, -- броня 20 
	{ 111, 1, true, { 112, 1 }, { 110, 1 }, { 22, 1 }, }, -- топливо 21
	{ 111, 1, true, { 112, 1 }, { 11, 3 }, { 12, 3 },  { 13, 3 } }, -- топливо 22
	{ 6, 1, true, { 49, 1 }, { 56, 1 } }, -- винт 23
}

local needToBeKnown = { 19, 20 }

function loadedCraftTable (craftT)
	for i, v in ipairs ( craftT ) do
		recipes[v][3] = true
	end
	setElementData ( localPlayer, 'knownRecipes', craftT )
end

addEvent( "loadedCraftTable", true )
addEventHandler( "loadedCraftTable", getRootElement(), loadedCraftTable )

function addCraftRecipe ( num, id )
	if not recipes[num][3] then
		exports.pipboy:addInfoBox ('Теперь вы знаете, как собрать '..things[recipes[num][1]][2], 2 )
		exports.inventory:removePlayerItem ( 102, 1 )
		local knownRecipes = {}
		recipes[num][3] = true
		for i, v in ipairs ( needToBeKnown ) do
			if recipes[v][3] then
				table.insert ( knownRecipes, v )
			end
		end
		setElementData ( localPlayer, 'knownRecipes', knownRecipes )
	end
end


function renderCraftMenu ( )
	--local x, y = xBart+200, yBart+30
	local x, y = xBart+175, yBart+30
	local num = 1
	local total = 0
	dxDrawRectangle ( xBart, yBart, 700, 480, tocolor ( 0, 10, 0, 180 ) )
	tx, ty = xBart+30, yBart+50
	for i = 1+sOff, 7+sOff do
		if i <= #sInv then
			if sInv[i][2] <= 0 then table.remove ( sInv, i ) end
			if ty > yBart+15 then
				local itString = nil
				if sInv[i][2] > 1 then
					itString = things[sInv[i][1]][2].." ("..sInv[i][2]..")"
				else
					itString = things[sInv[i][1]][2]
				end
				dxDrawText ( itString, tx, ty, screenWidth, yBart+335, tocolor ( 255, 182, 66 ), 1.2, "default-bold", "left", "top", true )
			end
			if glowL then
				if glowItem == i then
					dxDrawRectangle ( tx-5, ty-5, 185, 30, tocolor ( 255, 182, 66, 30 ) )
					dxDrawLine ( tx-5, ty-5, tx+180, ty-5, tocolor ( 255, 182, 66 ), 1.3 )
					dxDrawLine ( tx-5, ty-5, tx-5, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
					dxDrawLine ( tx+180, ty-5, tx+180, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
					dxDrawLine ( tx-5, ty+25, tx+180, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
				end
			end
			ty = ty + 40
		end
	end
	tx, ty = xBart+430, yBart+50
	for i = 1+hOff, 7+hOff do
		if i <= #hInv then
			if ty > yBart+15 then
				local itString = nil
				if hInv[i][2] > 1 then
					itString = things[hInv[i][1]][2].." ("..hInv[i][2]..")"
				else
					itString = things[hInv[i][1]][2]
				end
				dxDrawText ( itString, xBart+430, ty, screenWidth, yBart+335, tocolor ( 255, 182, 66 ), 1.2, "default-bold", "left", "top", true )
			end
			if not glowL then
				if glowItem == i then
					dxDrawRectangle ( tx-5, ty-5, 185, 30, tocolor ( 255, 182, 66, 30 ) )
					dxDrawLine ( tx-5, ty-5, tx+180, ty-5, tocolor ( 255, 182, 66 ), 1.3 )
					dxDrawLine ( tx-5, ty-5, tx-5, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
					dxDrawLine ( tx+180, ty-5, tx+180, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
					dxDrawLine ( tx-5, ty+25, tx+180, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
				end
			end
			ty = ty +40
		end
	end
	dxDrawLine ( xBart+15, yBart+15, xBart+30, yBart+15, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawText ( 'Инвентарь', xBart+30, yBart+5, screenWidth, yBart+50, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
	dxDrawLine ( xBart+165, yBart+15, xBart+270, yBart+15, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+270, yBart+15, xBart+270, yBart+50, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+15, yBart+15, xBart+15, yBart+50, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+15, yBart+335, xBart+15, yBart+300, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+15, yBart+335, xBart+270, yBart+335, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+270, yBart+335, xBart+270, yBart+300, tocolor ( 255, 182, 66 ), 1.5 )
	
	dxDrawLine ( xBart+415, yBart+15, xBart+430, yBart+15, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawText ( 'Ингредиенты', xBart+430, yBart+5, screenWidth, yBart+50, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
	dxDrawLine ( xBart+600, yBart+15, xBart+670, yBart+15, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+670, yBart+15, xBart+670, yBart+50, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+415, yBart+15, xBart+415, yBart+50, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+415, yBart+335, xBart+415, yBart+300, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+415, yBart+335, xBart+670, yBart+335, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+670, yBart+335, xBart+670, yBart+300, tocolor ( 255, 182, 66 ), 1.5 )
	
	dxDrawLine ( xBart+15, yBart+435, xBart+15, yBart+470, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+15, yBart+470, xBart+670, yBart+470, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+670, yBart+435, xBart+670, yBart+470, tocolor ( 255, 182, 66 ), 1.5 )
	
	dxDrawText ( 'Закрыть', xBart+290, yBart+300, screenWidth, yBart+350, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
	if closeSel then
		dxDrawLine ( xBart+285, yBart+295, xBart+400, yBart+295, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+285, yBart+295, xBart+285, yBart+335, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+400, yBart+295, xBart+400, yBart+335, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+285, yBart+335, xBart+400, yBart+335, tocolor ( 255, 182, 66 ), 1.3 )
	end
	if createSel then
		dxDrawLine ( xBart+285, yBart+250, xBart+400, yBart+250, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+285, yBart+250, xBart+285, yBart+290, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+400, yBart+250, xBart+400, yBart+290, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+285, yBart+290, xBart+400, yBart+290, tocolor ( 255, 182, 66 ), 1.3 )
	end
	if compileSel then
		dxDrawLine ( xBart+285, yBart+200, xBart+400, yBart+200, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+285, yBart+200, xBart+285, yBart+240, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+400, yBart+200, xBart+400, yBart+240, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+285, yBart+240, xBart+400, yBart+240, tocolor ( 255, 182, 66 ), 1.3 )
	end
	if itemDone then
		if creatingItem > 0 then
			dxDrawText ( 'Собрать', xBart+290, yBart+200, screenWidth, yBart+350, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
			dxDrawText ( 'Отмена', xBart+290, yBart+250, screenWidth, yBart+350, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
			dxDrawLine ( xBart+630, yBart+350, xBart+500, yBart+350, tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawLine ( xBart+630, yBart+350, xBart+630, yBart+385, tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawText ( 'ВЕС', xBart+505, yBart+350, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top" )
			
			dxDrawText ( things[creatingItem][2], xBart+205, yBart+370, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.7, "default-bold", "left", "top" )
			
			dxDrawLine ( xBart+630, yBart+400, xBart+200, yBart+400, tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawLine ( xBart+630, yBart+400, xBart+630, yBart+435, tocolor ( 255, 182, 66 ), 1.5 )
			dxDrawText ( 'ЭФФ.', xBart+205, yBart+400, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top" )
			
			dxDrawText ( things[creatingItem][3], xBart+205, yBart+405, xBart+625, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default-bold", "right", "top" ) -- эффекты
			dxDrawText ( things[creatingItem][4], xBart+625, yBart+350, xBart+625, screenHeight, tocolor ( 255, 182, 66 ), 2, "default-bold", "right", "top" ) -- вес
			dxDrawImage ( xBart+50, yBart+350, 128, 128, things[creatingItem][1], 0, 0, 0, tocolor ( 255, 182, 66 ) )
		end
	else
		if #hInv > 1 then
			dxDrawText ( 'Сложить', xBart+290, yBart+250, screenWidth, yBart+350, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
		elseif #hInv == 1 then
			dxDrawText ( 'Раз-ть', xBart+290, yBart+250, screenWidth, yBart+350, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
		end
		dxDrawImage ( xBart+495, yBart+320, 128, 128, t.mrCraft, 0, 0, 0, tocolor ( 255, 182, 66 ) )
		dxDrawText ( '1. Выберите ингредиенты\n2. Нажмите \'Сложить\'\n3. В случае неудачи, вы получите хлам\n4. Нажмите \'Собрать\'', xBart+30, yBart+360, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default-bold", "left", "top" )
	end
	dxDrawText ( '\"Мистер Рукоблуд 1000\" (c)РобКО', xBart+455, yBart+450, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1, "default-bold", "left", "top" )
	drawBarterArrows ()	
end

--addEventHandler ( "onClientRender", root, renderCraftMenu )

barterA = {
	{ 220, 35 },
	{ 220, 285 },
	{ 620, 35 },
	{ 620, 285 }
}

function drawBarterArrows ()
	for i = 1, 4 do
		if ( i == 1 and sOff > 0 ) or ( i == 2 and sOff+7 < #sInv ) or ( i == 3 and hOff > 0 ) or ( i == 4 and hOff+7 < #hInv ) then
			local rot = 0
			local color = tocolor ( 255, 182, 66 )
			if i == 2 or i == 4 then rot = 180 end
			if i == selArrow then color = tocolor ( 255, 240, 66 ) end
			dxDrawImage ( xBart+barterA[i][1], yBart+barterA[i][2], 32, 32, t.arrow, rot, 0, 0, color )
		end
	end
end

function initCraft ()
	if not craftShow then
		craftShow = true
		executeCommandHandler ( "showhude", "1" )
		sInv = exports.inventory:getItemsLargeNull() -- вес, ид, количество
		hInv = {}
		ty = yBart+50
		closePipBoy()
		setElementData ( localPlayer, "inventoryAllowed", 0 )
		for i = 1, 7 do
			local createdLabel = guiCreateLabel ( xBart+10, ty-5, 180, 30, "", false )
			setElementData ( createdLabel, "craftID", i )
			setElementData ( createdLabel, "barterS", true )
			addEventHandler ( "onClientGUIClick", createdLabel, craftSelfItemClick, false )
			ty = ty+40
			table.insert ( craftElements, createdLabel )
		end
		ty = yBart+50
		for i = 1, 7 do
			local createdLabel = guiCreateLabel ( xBart+410, ty-5, 180, 30, "", false )
			setElementData ( createdLabel, "craftID", i )
			addEventHandler ( "onClientGUIClick", createdLabel, craftHisItemClick, false )
			ty = ty+40
			table.insert ( craftElements, createdLabel )
		end
		upLeft = guiCreateLabel (  xBart+220, yBart+35, 32, 32, "", false )
		dnLeft = guiCreateLabel (  xBart+220, yBart+285, 32, 32, "", false )
		setElementData ( upLeft, "craftArrowID",1 )
		setElementData ( dnLeft, "craftArrowID",2 )
		setElementData ( upLeft, "craftArrow",true )
		setElementData ( dnLeft, "craftArrow",true )
		upRight = guiCreateLabel ( xBart+620, yBart+35, 32, 32, "", false )
		dnRight = guiCreateLabel ( xBart+620, yBart+285, 32, 32, "", false )
		setElementData ( upRight, "craftArrowID",3 )
		setElementData ( dnRight, "craftArrowID",4 )
		setElementData ( upRight, "craftArrow",true )
		setElementData ( dnRight, "craftArrow",true )
		addEventHandler ( "onClientGUIClick", upLeft, craftArrowClick, false )
		addEventHandler ( "onClientGUIClick", dnLeft, craftArrowClick, false )
		addEventHandler ( "onClientGUIClick", upRight, craftArrowClick, false )
		addEventHandler ( "onClientGUIClick", dnRight, craftArrowClick, false )
		addEventHandler ( "onClientRender", root, renderCraftMenu )
		closeLabel = guiCreateLabel ( xBart+285, yBart+295, 115, 40, "", false )
		createLabel = guiCreateLabel ( xBart+285, yBart+250, 115, 40, "", false )
		compileLabel = guiCreateLabel ( xBart+285, yBart+200, 115, 40, "", false )
		addEventHandler ( "onClientGUIClick", closeLabel, closeCraftMenu, false )
		addEventHandler ( "onClientGUIClick", createLabel, createButtonClicked, false )
		addEventHandler ( "onClientGUIClick", compileLabel, compileButtonClicked, false )
		addEventHandler( "onClientMouseEnter", getRootElement(), craftMouseEnter )
		addEventHandler( "onClientMouseLeave", getRootElement(), craftMouseLeave )
		showCursor ( true )
	end
end

function closeCraftMenu ()
	playSound ( "media/sound/ui_pipboy_select.wav" )
	if craftShow and isElement ( upRight ) then
		for i = 1, #craftElements do
			destroyElement ( craftElements[i] )
			craftElements[i] = nil
		end
		removeEventHandler ( "onClientGUIClick", upLeft, craftArrowClick )
		removeEventHandler ( "onClientGUIClick", dnLeft, craftArrowClick )
		removeEventHandler ( "onClientGUIClick", upRight, craftArrowClick )
		removeEventHandler ( "onClientGUIClick", dnRight, craftArrowClick )
		removeEventHandler ( "onClientRender", root, renderCraftMenu )
		removeEventHandler( "onClientMouseEnter", getRootElement(), craftMouseEnter )
		removeEventHandler( "onClientMouseLeave", getRootElement(), craftMouseLeave )
		destroyElement ( upRight )
		destroyElement ( dnRight )
		destroyElement ( upLeft )
		destroyElement ( dnLeft )
		destroyElement ( closeLabel )
		destroyElement ( createLabel )
		destroyElement ( compileLabel )
		sOff = 0
		hOff = 0
		glowItem = 0
		glowL = false
		selArrow = 0
		bItemSel = 0
		closeSel = false
		craftShow = false
		setElementData ( localPlayer, "inventoryAllowed", 1 )
		executeCommandHandler ( "showhude", "0" )
		showCursor ( false )
	end
end
addCommandHandler ( 'top', initCraft )
createClickAvail = true

function compileButtonClicked ()
	if createClickAvail then
		unableToMove = true
		createClickAvail = false
		setTimer ( function () createClickAvail = true end, 1500, 1 )
		if creatingItem > 0 and itemDone then
			local itEx = false
			for i = 1, #sInv do
				if sInv[i][1] == creatingItem then
					itEx = true
					sInv[i][2] = sInv[i][2]+itemsToCreate
					break
				end
			end
			if not itEx then
				table.insert ( sInv, { creatingItem, recipes[recipeID][2]*itemsToCreate } )		
			end
			compileSel = false
			exports.inventory:givePlayerItemWW ( recipes[recipeID][1], recipes[recipeID][2]*itemsToCreate )
			for i = 4, #recipes[recipeID] do
				exports.inventory:removePlayerItem ( recipes[recipeID][i][1], recipes[recipeID][i][2]*itemsToCreate )
			end
			triggerEvent ( "onPlayerCraftItem", localPlayer, recipes[recipeID][1], recipes[recipeID][2] )
			itemDone = false
			creatingItem = 0
			exports.inventory:checkPlayerWeight ()
			unableToMove = false
		end
	else
		exports.pipboy:addInfoBox ('Подождите немного', 1 )
	end
end

cantDissmbld = { 90, 91, 92 } -- нельзя разобрать

function createButtonClicked ()
	if createClickAvail then
		createClickAvail = false
		unableToMove = true
		setTimer ( function () createClickAvail = true end, 1500, 1 )
		if itemDone then
			itemDone = false
			local itEx = false
			for b = 4, #recipes[recipeID] do
				for i = 1, #hInv do
					if hInv[i][1] == recipes[recipeID][b][1] then
						itEx = true
						hInv[i][2] = hInv[i][2]+recipes[recipeID][b][2]*itemsToCreate
						break
					end
				end
				if not itEx then
					if not itEx then
						table.insert ( hInv, { recipes[recipeID][b][1], recipes[recipeID][b][2]*itemsToCreate } )		
					end
				end
			end
			unableToMove = false
			recipeID = 0
			creatingItem = 0
		elseif #hInv == 1 then
			local destrID = hInv[1]
			local done = false
			local itemsTable = {}
			for i, id in ipairs ( cantDissmbld ) do
				if id == destrID[1] then
					addInfoBox ( 'Эту вещь нельзя разобрать', 2 )
					return true
				end			
			end
			for i = 1, #destroys do
				if destroys[i][1] == destrID[1] then
					for b, t in ipairs ( destroys[i] ) do
						if b ~= 1 then
							if t[2] then
								local totalItems = 0
								for c = 1, hInv[1][2] do
									if math.random ( 1, t[5] ) == 1 then
										totalItems = totalItems+math.random(t[3],t[3])
									end
								end
								if totalItems > 0 then
									exports.inventory:givePlayerItemWW ( t[1], totalItems )
									table.insert ( itemsTable, { t[1], totalItems } )
									--hInv = {}
									done = true
								end
							else
								done = true
								exports.inventory:givePlayerItemWW ( t[1], t[3]*hInv[1][2] )
								table.insert ( itemsTable, { t[1], t[3]*hInv[1][2] } )
								--hInv = {}
								unableToMove = false
							end
						end
					end
				end
			end
			if #itemsTable == 0 then
				addInfoBox ( 'Вы получили только мусор', 2 )
			end
			itemsTable = false
			-- for d, t in ipairs ( itemsTable ) do
				-- table.insert ( sInv, t )
			-- end
			triggerEvent ( "onPlayerDisAssembleItem", localPlayer, hInv[1][1], hInv[1][2], itemsTable )
			exports.inventory:removePlayerItem ( hInv[1][1], hInv[1][2] )
			hInv = {}
		else
			if #hInv > 0 then
				local itemsAmount = #hInv
				local itemFound = false
				for i = 1, #recipes do
					if #recipes[i]-3 == itemsAmount then
						local itemsMatch = 0
						local minimumItemQ = math.huge
						local minimumItemI = 1
						for b = 4, #recipes[i] do
							for c = 1, #hInv do 
								if recipes[i][b][1] == hInv[c][1] and recipes[i][b][2] <= hInv[c][2]  then
									itemsMatch = itemsMatch+1
									local itemsToUse = math.ceil ( hInv[c][2]/recipes[i][b][2])
									if itemsToUse < minimumItemQ then
										minimumItemQ = itemsToUse
										minimumItemI = b
									end
								end
							end
						end
						if itemsMatch == #recipes[i]-3 then
							local indexesToRemove = {}
							if minimumItemQ > 0 and recipes[i][1] > 42 and recipes[i][1] < 49 then
								itemsToCreate = minimumItemQ
							else
								itemsToCreate = 1
							end
							for b = 4, #recipes[i] do
								for c = 1, #hInv do 
									if recipes[i][b][1] == hInv[c][1] then
										local am = hInv[c][2]-recipes[i][b][2] 
										if am <= 0 then
											table.insert ( indexesToRemove, c )
										else
											hInv[c][2] = hInv[c][2]-recipes[i][b][2]*itemsToCreate 
										end
									end
								end
							end
							if recipes[i][3] then
								table.sort ( indexesToRemove, function ( a, b ) return a>b end)
								for i = 1, #indexesToRemove do
									table.remove ( hInv, indexesToRemove[i] )
								end
							--	hInv = {}
								creatingItem = recipes[i][1]
								recipeID = i
								itemDone = true
								itemFound = true
							end
							break
						end
					end
				end
				if not itemFound then
					--if not getElementData ( localPlayer, "craftPerk" ) then
					if math.random ( 1, 4 ) == 1 then
						for i = 1, #hInv do 
							exports.inventory:removePlayerItem ( hInv[i][1], hInv[i][2] )
						end
						unableToMove = false
						hInv = {}
					end
					exports.pipboy:addInfoBox ('Рецепт не найден', 2 )
				end
			end
		end
	else
		exports.pipboy:addInfoBox ('Подождите немного', 1 )
	end
end

function craftSelfItemClick ()
	if unableToMove then return true end
		local id = getElementData ( source, "craftID" )
		playSound ( "media/sound/ui_items_generic_down.wav" )
		if #sInv >= id then
			local itEx = false
			for i = 1, #hInv do
				if hInv[i][1] == sInv[id+sOff][1] then
					itEx = true
					hInv[i][2] = hInv[i][2]+1
					break
				end
			end
			if not itEx then
				table.insert ( hInv, { sInv[id+sOff][1], 1 } )		
			end
			if sInv[id+sOff][2] == 1 then
				table.remove ( sInv, id+sOff )
				if sOff > 0 then
					sOff = sOff-1
				end
			else
				sInv[id+sOff][2] = sInv[id+sOff][2]-1
			end
		end
end

function craftHisItemClick ()
	local id = getElementData ( source, "craftID" )
	if unableToMove then return true end
	if #hInv >= id then
		local itEx = false
		for i = 1, #sInv do
			if sInv[i][2] > 0 then
				if sInv[i][1] == hInv[id+hOff][1] then -- тут
					sInv[i][2] = sInv[i][2]+1
					itEx = true
					break
				end
			end
		end
		if not itEx then
			table.insert ( sInv, { hInv[id+hOff][1], 1 } )		-- тут
		end
		if hInv[id+hOff][2] == 1 then
			table.remove ( hInv, id+hOff )
		else
			hInv[id+hOff][2] = hInv[id+hOff][2]-1
		end
		if hOff > 0 then
			hOff = hOff-1
		end
	end
end

function craftArrowClick ( )
	local arrowID = getElementData ( source, "craftArrowID" )
	if arrowID == 1 then
		if sOff > 0 then
			sOff = sOff-1 
		end
	elseif arrowID == 2 then
		if sOff+7 < #sInv then
			sOff = sOff+1 
		end
	elseif arrowID == 3 then
		if hOff > 0 then
			hOff = hOff-1 
		end
	else
		if hOff+7 < #hInv then
			hOff = hOff+1 
		end
	end
end
 
function craftMouseEnter(aX, aY)
	if getElementData ( source, "craftID" ) then
		if getElementData ( source, "barterS" ) then 
			if getElementData ( source, "craftID" )+sOff <= #sInv then 
				playSound ( "media/sound/ui_menu_focus.wav" )
				glowL = true 
				glowItem = getElementData ( source, "craftID" )+sOff
				bItemSel = sInv[glowItem][1]
			end
		else 
			if getElementData ( source, "craftID" )+hOff <= #hInv then 
				playSound ( "media/sound/ui_menu_focus.wav" )
				glowL = false 
				glowItem = getElementData ( source, "craftID" )+hOff
				bItemSel = hInv[glowItem][1]
			end
		end
	elseif getElementData ( source, "barterArrow" ) then
		selArrow = getElementData ( source, "barterArrowID" )
	elseif source == closeLabel then
		playSound ( "media/sound/ui_menu_focus.wav" )
		closeSel = true 
	elseif source == compileLabel and itemDone then
		playSound ( "media/sound/ui_menu_focus.wav" )
		compileSel = true 
	elseif ( source == createLabel ) and ( itemDone or #hInv > 0 )then
		playSound ( "media/sound/ui_menu_focus.wav" )
		createSel = true 
	end
end

function craftMouseLeave(aX, aY)
	if getElementData ( source, "craftID" ) then 
		glowItem = 0
	elseif getElementData ( source, "craftArrow" ) then
		selArrow = 0
	elseif source == closeLabel then
		closeSel = false 
	elseif source == compileLabel then
		compileSel = false 
	elseif source == createLabel then
		createSel = false 
	end
end

function checkCraftPlace( theElement, matchingDimension )
    if ( theElement == localPlayer ) and matchingDimension then
		if getElementData ( source, "craft_place" ) then
			bindKey ( "E", "down", initCraft )
		end
    end
end
addEventHandler("onClientColShapeHit",getRootElement(),checkCraftPlace)

function checkCraftPlaceLeave( theElement, matchingDimension )
	if ( theElement == localPlayer ) and matchingDimension then
		if getElementData ( source, "craft_place" ) then
			unbindKey ( "E", "down", initCraft )
		end
    end
end
addEventHandler("onClientColShapeLeave",getRootElement(),checkCraftPlaceLeave)