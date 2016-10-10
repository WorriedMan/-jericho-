items = { -- название тип ид 5 6 7 цены
	{ "Рука гуля", 1, 4, 10, "Еда. Здоровье +50; Радиация +30; Голод -30; Вес 4 кг", 10, 50, 30, 60, 30, 20, 20, 10}, -- 1
	{ "Шашлык из белки", 1, 0.5, 2, "Еда. Здоровье +10; Радиация +10; Голод -1; Вес 0.5 кг", 30, 70, 50, 50, 20, 10, 10, 10 }, -- 2
	{ "Шашлык из игуаны", 1, 1.5, 3, "Еда. Здоровье +20; Радиация +20; Голод -15; Вес 1.5 кг", 50, 110, 70, 50, 20, 20, 20, 30, 20 }, -- 3
	{ "Радотаракан", 1, 2, 4, "Еда. Здоровье +30; Радиация +30; Голод -25; Вес 2 кг" , 70, 140, 100, 50, 80, 30, 30, 100 }, -- 4
	{ "Чистая вода", 1, 1, 5, "Еда. Здоровье +30; Радиация -20; Голод -1; Вес 1 кг", 70, 180, 30, 30, 100, 30, 100, 300 }, -- 5
	{ "Винт", 2, 1, 6, "Лекарство. ОД +10; Голод +10; Вес 1 кг", 500, 100, 350, 350, 700, 200, 300, 300 }, -- 6
	{ "Антирад", 2, 2, 7, "Лекарство. Полностью выводит радиацию из организма. Голод +10; Вес 2 кг", 600, 50, 250, 350, 600, 150, 250, 400 }, -- 7
	{ "Стимулятор", 2, 3, 1, "Лекарство. Полностью восстанавливает здоровье. Голод +5; Вес 3 кг", 300, 30, 50, 150, 400, 173, 180, 200}, -- 8
	{ "Пиво", 1, 1, 11, "Алкоголь. Здоровье +10; Радиация -10; Голод -5; Вес 1 кг", 300, 30, 50, 20, 200, 70, 50, 100 }, -- 9
	{ "Водка", 1, 1, 12, "Алкоголь. Здоровье +20; Радиация -20; Голод -2", 300, 30, 50, 25, 200, 80, 50,20}, -- 10
	{ "Самогон", 1, 1, 13, "Алкоголь. Радиация -20; Здоровье -5; Голод -7; Вес 1 кг", 300, 30, 50, 30, 200, 90, 20, 50 }, -- 11
	{ "АнтиРад костюм", 2, 10, 14, "Защита от внешней радиации. Вес 10 кг", 300, 10000, 50, 50, 50, 20000, 0, 0 }, -- 12
	{ "Тушенка", 1, 1, 18, "Еда. Полностью убирает голод. Вес 1 кг", 200, 200, 200, 200, 150, 400, 150, 250 }, -- 13
	{ "Консервы", 1, 1, 19, "Еда. Голод -20; Вес 1 кг", 300, 10000, 50, 50, 200, 3000, 200, 0 }, -- 14
	{ "Пакетик орехов", 1, 0.5, 20, "Еда. Голод -5; Вес 0.5 кг", 300, 10000, 50, 10, 10000, 15, 5, 0 }, -- 15
	{ "Китайская винтовка", 3, 7, 24, "Патроны калибра 5,56-м. УВС 132. Вес 7 кг", 30000, 39000, 25000, 25000, 40000, 40000, 50000, 0 }, -- 16 
	{ "Патроны 5,56", 4, 0.01, 25, "", 100, 30, 60, 60, 100, 100, 120, 50 }, -- 17 УБРАТЬ
	{ "Кий", 5, 2, 26, "Ручное оружие. Вес 2 кг", 200, 230, 50, 60, 150, 200, 150, 0 }, -- 18
	{ "Бензопила", 5, 10, 27, "Ручное оружие. Вес 10 кг", 10000, 15000, 12000, 16000, 17000, 20000, 7500, 0 }, -- 19
	{ "Лопата", 5, 2, 28, "Ручное оружие. Вес 2 кг", 20, 10, 15, 10, 30, 15, 10, 0 }, -- 20
	{ "Катана", 5, 1, 29, "Ручное оружие. Вес 1 кг", 10000, 10000, 10000, 10000, 15000, 13000, 19000, 0 }, -- 21
	{ "Винтовка", 3, 2, 30, "Однозарядная винтовка. Патроны .50 калибра. Урон 75; Вес 2 кг", 7000, 10000, 10000, 12000, 11000, 20000, 10000, 6500 }, -- 22 УБРАТЬ
	{ "Бесшумный", 3, 0.5, 31, "Пистолет. Патроны .32 калибра. Урон 40; Вес 500 грамм", 18900, 17000, 14000, 15000, 10590, 10590, 15500, 0 }, --23 УБРАТЬ
	{ "Снайперская винтовка", 3, 5, 32, "Однозарядная винтовка. Патроны .50 калбира. Урон 125; Вес 5 кг", 30000, 20000, 30000, 20000, 60000, 19999, 50000, 0 }, -- 24 УБРАТЬ
	{ "Шотган", 3, 3, 33, "Дробовик. Патроны дробь. Урон 10; Вес 3 кг", 10000, 15000, 20000, 5000, 12000, 11000, 7890, 0 }, -- 25 УБРАТЬ
	{ "10-мм пистолет", 3, 3, 34, "Пистолет. Патроны калибра 10-мм. УВС: 60.5", 20000, 23000, 15000, 30000, 20000, 17000, 19000, 0 }, -- 26
	{ "Охотничий револьвер", 3, 4, 144, "УВС: 87", 15000, 20000, 20000, 10000, 29000, 20000, 23000, 0 }, -- 27
	{ "Американская винтовка", 3, 7, 36, "Патроны калибра 5,56-мм. УВС 104; Вес 7 кг", 50000, 28000, 37000, 36000, 40000, 45000, 50000, 0 }, -- 28
	{ "Дубинка", 5, 2, 37, "Ручное оружие. Вес 2 кг.", 100, 150, 50, 30, 70, 80, 65, 0 }, -- 29
	{ "9-мм пистолет", 3, 1.5, 129, "УВС: 49; Вес 1,5 кг", 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000 }, -- 30
	{ "9-мм патроны", 3, 0.01, 130, "", 5, 10, 15, 15, 15, 15, 15, 0 }, -- 31
	{ "9-мм пистолет-пулемёт", 4, 4, 134, "УВС: 154; Вес 4 кг.", 3000, 8000, 2500, 5000, 5000, 5000, 5000, 5000 }, -- 32
	{ "Винтовка резервиста", 4, 0.01, 43, "Патроны для пистолетов данного калибра. Вес 1 грамм", 10, 10, 10, 10, 30, 10, 15, 22 }, -- 33
	{ "10-мм патроны", 4, 0.05, 45, "Патроны для пистолета 10мм. Вес 5 грамм", 30, 30, 15, 10, 30, 40, 30, 50 }, -- 34
	{ "Дробь", 4, 0.1, 46, "Патроны для различных дробовиков. Вес 10 грамм", 25, 50, 50, 50, 70, 80, 25, 20 }, -- 35 УБРАТЬ
	{ "12,7-мм патроны", 4, 0.02, 48, "Патроны для американской винтовки. Вес 2 грамма", 60, 40, 70, 80, 90, 45, 80, 50 }, -- 36
	{ "Патрон кал. 45-70", 1, 0.065, 146, "", 60, 40, 70, 80, 90, 45, 80, 50 }, -- 37
	{ "Зараженная вода", 1, 0.5, 22, "Обычная вода, но приправленная радиацией", 15, 0, 0, 0, 0, 0, 0, 0, 10 }, -- 38
	{ "Патроны 5,56-мм", 4, 0.01, 25, "", 50, 30, 60, 70, 80, 10, 80, 30 }, -- 39
	{ "Кислородный накопитель", 3, 0.5, 109, "Позволяет пополнять запас воздуха", 250, 150, 130, 100, 250, 250, 250 }, -- 40
	{ "Ремонтный набор", 3, 2, 123, "Ремонтирует выбранный предмет на 50%", 200, 150, 130, 100, 250, 250, 250 }, -- 41
}

