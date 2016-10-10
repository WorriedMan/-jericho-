local sW, sH = guiGetScreenSize()
local currentTraderID
local selectedItem

local tradeWindow
local tradeGrid

local moneyLabel
local myWeightLabel
local discountsButton

local buyButton

local priceLabel
local weightLabel
local descriptionLabel

function showTraderWindow(trader_id)
	if not isElement(tradeWindow) then
		if not traders[trader_id] then return end
		currentTraderID = trader_id
		tradeWindow = guiCreateWindow(sW/2-238, sH/2-160, 476, 320, traders[trader_id].name, false)
		guiWindowSetSizable(tradeWindow, false)
		local wei = getElementData ( localPlayer, "invWeight" )
		local mWei = getElementData ( localPlayer, "maxWeight" )
		
		tradeGrid = guiCreateGridList(9, 24, 187, 251, false, tradeWindow)
		guiGridListAddColumn( tradeGrid, "Товар", 0.85 )
		
		moneyLabel = guiCreateLabel(206, 24, 249, 20, "Крышек в инвентаре: "..exports.inventory:getPlayerCaps(), false, tradeWindow)
		myWeightLabel = guiCreateLabel(206, 48, 249, 20, "Вес инвентаря: "..wei.."/"..mWei.." кг.", false, tradeWindow)
		discountsButton = guiCreateButton(205, 72, 167, 25, "Проверить мои скидки", false, tradeWindow)
		
		for i, v in pairs (tradeItems) do
			if v.prices[currentTraderID] then
				local row = guiGridListAddRow(tradeGrid)
				guiGridListSetItemText(tradeGrid, row, 1, i, false, false)
			end
		end
		showCursor(true)
		priceLabel = guiCreateLabel(205, 107, 249, 20, "Цена:", false, tradeWindow)
		weightLabel = guiCreateLabel(205, 133, 249, 20, "Вес:", false, tradeWindow)
		descriptionLabel = guiCreateLabel(205, 159, 249, 116, "Описание:", false, tradeWindow)
		guiLabelSetHorizontalAlign ( descriptionLabel, "left", true )
		buyButton = guiCreateButton(9, 279, 227, 31, "Купить", false, tradeWindow)
		local closeButton = guiCreateButton(239, 279, 227, 31, "Закрыть", false, tradeWindow)    
		addEventHandler("onClientGUIClick", closeButton, function() if source == closeButton then hideTraderWindow() end end )
		addEventHandler("onClientGUIClick", buyButton, buyButtonClicked )
		addEventHandler("onClientGUIClick", discountsButton, showDiscountsWindow )
		addEventHandler("onClientGUIClick", tradeGrid, refreshLabel )
	end
end

function refreshLabel()
--	if source and source ~= tradeGrid then return end
	local wei = getElementData ( localPlayer, "invWeight" )
	local mWei = getElementData ( localPlayer, "maxWeight" )
	guiSetText(moneyLabel,"Крышек в инвентаре: "..exports.inventory:getPlayerCaps())
	guiSetText(myWeightLabel,"Вес инвентаря: "..wei.."/"..mWei.." кг.")
	
	local row = guiGridListGetSelectedItem ( tradeGrid )
	if row and row ~= -1 then
		local name = guiGridListGetItemText ( tradeGrid, row, 1 )
		if tradeItems[name] and tradeItems[name].prices[currentTraderID] then
			selectedItem = name
			local discount = calculateDiscount(currentTraderID,name)
			guiSetText(priceLabel,"Цена: "..(tradeItems[name].prices[currentTraderID])*(1-discount/100).." КР (скидка "..discount.."%).")
			guiSetText(weightLabel,"Вес: "..tradeItems[name].weight.." кг.")
			guiSetText(descriptionLabel,"Описание: "..tradeItems[name].d)
		end
	end
end

function buyButtonClicked ()
	if source == buyButton then
		if selectedItem then
			triggerServerEvent("trade_new:attemptToBuyItem",localPlayer,currentTraderID,selectedItem,calculateDiscount(currentTraderID,selectedItem))
			guiSetEnabled(buyButton,false)
		end
	end
end

local discountsWindow
local discountsGrid

function showDiscountsWindow()
	if source ~= discountsButton then return end
	if not isElement (discountsWindow) and selectedItem and isElement(tradeWindow) then
		guiSetEnabled(tradeWindow,false)
		local discounts = getAllDiscounts(currentTraderID,selectedItem)
		discountsWindow = guiCreateWindow(sW/2-250, sH/2-192, 500, 284, "Ваши скидки у данного торговца", false)
        guiWindowSetSizable(discountsWindow, false)
		discountsGrid = guiCreateGridList(10, 21, 480, 211, false, discountsWindow)
		guiGridListAddColumn( discountsGrid, "Название", 0.65 )
		guiGridListAddColumn( discountsGrid, "Скидка", 0.2 )
		for i, v in pairs (discounts) do
			local row = guiGridListAddRow(discountsGrid)
			guiGridListSetItemText(discountsGrid, row, 1, i, false, false)
			guiGridListSetItemText(discountsGrid, row, 2, v.size.."%", false, false)
		end
		local closeBtn = guiCreateButton(10, 242, 188, 30, "Закрыть", false, discountsWindow)  
		addEventHandler("onClientGUIClick", closeBtn, function() if source == closeBtn then guiSetEnabled(tradeWindow,true) destroyElement(discountsWindow) end end )		
	end	
end

function hideTraderWindow()
	if isElement (discountsWindow) then destroyElement(discountsWindow) end 
	if isElement (tradeWindow) then
		destroyElement(tradeWindow) 
		showCursor(false)
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), hideTraderWindow )

function purchaseCompleted ()
	if isElement(tradeWindow) then
		guiSetEnabled(buyButton,true)
		refreshLabel()
	end
end

addEvent("trade_new:purchaseCompleted",true)
addEventHandler("trade_new:purchaseCompleted",root,purchaseCompleted)


addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),
    function ( startedRes )
		foodpickupNC = createPickup ( -946.1884765625,1911.6748046875,5, 3, 1274 )
		setElementInterior ( foodpickupNC, 17 )
		foodtextNC = exports.dtext:create3DText ( -946.1884765625,1911.6748046875,6, "Купить продукты", 255, 255, 255, 255, "nc" )
		setElementInterior ( foodtextNC, 17 )
		setElementData ( foodpickupNC, "trade-pickup", "nc_food" )
		
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