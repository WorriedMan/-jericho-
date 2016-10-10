local visibled = 0
local interPlayerID = nil
local localPlayerWeapons = nil
local findAllowed = 1
local interWindow
local playerIdEdit
local weaponGrid
local doingPlayerWindow

function createInteractionWindow ()
	if getElementData ( localPlayer, "online" ) == 1 then
		if visibled == 0 then
			exports.inventory:closeInventoryWindow()
			setElementData ( localPlayer, "inventoryAllowed", 0 )
			interWindow = guiCreateWindow(0.39, 0.39, 0.25, 0.21, "Взаимодействие", true)
			guiWindowSetSizable(interWindow, false)

			local playerInfoLabel = guiCreateLabel(0.09, 0.14, 0.84, 0.31, "Введите ID игрока, с которым хотите взаимодействовать. ID можно посмотреть, нажав кнопку TAB.", true, interWindow)
			guiSetFont(playerInfoLabel, "default-bold-small")
			guiLabelSetHorizontalAlign(playerInfoLabel, "center", true)
			playerIdEdit = guiCreateEdit(0.10, 0.51, 0.20, 0.21, "", true, interWindow)
			local findPlayerBtn = guiCreateButton(0.32, 0.53, 0.57, 0.19, "Поиск", true, interWindow)
			guiSetProperty(findPlayerBtn, "NormalTextColour", "FFAAAAAA")
			local closePlayerFindBtn = guiCreateButton(0.28, 0.77, 0.45, 0.18, "Закрыть", true, interWindow)
			guiSetProperty(closePlayerFindBtn, "NormalTextColour", "FFAAAAAA")
			guiSetVisible ( interWindow, true )
			showCursor ( true )
			visibled = 1
			addEventHandler("onClientGUIChanged", playerIdEdit, function(element) 
				guiSetText ( playerIdEdit, string.gsub (guiGetText( playerIdEdit ), "%a", "") )
			end)
			
			addEventHandler ( "onClientGUIClick", closePlayerFindBtn, function () unShowInteract() end )
			
			addEventHandler ( "onClientGUIClick", findPlayerBtn, function ()
																	if findAllowed == 1 then
																		findInteractionPlayer()
																		findAllowed = 0 
																		setTimer ( function() findAllowed = 1 end, 5000, 1 )
																	else
																		outputChatBox ( "Подождите пару секунд" )
																	end
																end, false )
		else
			unShowInteract ()
		end
	end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),
    function ( startedRes )
		bindKey ( "Q", "down", "interactplayer" )
    end
);

addCommandHandler ( "interactplayer", createInteractionWindow )

function findInteractionPlayer ()
	local playerTextID = guiGetText ( playerIdEdit )
	if playerTextID then
		if playerTextID ~= "" then
			numbPlayerID = tonumber ( playerTextID )
			if numbPlayerID > 0 then -- todo сделать проверку на свой ID
				local playersTable = getElementsByType ( "player", getRootElement(), true )
				if #playersTable > 0 then
					local playerOnline = 0
					for i,player in ipairs (playersTable) do
						if getElementData ( player, "playerid" ) == tonumber(playerTextID) then
							playerOnline = 1
							local x, y, z = getElementPosition ( localPlayer )
							local x2, y2, z2 = getElementPosition ( player )
							if getDistanceBetweenPoints3D ( x, y, z, x2, y2, z2 ) < 5 then
								showDoingPlayerWindow ( player )
								interPlayerID = tonumber(playerTextID)
							else
								outputChatBox ("Игрок должен быть ближе 5 метров.", 255,255,127 )
							end
							break
						end
					end
					if playerOnline == 0 then
						outputChatBox ("Игрок не найден.", 255,255,127 )
					end
				else
					outputChatBox ("Поблизости нет игроков", 255,255,127 )
				end
			end
		end
	end
end