-- не используются: 17, 22, 23, 24, 25, 35

collections = { -- тип, поселение, количество вещей, вещи
	{ 1, 1, 5, 1, 2, 3, 4, 5 }, -- еда Новая Деревня 1
	{ 2, 1, 3, 6, 7, 8 }, -- лекарства Новая Деревня 2
	{ 1, 2, 5, 1, 2, 3, 4, 5 }, -- еда Союз Ученых 3
	{ 2, 2, 4, 6, 7, 8, 12 }, -- лекарства Союз Ученых 4
	{ 1, 3, 5, 1, 2, 3, 4, 5 }, -- еда Новый Вегас 5
	{ 2, 3, 3, 6, 7, 8 }, -- лекарства Новый Вегас 6
	{ 1, 1, 5, 1, 2, 3, 4, 5 }, -- еда Эль Кебрадос 7
	{ 2, 1, 3, 6, 7, 8 }, -- лекарства Эль Кебрадос 8
	{ 1, 3, 5, 1, 2, 3, 4, 5 }, -- еда Мотель 9
	{ 2, 3, 3, 6, 7, 8 }, -- лекарства Мотель 10
	{ 1, 3, 4, 5, 9, 10, 11 }, -- бар Мегатонна 11
	{ 1, 4, 6, 5, 9, 10, 13, 14, 15 }, -- еда Торговый Пост 12
	{ 2, 4, 3, 6, 7, 8, 40 }, -- лекарства Торговый Пост 13
	{ 1, 5, 5, 14, 13, 5, 9, 7, 3 }, -- караванщик Вест Сайд 14
	{ 2, 6, 5, 5, 6, 7, 8, 12}, -- Престон Ривет Сити 15
	{ 1, 6, 7, 1, 2, 3, 4, 13, 14, 15}, -- Фетси Ривет Сити 16
	{ 1, 6, 5, 5, 9, 10, 11, 15}, -- "У Руля" Ривет Сити 17
	{ 1, 6, 5, 5, 9, 10, 11, 15}, -- караванщик Ривет Сити 18
	{ 1, 7, 8, 5, 9, 10, 11, 15, 2, 3, 1}, -- Сайаг Кламат 19
	{ 3, 6, 13, 16, 18, 19, 20, 21, 26, 30, 28, 29, 31, 32, 34, 39 }, -- Снаряд Ривет Сити 20
	{ 3, 1, 13, 16, 18, 19, 20, 26, 30, 29, 31, 32, 34, 37, 41, 39 }, -- Оружие НД 21
	{ 3, 2, 12, 16, 18, 19, 20, 26, 30, 28, 29, 31, 32, 34, 39 }, -- Оружие СУ 22
	{ 3, 3, 13, 16, 18, 19, 20, 26, 30, 28, 29, 31, 32, 34, 37, 39 }, -- Оружие НВ 23
	{ 3, 4, 13, 16, 18, 19, 20, 26, 30, 28, 29, 31, 32, 34, 37, 39 }, -- Оружие ТП 24
	{ 3, 7, 13, 16, 18, 19, 20, 26, 30, 28, 29, 31, 32, 34, 37, 39 }, -- Оружие Кламат 25
	{ 3, 1, 2, 37, 38 }, -- Горбов 26
	{ 3, 8, 15, 38, 3, 1, 4, 5, 7, 8, 10, 11, 13, 32, 33, 34, 37, 41, 39 }, -- Роберт Мэйфлауэр 27
}

