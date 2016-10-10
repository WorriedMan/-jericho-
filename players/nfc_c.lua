local localPlayer = getLocalPlayer ()

local newNfn = 0

local nfnVisible = 0

local screenX, screenY = guiGetScreenSize ()

function toposition(x,y) 
  local finalX,finalY = x,y 
  if x > 1 then finalX = x 
  elseif x < -1 then finalX = screenX - x 
  elseif x > 0 then finalX = screenX * x 
  else finalX = screenX - (screenX * x) 
  end 
  -- 
  if y > 1 then finalY = y 
  elseif y < -1 then finalY = screenY - y 
  elseif y > 0 then finalY = screenY * y 
  else finalY = screenY - (screenY * y) 
  end 
  return finalX,finalY 
end

function addNewNotification ( types, value1, value2, value3, value4, value5 )
	local row = guiGridListAddRow(notificationsTab)
	if types == 0 then
		guiGridListSetItemText ( notificationsTab, row, 1, value1, false, false )
	elseif types == 1 then -- приглашение в группу
		-- приглашающий, ид группы, тип 0 - создание, 1 - приглашение
		guiGridListSetItemText ( notificationsTab, row, 1, value1 .. " приглашает тебя к себе в группу", false, false )
		exports.pipboy:addInfoBox(value1.." пригласил вас к себе в группу", 3 )
	elseif types == 2 then -- приглашение в группу
		guiGridListSetItemText ( notificationsTab, row, 1, "Дважды нажмите, для выбора новой способности", false, false )
		exports.pipboy:addInfoBox("Вам доступен выбор способности в панели уведомелния.", 2 )
	elseif types == 3 then -- выбор статы
		guiGridListSetItemText ( notificationsTab, row, 1, "Дважды нажмите, для повышения ", false, false )
		exports.pipboy:addInfoBox("Вам доступен выбор STAT в панели уведомления.", 2 )
	end
	--outputChatBox ("row:".. tostring(row), 255,255,127 )
	guiGridListSetItemData ( notificationsTab, row, 1, { types, value1, value2, value3, value4, value5 } )
	exports.pipboy:addInfoBox("Откройте панель уведомлений клавишей F1", 1 )
	newNfn = newNfn + 1
end

addEvent( "addNewNotificationS", true )
addEventHandler( "addNewNotificationS", getRootElement(), addNewNotification )

function actionOnNotification ()
	local selectedNfn = guiGridListGetSelectedItems ( notificationsTab )
	local nfnData = guiGridListGetItemData ( notificationsTab, tonumber(selectedNfn[1]["row"]), 1 )
	if nfnData then
		showCursor ( false )
		if nfnData[1] == 1 then
			showGroupQuestion ( nfnData[2], nfnData[3], nfnData[4] )
		elseif nfnData[1] == 2 then
			exports.perks:createPerkChoose ()
		elseif nfnData[1] == 3 then
			createStatsUpPanel ()
		end
		guiGridListRemoveRow ( notificationsTab, tonumber(selectedNfn[1]["row"]) )
	else
		outputChatBox ("Ошибка! Как можно скорее сообщите администратору код: B1aaaa", 255,255,127 )
	end
	guiSetVisible ( notificationsTab, false )
end

function  createNotificationsTab ()

	notificationsTab = guiCreateGridList(0.3055,0.4056,0.4055,0.2069,true)
	guiGridListSetSelectionMode(notificationsTab,2)

	guiGridListAddColumn(notificationsTab,"Уведомления",0.95)

	guiGridListSetSortingEnabled ( notificationsTab, false )
	
	
	guiSetVisible ( notificationsTab, false )
	
	addEventHandler("onClientGUIDoubleClick", notificationsTab, actionOnNotification,false)
	
	bindKey ( "F1", "down", showNotificationsBar )
	
	local rectX, rectY = toposition ( 0.8593, 0.1069 )
	local txtX, txtY = toposition ( 0.8562, 0.1125 )
		
end	

addEventHandler ( "onClientResourceStart",  getResourceRootElement(getThisResource()), createNotificationsTab )

function showNotificationsBar ()
	if nfnVisible == 0 then
		guiSetVisible ( notificationsTab, true )
		showCursor ( true )
		newNfn = 0
		nfnVisible = 1
	else
		guiSetVisible ( notificationsTab, false )
		showCursor ( false )
		nfnVisible = 0
	end
end