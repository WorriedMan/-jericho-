local convoyWindow
local convoyGrid
local sw,sh = guiGetScreenSize()

function handleVehicleDamage(attacker, weapon, loss, x, y, z, tyre)
	if tyre and attacker == localPlayer then
		if getElementData ( source, "convoy:id" ) then
			triggerServerEvent ("convoy:vehicleTireDamage",source,tyre)
		end
    end
end
addEventHandler("onClientVehicleDamage", root, handleVehicleDamage)

function showConvoyMenu(convoys,started)	
	showCursor ( true )
	if not isElement ( convoyWindow ) then
		convoyWindow = guiCreateWindow(sw/2-211,sh/2-179, 422, 358, "Панель управления конвоями", false)
        guiWindowSetSizable(convoyWindow, false)
        convoyGrid = guiCreateGridList(9, 24, 403, 280, false, convoyWindow)
		guiGridListAddColumn(convoyGrid,"Название",0.5)
		guiGridListAddColumn(convoyGrid,"Статус",0.45)
		for i, v in pairs ( convoys ) do
			local new_row = guiGridListAddRow(convoyGrid)
			guiGridListSetItemText(convoyGrid,new_row,1,v.id,false,false)
			guiGridListSetItemText(convoyGrid,new_row,2,started[v.id] and "Запущен" or "Не запущен",false,false)
			local r,g,b = 250,20,20
			if started[v.id] then
				r,g,b = 20,250,20
			end
			guiGridListSetItemColor ( convoyGrid, new_row, 2, r,g,b )
		end
		local startButton = guiCreateButton(10, 312, 189, 36, "Запустить", false, convoyWindow)
        local closeButton = guiCreateButton(223, 312, 189, 36, "Закрыть", false, convoyWindow) 
		addEventHandler("onClientGUIClick",convoyGrid,
		function() 
			local row,col = guiGridListGetSelectedItem(convoyGrid)
			if row ~= -1 then
				local text = guiGridListGetItemText(convoyGrid,row,2)
				guiSetText (startButton,text=="Запущен" and "Отменить" or "Запустить")
			end
		end,false)
		addEventHandler("onClientGUIClick",startButton,
		function() 
			local row,col = guiGridListGetSelectedItem(convoyGrid)
			if row ~= -1 then
				triggerServerEvent("convoy:onConvoyStartClicked",localPlayer,row+1, guiGetText (startButton)=="Запустить")
				destroyElement (convoyWindow)
				showCursor ( false )
			end
		end,false)
		addEventHandler("onClientGUIClick",closeButton,
		function() 
			destroyElement (convoyWindow)
			showCursor ( false )
		end,false)
	else
		destroyElement (convoyWindow)
		showCursor ( false )
	end
end

addEvent("convoy:showConvoyMenu", true)
addEventHandler("convoy:showConvoyMenu", root, showConvoyMenu )