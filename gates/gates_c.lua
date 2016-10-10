local screenWidth,screenHeight = guiGetScreenSize()
local currentBasesTable
local selectedGate
local playeridsWindow
local baseComboBox
local allowedPlayersGrid
local playerIDEdit

function showGatesWindow(recievedTable)  
	if not isElement ( playeridsWindow ) then
		selectedGate = nil
		currentBasesTable = recievedTable
		showCursor ( true )
		playeridsWindow = guiCreateWindow(screenWidth/2-213, screenHeight/2-192, 427, 394, "Установить игрокам доступ к воротам", false)
        guiWindowSetSizable(playeridsWindow, false)
        guiSetAlpha(playeridsWindow, 1.00)

        baseComboBox = guiCreateComboBox(109, 56, 207, 91, "", false, playeridsWindow)
        selectGatesWindow = guiCreateLabel(6, 25, 411, 21, "Выберите ворота:", false, playeridsWindow)
        guiLabelSetHorizontalAlign(selectGatesWindow, "center", false)
        guiLabelSetVerticalAlign(selectGatesWindow, "center")
        local allowedPlayers = guiCreateLabel(6, 94, 411, 21, "Допущенные игроки:", false, playeridsWindow)
        guiLabelSetHorizontalAlign(allowedPlayers, "center", false)
        guiLabelSetVerticalAlign(allowedPlayers, "center")
        allowedPlayersGrid = guiCreateGridList(10, 119, 407, 115, false, playeridsWindow)
		guiGridListAddColumn( allowedPlayersGrid, "ID игрока", 0.8 )
		for i, v in pairs (recievedTable) do
			guiComboBoxAddItem( baseComboBox, i )
		end
		
		
		local addPlayer = guiCreateLabel(6, 278, 411, 21, "Добавить игрока:", false, playeridsWindow)
        guiLabelSetHorizontalAlign(addPlayer, "center", false)
        guiLabelSetVerticalAlign(addPlayer, "center")
        local idLabel = guiCreateLabel(6, 302, 24, 20, "ID:", false, playeridsWindow)
        guiLabelSetHorizontalAlign(idLabel, "right", false)
        guiLabelSetVerticalAlign(idLabel, "center")
        playerIDEdit = guiCreateEdit(40, 299, 93, 29, "", false, playeridsWindow)
        local addButton  = guiCreateButton(142, 302, 253, 23, "Добавить", false, playeridsWindow)
		local deleteButton = guiCreateButton(9, 241, 408, 27, "Удалить выбранного игрока", false, playeridsWindow)
        local closeButton = guiCreateButton(9, 357, 408, 27, "Закрыть", false, playeridsWindow)    
		
		addEventHandler ( "onClientGUIComboBoxAccepted", baseComboBox,baseCombobxAccepted)
		addEventHandler("onClientGUIClick", addButton, playerAddClicked )
		addEventHandler("onClientGUIClick", deleteButton, playerDeleteClicked )
		addEventHandler("onClientGUIClick", closeButton, function () destroyElement ( playeridsWindow ) showCursor ( false ) end )
	else
		destroyElement ( playeridsWindow )
		showCursor(false)
	end
end

addEvent("gates:showGatesWindow",true)
addEventHandler("gates:showGatesWindow",getRootElement(),showGatesWindow)

function baseCombobxAccepted(combobox)
	local item = guiComboBoxGetSelected ( combobox )
    local text = tostring ( guiComboBoxGetItemText ( combobox , item ) )
    if ( text ~= "" ) then
		if currentBasesTable[text] then
			guiGridListClear(allowedPlayersGrid)
			selectedGate = text
			for i, v in ipairs (currentBasesTable[text]) do
				local row = guiGridListAddRow ( allowedPlayersGrid )
				guiGridListSetItemText ( allowedPlayersGrid, row, 1, v, false, false )
			end
		end
    end
end

local wait

function playerDeleteClicked()
	if wait then return true end
	wait = true
	setTimer ( function () wait = nil end, 2000, 1 )
	local row1 = guiGridListGetSelectedItem ( allowedPlayersGrid )
	if row1 and selectedGate then
		local id = tonumber(guiGridListGetItemText ( allowedPlayersGrid, row1, 1 ))
		local pos
		for i, v in ipairs (currentBasesTable[selectedGate]) do
			if v == id then
				pos = i
				break
			end
		end
		if pos then
			table.remove(currentBasesTable[selectedGate],pos)
			guiGridListRemoveRow ( allowedPlayersGrid, row1 )
			triggerServerEvent( "gates:deletePlayer", localPlayer, selectedGate, id )
		end
	end
end

function playerAddClicked()
	if wait then return true end
	wait = true
	setTimer ( function () wait = nil end, 2000, 1 )
	local id = tonumber(guiGetText(playerIDEdit))
	if id and selectedGate and id > 0 then 
		if #currentBasesTable[selectedGate] <= 20 then
			guiSetText (playerIDEdit,"")
			for i, v in ipairs (currentBasesTable[selectedGate]) do
				if v == id then
					outputChatBox ("Этот игрок уже добавлен на эти ворота",250,10,10)
					return true
				end
			end
			local row = guiGridListAddRow ( allowedPlayersGrid )
			guiGridListSetItemText ( allowedPlayersGrid, row, 1, id, false, false )
			table.insert(currentBasesTable[selectedGate],id)
			triggerServerEvent( "gates:addPlayer", localPlayer, selectedGate, id )
		else
			outputChatBox ("Вы не можете добавить больше 20 игроков на 1 ворота.",250,10,10)
		end
	end
end