function showDoingPlayerWindow ( player )
	
	doingPlayerWindow = guiCreateWindow(0.39, 0.31, 0.22, 0.48, "Действия с игроком "..getPlayerName ( player ), true)
	guiWindowSetSizable(doingPlayerWindow, false)
	guiSetAlpha(doingPlayerWindow, 1.00)
	
	local playerCreateGroupBtn = guiCreateButton(0.07, 0.10, 0.86, 0.13, "Пригласить в группу", true, doingPlayerWindow)
	guiSetProperty(playerCreateGroupBtn, "NormalTextColour", "FFAAAAAA")
	local playerGiveItemBtn = guiCreateButton(0.07, 0.26, 0.86, 0.13, "Передать вещь", true, doingPlayerWindow)
	guiSetProperty(playerGiveItemBtn, "NormalTextColour", "FFAAAAAA")
	--givePlayerWeaponBtn = guiCreateButton(0.07, 0.42, 0.86, 0.13, "Передать оружие", true, doingPlayerWindow)
	--guiSetProperty(givePlayerWeaponBtn, "NormalTextColour", "FFAAAAAA")
	local givePlayerMoneyBtn = guiCreateButton(0.07, 0.59, 0.86, 0.13, "Передать крышки", true, doingPlayerWindow)
	guiSetProperty(givePlayerMoneyBtn, "NormalTextColour", "FFAAAAAA")
	local closePlayerWindowBtn = guiCreateButton(0.07, 0.81, 0.84, 0.11, "Закрыть", true, doingPlayerWindow)
	guiSetFont(closePlayerWindowBtn, "default-bold-small")
	guiSetProperty(closePlayerWindowBtn, "NormalTextColour", "FFAAAAAA")
	guiSetVisible ( interWindow, false )
	guiSetVisible ( doingPlayerWindow, true )
	if not getElementData ( localPlayer, "gang" ) or getElementData ( player, "gang" ) then
		guiSetEnabled ( playerCreateGroupBtn, false )
	end
	
	addEventHandler("onClientGUIClick", playerCreateGroupBtn, function(element) 
		triggerServerEvent ( "sendPlayerInvite", localPlayer, getPlayerName(player) )
		guiSetEnabled ( playerCreateGroupBtn, false )
	end, false)
	addEventHandler("onClientGUIClick", doingPlayerWindow, function () cancelEvent() end, false)
	addEventHandler("onClientGUIClick", playerGiveItemBtn, function ()
																if getElementData ( localPlayer, "rplvl" ) > 2 then
																	createGiveItemWindow ()
																else
																	outputChatBox ( "Вы сможете передавать вещи только с 3-го уровня", 140,140,140 )
																end
															end, false)
	-- addEventHandler("onClientGUIClick", givePlayerWeaponBtn, function()
																	-- if getElementData ( player, "inarena" ) == 0 and getElementData ( player, "indmzone" ) == 0 and getElementData ( localPlayer, "inarena" ) == 0 then
																		-- if getElementData ( localPlayer, "rplvl" ) > 4 then
																			-- createGiveWeaponWindow()
																		-- else
																			-- outputChatBox ( "Вы сможете передовать оружие только с 5-го уровня", 140,140,140 )
																		-- end
																	-- else
																		-- outputChatBox ( "Этому игроку в данный момент нельзя передать оружие", 140,140,140 )
																	-- end
															 -- end, false)
	addEventHandler("onClientGUIClick", givePlayerMoneyBtn, function ()
																if getElementData ( localPlayer, "rplvl" ) > 4 then
																	createGiveMoneyWindow ()
																else
																	outputChatBox ( "Вы сможете передовать деньги только с 5-го уровня", 140,140,140 )
																end
															end, false)
	addEventHandler("onClientGUIClick", closePlayerWindowBtn, function () unShowInteract() end, false)
end

function unShowInteract ()
	if isElement(interWindow) then destroyElement ( interWindow ) end
	if isElement(doingPlayerWindow) then destroyElement ( doingPlayerWindow ) end
	if isElement(giveItemWindow) then destroyElement ( giveItemWindow ) end
	if isElement(giveWeaponWindow) then destroyElement ( giveWeaponWindow ) end
	if isElement(ammoSellWindow) then destroyElement ( ammoSellWindow ) end
	if isElement(giveMoneyWindow) then destroyElement ( giveMoneyWindow ) end		
	showCursor ( false )
	visibled = 0
	interPlayerID = nil
	setElementData ( localPlayer, "inventoryAllowed", 1 )
