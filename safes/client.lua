local itemsTableTMP = nil
local bagType = 1
admin = false

function showSafeMenu ( lootTable, isAdmin )
	--outputChatBox ("1 "..tostring(isElement(bagWindow))) 
	if not isElement ( bagWindow ) then
		itemsTableTMP = lootTable
	--	outputChatBox ("2 "..tostring(lootTable))
		showCursor ( true )
		bagWindow = guiCreateWindow(0.44, 0.40, 0.16, 0.23, "Мистер Хранитель-П", true)
		guiWindowSetSizable(bagWindow, false)
		guiSetAlpha(bagWindow, 1.00)
		admin = isAdmin
		openBag = guiCreateButton(0.07, 0.16, 0.86, 0.22, "Открыть сейф", true, bagWindow)
		guiSetProperty(openBag, "NormalTextColour", "FFAAAAAA")
		takeBag = guiCreateButton(0.07, 0.40, 0.86, 0.22, "Убрать сейф", true, bagWindow)
		guiSetProperty(takeBag, "NormalTextColour", "FFAAAAAA")
		closeBag = guiCreateButton(0.07, 0.70, 0.86, 0.22, "Закрыть", true, bagWindow)
		guiSetProperty(closeBag, "NormalTextColour", "FFAAAAAA")
		guiSetVisible ( bagWindow, true )
		
		addEventHandler ( "onClientGUIClick", openBag, openSafeClicked, false )
		addEventHandler ( "onClientGUIClick", takeBag, takeSafeClicked, false )
		addEventHandler ( "onClientGUIClick", closeBag, function () 
															itemsTableTMP = nil
															destroyElement ( bagWindow )
															showCursor ( false )
															triggerServerEvent ( "cancelUsingSafeC", localPlayer )
														end, false )
	end
end

addEvent( "showSafeMenuS", true )
addEventHandler( "showSafeMenuS", getRootElement(), showSafeMenu )

function openSafeClicked ()
	destroyElement ( bagWindow )
	showCursor ( false )
	--exports.pipboy:initBarter ( itemsTableTMP )
	askPasswordWindowC (3,"Введите пароль от этого сейфа",itemsTableTMP)
	itemsTableTMP = nil	
end

function takeSafeClicked ()
	if not admin and #itemsTableTMP > 0 then
		exports.pipboy:addInfoBox ( 'Сначала заберите из сейфа все вещи', 2 )
	else
		askPasswordWindowC (2,"Сложить ваш сейф")
		destroyElement ( bagWindow )
		itemsTableTMP = nil	
		exports.quests:unShowActLabel()
	end
end