local localPlayer = getLocalPlayer()
local visibled = 0

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),
    function ( startedRes )
		foodpickupNC = createPickup ( -946.1884765625,1911.6748046875,5, 3, 1274 )
		setElementInterior ( foodpickupNC, 17 )
		foodtextNC = exports.dtext:create3DText ( -946.1884765625,1911.6748046875,6, "Купить продукты", 255, 255, 255, 255, "nc" )
		setElementInterior ( foodtextNC, 17 )
		setElementData ( foodpickupNC, "trade-pickup", "sc_food" )
		
		medpickupNC = createPickup ( -957.556640625,1887.5341796875, 5, 3, 1274 )
		setElementInterior ( medpickupNC, 17 )
		medtextNC = exports.dtext:create3DText ( -957.556640625,1887.5341796875, 6, "Купить лекарства", 255, 255, 255, 255, "nc" )
		setElementInterior ( medtextNC, 17 )
		setElementData ( medpickupNC, "trade-pickup", "nc_medic" )
		
		foodpickupSU = createPickup ( 262.4970703125, 1855.2958984375, 8.7578125, 3, 1274 )
		mfoodextSU = exports.dtext:create3DText ( 262.4970703125, 1855.2958984375, 9.7578125, "Купить продукты", 255, 255, 255, 255, "nc" )
		setElementData ( foodpickupSU, "trade-pickup", "sc_food" )
		
		medpickupSU = createPickup ( -260.20401000977,1539.8863525391,76.3203125, 3, 1274 )
		medtextSU = exports.dtext:create3DText ( -260.20401000977,1539.8863525391,77.3203125, "Купить лекарства", 255, 255, 255, 255, "nc" )
		setElementData ( medpickupSU, "trade-pickup", "sc_medic" )

		medpickupNV = createPickup ( -208.0888671875,2713.0947265625,62.979370117188, 3, 1274 )
		medtextNV = exports.dtext:create3DText ( -208.0888671875,2713.0947265625,63.979370117188, "Купить лекарства", 255, 255, 255, 255, "nc" )
		setElementData ( medpickupNV, "trade-pickup", "nv_medic" )
		
		foodpickupNV = createPickup ( -220.6279296875,2643.9833984375,63.003177642822, 3, 1274 )
		foodtextNV = exports.dtext:create3DText ( -220.6279296875,2643.9833984375,64.003177642822, "Купить продукты", 255, 255, 255, 255, "nc" )
		setElementData ( foodpickupNV, "trade-pickup", "nv_food" )
		
		medpickupEHL = createPickup ( -1531.3271484375,2610.763671875,55.8359375, 3, 1274 )
		medtextEHL = exports.dtext:create3DText ( -1531.3271484375,2610.763671875,56.8359375, "Купить лекарства", 255, 255, 255, 255, "nc" )
		setElementData ( medpickupEHL, "trade-pickup", "ehl_medic" )
		
		foodpickupEHL = createPickup ( -1509.583984375,2590.3603515625,55.8359375, 3, 1274 )
		foodtextEHL = exports.dtext:create3DText ( -1509.583984375,2590.3603515625,56.8359375, "Купить продукты", 255, 255, 255, 255, "nc" )
		setElementData ( foodpickupEHL, "trade-pickup", "ehl_food" )
		
		medpickupHOT = createPickup ( -789.703125,2757.30078125,45.854598999023, 3, 1274 )
		medtextHOT = exports.dtext:create3DText ( -789.703125,2757.30078125,46.854598999023, "Купить лекарства", 255, 255, 255, 255, "nc" )
		setElementData ( medpickupHOT, "trade-pickup", "motel_medic" )
		
		foodpickupHOT = createPickup ( -768.375,2765.1845703125,45.855598449707, 3, 1274 )
		foodtextHOT = exports.dtext:create3DText ( -768.375,2765.1845703125,46.855598449707, "Купить продукты", 255, 255, 255, 255, "nc" )
		setElementData ( foodpickupHOT, "trade-pickup", "motel_food" )
		
		--продажа ниже
		
		-- sellpickupNC = createPickup ( -704.900390625,2052.56640625,60.832431793213, 3, 1274 )
		-- selltextupNC = exports.dtext:create3DText ( -704.900390625,2052.56640625,61.832431793213, "Продать товары", 255, 255, 255, 255, "nc" )
		-- setElementData ( sellpickupNC, "sell-pickup", 1 )
				
		-- sellpickupSU = createPickup ( -278.1806640625,1514.109375,75.5625, 3, 1274 )
		-- selltextSU = exports.dtext:create3DText ( -278.1806640625,1514.109375,76.5625, "Продать товары", 255, 255, 255, 255, "nc" )
		-- setElementData ( sellpickupSU, "sell-pickup", 2 )
		
		-- sellpickupNV = createPickup ( -288.40795898438,2736.6245117188,62.401977539063, 3, 1274 )
		-- selltextpNV = exports.dtext:create3DText ( -288.40795898438,2736.6245117188,63.401977539063, "Продать товары", 255, 255, 255, 255, "nc" )
		-- setElementData ( sellpickupNV, "sell-pickup", 3 )
		
		-- addEventHandler("onClientPickupHit", sellpickupNV, clientPickupCheckTrade)
		-- addEventHandler("onClientPickupHit", sellpickupSU, clientPickupCheckTrade)
		-- addEventHandler("onClientPickupHit", sellpickupNC, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", foodpickupHOT, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", medpickupHOT, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", foodpickupEHL, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", medpickupEHL, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", foodpickupNV, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", medpickupNV, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", medpickupSU, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", foodpickupSU, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", medpickupNC, clientPickupCheckTrade)
		addEventHandler("onClientPickupHit", foodpickupNC, clientPickupCheckTrade)
		
	end
)