end

function createGiveItemWindow ()
		giveItemWindow = guiCreateWindow(0.36, 0.25, 0.22, 0.48, "Передать вещь", true)
		guiWindowSetSizable(giveItemWindow, false)
		guiSetAlpha(giveItemWindow, 1.00)

		giveItemGrid = guiCreateGridList(0.04, 0.08, 0.93, 0.78, true, giveItemWindow)
		guiGridListAddColumn(giveItemGrid, "Вещь", 0.6)
		guiGridListAddColumn(giveItemGrid, "Кол-во", 0.2)
		chsGiveItem = guiCreateButton(0.03, 0.88, 0.47, 0.09, "Выбрать", true, giveItemWindow)
		guiSetProperty(chsGiveItem, "NormalTextColour", "FFAAAAAA")
		closeGiveBtn = guiCreateButton(0.50, 0.88, 0.47, 0.09, "Закрыть", true, giveItemWindow)
		guiSetProperty(closeGiveBtn, "NormalTextColour", "FFAAAAAA")
		guiSetEnabled ( doingPlayerWindow, false )
		guiSetVisible ( giveItemWindow, true )
		local itemsTable = exports.inventory:getItemsLargeNull()
		if itemsTable then
			if #itemsTable > 0 then
				for i=1, #itemsTable do
					local addedRow = guiGridListAddRow ( giveItemGrid )
					guiGridListSetItemText(giveItemGrid, addedRow, 1, itemsTable[i][3], false, false)
					guiGridListSetItemText(giveItemGrid, addedRow, 2, itemsTable[i][2], false, false)
					guiGridListSetItemData ( giveItemGrid, addedRow, 1, { itemsTable[i][1], itemsTable[i][2], addedRow, itemsTable[i][4], itemsTable[i][5] } )
				end
			end
		end
		addEventHandler("onClientGUIDoubleClick", giveItemGrid, givePlayerItemChoosen,false)
		addEventHandler("onClientGUIClick", chsGiveItem,givePlayerItemChoosen,false)
		addEventHandler("onClientGUIClick", closeGiveBtn,function ()
															guiSetVisible ( giveItemWindow, false )
															guiSetEnabled ( doingPlayerWindow, true )
														 end,false)
end

function givePlayerItemChoosen ()
	local selectedItems = guiGridListGetSelectedItems ( giveItemGrid )
	if selectedItems[1] then
		local itemData = guiGridListGetItemData ( giveItemGrid, tonumber(selectedItems[1]["row"]), 1 )
		if itemData[2] > 0 then
			triggerServerEvent ( "givePlayerItemClient", localPlayer, interPlayerID, itemData[1], itemData[2], itemData[3], itemData[4], itemData[5] )
		end
	end
end

