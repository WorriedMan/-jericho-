local work_safe_id = 1
local xs, ys = guiGetScreenSize()
local passed = true
itemsTableTMP = nil
usingpin = false
pincode = 0
maxnum = 15
openedSafes = {}
function askPasswordWindowC (id,text,items)
	if not isElement ( activateWindow ) then
		itemsTableTMP = items
		if id == 3 and openedSafes[getElementData(localPlayer,"currentCol")] then
			exports.pipboy:initBarterSafe ( items )
			return true
		end
		work_safe_id = id
		showCursor (true)
		activateWindow = guiCreateWindow ( xs/2-150, ys/2-75, 305, 160, text, false )
		guiSetAlpha ( activateWindow, 255 )
		descrLabel = guiCreateLabel ( 10, 25, 285, 60, "Введите пароль от сейфа \"Мистер Хранитель-П\"", false, activateWindow )
		codeEdit = guiCreateEdit ( 10, 45, 280, 35, "", false, activateWindow )
		guiSetFont ( descrLabel, "default-bold-small" )
		guiEditSetCaretIndex ( codeEdit, 0 )
		passed = false
		setTimer (function() passed = true end, 1000, 1)
		buttonActivate = guiCreateButton( 30, 125, 100, 30, "Ввод (enter)", false, activateWindow )
		buttonClose = guiCreateButton( 170, 125, 100, 30, "Выход", false, activateWindow )
		if id == 3 then
			buttonPin = guiCreateButton( 30, 85, 240, 30, "Использовать заколку", false, activateWindow )
			if exports.inventory:getItemAmount ( 126 ) < 1 then
				guiSetEnabled ( buttonPin, false )
			end
			addEventHandler("onClientGUIClick", buttonPin, useBobbyPin, false)
		end
		usingpin = false
		addEventHandler("onClientGUIClick", buttonActivate, startActivation, false)
		addEventHandler("onClientGUIClick", buttonClose, closeActivation, false)
		bindKey ( 'enter', "down", startActivation )
	end
end

addEvent("askPasswordWindow",true)
addEventHandler("askPasswordWindow",getRootElement(),askPasswordWindowC)

function useBobbyPin ()
	guiSetEnabled (buttonPin,false)
	exports.inventory:removePlayerItem(126, 1 )
	usingpin = true
	if getElementData ( localPlayer, "perk34" ) then maxnum = math.floor(maxnum/2) end
	pincode = math.random ( 1, maxnum )
	guiSetText (descrLabel,"Введите число от 1 до "..maxnum..".")
	exports.pipboy:addInfoBox ("Введите число от 1 до "..maxnum.." и нажмите ввод.", 3)
end

function closeActivation ()
	unbindKey( 'enter', "down", startActivation )
	showCursor ( false )
	destroyElement ( activateWindow )
	if work_safe_id ~= 1 then
		triggerServerEvent ( "cancelUsingSafeC", localPlayer )
	end
end

function startActivation ()
	if not passed then
		return true
	end
	showCursor ( false )
	if usingpin and work_safe_id == 3 then
		local text = tonumber(guiGetText (codeEdit))
		if text then
			if text == pincode then
				exports.pipboy:initBarterSafe ( itemsTableTMP )
				destroyElement ( activateWindow )
				unbindKey( 'enter', "down", startActivation )
				return true
			end
		end
		guiSetText ( descrLabel, "Введите пароль от сейфа \"Мистер Хранитель-П\"" )
		guiSetText ( codeEdit, "" )
		exports.pipboy:addInfoBox ("Не удалось взломать сейф.", 2)
		usingpin = false
		if exports.inventory:getItemAmount ( 126 ) > 0 then
			guiSetEnabled (buttonPin,true)
		end
		showCursor ( true )
		return true
	elseif work_safe_id == 1 then
		triggerServerEvent ("createSafeFromClient", localPlayer, guiGetText (codeEdit) )
	else
		local col = getElementData ( localPlayer, "currentCol" ) 
		if isElement(col) and getElementData ( col, "safe" ) then
			local password = getElementData ( col, "pass" )
			if guiGetText (codeEdit) == password or admin then
				if work_safe_id == 2 then
					triggerServerEvent ( "deleteSafeFromClient", localPlayer )
				else
					openedSafes[col] = true
					exports.pipboy:initBarterSafe ( itemsTableTMP )
				end
			else
				triggerServerEvent ( "cancelUsingSafeC", localPlayer )
				exports.pipboy:addInfoBox ("Пароль введен не верно",3)
				setElementData ( localPlayer, "inventoryAllowed", 1 )
			end
		end
	end
	destroyElement ( activateWindow )
	unbindKey( 'enter', "down", startActivation )
end