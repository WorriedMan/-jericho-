local screenWidth,screenHeight = guiGetScreenSize()
local color = tocolor ( 255, 182, 66 )

sOff = 0
hOff = 0
glowItem = 0
glowL = false
selArrow = 0
bItemSel = 0
closeSel = false
barterShow = false
bagType = 0
banditLoot = false
banditLootSphere = false

local def_font = { 1.2, "default-bold" }
local new_font = dxCreateFont ( "arial.ttf", 10 )
if new_font then
	def_font = { 1, new_font }
end

local xBart = screenWidth/2-350
local yBart = screenHeight/2-240
local bagWeight = 0
local selectedSelfItem
local selectedHisItem

barterElements = {}

function renderBarterMenu ( )
	--local x, y = xBart+200, yBart+30
	local x, y = xBart+175, yBart+30
	local num = 1
	local total = 0
	dxDrawRectangle ( xBart, yBart, 700, 480, tocolor ( 0, 10, 0, 180 ) )
	tx, ty = xBart+30, yBart+50
	local selectedSelfItemFound = false
	for i = 1+sOff, 7+sOff do
		if i <= #sInv then
			if ty > yBart+15 then
				local itString = nil
				if sInv[i][2] > 1 then
					itString = things[sInv[i][1]][2].." ("..sInv[i][2]..")"
				else
					itString = things[sInv[i][1]][2]
				end
				dxDrawText ( itString, tx, ty, screenWidth, yBart+335, tocolor ( 255, 182, 66 ), def_font[1], def_font[2], "left", "top", true )
			end
			if isCursorInPosition(tx-5,ty-5,185,30) then
				selectedSelfItemFound = true
				selectedSelfItem = i-sOff
				bItemSel = sInv[i][1]
				dxDrawRectangle ( tx-5, ty-5, 185, 30, tocolor ( 255, 182, 66, 30 ) )
				dxDrawLine ( tx-5, ty-5, tx+180, ty-5, tocolor ( 255, 182, 66 ), 1.3 )
				dxDrawLine ( tx-5, ty-5, tx-5, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
				dxDrawLine ( tx+180, ty-5, tx+180, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
				dxDrawLine ( tx-5, ty+25, tx+180, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
				if sInv[i][5] then
					dxDrawLine ( xBart+355, yBart+350, xBart+490, yBart+350, tocolor ( 255, 182, 66 ), 1.5 )
					dxDrawLine ( xBart+490, yBart+350, xBart+490, yBart+385, tocolor ( 255, 182, 66 ), 1.5 )
					dxDrawText ( 'ССТ '..tostring(math.floor(sInv[i][5])).."%", xBart+360, yBart+350, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top" )
				end
			end
			ty = ty + 40
		end
	end
	if not selectedSelfItemFound then
		if selectedSelfItem then
			selectedSelfItem = nil
			bItemSel = 0
		end
	end
	tx, ty = xBart+430, yBart+50
	local selectedHisItemFound = false
	for i = 1+hOff, 7+hOff do
		if i <= #hInv then
			if ty > yBart+15 then
				local itString = nil
				if hInv[i][2] > 1 then
					itString = things[hInv[i][1]][2].." ("..hInv[i][2]..")"
				else
					itString = things[hInv[i][1]][2]
				end
				dxDrawText ( itString, xBart+430, ty, screenWidth, yBart+335, tocolor ( 255, 182, 66 ), def_font[1], def_font[2], "left", "top", true )
			end
			if isCursorInPosition(tx-5,ty-5,185,30) then
				selectedHisItemFound = true
				selectedHisItem = i-hOff
				bItemSel = hInv[i][1]
				dxDrawRectangle ( tx-5, ty-5, 185, 30, tocolor ( 255, 182, 66, 30 ) )
				dxDrawLine ( tx-5, ty-5, tx+180, ty-5, tocolor ( 255, 182, 66 ), 1.3 )
				dxDrawLine ( tx-5, ty-5, tx-5, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
				dxDrawLine ( tx+180, ty-5, tx+180, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
				dxDrawLine ( tx-5, ty+25, tx+180, ty+25, tocolor ( 255, 182, 66 ), 1.3 )
				if hInv[i][3] then
					dxDrawLine ( xBart+355, yBart+350, xBart+490, yBart+350, tocolor ( 255, 182, 66 ), 1.5 )
					dxDrawLine ( xBart+490, yBart+350, xBart+490, yBart+385, tocolor ( 255, 182, 66 ), 1.5 )
					dxDrawText ( 'ССТ '..tostring(math.floor(hInv[i][3]))..'%', xBart+360, yBart+350, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top" )
				end
			end
			ty = ty +40
		end
	end
	if not selectedHisItemFound then
		if selectedHisItem then
			selectedHisItem = nil
			bItemSel = 0
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
	local textLabel = 'Ящик'
	if bagType > 0 then
		textLabel = 'Сумка'
	end
	if banditLoot then
		textLabel = 'Тело'
	end
	dxDrawText ( textLabel, xBart+430, yBart+5, screenWidth, yBart+50, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
	dxDrawLine ( xBart+500, yBart+15, xBart+670, yBart+15, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+670, yBart+15, xBart+670, yBart+50, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+415, yBart+15, xBart+415, yBart+50, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+415, yBart+335, xBart+415, yBart+300, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+415, yBart+335, xBart+670, yBart+335, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+670, yBart+335, xBart+670, yBart+300, tocolor ( 255, 182, 66 ), 1.5 )
	
	dxDrawLine ( xBart+15, yBart+435, xBart+15, yBart+470, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+15, yBart+470, xBart+670, yBart+470, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+670, yBart+435, xBart+670, yBart+470, tocolor ( 255, 182, 66 ), 1.5 )
	
	dxDrawLine ( xBart+630, yBart+350, xBart+500, yBart+350, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+630, yBart+350, xBart+630, yBart+385, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawText ( 'ВЕС', xBart+505, yBart+350, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top" )
	
	
	dxDrawLine ( xBart+630, yBart+400, xBart+200, yBart+400, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+630, yBart+400, xBart+630, yBart+435, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawText ( 'ЭФФ.', xBart+205, yBart+400, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top" )
	dxDrawText ( 'Закрыть', xBart+290, yBart+300, screenWidth, yBart+350, tocolor ( 255, 182, 66 ), 2, "default-bold", "left", "top", true )
	if bagType > 0 then
		dxDrawText ( 'Вес вещей: '..string.sub(tostring(bagWeight),1,3)..' кг', xBart+570, yBart+25, screenWidth, yBart+50, tocolor ( 255, 182, 66 ), 1, "default-bold", "left", "top", true )
	end
	if closeSel then
		dxDrawLine ( xBart+285, yBart+295, xBart+400, yBart+295, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+285, yBart+295, xBart+285, yBart+335, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+400, yBart+295, xBart+400, yBart+335, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+285, yBart+335, xBart+400, yBart+335, tocolor ( 255, 182, 66 ), 1.3 )
	end
	if bItemSel > 0 then
		dxDrawText ( things[bItemSel][3], xBart+205, yBart+405, xBart+625, screenHeight, tocolor ( 255, 182, 66 ), def_font[1], def_font[2], "right", "top" ) -- эффекты
		dxDrawText ( things[bItemSel][4], xBart+625, yBart+350, xBart+625, screenHeight, tocolor ( 255, 182, 66 ), 2, "default-bold", "right", "top" ) -- вес
		dxDrawImage ( xBart+50, yBart+350, 128, 128, things[bItemSel][1], 0, 0, 0, tocolor ( 255, 182, 66 ) )
	end
	drawBarterArrows ()	
	if isCursorInsideMyBarter() then
		dxDrawImage ( xBart+300, yBart+100, 128, 256, t.b_arrow, 0, 0, 0, tocolor ( 255, 182, 66 ) )
	else
		dxDrawImage ( xBart+280, yBart-20, 128, 256, t.b_arrow, 180, 0, 0, tocolor ( 255, 182, 66 ) )
	end
end

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

function initBarterBandit ( loot )
	banditLoot = true
	banditLootSphere = loot
	-- outputChatBox ( tostring ( getElementData ( loot, 'itemsTable' )))
	-- outputChatBox ( tostring ( #getElementData ( loot, 'itemsTable' )))
	initBarter ( getElementData ( loot, 'itemsTable' ) or {}, 0 )
end

function initBarterSafe ( items )
	safeLoot = true
	banditLoot = false
	initBarter ( items, 0 )
end

function initBarter ( box, kind )
	executeCommandHandler ( "showhude", "1" )
	barterShow = true
	sInv = exports.inventory:getItemsLargeNull() -- вес, ид, количество
	--outputDebugString (tostring(box))
	hInv = box
	bagType = kind or 0
	calculateBagWeight ()
	ty = yBart+50
	selectedSelfItem = nil
	selectedHisItem = nil
	closePipBoy()
	setElementData ( localPlayer, "inventoryAllowed", 0 )
	-- for i = 1, 7 do
		-- local createdLabel = guiCreateLabel ( xBart+10, ty-5, 180, 30, "", false )
		-- setElementData ( createdLabel, "barterID", i )
		-- setElementData ( createdLabel, "barterS", true )
		-- addEventHandler ( "onClientGUIClick", createdLabel, barterSelfItemClick, false )
		-- ty = ty+40
		-- table.insert ( barterElements, createdLabel )
	-- end
	-- ty = yBart+50
	-- for i = 1, 7 do
		-- local createdLabel = guiCreateLabel ( xBart+410, ty-5, 180, 30, "", false )
		-- setElementData ( createdLabel, "barterID", i )
		-- addEventHandler ( "onClientGUIClick", createdLabel, barterHisItemClick, false )
		-- ty = ty+40
		-- table.insert ( barterElements, createdLabel )
	-- end
	bindKey ( "mouse1", "down", barterSelfItemClick )
	bindKey ( "mouse1", "down", barterHisItemClick )
	upLeft = guiCreateLabel (  xBart+220, yBart+35, 32, 32, "", false )
	dnLeft = guiCreateLabel (  xBart+220, yBart+285, 32, 32, "", false )
	setElementData ( upLeft, "barterArrowID",1 )
	setElementData ( dnLeft, "barterArrowID",2 )
	setElementData ( upLeft, "barterArrow",true )
	setElementData ( dnLeft, "barterArrow",true )
	upRight = guiCreateLabel ( xBart+620, yBart+35, 32, 32, "", false )
	dnRight = guiCreateLabel (  xBart+620, yBart+285, 32, 32, "", false )
	setElementData ( upRight, "barterArrowID",3 )
	setElementData ( dnRight, "barterArrowID",4 )
	setElementData ( upRight, "barterArrow",true )
	setElementData ( dnRight, "barterArrow",true )
	addEventHandler ( "onClientGUIClick", upLeft, barterArrowClick, false )
	addEventHandler ( "onClientGUIClick", dnLeft, barterArrowClick, false )
	addEventHandler ( "onClientGUIClick", upRight, barterArrowClick, false )
	addEventHandler ( "onClientGUIClick", dnRight, barterArrowClick, false )
	addEventHandler ( "onClientRender", root, renderBarterMenu )
	closeLabel = guiCreateLabel ( xBart+285, yBart+295, 115, 40, "", false )
	addEventHandler ( "onClientGUIClick", closeLabel, closeBarterMenu, false )
	addEventHandler( "onClientMouseEnter", getRootElement(), barterMouseEnter )
	addEventHandler( "onClientMouseLeave", getRootElement(), barterMouseLeave )
	
	bindKey ( "mouse_wheel_up", "down", playerScrollBarter, "up" )
	bindKey ( "mouse_wheel_down", "down", playerScrollBarter, "down" )
	
	showCursor ( true )
end

function playerScrollBarter (key,keyState,arg)
	if ( keyState == "down" ) then
		if arg == "up" then
			if isCursorInsideMyBarter() then
				if sOff > 0 then
					sOff = sOff-1 
				end
			elseif isCursorInsideMyLoot() then
				if hOff > 0 then
					hOff = hOff-1 
				end
			end
		elseif arg == "down" then
			if isCursorInsideMyBarter() then
				if sOff+7 < #sInv then
					sOff = sOff+1 
				end
			elseif isCursorInsideMyLoot() then
				if hOff+7 < #hInv then
					hOff = hOff+1 
				end
			end
		end
	end
end

function isCursorInsideMyBarter()
	return isCursorInPosition ( xBart+15,yBart+15,255,320 )
end

function isCursorInsideMyLoot()
	return isCursorInPosition (	xBart+415, yBart+15,255,320 )
end

function closeBarterMenu ()
	playSound ( "media/sound/ui_pipboy_select.wav" )
	if barterShow and isElement ( upRight ) then
		-- for i = 1, #barterElements do
			-- destroyElement ( barterElements[i] )
			-- barterElements[i] = nil
		-- end
		unbindKey ( "mouse1", "down", barterSelfItemClick )
		unbindKey ( "mouse1", "down", barterHisItemClick )
		removeEventHandler ( "onClientGUIClick", upLeft, barterArrowClick )
		removeEventHandler ( "onClientGUIClick", dnLeft, barterArrowClick )
		removeEventHandler ( "onClientGUIClick", upRight, barterArrowClick )
		removeEventHandler ( "onClientGUIClick", dnRight, barterArrowClick )
		removeEventHandler ( "onClientRender", root, renderBarterMenu )
		removeEventHandler( "onClientMouseEnter", getRootElement(), barterMouseEnter )
		removeEventHandler( "onClientMouseLeave", getRootElement(), barterMouseLeave )
		destroyElement ( upRight )
		destroyElement ( dnRight )
		destroyElement ( upLeft )
		destroyElement ( dnLeft )
		destroyElement ( closeLabel )
		sOff = 0
		hOff = 0
		glowItem = 0
		glowL = false
		selArrow = 0
		bItemSel = 0
		closeSel = false
		setElementData ( localPlayer, "inventoryAllowed", 1 )
		if safeLoot then
			triggerServerEvent ( "cancelUsingSafeC", localPlayer ) 
			safeLoot = false
		elseif banditLoot then
			if isElement ( banditLootSphere ) then
				setElementData ( banditLootSphere, 'seeing', false )
			end
			banditLootSphere = false
		else
			--exports.loot:finishWorkWithLoot ( getElementData ( localPlayer, "workLoot" ) )
			triggerServerEvent ( "finishWorkWithLoot", getLocalPlayer() ) 
			setElementData ( localPlayer, "workBag", false )
			setElementData ( localPlayer, "workLoot", false )
		end
		executeCommandHandler ( "showhude", "0" )
		banditLoot = false
		showCursor ( false )
	end
end

function calculateBagWeight ()
	if bagType > 0 and #hInv > 0 then
		local tempWeight = 0
		for i=1,#hInv do
			tempWeight = tempWeight+things[hInv[i][1]][4]*hInv[i][2]
		end
		bagWeight = tempWeight
	else
		bagWeight = 0	
	end
end

bagWeightMax = {
	30,
	70,
	100,
}

local selfClickTimes = 0
local clicked2secondsAgoSelf = false
local clickedSelfTimer = nil
local prevItemClickedSelf = 0

local moveAvailable = true

function barterSelfItemClick ()
	if getElementData ( localPlayer, "rplvl" ) > 2 then
		if not moveAvailable or not selectedSelfItem then return true end
		moveAvailable = false
		setTimer ( function () moveAvailable = true end, 500, 1 )
		local id = selectedSelfItem
		playSound ( "media/sound/ui_items_generic_down.wav" )
		if #sInv >= id then
			if things[sInv[id+sOff][1]][6] then
				addInfoBox ( "Это квестовый предмет, его не переложить.", 2 )
				return true
			end
			if bagType > 0 then
				if bagWeight+things[sInv[id+sOff][1]][4] > bagWeightMax[bagType] then 
					addInfoBox ( "Сумка переполнена. Выложите некоторые вещи.", 2 )
					return true
				end
			end
			prevItemClickedSelf = sInv[id+sOff][1]
			if not clicked2secondsAgoSelf or prevItemClickedSelf ~= sInv[id+sOff][1] then
				selfClickTimes = 0
			end
			selfClickTimes = selfClickTimes+1
			clicked2secondsAgoSelf = true
			if isTimer ( clickedSelfTimer ) then
				killTimer ( clickedSelfTimer )
			end
			clickedSelfTimer = setTimer ( function () clicked2secondsAgoSelf = false end, 1000, 1 )
			local quant = 1
			if selfClickTimes > 5 then
				quant = ( sInv[id+sOff][2] < 5 and sInv[id+sOff][2] ) or 5
			end
			if selfClickTimes > 10 then
				quant = ( sInv[id+sOff][2] < 10 and sInv[id+sOff][2] ) or 10
			end
			--outputDebugString (" quant "..tostring(quant))
			local itEx = false
			if not things[sInv[id+sOff][1]][7] then 
				for i = 1, #hInv do
					if hInv[i][1] == sInv[id+sOff][1] then
						itEx = true
						hInv[i][2] = hInv[i][2]+quant
						break
					end
				end
			end
			--outputDebugString ( tostring (sInv[id+sOff][5]))
			if not itEx then
				--outputDebugString ('item Not exist '..tostring(sInv[id+sOff][1]) )
				table.insert ( hInv, { sInv[id+sOff][1], quant, sInv[id+sOff][5]  } )		
			end
			exports.inventory:removePlayerItemByPos ( sInv[id+sOff][6], quant )
			exports.inventory:checkPlayerWeight ()
			if sInv[id+sOff][2] == quant then
				table.remove ( sInv, id+sOff )
				if sOff > 0 then
					sOff = sOff-quant
				end
			else
				sInv[id+sOff][2] = sInv[id+sOff][2]-quant
			end
			if safeLoot then
				triggerServerEvent ( "changeSafeTable", localPlayer, hInv ) 
			elseif banditLoot then
				if isElement ( banditLootSphere ) then
					setElementData ( banditLootSphere, 'itemsTable', hInv )
				else
					closeBarterMenu()
				end
			else
				exports.loot:changeLootTable ( getElementData ( localPlayer, "workLoot" ), hInv )
			end
			calculateBagWeight()
		end
	else
		addInfoBox ( 'Вы сможете класть свои вещи в ящик только с 3 уровня', 4 )
	end
end

local hisClickTimes = 0
local clicked2secondsAgoHis = false
local clickedHisTimer = nil
local prevItemClicked = 0

local moveAvailable = true

function barterHisItemClick ()
	if not moveAvailable or not selectedHisItem then return true end
	moveAvailable = false
	setTimer ( function () moveAvailable = true end, 200, 1 )
	local id = selectedHisItem
	if #hInv >= id then
		if not clicked2secondsAgoHis or prevItemClicked ~= hInv[id+hOff][1] then
			hisClickTimes = 0
		end
		prevItemClicked = hInv[id+hOff][1]
		hisClickTimes = hisClickTimes+1
		clicked2secondsAgoHis = true
		if isTimer ( clickedHisTimer ) then
			killTimer ( clickedHisTimer )
		end
		clickedHisTimer = setTimer ( function () clicked2secondsAgoHis = false end, 1000, 1 )
		local quant = 1
		if hisClickTimes > 5 then
			quant = ( hInv[id+hOff][2] < 5 and hInv[id+hOff][2] ) or 5
		end
		if hisClickTimes > 10 then
			quant = ( hInv[id+hOff][2] < 10 and hInv[id+hOff][2] ) or 10
		end
		local itemGived, slot = exports.inventory:givePlayerItem ( hInv[id+hOff][1], quant, false, hInv[id+hOff][3] )
		--local itemGived, slot = exports.inventory:givePlayerItemWW ( hInv[id+hOff][1], quant, false, hInv[id+hOff][3] )
		if itemGived then 
			local itEx = false
			if not things[hInv[id+hOff][1]][7] then 
				for i = 1, #sInv do
					if sInv[i][2] > 0 then
						if sInv[i][1] == hInv[id+hOff][1] then -- тут
							sInv[i][2] = sInv[i][2]+quant
							itEx = true
							break
						end
					end
				end
			end
			if not itEx then
				table.insert ( sInv, { hInv[id+hOff][1], quant, false, false, hInv[id+hOff][3], slot } )		-- тут
			end
			exports.inventory:checkPlayerWeight ()
			if hInv[id+hOff][2] == quant then
				table.remove ( hInv, id+hOff )
			else
				hInv[id+hOff][2] = hInv[id+hOff][2]-quant
			end
			if hOff > 0 then
				hOff = hOff-1
			end
			calculateBagWeight()
			if banditLoot then
				if isElement ( banditLootSphere ) then
					setElementData ( banditLootSphere, 'itemsTable', hInv )
				else
					closeBarterMenu()
				end
			elseif safeLoot then
				triggerServerEvent("changeSafeTable", localPlayer, hInv )
			else
				exports.loot:changeLootTable ( getElementData ( localPlayer, "workLoot" ), hInv )
			end
		end
	end
end

function barterArrowClick ( )
	local arrowID = getElementData ( source, "barterArrowID" )
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

function barterMouseEnter(aX, aY)
	if getElementData ( source, "barterID" ) then
		if getElementData ( source, "barterS" ) then 
			if getElementData ( source, "barterID" )+sOff <= #sInv then 
				playSound ( "media/sound/ui_menu_focus.wav" )
				glowL = true 
				glowItem = getElementData ( source, "barterID" )+sOff
				bItemSel = sInv[glowItem][1]
			end
		else 
			if getElementData ( source, "barterID" )+hOff <= #hInv then 
				playSound ( "media/sound/ui_menu_focus.wav" )
				glowL = false 
				glowItem = getElementData ( source, "barterID" )+hOff
				bItemSel = hInv[glowItem][1]
			end
		end
	elseif getElementData ( source, "barterArrow" ) then
		selArrow = getElementData ( source, "barterArrowID" )
	elseif source == closeLabel then
		playSound ( "media/sound/ui_menu_focus.wav" )
		closeSel = true 
	end
end

function barterMouseLeave(aX, aY)
	if getElementData ( source, "barterID" ) then 
		glowItem = 0
	elseif getElementData ( source, "barterArrow" ) then
		selArrow = 0
	elseif source == closeLabel then
		closeSel = false 
	end
end