function createGiveWeaponWindow ()
	giveWeaponWindow = guiCreateWindow(0.38, 0.24, 0.21, 0.47, "", true)
	guiWindowSetSizable(giveWeaponWindow, false)
	guiSetAlpha(giveWeaponWindow, 1.00)

	weaponGrid = guiCreateGridList(0.03, 0.07, 0.93, 0.79, true, giveWeaponWindow)
	guiGridListAddColumn(weaponGrid, "Оружие", 0.4)
	guiGridListAddColumn(weaponGrid, "Патроны", 0.4)
	giveWeaponBtn = guiCreateButton(0.04, 0.88, 0.39, 0.10, "Передать", true, giveWeaponWindow)
	guiSetProperty(giveWeaponBtn, "NormalTextColour", "FFAAAAAA")
	closeWeaponBtn = guiCreateButton(0.53, 0.87, 0.39, 0.10, "Заркыть", true, giveWeaponWindow)
	guiSetProperty(closeWeaponBtn, "NormalTextColour", "FFAAAAAA")
	guiSetEnabled ( doingPlayerWindow, false )
	guiSetVisible ( giveWeaponWindow, true )
	--localPlayerWeapons = {}
	for i = 1, 10 do
		local tmpAmmo = getPedTotalAmmo ( localPlayer, i )
		local tmpWeap = getPedWeapon ( localPlayer, i )
		--table.insert ( localPlayerWeapons, { tmpWeap, tmpAmmo } )
		if tmpAmmo > 0 then
			local addedRow = guiGridListAddRow ( weaponGrid )
			guiGridListSetItemText(weaponGrid, addedRow, 1, weaponNames[tmpWeap], false, false)
			guiGridListSetItemText(weaponGrid, addedRow, 2, tmpAmmo, false, false)
			guiGridListSetItemData ( weaponGrid, addedRow, 1, { tmpWeap, tmpAmmo, addedRow, i } )
		end
	end
	addEventHandler("onClientGUIDoubleClick", weaponGrid, givePlayerWeaponChoosen,false)
	addEventHandler("onClientGUIClick", giveWeaponBtn,givePlayerWeaponChoosen,false)
	addEventHandler("onClientGUIClick", closeWeaponBtn,function ()
															guiSetEnabled ( doingPlayerWindow, true )
															guiSetVisible ( giveWeaponWindow, false )
													   end,false)
end

function givePlayerWeaponChoosen ()
	local selectedItems = guiGridListGetSelectedItems ( weaponGrid )
	if selectedItems[1] then
		local itemData = guiGridListGetItemData ( weaponGrid, tonumber(selectedItems[1]["row"]), 1 )
		if itemData[1] ~= 38 then
			if itemData[2] > 0 then
				ammoSellWindow = guiCreateWindow(0.46, 0.38, 0.13, 0.28,"", true)
				guiWindowSetSizable(ammoSellWindow, false)
				ammoLabel = guiCreateLabel(0.23, 0.12, 0.60, 0.07, "У вас есть: "..tostring(itemData[2]), true, ammoSellWindow)
				ammoEdit = guiCreateEdit(0.32, 0.46, 0.43, 0.12, "", true, ammoSellWindow)
				guiEditSetMaxLength(ammoEdit, 4)
				ammountLabel = guiCreateLabel(0.32, 0.35, 0.66, 0.07, "Количество:", true, ammoSellWindow)
				sellAmmoBtn = guiCreateButton(0.25, 0.62, 0.53, 0.13, "Передать", true, ammoSellWindow)
				guiSetProperty(sellAmmoBtn, "NormalTextColour", "FFAAAAAA")
				noAmmoBtn = guiCreateButton(0.25, 0.80, 0.53, 0.13, "Отмена", true, ammoSellWindow)
				guiSetProperty(noAmmoBtn, "NormalTextColour", "FFAAAAAA")
				guiSetEnabled ( giveWeaponWindow, false )
		
				addEventHandler("onClientGUIChanged", ammoEdit, function(element) 
					guiSetText ( ammoEdit, string.gsub (guiGetText( ammoEdit ), "%a", "") )
				end)
				
				addEventHandler("onClientGUIClick", sellAmmoBtn, function(element) 
					local sellAmount = guiGetText ( ammoEdit, string.gsub (guiGetText( ammoEdit ), "%a", "") )
					if sellAmount ~= "" then
						if tonumber(sellAmount) > 0 then
							if itemData[2] >= tonumber(sellAmount) then
								destroyElement ( ammoSellWindow )
								guiSetEnabled ( giveWeaponWindow, true )
								triggerServerEvent ( "givePlayerWeaponClient", localPlayer, interPlayerID, itemData[1], itemData[2], itemData[3], itemData[4], tonumber(sellAmount) )
							else
								outputChatBox ( "У вас нет столько патрон" )
							end
						else
							destroyElement ( ammoSellWindow )
							guiSetEnabled ( giveWeaponWindow, true )
						end
					end
				end)
				
				addEventHandler("onClientGUIClick", noAmmoBtn, function(element) 
					destroyElement ( ammoSellWindow )
					guiSetEnabled ( giveWeaponWindow, true )
				end)
			end
		end
	end
