GUIEditor_Button = {}
GUIEditor_Window = {}
GUIEditor_Image = {}
GUIEditor_Grid = {}

menushow = 0
mainshowed = false
exitshowed = false

kills = 0
deaths = 0

country = 0
build = 0

localPlayer = getLocalPlayer ()

function warpPlayerToDMC ( type )

	zoneWindow = guiCreateWindow(0.36, 0.36, 0.23, 0.34, "\""..dmZonesCfg[type][1].."\"", true)
	guiWindowSetSizable(zoneWindow, false)

	spawnButt = guiCreateButton(0.09, 0.21, 0.83, 0.19, "Спавн", true, zoneWindow)
	guiSetProperty(spawnButt, "NormalTextColour", "FFAAAAAA")

	lobbyButt = guiCreateButton(0.09, 0.69, 0.83, 0.19, "Назад в лобби", true, zoneWindow)
	guiSetProperty(lobbyButt, "NormalTextColour", "FFAAAAAA")
	
	showCursor ( true )
	guiSetVisible ( zoneWindow, true )
	
	addEventHandler("onClientGUIClick", spawnButt,
			function ()
				exports.pipboy:addInfoBox ( "Нажмите кнопку З для выхода из зоны", 4 )
				showCursor ( false )
				setElementData ( localPlayer, "indmzone", 1 )
				setElementData ( localPlayer, "dmzone", type )
				toggleControl ( "fire", true )
				guiSetVisible ( zoneWindow, false )
				showCursor ( false )
				kills = getElementData ( localPlayer, "dmkills" )
				deaths = getElementData ( localPlayer, "dmdeaths" )
				addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), wastedMessage )
				setCameraTarget ( getLocalPlayer() )
				triggerServerEvent ( "respawnDMPlayerC", localPlayer )
				setElementData ( localPlayer, "safezone.id", nil )
				bindKey ( "p", "down", showAcceptDMExit )
				addEventHandler ( "onClientRender", root, updateStatsCount )

			end
	,false)
	
	addEventHandler("onClientGUIClick", lobbyButt,
			function ()
				guiSetVisible ( zoneWindow, false )
				showCursor ( false )
				setCameraTarget ( localPlayer )
				setElementInterior( localPlayer, 2, 2526.8134765625,-1315.6943359375,1031.421875 )
			end
	,false)
	
end

addEvent( "warpPlayerToDM", true )
addEventHandler( "warpPlayerToDM", getRootElement(), warpPlayerToDMC )
                            

function spawnDMPlayer ()
	setCameraTarget ( getLocalPlayer() )
	local spawnnum = math.random (1,6)
	if spawnnum == 1 then
		setElementPosition ( getLocalPlayer(), -1466.3994140625,-1482.5419921875,101.7578125 )
	elseif spawnnum == 2 then
		setElementPosition ( getLocalPlayer(), -1439.91796875,-1446.85546875,101.921875 )
	elseif spawnnum == 3 then
		setElementPosition ( getLocalPlayer(), -1364.72265625,-1473.861328125,102.43141174316 )
	elseif spawnnum == 4 then
		setElementPosition ( getLocalPlayer(), -1315.5306396484,-1518.7410888672,103.42401885986 )
	elseif spawnnum == 5 then
		setElementPosition ( getLocalPlayer(), -1357.638671875,-1570.3427734375,102.38388061523 )
	elseif spawnnum == 6 then
		setElementPosition ( getLocalPlayer(), -1427.5869140625,-1597.9658203125,101.7578125 )
	end
end

messages = { 
"В следующий раз удача будет твоей",
"Тебе не кажется, что ты слишком медленный для такой игры?",
"Неплохо, потсан",
"Тебя опять прихлопнул какой то нуб",
"Ебать ты лох",
}

