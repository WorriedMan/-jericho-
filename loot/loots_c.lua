function initLootBarter ( lootTable )
	exports.pipboy:initBarter ( lootTable, 0 )
end

addEvent( "initLootBarterS", true )
addEventHandler( "initLootBarterS", getRootElement(), initLootBarter )

function initLootBarterBandit ( loot )
	exports.pipboy:initBarterBandit ( loot )
end

addEvent( "initLootBarterBandit", true )
addEventHandler( "initLootBarterBandit", getRootElement(), initLootBarterBandit )

function getPositionLootC ( x, y, shape )
	local pX, pY, pZ = getElementPosition ( localPlayer )
	z = getGroundPosition ( x, y, pZ+500 )
	if z then
		triggerServerEvent ( "spawnLoot", getLocalPlayer(), shape, x,y,z ) 
	end
end
	
addEvent( "getPositionLoot", true )
addEventHandler( "getPositionLoot", getRootElement(), getPositionLootC )

function getPositionFungusC ( x, y, shape )
	local pX, pY, pZ = getElementPosition ( localPlayer )
	z = getGroundPosition ( x, y, pZ+500 )
	if z then
		triggerServerEvent ( "spawnFungus", getLocalPlayer(), shape, x,y,z ) 
	end
end
	
addEvent( "getPositionFungus", true )
addEventHandler( "getPositionFungus", getRootElement(), getPositionFungusC )

local seenLoots = {}

function getLootState ( id )
	if seenLoots[id] then
		return false
	else
		return true
	end
end

function setLootState ( id )
	seenLoots[id] = true
end

function changeLootTable ( lootID, itemTable, finito )
	if getElementData ( localPlayer, "workBag" ) then
		triggerServerEvent ( "changeBagTable", getLocalPlayer(), getElementData ( localPlayer, "workBag" ), itemTable, finito ) 
		--setElementData ( localPlayer, "workBag", false )
	elseif getElementData ( localPlayer, "workLoot" ) then
		--setElementData ( localPlayer, "workLoot", false )
		triggerServerEvent ( "changeLootTableC", getLocalPlayer(), lootID, itemTable, finito ) 
	end
end

local itemsTableTMP = nil
local bagType = 1

function showBagMenu ( lootTable, kind )
	itemsTableTMP = lootTable
	showCursor ( true )
	bagType = kind
	label = 'Сумка'
	if kind == 2 then
		label = 'Средняя сумка'
	elseif kind == 3 then
		label = 'Большая сумка'
	end
	bagWindow = guiCreateWindow(0.44, 0.40, 0.16, 0.23, label, true)
	guiWindowSetSizable(bagWindow, false)
	guiSetAlpha(bagWindow, 1.00)

	openBag = guiCreateButton(0.07, 0.16, 0.86, 0.22, "Открыть сумку", true, bagWindow)
	guiSetProperty(openBag, "NormalTextColour", "FFAAAAAA")
	takeBag = guiCreateButton(0.07, 0.40, 0.86, 0.22, "Взять сумку", true, bagWindow)
	guiSetProperty(takeBag, "NormalTextColour", "FFAAAAAA")
	closeBag = guiCreateButton(0.07, 0.70, 0.86, 0.22, "Закрыть", true, bagWindow)
	guiSetProperty(closeBag, "NormalTextColour", "FFAAAAAA")
	guiSetVisible ( bagWindow, true )
	
	addEventHandler ( "onClientGUIClick", openBag, openBagClicked, false )
	addEventHandler ( "onClientGUIClick", takeBag, takeBagClicked, false )
	addEventHandler ( "onClientGUIClick", closeBag, function () 
														itemsTableTMP = nil
														destroyElement ( bagWindow )
														showCursor ( false )
														triggerServerEvent ( "cancelUsingBoxC", localPlayer )
													end, false )
end

addEvent( "showBagMenuS", true )
addEventHandler( "showBagMenuS", getRootElement(), showBagMenu )

function openBagClicked ()
	destroyElement ( bagWindow )
	showCursor ( false )
	exports.pipboy:initBarter ( itemsTableTMP, bagType )
	itemsTableTMP = nil	
end

function takeBagClicked ()
	if #itemsTableTMP > 0 then
		exports.pipboy:addInfoBox ( 'Сначала заберите из сумки все вещи', 2 )
	else
		triggerServerEvent ( "deleteBagFromClient", localPlayer, bagType )
		destroyElement ( bagWindow )
		showCursor ( false )
		itemsTableTMP = nil	
		exports.quests:unShowActLabel()
	end
end

function createBagPlaceClient (kind)
	if not exports.safezones:getPlayerZoneConfig(localPlayer).noSafes then
		local int = getElementInterior ( localPlayer )
		local dim = getElementDimension ( localPlayer ) 
		triggerServerEvent ( "createBagFromClient", localPlayer, int, dim, kind )
	else
		exports.pipboy:addInfoBox ( 'Вы не можете положить сумку в этом месте', 2 )
	end
end

function checkFungusAnimationC ( fungus )
	block, anim = getPedAnimation( localPlayer )
	if block == "bomber" then
		triggerServerEvent ( "destroyFungusC", localPlayer, fungus )
		exports.inventory:givePlayerItem ( 49, 1 )
		exports.quests:unShowActLabel ()
	else
		triggerServerEvent ( "notComplFungusC", localPlayer, fungus )
	end
end

addEvent( "checkFungusAnimation", true )
addEventHandler( "checkFungusAnimation", getRootElement(), checkFungusAnimationC )