function clientPickupCheckTrade (player)
	if player == localPlayer then
		if getElementData ( source, "trade-pickup" ) then
			showTraderWindow ( getElementData ( source, "trade-pickup" ) )
		end
		if getElementData ( source, "sell-pickup" ) then -- продажа
			showSellWindow ( getElementData ( source, "sell-pickup" ) )
		end
	end
end

function showTraderWindow ( id )
	if visibled == 0 then
		setElementData ( localPlayer, "inventoryAllowed", 0 )
		exports.inventory:closeInventoryWindow()
		traderWindow = guiCreateWindow(0.25, 0.24, 0.49, 0.54, "Вес: "..getElementData ( localPlayer, "invWeight" ).."/"..getElementData ( localPlayer, "maxWeight" ).." кг", true)
		guiWindowSetSizable(traderWindow, false)

		traderBuy = guiCreateButton(0.41, 0.89, 0.24, 0.07, "Купить", true, traderWindow)
		guiSetProperty(traderBuy, "NormalTextColour", "FFAAAAAA")
		traderExit = guiCreateButton(0.73, 0.89, 0.24, 0.07, "Закрыть", true, traderWindow)
		guiSetProperty(traderExit, "NormalTextColour", "FFAAAAAA")
		traderGrid = guiCreateGridList(0.01, 0.05, 0.97, 0.82, true, traderWindow)
		guiGridListAddColumn(traderGrid, "Название", 0.2)
		guiGridListAddColumn(traderGrid, "Цена", 0.1)
		guiGridListAddColumn(traderGrid, "Количество", 0.1)
		guiGridListAddColumn(traderGrid, "Описание", 0.5)
		local id = tonumber(id)
		local amount = collections[id][3]
		for i = 1, amount do
			guiGridListAddRow(traderGrid)
			local itemID = collections[id][i+3]
			if itemID then
				guiGridListSetItemText(traderGrid, i-1, 1, items[itemID][1], false, false)
				guiGridListSetItemText(traderGrid, i-1, 2, tostring(items[itemID][5+collections[id][2]]), false, false)
				guiGridListSetItemText(traderGrid, i-1, 4, items[itemID][5], false, false)
				local wasQuant = exports.inventory:getItemAmount(items[itemID][4])
				if wasQuant then
					guiGridListSetItemText(traderGrid, i-1, 3, tostring(wasQuant), false, false)
				else
					guiGridListSetItemText(traderGrid, i-1, 3, "0", false, false)
				end
				guiGridListSetItemData ( traderGrid, i-1, 1, { itemID, id, items[itemID][4] } )
			end
		end
		addEventHandler("onClientGUIDoubleClick", traderGrid, actionOnTrader,false)
		addEventHandler("onClientGUIClick", traderBuy,
				function ()
					actionOnTrader()
				end
		,false)
		addEventHandler("onClientGUIClick", traderExit,
			function ()
				guiSetVisible ( traderWindow, false )
				showCursor ( false )
				setElementData ( localPlayer, "inventoryAllowed", 1 )
				visibled = 0
				if getElementData ( localPlayer, 'rplvl' ) < 2 then
					exports.pipboy:addInfoBox ( "Для открытия инвентаря нажмите кнопку Ш", 2 )
				end
			end
		,false)
		showCursor ( true )
		visibled = 1
	end