function wastedMessage ( killer, weapon, bodypart )
	if source == localPlayer then
		if getElementData ( localPlayer, "indmzone" ) == 1 then
			local randomID = math.random ( 1, #messages ) --get a random ID from the table
			local randomMessage = messages[randomID] --use that to retrieve a message
			outputChatBox ( randomMessage, 255, 0, 0 ) --output the message
			if getElementData ( localPlayer, "indmzone1" ) == 1 then
			else
				setTimer ( function ()
				triggerServerEvent ( "respawnDMPlayerC", getLocalPlayer() )
				end, 5000, 1 )
			end
			exports.pipboy:addInfoBox ( "Нажмите кнопку З для выхода из зоны", 2 )
			deaths = deaths + 1
			setElementData ( localPlayer, "dmdeaths", deaths )
		end
	elseif killer == localPlayer then
		kills = kills+1
		setElementData ( localPlayer, "dmkills", kills )
	end
end

local exitTimer = nil

function showAcceptDMExit ( )
	if not exitshowed then
		exitshowed = true   
		if getElementData ( localPlayer, "indmzone" ) == 1 then
			GUIEditor_Window[3] = guiCreateWindow(594,384,212,137,"Выйти из зоны?",false)
			GUIEditor_Button[9] = guiCreateButton(44,24,126,53,"Выйти ",false,GUIEditor_Window[3])
			GUIEditor_Button[10] = guiCreateButton(65,94,84,32,"Отмена",false,GUIEditor_Window[3])
			guiSetVisible ( GUIEditor_Window[3], true )
			showCursor ( true )
			addEventHandler("onClientGUIClick", GUIEditor_Button[9],
				function ()
					if not isTimer ( exitTimer ) then
						exports.pipboy:addInfoBox ( "Не двигайтесь 5 секунд для выхода", 3 )
						local x,y,z = getElementPosition ( localPlayer )
						showCursor ( false )
						destroyElement ( GUIEditor_Window[3] )
						exitTimer = setTimer ( exitDmZone, 5000, 1, x, y, z )
					end
				end
			,false)
			addEventHandler("onClientGUIClick", GUIEditor_Button[10],
				function ()
				    showCursor ( false )
					destroyElement ( GUIEditor_Window[3] )
					exitshowed = false
				end
			,false)
		end
	end
end

addCommandHandler ("exitdm", showAcceptDMExit)

function exitDmZone (x,y,z)
	local nx, ny, nz = getElementPosition ( localPlayer )
	exitTimer = nil
	exitshowed = false
	if nx == x and ny == y and nz == z then
		setElementData ( localPlayer, "indmzone", 0 )
		removeEventHandler("onClientRender", root, updateStatsCount)
		removeEventHandler("onClientPlayerWasted", getLocalPlayer(), wastedMessage)
		triggerServerEvent ( "setDMPlayersC", getLocalPlayer(), getElementData ( localPlayer, "dmzone" ), 2 )
		triggerServerEvent ( "playerLeavedDmZoneC", getLocalPlayer() )
		setElementData ( localPlayer, "dmzone", 0 )
		setCameraTarget ( localPlayer )
		toggleControl ( "fire", false )
	end
end

dmZonesCfg = {
	{ "Ферма", "Включены", 1, -1339.9453125,-1447.09375,123.6640625, -1441.91015625,-1603.66015625,101.91873931885 },
	{ "Стройка", "Включены", 2, -2134.9541015625,220.2197265625,55.636680603027, -2059.2099609375,255.4248046875,36.958866119385 },
}

function showDMZoneSelect ()
	if not mainshowed then
		mainshowed = true
		chooseDmWindow = guiCreateWindow(0.34, 0.33, 0.31, 0.47, "Выбери ДМ зону", true)
		guiWindowSetSizable(chooseDmWindow, false)
		guiSetAlpha(chooseDmWindow, 1.00)

		zonesGrid = guiCreateGridList(0.03, 0.08, 0.94, 0.72, true, chooseDmWindow)
		guiGridListAddColumn(zonesGrid, "Название", 0.3)
		guiGridListAddColumn(zonesGrid, "Игроки", 0.3)
		guiGridListAddColumn(zonesGrid, "Зомби", 0.3)
		chsZoneButt = guiCreateButton(0.04, 0.83, 0.42, 0.12, "Выбрать", true, chooseDmWindow)
		guiSetProperty(chsZoneButt, "NormalTextColour", "FFAAAAAA")
		exitChsButt = guiCreateButton(0.53, 0.83, 0.42, 0.12, "Закрыть", true, chooseDmWindow)
		guiSetProperty(exitChsButt, "NormalTextColour", "FFAAAAAA")
		triggerServerEvent ( "getDMPlayersC", getLocalPlayer() )
		
		for i = 1, #dmZonesCfg do
		    local addedRow = guiGridListAddRow(zonesGrid)
			guiGridListSetItemText ( zonesGrid, addedRow, 1, dmZonesCfg[i][1], false, false )
			guiGridListSetItemText ( zonesGrid, addedRow, 2, tostring(country), false, false )
			guiGridListSetItemText ( zonesGrid, addedRow, 3, dmZonesCfg[i][2], false, false )
			guiGridListSetItemData ( zonesGrid, addedRow, 1, dmZonesCfg[i][3] )
		end

		guiSetVisible ( chooseDmWindow, true )
		showCursor(true)
		guiGridListSetSelectionMode ( zonesGrid, 1 )
		addEventHandler("onClientGUIDoubleClick", zonesGrid, dmZoneChoosed,false)
		addEventHandler("onClientGUIClick", chsZoneButt, dmZoneChoosed,false)
		addEventHandler("onClientGUIClick", exitChsButt,
			function ()
				destroyElement (chooseDmWindow)
				showCursor ( false )
				mainshowed = false
			end
		,false)
	end
end

addEvent( "showDMZoneSelectS", true )
addEventHandler( "showDMZoneSelectS", getRootElement(), showDMZoneSelect )


function dmZoneChoosed ()
	local selectedZone = guiGridListGetSelectedItems ( zonesGrid )
	if selectedZone[1] then
		local thingData = guiGridListGetItemData ( zonesGrid, tonumber(selectedZone[1]["row"]), 1 )
		if thingData then
			setCameraMatrix( dmZonesCfg[thingData][4],dmZonesCfg[thingData][5],dmZonesCfg[thingData][6],dmZonesCfg[thingData][7],dmZonesCfg[thingData][8],dmZonesCfg[thingData][9])
			showCursor ( false )
			destroyElement (chooseDmWindow)
			mainshowed = false
			triggerServerEvent ( "setDMPlayersC", getLocalPlayer(), thingData, 1 )
			setElementInterior ( localPlayer, 0 )
			warpPlayerToDMC ( thingData )
		end
	end
end
--addCommandHandler ("gotodm", showDMZoneSelect)

function updatePlayersDMCount ( village, bld )
	country = village
	build = bld
end

addEvent( "updatePlayersDMCountS", true )
addEventHandler( "updatePlayersDMCountS", getRootElement(), updatePlayersDMCount )

local screenWidth, screenHeight = guiGetScreenSize ( )
function updateStatsCount ()
	dxDrawText ( "Убийств: "..tostring(kills), screenWidth/2, screenHeight - 41, screenWidth, screenHeight, tocolor ( 20, 200, 20, 255 ), 1.02, "pricedown" )
	dxDrawText ( "Смертей: "..tostring(deaths), screenWidth/2, screenHeight - 91, screenWidth, screenHeight, tocolor ( 250, 10, 10, 255 ), 1.02, "pricedown" )
end

--- --- --- --- ---
