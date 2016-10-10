goods = { -- название тип ид цены
	{ "Рука гуля", 1, 10, 5, 30, 10, 0, 0, 30, 5 }, -- 1
	{ "Шашлык из белки", 1, 2, 10, 40, 20, 0, 0, 30, 10}, -- 2
	{ "Шашлык из игуаны", 1, 3, 20, 50, 30, 0, 0, 40, 20}, -- 3
	{ "Двойная крыса", 1, 4, 40, 60, 60, 0, 0, 50, 30}, -- 4
	{ "Чистая вода", 1, 5, 50, 90, 5, 0, 0, 20, 80}, -- 5
	{ "Психо", 2, 6, 50, 50, 50, 0, 0, 150, 100}, -- 6
	{ "Антирад", 2, 7, 110, 40, 80, 0, 0, 100, 140}, -- 7
	{ "Стимулятор", 2, 1, 50, 10, 40, 0, 0, 36, 70}, -- 8
	{ "Тушенка", 1, 18, 50, 50, 50, 20, 50, 70, 50 }, -- 9
}

weaponsAmmo = {
	{ 22, 23, 24 },
	{ 25, 26, 27 },
	{ 28, 29, 32 },
	{ 30, 31 },
	{ 33, 34 },
}

needing = {
"низкая",
"средняя",
"высокая",
}


stringName = {
	"moneyNC",
	"moneySU",
	"moneyNV",

}

local localPlayer = getLocalPlayer()
local visibled = 0

function showSellWindow ( id )
	if visibled == 0 then
		exports.inventory:closeInventoryWindow()
		setElementData ( localPlayer, "invetntoryAllowed", 0 )
		sellWindow = guiCreateWindow(0.25, 0.24, 0.49, 0.54, "Денег в поселении: "..tostring(getElementData(localPlayer,stringName[id])).."$", true)
		guiWindowSetSizable(sellWindow, false)

		sellButton = guiCreateButton(0.41, 0.89, 0.24, 0.07, "Продать", true, sellWindow)
		guiSetProperty(sellButton, "NormalTextColour", "FFAAAAAA")
		sellExit = guiCreateButton(0.73, 0.89, 0.24, 0.07, "Закрыть", true, sellWindow)
		guiSetProperty(sellExit, "NormalTextColour", "FFAAAAAA")
		sellGrid = guiCreateGridList(0.01, 0.05, 0.97, 0.82, true, sellWindow)
		guiGridListAddColumn(sellGrid, "Название", 0.27)
		guiGridListAddColumn(sellGrid, "Цена", 0.1)
		guiGridListAddColumn(sellGrid, "Количество", 0.1)
		guiGridListAddColumn(sellGrid, "Потребность в поселении", 0.5)
		local id = tonumber(id)
		for i = 1, #goods do
			guiGridListAddRow(sellGrid)
			guiGridListSetItemText(sellGrid, i-1, 1, goods[i][1], false, false)
			guiGridListSetItemText(sellGrid, i-1, 2, tostring(goods[i][3+id]), false, false)
			guiGridListSetItemText(sellGrid, i-1, 4, needing[2], false, false)
			-- if i == 9 or i == 10 or i == 11 or i == 12 or i == 13 then
				-- local ammo = getPedTotalAmmo ( localPlayer, goods[i][3] )
				-- guiGridListSetItemText(sellGrid, i-1, 3, tostring(ammo), false, false)
				-- guiGridListSetItemData ( sellGrid, i-1, 1, { i, id, goods[i][3], goods[i][2] } )
				-- guiGridListSetItemColor ( sellGrid, i-1, 1, 100, 100, 250 )
				-- guiGridListSetItemColor ( sellGrid, i-1, 2, 100, 100, 250 )
				-- guiGridListSetItemColor ( sellGrid, i-1, 3, 100, 100, 250 )
				-- guiGridListSetItemColor ( sellGrid, i-1, 4, 100, 100, 250 )
			-- else
				local wasQuant = exports.inventory:getItemAmount (goods[i][3])
				if wasQuant then
					guiGridListSetItemText(sellGrid, i-1, 3, tostring(wasQuant), false, false)
				else
					guiGridListSetItemText(sellGrid, i-1, 3, "0", false, false)
				end
				guiGridListSetItemData ( sellGrid, i-1, 1, { i, id, goods[i][3] } )
		--end
		end
		addEventHandler("onClientGUIDoubleClick", sellGrid, actionOnSeller,false)
		addEventHandler("onClientGUIClick", sellButton,
				function ()
					actionOnSeller()
				end
		,false)
		addEventHandler("onClientGUIClick", sellExit,
			function ()
				guiSetVisible ( sellWindow, false )
				showCursor ( false )
				visibled = 0
				setElementData ( localPlayer, "invetntoryAllowed", 1 )
			end
		,false)
		showCursor ( true )
		visibled = 1
	end
end

--addCommandHandler ( "4", showsellWindow )

function actionOnSeller ()
	local selectedThings = guiGridListGetSelectedItems ( sellGrid )
	if selectedThings[1] then
		if getElementData ( localPlayer, "sellingNotAvailable" ) then
			return true
		end
		setElementData ( localPlayer, "sellingNotAvailable", true )
		setTimer ( function () setElementData ( localPlayer, "sellingNotAvailable", false ) end, 1500, 1 )
		local thingData = guiGridListGetItemData ( sellGrid, tonumber(selectedThings[1]["row"]), 1 )
		local gridText = guiGridListGetItemText ( sellGrid, tonumber(selectedThings[1]["row"]), 1 )
		if thingData then
			if gridText == goods[thingData[1]][1] then
				if thingData[4] then
					return true
				else
					local slotID = exports.inventory:getItemAmount (thingData[1])
					if slotID then	-- getFreeSlotInventory
						if slotID == 0 then
							exports.pipboy:addInfoBox ("У вас нету данного предмета",1)
							guiGridListSetItemText( sellGrid, tonumber(selectedThings[1]["row"]), 3, "0", false, false )
							return true
						end
					end
					if exports.inventory:removePlayerItem ( thingData[3], 1 ) then
						local itemPrice = goods[thingData[1]][3+thingData[2]]
						if getElementData ( localPlayer, stringName[thingData[2]] ) >= itemPrice then
							triggerServerEvent ( "goodSoldServerC", localPlayer, goods[thingData[1]][1], 1, goods[thingData[1]][3+thingData[2]], thingData[2] )
							triggerServerEvent ( "giveTradersMoneyC", localPlayer, goods[thingData[1]][3+thingData[2]] )
							exports.pipboy:addInfoBox ("Продан предмет "..goods[thingData[1]][1], 1 )	
							setTimer ( function () guiSetText ( sellWindow, "Денег в поселении: "..tostring(getElementData(localPlayer,stringName[thingData[2]])).."$" )end, 800, 1 )
						else
							exports.pipboy:addInfoBox ("В поселении недостаточно денег для покупки, подождите 4 часа", 4)
						end
					else
						exports.pipboy:addInfoBox ("У вас нету данного предмета",1 )
						guiGridListSetItemText( sellGrid, tonumber(selectedThings[1]["row"]), 3, "0", false, false )
					end
					guiGridListSetItemText( sellGrid, tonumber(selectedThings[1]["row"]), 3, exports.inventory:getItemAmount (thingData[3]), false, false )
				end
			end
		else
			outputChatBox ("Ошибка! Как можно скорее сообщите администратору код: B1aaaa", 255,255,127 )
		end
	end
end