end

function createGiveMoneyWindow ()
	giveMoneyWindow = guiCreateWindow(0.46, 0.38, 0.13, 0.28,"", true)
	guiWindowSetSizable(giveMoneyWindow, false)
	moneyLabel = guiCreateLabel(0.23, 0.12, 0.60, 0.07, "У вас есть: "..tostring(exports.inventory:getPlayerCaps()).." крышек", true, giveMoneyWindow)
	moneyEdit = guiCreateEdit(0.32, 0.46, 0.43, 0.12, "", true, giveMoneyWindow)
	guiEditSetMaxLength(moneyEdit, 8)
	moneyLabel = guiCreateLabel(0.32, 0.35, 0.66, 0.07, "Сумма:", true, giveMoneyWindow)
	giveMoneyBtn = guiCreateButton(0.25, 0.62, 0.53, 0.13, "Передать", true, giveMoneyWindow)
	guiSetProperty(giveMoneyBtn, "NormalTextColour", "FFAAAAAA")
	noMoneyBtn = guiCreateButton(0.25, 0.80, 0.53, 0.13, "Отмена", true, giveMoneyWindow)
	guiSetProperty(noMoneyBtn, "NormalTextColour", "FFAAAAAA")
	guiSetVisible ( giveMoneyWindow, true )
	guiSetEnabled ( doingPlayerWindow, false )
	
	addEventHandler("onClientGUIChanged", moneyEdit, function(element) 
		guiSetText ( moneyEdit, string.gsub (guiGetText( moneyEdit ), "%a", "") )
	end)
	
	addEventHandler("onClientGUIClick", giveMoneyBtn, function(element) 
		local moneyAmount = guiGetText ( moneyEdit, string.gsub (guiGetText( moneyEdit ), "%a", "") )
		if moneyAmount ~= "" then
			if tonumber(moneyAmount) > 0 then
		if exports.inventory:getPlayerCaps() >= tonumber(moneyAmount) then
			destroyElement ( giveMoneyWindow )
			guiSetEnabled ( doingPlayerWindow, true )
			triggerServerEvent ( "givePlayerMoneyClient", localPlayer, interPlayerID, tonumber(moneyAmount) )
		else
			outputChatBox ( "У вас нет столько денег" )
		end
			else
			destroyElement ( giveMoneyWindow )
			guiSetEnabled ( doingPlayerWindow, true )
			end
		end
	end)
	
	addEventHandler("onClientGUIClick", noMoneyBtn, function(element) 
		destroyElement ( giveMoneyWindow )
		guiSetEnabled ( doingPlayerWindow, true )
	end)
end

function recieveSmthClient ( id, playerName )
	if id == 1 then
		outputChatBox ( playerName.." передал вам вещь", 140,140,140 )
	end
end

addEvent( "recieveSmthServer", true )
addEventHandler( "recieveSmthServer", getRootElement(), recieveSmthClient )

function sendSmthClientDone ( id, playerName, rowID, amount, itemid, maxItems )
	if id == 1 then
		outputChatBox ( "Вы успешно передали вещь игроку "..playerName, 140,140,140 )
		guiGridListSetItemText(giveItemGrid, rowID, 2, amount, false, false)
		guiGridListSetItemData ( giveItemGrid, rowID, 1, { itemid, amount, rowID } )
	elseif id == 2 then
		outputChatBox ( "Вы успешно передали патроны игроку "..playerName, 140,140,140 )
		guiGridListSetItemText( weaponGrid, rowID, 2, amount, false, false )
		guiGridListSetItemData ( weaponGrid, rowID, 1, { itemid, amount, rowID, maxItems } )
	end
end

addEvent( "sendSmthServerDone", true )
addEventHandler( "sendSmthServerDone", getRootElement(), sendSmthClientDone )