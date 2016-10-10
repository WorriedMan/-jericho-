local screenWidth,screenHeight = guiGetScreenSize()
local color = tocolor ( 255, 182, 66 )

sOff = 0
hOff = 0
glowItem = 0
glowL = false
selArrow = 0
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
availRecipes = {}
selectedRecipe = false

craftElements = {}

recipes = { -- {ид, вероятность получить хоть что то, минимальное количество, максимальное количество }
	{ creation = { {92, 100, 1, 1 } }, qty = 1, weight = 0.02, craft_name = "Оправа очков", known = true, ingreds = { { 89, 1 } }, xp = 100 }, -- хлам
	{ creation = { {13, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Самогон", known = true, ingreds = { { 22, 1 }, { 49, 2 } }, xp = 10 }, 
	{ creation = { {15, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Святой грааль", known = false, ingreds = { { 6, 1 }, { 12, 1 }, { 17, 1 } }, xp = 100 },
	{ creation = { {5, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Чистая вода", known = true, ingreds = { { 22, 1 }, { 7, 1 } }, xp = 10 }, -- чистая вода
	{ creation = { {5, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Чистая вода", known = true, ingreds = { { 22, 1 }, { 58, 1 } }, xp = 10 }, -- чистая вода
	{ creation = { {42, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = ".50 патроны", known = true, ingreds = { { 63, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, xp = 1 }, -- .50 патроны
	{ creation = { {44, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = ".32 патроны", known = true, ingreds = { { 65, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, xp = 1 }, -- .32
	{ creation = { {45, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "10мм патроны", known = true, ingreds = { { 64, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, xp = 1 }, -- 10 мм
	{ creation = { {46, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Дробь", known = true, ingreds = { { 62, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, xp = 1 }, -- дробь
	{ creation = { {47, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = ".308 патроны", known = true, ingreds = { { 66, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, xp = 1 }, -- .308
	{ creation = { {48, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "12.7 патроны", known = true, ingreds = { { 67, 1 }, { 68, 1 }, { 70, 1 }, { 71, 1 } }, xp = 1 }, -- 12.7
	{ creation = { {146, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Патрон кал. 45-70", known = true, ingreds = { { 147, 1 }, { 68, 1 }, { 147, 1 }, { 71, 1 } }, xp = 1 }, -- 45-70
	{ creation = { {25, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Патроны 5,56-мм", known = true, ingreds = { { 153, 1 }, { 68, 1 }, { 147, 1 }, { 71, 1 } }, xp = 1 }, -- 5,56
	{ creation = { {141, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Патрон кал. 357 'Магнум'", known = true, ingreds = { { 142, 1 }, { 68, 1 }, { 147, 1 }, { 71, 1 } }, xp = 1 }, -- .357
	{ creation = { {130, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "9-мм патрон", known = true, ingreds = { { 131, 1 }, { 68, 1 }, { 147, 1 }, { 71, 1 } }, xp = 1 }, -- 9-мм
	{ creation = { {23, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Сумка", known = true, ingreds = { { 72, 1 }, { 73, 1 } }, xp = 30 }, -- сумка
	{ creation = { {30, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Винтовка", known = true, ingreds = { { 75, 1 }, { 77, 1 }, { 80, 1 }, { 81, 1 } }, xp = 100 }, -- винтовка
	{ creation = { {24, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Китайская винтовка", known = true, ingreds = { { 75, 1 }, { 77, 1 }, { 82, 1 }, { 83, 1 }, { 84, 1 } }, xp = 100 }, -- кит. винтовка
	{ creation = { {36, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Американская винтовка", known = true, ingreds = { { 75, 1 }, { 77, 1 }, { 85, 1 }, { 86, 1 }, { 87, 1 } }, xp = 100 }, -- американская винтовка
	{ creation = { {33, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Шотган", known = true, ingreds = { { 75, 1 }, { 77, 1 }, { 79, 1 } }, xp = 100 }, -- шотган
	{ creation = { {32, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Винтовка", known = true, ingreds = { { 75, 1 }, { 76, 1 }, { 77, 1 }, { 80, 1 }, { 81, 1 } }, xp = 100 }, -- винтовка
	{ creation = { {90, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Новые очки", known = true, ingreds = { { 91, 1 }, { 92, 1 }, }, xp = 100 }, -- новые очки
	{ creation = { {94, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Миниган", known = false, { 30, 6 }, ingreds = { { 93, 1 }, { 95, 1 }, { 61, 1 } }, xp = 100 }, -- миниган 19
	{ creation = { {96, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Броня солдата", known = false, ingreds = { { 68, 90 }, { 72, 6 }, { 73, 2 }, }, xp = 80 }, -- броня 20 
	{ creation = { {111, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Топливо для 'Горбомета'", known = true, ingreds = { { 112, 1 }, { 110, 1 }, { 22, 1 }, }, xp = 1 }, -- топливо 21
	{ creation = { {111, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Топливо для 'Горбомета", known = true, ingreds = { { 112, 1 }, { 11, 3 }, { 12, 3 },  { 13, 3 } }, xp = 1 }, -- топливо 22
	{ creation = { {6, 100, 1, 1 }, }, qty = 1, weight = 10, craft_name = "Винт", known = true, ingreds = { { 49, 1 }, { 56, 1 } }, xp = 20 }, -- винт 23
	{ creation = { {55, 100, 1, 2 }, }, qty = 1, weight = 3, craft_name = "Хлам", known = true, ingreds = { { 1, 1 } }, xp = 1 }, -- хлам
	{ creation = { {55, 100, 1, 1 }, }, qty = 1, weight = 3, craft_name = "Хлам", known = true, ingreds = { { 52, 1 }, { 53, 1 }, { 61, 1 } }, xp = 1 }, -- хлам
	{ creation = { {55, 100, 1, 4 }, }, qty = 1, weight = 3, craft_name = "Хлам", known = true, ingreds = { { 60, 1 }, { 53, 1 }, { 61, 1 } }, xp = 1 }, -- хлам
	{ creation = { {56, 100, 1, 1 }, }, qty = 1, weight = 0.01, craft_name = "Пустой шприц", known = true, ingreds = { { 1, 1 } } }, -- хлам
	{ creation = { {63, 100, 1, 1 }, {68, 40, 1, 1 }, {70, 20, 1, 2 }, {71, 50, 1, 3 } }, qty = 1, weight = 0.02, craft_name = ".50 разобрать", known = true, ingreds = { { 42, 1 } } }, -- хлам
	{ creation = { {65, 100, 1, 1 }, {68, 40, 1, 1 }, {70, 20, 1, 2 }, {71, 50, 1, 2 } }, qty = 1, weight = 0.02, craft_name = ".32 разобрать", known = true, ingreds = { { 44, 1 } } }, -- хлам
	{ creation = { {62, 100, 1, 1 }, {68, 40, 1, 1 }, {70, 20, 1, 2 }, {71, 50, 1, 2 } }, qty = 1, weight = 0.02, craft_name = "Дробь разобрать", known = true, ingreds = { { 46, 1 } } }, -- хлам
	{ creation = { {64, 100, 1, 1 }, {68, 40, 1, 1 }, {70, 20, 1, 2 }, {71, 50, 1, 2 } }, qty = 1, weight = 0.02, craft_name = "10мм разобрать", known = true, ingreds = { { 45, 1 } } }, -- хлам
	{ creation = { {66, 100, 1, 1 }, {68, 40, 1, 1 }, {70, 20, 1, 2 }, {71, 50, 1, 2 } }, qty = 1, weight = 0.02, craft_name = ".308 разобрать", known = true, ingreds = { { 47, 1 } } }, -- хлам
	{ creation = { {67, 100, 1, 1 }, {68, 40, 1, 1 }, {70, 20, 1, 2 }, {71, 50, 1, 2 } }, qty = 1, weight = 0.02, craft_name = "12.7 разобрать", known = true, ingreds = { { 48, 1 } } }, -- хлам
	{ creation = { {147, 100, 1, 1 }, {68, 40, 1, 1 }, {70, 20, 1, 2 }, {71, 50, 1, 2 } }, qty = 1, weight = 0.02, craft_name = "45-70 разобрать", known = true, ingreds = { { 146, 1 } } }, -- хлам
	{ creation = { {142, 100, 1, 1 }, {68, 40, 1, 1 }, {70, 20, 1, 2 }, {71, 50, 1, 2 } }, qty = 1, weight = 0.02, craft_name = ".357 'Магнум' разобрать", known = true, ingreds = { { 141, 1 } } }, -- хлам
	{ creation = { {153, 100, 1, 1 }, {68, 40, 1, 1 }, {70, 20, 1, 2 }, {71, 50, 1, 2 } }, qty = 1, weight = 0.02, craft_name = "5,56-мм разобрать", known = true, ingreds = { { 25, 1 } } }, -- хлам
}

local needToBeKnown = { 19, 20 }

function loadedCraftTable (craftT)
	for i, v in ipairs ( craftT ) do
		recipes[v].known = true
	end
	setElementData ( localPlayer, 'knownRecipes', craftT )
end

addEvent( "loadedCraftTable", true )
addEventHandler( "loadedCraftTable", getRootElement(), loadedCraftTable )

function addCraftRecipe ( num, id )
	if not recipes[num].known then
		exports.pipboy:addInfoBox ('Теперь вы знаете, как собрать '..things[recipes[num][1]][2], 2 )
		local knownRecipes = {}
		recipes[num].known = true
		for i, v in ipairs ( needToBeKnown ) do
			if recipes[v].known then
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
		if i <= #availRecipes then
			dxDrawText ( recipes[availRecipes[i].id].craft_name, tx, ty, screenWidth, yBart+335, tocolor ( 255, 182, 66 ), 1.2, "default-bold", "left", "top", true )
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
	if selectedRecipe and selectedRecipe.ingreds then
		for i = 1+hOff, 7+hOff do
			if i <= #selectedRecipe.ingreds then
				dxDrawText ( things[selectedRecipe.ingreds[i][1]][2].." ["..(exports.inventory:getItemAmount(selectedRecipe.ingreds[i][1]) or 0 ).."/"..selectedRecipe.ingreds[i][2].."]", xBart+430, ty, screenWidth, yBart+335, tocolor ( 255, 182, 66 ), 1.2, "default-bold", "left", "top", true )
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
	end
	dxDrawLine ( xBart+15, yBart+15, xBart+30, yBart+15, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawText ( 'Рецепты', xBart+30, yBart+5, screenWidth, yBart+50, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
	dxDrawLine ( xBart+145, yBart+15, xBart+270, yBart+15, tocolor ( 255, 182, 66 ), 1.5 )
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
	if selectedRecipe then
			dxDrawText ( 'Сделать', xBart+290, yBart+200, screenWidth, yBart+350, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
			--dxDrawText ( 'Отмена', xBart+290, yBart+250, screenWidth, yBart+350, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
			--dxDrawText ( 'Итого вес: ~'..selectedRecipe.weight, xBart+200, yBart+350, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.1, "default-bold", "left", "top" )
			
			local creation_text = "Результат:\n"
			for i, v in ipairs (selectedRecipe.creation) do
				if things[v[1]] then
					creation_text = creation_text..things[v[1]][2].. " (~"..v[3]..")\n"
				end
			end
			
			dxDrawText ( creation_text, xBart+30, yBart+345, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.1, "default-bold", "left", "top" )
	else
		dxDrawText ( '1. Выберите рецепт\n2. Нажмите \'Сделать\'\n', xBart+30, yBart+360, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default-bold", "left", "top" )
	end
	dxDrawImage ( xBart+495, yBart+320, 128, 128, t.mrCraft, 0, 0, 0, tocolor ( 255, 182, 66 ) )
	dxDrawText ( '\"Мистер Рукоблуд 1000\" (c)РобКо 2073', xBart+435, yBart+450, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1, "default-bold", "left", "top" )
	drawBarterArrows ()	
end

barterA = {
	{ 220, 35 },
	{ 220, 285 },
	{ 620, 35 },
	{ 620, 285 }
}

function drawBarterArrows ()
	for i = 1, 4 do
		if ( i == 1 and sOff > 0 ) or ( i == 2 ) or ( i == 3 and selectedRecipe and #selectedRecipe.creation > 7 ) or ( i == 4 and hOff+7 < #hInv ) then
			local rot = 0
			local color = tocolor ( 255, 182, 66 )
			if i == 2 or i == 4 then rot = 180 end
		--	if i == selArrow then color = tocolor ( 255, 240, 66 ) end
			dxDrawImage ( xBart+barterA[i][1], yBart+barterA[i][2], 32, 32, t.arrow, rot, 0, 0, color )
		end
	end
end

function getPlayerAvailRecipes ()
	local tempTable = {}
	for i, v in ipairs ( recipes ) do
		if v.known then
			v.id = i
			table.insert ( tempTable, v )
		end
	end
	return tempTable
end

function initCraft ()
	if not craftShow then
		craftShow = true
		executeCommandHandler ( "showhude", "1" )
		sInv = exports.inventory:getItemsLargeNull() -- вес, ид, количество
		hInv = {}
		selectedRecipe = false
		availRecipes = getPlayerAvailRecipes()
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
		--ty = yBart+50
		-- for i = 1, 7 do
			-- local createdLabel = guiCreateLabel ( xBart+410, ty-5, 180, 30, "", false )
			-- setElementData ( createdLabel, "craftID", i )
			-- addEventHandler ( "onClientGUIClick", createdLabel, craftHisItemClick, false )
			-- ty = ty+40
			-- table.insert ( craftElements, createdLabel )
		-- end
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
		--createLabel = guiCreateLabel ( xBart+285, yBart+250, 115, 40, "", false )
		compileLabel = guiCreateLabel ( xBart+285, yBart+200, 115, 40, "", false )
		addEventHandler ( "onClientGUIClick", closeLabel, closeCraftMenu, false )
		addEventHandler ( "onClientGUIClick", compileLabel, compileButtonClicked, false )
		addEventHandler( "onClientMouseEnter", getRootElement(), craftMouseEnter )
		addEventHandler( "onClientMouseLeave", getRootElement(), craftMouseLeave )
		showCursor ( true )
	end
end

--addCommandHandler ("cr",initCraft)

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
		destroyElement ( compileLabel )
		sOff = 0
		hOff = 0
		glowItem = 0
		glowL = false
		selArrow = 0
		closeSel = false
		craftShow = false
		setElementData ( localPlayer, "inventoryAllowed", 1 )
		executeCommandHandler ( "showhude", "0" )
		showCursor ( false )
	end
end
addCommandHandler ( 'top', initCraft )
createClickAvail = true

cantDissmbld = { 90, 91, 92 } -- нельзя разобрать

function compileButtonClicked ()
	if selectedRecipe and not unableToMove then
		unableToMove = true
		setTimer ( function () unableToMove = false end, 300, 1 )
		for i, v in ipairs (selectedRecipe.ingreds) do
			if ( exports.inventory:getItemAmount(v[1]) or 0 ) < v[2] then
				addInfoBox ( 'У вас не хватает ингридиентов', 2 )
				return true 
			else
				exports.inventory:removePlayerItem(v[1],v[2])
			end
		end
		local youcreated = "Вы получили: "
		local gotitems = {}
		for i, v in ipairs (selectedRecipe.creation) do	
			if math.random ( 1, 100 ) <= v[2] then
				local quant = math.random(v[3],v[4])
				exports.inventory:givePlayerItemWW ( v[1], quant, true )
				if #gotitems > 0 then
					youcreated = youcreated..", "
				end
				table.insert(gotitems,{v[1],quant})
				youcreated = youcreated..things[v[1]][2].." ("..quant..")"
			end
		end
		if selectedRecipe.xp then
			exports.players:givePlayerXPClient ( selectedRecipe.xp )
		end
		triggerEvent ( "onPlayerCraftItem", localPlayer, selectedRecipe.craft_name, gotitems )
		if #gotitems > 0 then
			addInfoBox ( youcreated, 2 )
		else
			addInfoBox ( "Похоже у вас ничего не получилось", 2 )
		end
	end
end

function craftSelfItemClick ()
	if unableToMove then return true end
	local id = getElementData ( source, "craftID" )
	playSound ( "media/sound/ui_items_generic_down.wav" )
	if #availRecipes >= id then
		selectedRecipe = availRecipes[id+sOff]
		hOff = 0
	end
end

function craftArrowClick ( )
	local arrowID = getElementData ( source, "craftArrowID" )
	if arrowID == 1 then
		if sOff > 0 then
			sOff = sOff-1 
		end
	elseif arrowID == 2 then
		if sOff+7 < #availRecipes then
			sOff = sOff+1 
		end
	elseif arrowID == 3 then
		if hOff > 0 then
			hOff = hOff-1 
		end
	elseif selectedRecipe then
		if hOff+7 < #selectedRecipe.ingreds then
			hOff = hOff+1 
		end
	end
end
 
function craftMouseEnter(aX, aY)
	if getElementData ( source, "craftID" ) then
		if getElementData ( source, "barterS" ) then 
			if getElementData ( source, "craftID" )+sOff <= #recipes then 
				playSound ( "media/sound/ui_menu_focus.wav" )
				glowL = true 
				glowItem = getElementData ( source, "craftID" )+sOff
			end
		end
	elseif getElementData ( source, "barterArrow" ) then
		selArrow = getElementData ( source, "barterArrowID" )
	elseif source == closeLabel then
		playSound ( "media/sound/ui_menu_focus.wav" )
		closeSel = true 
	elseif source == compileLabel and selectedRecipe then
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