end

moveAvailable = true

function actionOnTrader ()
	if not moveAvailable then return true end
	moveAvailable = false
	setTimer ( function () moveAvailable = true end, 200, 1 )
	local selectedThings = guiGridListGetSelectedItems ( traderGrid )
	if selectedThings[1] then
		local thingData = guiGridListGetItemData ( traderGrid, tonumber(selectedThings[1]["row"]), 1 )
		local gridText = guiGridListGetItemText ( traderGrid, tonumber(selectedThings[1]["row"]), 1 )
		if thingData then
			if gridText == items[thingData[1]][1] then
				if getElementData ( localPlayer, "invWeight" )+items[thingData[1]][3] >= getElementData ( localPlayer, "maxWeight" ) then
					exports.pipboy:addInfoBox ("Вы не можете купить больше предметов из-за перегруза",2 )
					return true
				end
				local itemPrice = items[thingData[1]][5+collections[thingData[2]][2]]
				if exports.inventory:getPlayerCaps() >= itemPrice then					
					exports.inventory:givePlayerItem ( items[thingData[1]][4], 1, true )
					exports.inventory:checkPlayerWeight ()
					triggerServerEvent ( "takeTradersMoneyC", localPlayer, items[thingData[1]][5+collections[thingData[2]][2]] )
					triggerServerEvent ( "goodBoughtServerC", localPlayer, items[thingData[1]][1], 1, items[thingData[1]][5+collections[thingData[2]][2]], collections[thingData[2]][2] )
					guiGridListSetItemText( traderGrid, tonumber(selectedThings[1]["row"]), 3, exports.inventory:getItemAmount (thingData[3]), false, false )
					guiSetText ( traderWindow, "Вес: "..getElementData ( localPlayer, "invWeight" ).."/"..getElementData ( localPlayer, "maxWeight" ).." кг" )
				else
					exports.pipboy:addInfoBox ("У вас недостаточно денег",1 )
					return true
				end
			end
		else
			outputChatBox ("Ошибка! Как можно скорее сообщите администратору код: B1aaaa", 255,255,127 )
		end
	end
end

