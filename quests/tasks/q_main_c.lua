local localPlayer = getLocalPlayer()

currentMissionBlip = nil

misBlips = {
	nil, -- к секретарю
	nil, -- найти алекса
	{ -1532.0859375,2601.240234375,55.692333221436 }, -- идти к суаресу
	{ -2274.34765625,2677.4365234375,55.4296875 }, -- в туннель
	{ -1320.5439453125,2698.6103515625,50.26628112793 }, -- на заправку
	nil, -- к Эми
	nil, -- убить зомби
	nil, -- отправиться в Союз Ученых
	
}

coords = {
	{ -1532.0859375,2601.240234375,55.692333221436 }, -- Эль Кебрадос
	{ -2274.34765625,2677.4365234375,55.4296875 }, -- туннель
	{ -365.982421875,1510.31640625,75.5625 }, -- Союз Ученых
	{ 1047.12109375,2383.77734375,10.8203125 }, -- склад в Лас Вентурасе
	{ 1530.6728515625,751.0517578125,11.023437 },
	{-255.1474609375,2603.1240234375,62.858154296875}, -- новыйй вегас
	{ -645.921875,1282.6513671875,11.050584793091 }, -- подлодка

}

blipsCol = { -- stage, main, coord
	{ 3, 1, 1 },
	{ 4, 1, 2 },
	{ 4, 2, 2 },
	{ 4, 3, 2 },
	{ 7, 1, 3 },
	{ 8, 2, 4 },
	{ 8, 4, 5 },
	{ 11, 2, 6 },
	{ 12, 1, 7 },
}

function destroyMissionBlip ()
	if currentMissionBlip then destroyElement ( currentMissionBlip ) end
end

function changeMissionBlip ()
	if currentMissionBlip then destroyElement ( currentMissionBlip ) end
	for i = 1, #blipsCol do
		if getElementData ( localPlayer, "quest_main_st" ) == blipsCol[i][1] and getElementData ( localPlayer, "quest_main" ) == blipsCol[i][2] then
			currentMissionBlip = createBlip ( coords[blipsCol[i][3]][1], coords[blipsCol[i][3]][2], coords[blipsCol[i][3]][3], 19, 3 )
			break
		end
	end
end

compMainPos = { -- _st, _main, координаты
	{ 0, 0, -943.900390625,1947.31640625,5 },
	{ 1, 1, -674.193359375, 2048.4140625, 60.381847381592 },
	{ 2, 2, -674.193359375, 2048.4140625, 60.381847381592 },
	{ 3, 1, -1532.0859375,2601.240234375,55.692333221436 }, 
	{ 4, 1, -2274.34765625,2677.4365234375,55.4296875 },
	{ 4, 2, -2274.34765625,2677.4365234375,55.4296875 },
	{ 4, 3, -2253.5205078125,2646.0595703125,55.37158203125 },
	{ 4, 4, -1532.0859375,2601.240234375,55.692333221436 }, 
	{ 5, 1, -1320.5439453125,2698.6103515625,50.26628112793 },
	{ 6, 1, -674.193359375, 2048.4140625, 60.381847381592 }, 
	{ 6, 2, -674.193359375, 2048.4140625, 60.381847381592 },
	{ 7, 1, -368.421875, 1511.0439453125, 76.311706542969 },
	{ 7, 2, -329.81640625, 1537.0419921875, 76.611709594727 }, 
	{ 8, 1, -295.2529296875,1546.88671875,75.359375 },
	{ 8, 2, 1047.12109375,2383.77734375,10.8203125 },
	{ 8, 3, -295.2529296875,1546.88671875,75.359375 },
	{ 8, 4, 1530.6728515625,751.0517578125,11.0234375 },
	{ 8, 5, -295.2529296875,1546.88671875,75.359375 },
	{ 8, 6, -329.81640625, 1537.0419921875, 76.611709594727 },
	{ 11, 1, -368.421875, 1511.0439453125, 76.311706542969 },
	{ 11, 2, -255.1474609375, 2603.1240234375, 62.858154296875 },
	{ 12, 1, -645.921875,1282.6513671875,11.050584793091 },
}

compAdditPos = {
	{ {} },
	{ {-175.990234375, 2660.5859375,62.903839111328}, {419.1611328125,2477.0849609375,16.492168426514}, { -255.11328125,2756.5771484375,62.6875} }, 
	{ {-1455.0068359375,2611.4736328125,55.8359375},{-1455.0068359375,2611.4736328125,55.8359375},{-1455.0068359375,2611.4736328125,55.8359375}, {-830.587890625,2042.517578125,60.3828125} }, -- детектив
	{ {1058.1669921875,1260.7255859375,10.8203125},{1058.1669921875,1260.7255859375,10.8203125},{-175.990234375, 2660.5859375,62.903839111328}, }, -- поиск тп
	{ {} },
	{ { 1058.1669921875,1260.7255859375,10.8203125 }, {-366.2333984375,1549.408203125,75.5625},{ 2239.0498046875,1285.396484375,10.8203125},{-160.9365234375,2673.4130859375,62.683616638184},{-99.28125,1083.228515625,19.749971389771},{-160.9365234375,2673.4130859375,62.683616638184},{-3032.482421875,428.95703125,9.5517873764038}},
	{ { 1367.5576171875,248.2109375,19.566932678223 }, {}, { 2332.5322265625,-3.6416015625,26.558090209961 }, {}, { 2332.5322265625,-3.6416015625,26.558090209961 }, {}, {} },
	{ {-670.7, 275, 60}, { -675.8896484375,2075.4287109375,60.381847381592 }, { -594.5771484375,2018.6298828125,60.538135528564}, { -675.8896484375,2075.4287109375,60.381847381592 }, {}, { -675.8896484375,2075.4287109375,60.381847381592 }, {} },
	{ {-269,1489,75}, {}, { -175.990234375,2660.5859375,62.903839 }, {212.80859375,1855.51953125,13.016319274902},{-254.48046875,1531.4677734375,75.5625},{}},
	{{},{},{}},
	{ {2161,-104, 2}, {}, { 2326, -1.1, 26.5}, {2174, -1535, 2.2}, { 2326, -1.1, 26.5}, {}},
	{ {2108,-1748,12},{2818,-1428,35},{2523,-1712,13},{1680,-1494,17.5},{827,-1004,26},{735,-1381,24},{392,-1840,7.8},{2154,-1533,2.9},{},{},{},{}},
}

function updateCompassMarker ()
		for i = 1, #compMainPos do
			if getElementData ( localPlayer, "quest_main_st" ) == compMainPos[i][1] and getElementData ( localPlayer, "quest_main" ) == compMainPos[i][2] then
				--triggerServerEvent ( "getCompassNPC", localPlayer, compMainPos[4] )
				setElementData ( localPlayer, "showArrowC", true )
				--setElementData ( localPlayer, 
				exports.players:updateCompassArrowPos ( compMainPos[i][3], compMainPos[i][4], compMainPos[i][5] )
				if getElementData ( localPlayer, "inBuild" ) then setElementData ( localPlayer, "showArrowC", false ) end
				return true
			end
		end
		setElementData ( localPlayer, "showArrowC", false )
end

function updateCompassAdditMarker ( id, stage )
	if #compAdditPos[id] >= stage and #compAdditPos[id][stage] > 0 then
		exports.players:updateCompassAdditArrowPos ( compAdditPos[id][stage][1], compAdditPos[id][stage][2], compAdditPos[id][stage][3] )
		setElementData ( localPlayer, "showAdditArrowC", true )
		if getElementData ( localPlayer, "inBuild" ) then setElementData ( localPlayer, "showAdditArrowC", false ) end
	else
		setElementData ( localPlayer, "showAdditArrowC", false )
	end
end



function loadAllTasks( )
	if getElementData ( localPlayer, "online" ) == 1 then
		--createQuestsPanel ()
		updateCompassMarker ()
		setRadioChannel ( 0 )
		addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), stationDraw) -- add an event handler
		--bindKey ( "F3", "down", createQuestsPanel )
		local quest_main_st = getElementData ( localPlayer, "quest_main_st" )
		if quest_main_st > 0 then
			for i = 1, #blipsCol do
				if quest_main_st == blipsCol[i][1] and getElementData ( localPlayer, "quest_main" ) == blipsCol[i][2] then
					currentMissionBlip = createBlip ( coords[blipsCol[i][3]][1], coords[blipsCol[i][3]][2], coords[blipsCol[i][3]][3], 19, 3 )
					break
				end
			end
		end	
	--	bindKey ( "space", "down", checkNearTask )
	--	outputChatBox ( getElementData ( localPlayer, "quest_main" ) )
		if getElementData ( localPlayer, "quest_main_st" ) == 4 and getElementData ( localPlayer, "quest_main" ) == 1 then
			st4Full_main_Q ()
			--local x1, x2, x3 = getElementPosition ( tunnelMarker_1 )
			--outputChatBox ( tostring(x1))
			--outputChatBox ( tostring(x2))
			--outputChatBox ( tostring(x3))
		elseif quest_main_st == 4 and getElementData ( localPlayer, "quest_main" ) == 2 then
			tunnelMarker_1 = createMarker ( -2274.34765625,2677.4365234375,55.4296875, "corona", 1, 255,255,255 )
			addEventHandler ( "onClientMarkerHit", tunnelMarker_1, st4FirstMarkerHit )
		elseif quest_main_st == 4 and getElementData ( localPlayer, "quest_main" ) == 3 then
			tunnelMarker_2 = createMarker ( -2253.5205078125,2646.0595703125,55.37158203125, "corona", 1, 255,255,255 )
			addEventHandler ( "onClientMarkerHit", tunnelMarker_2, st4SecondMarkerHit )
		elseif quest_main_st == 5 and getElementData ( localPlayer, "quest_main" ) == 1 then
			fillMarker = createMarker ( -1320.5439453125,2698.6103515625,50.26628112793, "corona", 1, 255,255,255 )
			fillVehicle = createVehicle ( 541, -1326.2998046875,2694.994140625,49.687591552734, 0,0,312.55755615234, "VEGAS" )
			setVehicleColor ( fillVehicle, 0, 1, 0, 0 )
			setVehicleEngineState ( fillVehicle, true )
			setVehicleLightState ( fillVehicle, 3, 0 )
			setVehicleLocked ( fillVehicle, true )
			--outputChatBox ( tostring(getVehicleEngineState(fillVehicle)))
		elseif quest_main_st == 8 and getElementData ( localPlayer, "quest_main" ) == 1 then
			lvMarker = createMarker ( 1047.12109375,2383.77734375,10.8203125, "checkpoint", 1, 255,255,255 )
		elseif quest_main_st == 8 and getElementData ( localPlayer, "quest_main" ) == 2 then
			lvMarker = createMarker ( 1047.12109375,2383.77734375,10.8203125, "checkpoint", 1, 255,255,255 )
		elseif quest_main_st == 8 and getElementData ( localPlayer, "quest_main" ) == 3 then
			lvMarker2 = createMarker ( 1530.6728515625,751.0517578125,11.023437, "checkpoint", 1, 255,255,255 )
		elseif quest_main_st == 8 and getElementData ( localPlayer, "quest_main" ) == 4 then
			lvMarker2 = createMarker ( 1530.6728515625,751.0517578125,11.023437, "checkpoint", 1, 255,255,255 )
		end
		if getElementData ( localPlayer, "detective_quest" ) == 1 then
			narko_det = createPickup ( 1291.2724609375,-1015.8310546875,6645.731933593, 3, 1274 )
			adren_det = createPickup ( 1312.5546875,-989.447265625,6645.7319335938, 3, 1274 )
		elseif getElementData ( localPlayer, "detective_quest" ) == 2 then
			adren_det = createPickup ( 1312.5546875,-989.447265625,6645.7319335938, 3, 1274 )
		elseif getElementData ( localPlayer, "detective_quest" ) == 3 then
			narko_det = createPickup ( 1291.2724609375,-1015.8310546875,6645.731933593, 3, 1274 )
		end
		if getElementData ( localPlayer, "quest_meh" ) == 5 then
			shet_cash = createPickup ( -212.80834960938,1091.1323242188,-10.340960502625, 3, 1279 )
		end
		if getElementData ( localPlayer, "quest_prob" ) == 4 then
			createOystersKlamat ()
		end
		if getElementData ( localPlayer, 'quest_her' ) == 1 then
			argailColShape = createColSphere ( 212.80859375,1855.51953125,13.016319274902, 3 )
			--setElementData ( argailColShape, 'action', true )
			--setElementData ( argailColShape, 'type', 6 )
			addEventHandler("onClientColShapeHit",argailColShape,
			function () 
				exports.pipboy:addInfoBox ( 'На мертвом гуле вы находите письмо', 2 )
				exports.inventory:givePlayerItemWW ( 108, 1 )
				destroyElement ( argailColShape )
			end)
		end
		if getElementData ( localPlayer, 'quest_ring' ) == 4 then
			samaraShpinColShape = createColSphere (-592.5,2321.5,36, 2 )
			superShpinIcon = exports.pipboy:addMapIcon ( -592.5,2321.5,36, 3, 'Шпинат' ) or 0 
			addEventHandler("onClientColShapeHit",samaraShpinColShape,
			function () 
				exports.pipboy:addInfoBox ( 'Вы собрали Супершпинат, теперь отправляйтесь в Союз Ученых на встречу с этой тварью!', 2 )
				outputChatBox ("Информация: Прогресс сохранен", 0,153,51 )
				destroyElement ( samaraShpinColShape )
				exports.players:givePlayerXPClient ( 100 )
				setElementData ( localPlayer, 'quest_ring', 5 )
				exports.pipboy:deleteMapIcon ( superShpinIcon )
			end)
		end
		if getElementData ( localPlayer, 'quest_whiskey' ) == 1 then
			samogonApparat = createColSphere (2161,-104, 2, 7 )
			samogonIcon = exports.pipboy:addMapIcon ( 2161,-104, 2, 3, 'Самогон' ) or 0  
			addEventHandler("onClientColShapeHit",samogonApparat,
			function () 
				exports.pipboy:addInfoBox ( 'Аппарата нет, но вы находите записку', 2 )
				exports.inventory:givePlayerItemWW ( 121, 1 )
				outputChatBox ("Информация: Прогресс сохранен", 0,153,51 )
				destroyElement ( samogonApparat )
				exports.players:givePlayerXPClient ( 100 )
				setElementData ( localPlayer, 'quest_whiskey', 2 )
				exports.pipboy:deleteMapIcon ( samogonIcon )
			end)
		end
		if getElementData ( localPlayer, 'quest_check' ) >= 1 and getElementData ( localPlayer, "quest_check" ) < 8 then
			local quest = getElementData ( localPlayer, 'quest_check' )
			checkingTransmitter = createColSphere (lsmarkers[quest].x,lsmarkers[quest].y, lsmarkers[quest].z, 4 )
			checkingTransmitterIcon = exports.pipboy:addMapIcon ( lsmarkers[quest].x,lsmarkers[quest].y, lsmarkers[quest].z, 3, 'Трансмиттер' ) or 0 
			addEventHandler("onClientColShapeHit",checkingTransmitter,loadNextTransmitter)
		end
	end
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), loadAllTasks )

lsmarkers = {
	{ x = 2109.8, y = -1784.7, z = 12, xp = 50},
	{ x = 2818, y = -1428, z = 35, xp = 25},
	{ x = 2523, y = -1712, z = 13, xp = 100},
	{ x = 1680, y = -1494, z = 17.5, xp = 100},
	{ x = 827, y = -1004, z = 26, xp = 50},
	{ x = 735, y = -1381, z = 24, xp = 200},
	{ x = 392, y = -1840, z = 7.8, xp = 100},
}



function st4Full_main_Q ()
	tunnelMarker_1 = createMarker ( -2274.34765625,2677.4365234375,55.4296875, "corona", 1, 255,255,255 )
	tunnelMarker_2 = createMarker ( -2253.5205078125,2646.0595703125,55.37158203125, "corona", 1, 255,255,255 )
	addEventHandler ( "onClientMarkerHit", tunnelMarker_1, st4FirstMarkerHit )
	addEventHandler ( "onClientMarkerHit", tunnelMarker_2, st4SecondMarkerHit )
end

function st4FirstMarkerHit (hitPlayer)
	if hitPlayer == localPlayer then
		updateCompassMarker ()
		if getElementData ( localPlayer, "quest_main_st" ) == 4 and getElementData ( localPlayer, "quest_main" ) == 1 then
			setElementData ( localPlayer, "quest_main", 3 )
			exports.pipboy:addInfoBox("Прогресс сохранен",4)
			outputChatBox ("Здесь все завалено, следовательно гули не могли пройти через ЭТУ ЧАСТЬ туннеля", 255,255,255 )
			removeEventHandler ( "st4FirstMarkerHit", tunnelMarker_1, st4FirstMarkerHit )
			destroyElement ( tunnelMarker_1 )
			return true
		end
		if getElementData ( localPlayer, "quest_main_st" ) == 4 and getElementData ( localPlayer, "quest_main" ) == 2 then
			setElementData ( localPlayer, "quest_main", 4 )	
			outputChatBox ("Здесь так же все завалено, но вы 15 патронов калибра 10мм!", 255,255,255 )
			exports.inventory:givePlayerItem ( 45, 15 )
			exports.pipboy:addInfoBox("Прогресс сохранен",4)
			removeEventHandler ( "st4FirstMarkerHit", tunnelMarker_1, st4FirstMarkerHit )
			changeMissionBlip ()
			destroyElement ( tunnelMarker_1 )
			return true
		end
	end
end

function st4SecondMarkerHit (hitPlayer)
	if hitPlayer == localPlayer then
		updateCompassMarker ()
		if getElementData ( localPlayer, "quest_main_st" ) == 4 and getElementData ( localPlayer, "quest_main" ) == 1 then
			removeEventHandler ( "st4FirstMarkerHit", tunnelMarker_2, st4SecondMarkerHit )
			destroyElement ( tunnelMarker_2 )
			setElementData ( localPlayer, "quest_main", 2 )
			exports.pipboy:addInfoBox("Прогресс сохранен",4)
			outputChatBox ("Здесь все завалено, следовательно гули не могли пройти через ЭТУ ЧАСТЬ туннеля", 255,255,255 )
			return true
		end
		if getElementData ( localPlayer, "quest_main_st" ) == 4 and getElementData ( localPlayer, "quest_main" ) == 3 then
			setElementData ( localPlayer, "quest_main", 4 )
			outputChatBox ("Здесь так же все завалено, но вы находите 10 патрон для дробовика!", 255,255,255 )
			exports.inventory:givePlayerItem ( 46, 10 )
			exports.pipboy:addInfoBox("Прогресс сохранен",4)
			removeEventHandler ( "st4FirstMarkerHit", tunnelMarker_2, st4SecondMarkerHit )
			changeMissionBlip ()
			destroyElement ( tunnelMarker_2 )
			return true
		end
	end
end

local function tasksPickupHits(thePlayer, matchingDimension)
	if thePlayer == localPlayer then
		updateCompassMarker ()
		if source == narko_det then
			destroyElement ( narko_det )
			if getElementData ( localPlayer, "detective_quest" ) == 1 then
				outputChatBox ("Где-то тут должна быть еще наркота.", 255,255,255 )
				exports.pipboy:addInfoBox("Прогресс сохранен",4)
				setElementData ( localPlayer, "detective_quest", 2 )
				updateCompassAdditMarker ( 2, 2 )
			else
				setElementData ( localPlayer, "detective_quest", 4 )
				outputChatBox ("Отлично, наркота собрана, возвращаемся к Бобу Дилану", 255,255,255 )
				exports.pipboy:addInfoBox("Прогресс сохранен",4)
				updateCompassAdditMarker ( 2, 4 )
			end
		elseif source == adren_det then
			destroyElement ( adren_det )
			if getElementData ( localPlayer, "detective_quest" ) == 1 then
				outputChatBox ("Где-то тут должна быть еще наркота.", 255,255,255 )
				exports.pipboy:addInfoBox("Прогресс сохранен",4)
				setElementData ( localPlayer, "detective_quest", 3 )
				updateCompassAdditMarker ( 2, 3 )
			else
				setElementData ( localPlayer, "detective_quest", 4 )
				outputChatBox ("Отлично, наркота собрана, возвращаемся к Бобу Дилану", 255,255,255 )
				exports.pipboy:addInfoBox("Прогресс сохранен",4)
				updateCompassAdditMarker ( 2, 4 )
			end
		elseif source == shet_cash then
				destroyElement ( shet_cash )
				setElementData ( localPlayer, "quest_meh", 6 )
				outputChatBox ("Отлично, щетка найдена, возвращаемся к Джони Кэшу", 255,255,255 )
				exports.pipboy:addInfoBox("Прогресс сохранен",4)
				updateCompassAdditMarker ( 6, 6 )
		elseif source == clamLeavePickup then 
			fadeCamera ( false )
			destroyElement ( source ) 
			setTimer ( function ()
						setElementDimension ( localPlayer, 0 )
						setElementInterior ( localPlayer, 0 )
						setElementPosition ( localPlayer, 1367.5576171875,248.2109375,19.566932678223 )
						fadeCamera ( true )
					end, 1000, 1 )
		end
		if getElementData ( source, "oysterKL" ) then
			destroyElement ( source ) 
			setElementData ( localPlayer, "quest_prob_oy", getElementData ( localPlayer, "quest_prob_oy" )+1 )
			if (5-getElementData ( localPlayer, "quest_prob_oy" )) > 0 then
				outputChatBox ("Осталось найти устриц "..(5-getElementData ( localPlayer, "quest_prob_oy" )).."", 255,255,255 )
			else
				outputChatBox ("Найдены все устрицы, Боб будет доволен", 255,255,255 )
				setElementData ( localPlayer, "quest_prob", 5 )
				exports.pipboy:addInfoBox("Прогресс сохранен",4)
				updateCompassAdditMarker ( 7, 5)
			end
		end
	end
end
addEventHandler("onClientPickupHit", root, tasksPickupHits)

-- Часть 9

function tasksMarkerHits ( hitPlayer, matchingDimension )
	if hitPlayer == localPlayer then
		if source == fillMarker then
			--outputChatBox ( "2" )
			destroyElement ( fillMarker )
			destroyElement ( fillVehicle )
			fadeCamera ( false, 2 )
			exports.pipboy:addInfoBox("Вас вырубили", 3 )
			setTimer ( contTripFill, 4000, 1 )
		elseif source == lvMarker then
			destroyElement ( lvMarker )
			fadeCamera ( false )
			setTimer ( function ()
						triggerServerEvent ( "createStage8step1vehiclec", getLocalPlayer() )
					end, 1000, 1 )
			setTimer ( function ()
						fadeCamera ( true )
						outputChatBox ("Отправляйтесь обратно в Союз Ученых.", 255,255,255 )
						destroyMissionBlip ()
						exports.players:updateCompassArrowPos ( -286.404296875,1547.572265625,74.65357208252 )
						setElementData ( localPlayer, "showArrowC", true )
						s8st1returnMarker = createMarker ( -286.404296875,1547.572265625,74.65357208252, "checkpoint", 1, 255,255,255 )
					end, 2000, 1 )
		elseif source == lvMarker2 then
			fadeCamera ( false )
			setTimer ( function ()
						triggerServerEvent ( "createStage8step2vehiclec", getLocalPlayer() )
						destroyElement ( lvMarker2 )
					end, 1000, 1 )
			setTimer ( function ()
						fadeCamera ( true )
						outputChatBox ("Отправляйтесь обратно в Союз Ученых.", 255,255,255 )
						destroyMissionBlip ()
						exports.players:updateCompassArrowPos ( -286.404296875,1547.572265625,74.65357208252 )
						setElementData ( localPlayer, "showArrowC", true )
						s8st2returnMarker = createMarker ( -286.404296875,1547.572265625,74.65357208252, "checkpoint", 1, 255,255,255 )
			end, 2000, 1 )
		elseif source == s8st1returnMarker then
			if getPedOccupiedVehicle ( localPlayer ) then
				if getElementData(getPedOccupiedVehicle ( localPlayer ), "task8" ) then 
					fadeCamera ( false )
					setTimer ( function ()
								triggerServerEvent ( "destroyStage8step1vehiclec", getLocalPlayer() )
								destroyElement ( s8st1returnMarker )
							end, 1000, 1 )
					setTimer ( function ()
								fadeCamera ( true )
								exports.players:givePlayerXPClient ( 100 )
								exports.pipboy:addInfoBox("Прогресс сохранен",4)
								setElementData ( localPlayer, "quest_main", 3 )
								setElementData ( localPlayer, "quest_main_st", 8 )
								setElementData ( localPlayer, "onmission", false )
								setElementData ( localPlayer, "mission", 0 )
								updateCompassMarker ()
								outputChatBox ("Катерина Минет: Отлично, подойдите ко мне.", 255, 255, 255 )
							end, 2000, 1 )
				end
			end
		elseif source == s8st2returnMarker then
			if getPedOccupiedVehicle ( localPlayer ) then
				if getElementData(getPedOccupiedVehicle ( localPlayer ), "task8" ) then 
					fadeCamera ( false )
					setTimer ( function ()
								triggerServerEvent ( "destroyStage8step2vehiclec", getLocalPlayer() )
								destroyElement ( s8st2returnMarker )
								setElementPosition ( localPlayer, -286.404296875,1547.572265625,74.65357208252 )
							end, 1000, 1 )
					setTimer ( function ()
								fadeCamera ( true )
								exports.players:givePlayerXPClient ( 100 )
								exports.pipboy:addInfoBox("Прогресс сохранен",4)
								setElementData ( localPlayer, "quest_main", 5 )
								setElementData ( localPlayer, "quest_main_st", 8 )
								setElementData ( localPlayer, "onmission", false )
								setElementData ( localPlayer, "mission", 0 )
								updateCompassMarker ()
								outputChatBox ("Катерина Минет: Молодчинка, идите сюда.", 255, 255, 255 )
							end, 2000, 1 )
				end
			end
		end
	end
end
addEventHandler ( "onClientMarkerHit", getRootElement(), tasksMarkerHits )

function destroyTaskElementC ()
	if getElementData ( localPlayer, "mission" ) == 1 then
		destroyElement ( s8st1returnMarker )
	elseif getElementData ( localPlayer, "mission" ) == 2 then
		destroyElement ( s8st2returnMarker )
	end
end

addEvent("destroyFromSever", true)
addEventHandler("destroyFromSever", getRootElement(), destroyTaskElementC)

function create8stageFirstMarker ()
	lvMarker = createMarker ( 1047.12109375,2383.77734375,10.8203125, "checkpoint", 1, 255,255,255 )
end

function create8stageSecondMarker ()
	lvMarker2 = createMarker ( 1530.6728515625,751.0517578125,11.0234375, "checkpoint", 1, 255,255,255 )
end

function testTripFill ()
	fadeCamera ( false, 2 )
	exports.pipboy:addInfoBox("Вас вырубили", 3 )
	setTimer ( contTripFill, 4000, 1 )
	createVehicleStage9 ()
	setElementData ( localPlayer, "ontask", true )
end

--addCommandHandler ("test1", testTripFill)

function contTripFill ()
	setElementDimension ( localPlayer, getElementData ( localPlayer, "playerid" ) )
	setElementPosition ( localPlayer, -266.3896484375,2586.1650390625,63.5703125 )
	setElementRotation ( localPlayer, 0, 0, 171.60632324219 )
	--setElementPosition ( fillVehicle, -256.66796875,2589.0166015625,63.195362091064 )
	--setElementRotation ( fillVehicle, 0,0,88.867004394531 )
	docPed = createPed ( 83, -266.92578125,2581.9228515625,63.5703125, 138 )
	setElementDimension ( docPed, getElementData ( localPlayer, "playerid" ) ) 
	setPedAnimation ( localPlayer, "ped", "handsup",-1, false, false )
	outputChatBox ("Вас куда то везут...", 0,153,51 )
	setTimer ( finishTripFill, 4000, 1 )
end

function finishTripFill ()
	outputChatBox ("Неизвестный голос: Снимите с него мешок", 255,255,255 )
	outputChatBox ("Другой неизвестный голос: "..getPlayerName(localPlayer)..", подними руки", 255,255,255 )
	triggerServerEvent ( "mainQuest_stage_9c", getLocalPlayer() ) 
	setTimer ( finishTripFillStage2, 3000, 1 )
end

function finishTripFillStage2 ()
	outputChatBox ("Вы поднимаете руки", 0,153,51 )
	setTimer ( finishTripFillStage3, 3000, 1 )
end

function finishTripFillStage3 ()
	outputChatBox ("Неизвестный: Вот так, и не опускай их, за нами не постоит размазать твои мозги об пол", 255,255,255 )
	fadeCamera ( true, 2 )
	setTimer ( function ()
					lvFillTripStartConversation ()
				end, 8000, 1 )
end

function finishStage9TripBegin ()
	outputChatBox ("Ага, вас опять куда то везут...", 0,153,51 )
	setTimer ( finishStage9TripConversation, 4000, 1 )
end

function stage9ConversationFinish ()
	outputChatBox ("Вас выкинули из машины", 0,153,51 )
	setTimer ( stage9Finish1, 2000, 1 )
end

function stage9Finish1 ()
	outputChatBox ("Кажется к вам приближаются гули", 0,153,51 )
	setTimer ( stage9Finish2, 2000, 1 )
end

function stage9Finish2 ()
	outputChatBox ("Вы снимаете мешок со своей головы", 0,153,51 )
	setTimer ( stage9Finish3, 2000, 1 )
end

function stage9Finish3 ()
	setElementDimension ( localPlayer, 0 )
	local randomPosition = math.random ( 1, 2 )
	if randomPosition == 1 then
		setElementPosition ( localPlayer, -1431.3828125,2595.376953125,55.8359375 )
	else
		setElementPosition ( localPlayer, -1505.75,2639.6748046875,55.8359375 )
	end
	exports.pipboy:addInfoBox("Получено задание \"Пьяная черепаха?!\"", 4 )
	setElementData ( localPlayer, "quest_main_st", 6 )
	setElementData ( localPlayer, "quest_main", 1 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setPedAnimation ( localPlayer )
	setElementData ( localPlayer, "ontask", false )
	fadeCamera ( true, 2 )
end

function callServerFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    -- If the serverside event handler is not in the same resource, replace 'resourceRoot' with the appropriate element
    triggerServerEvent("onClientCallsServerFunction", resourceRoot , funcname, unpack(arg))
end

function callClientFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onServerCallsClientFunction", true)
addEventHandler("onServerCallsClientFunction", resourceRoot, callClientFunction)

function stationDraw(station)
	cancelEvent()
end
 
function leaveClamTaskBell ()
	clamLeavePickup = createPickup ( 364.9072265625,-11.7666015625,1001.8515625, 3, 1318 )
	setElementDimension ( clamLeavePickup, getElementData ( localPlayer, "playerid" ) )
	setElementInterior ( clamLeavePickup, 9 )
end

oysterPlaces = {
	{ 1407.693359375,297.6103515625,19.5546875 },
	{ 1378.828125,260.583984375,19.566932678223 },
	{ 1352.4970703125,188.9853515625,24.227144241333 },
	{ 1329.8671875,197.8505859375,19.5546875 },
	{ 1291.4775390625,235.2841796875,19.5546875 },
	{ 1243.56640625,217.310546875,23.055511474609 },
	{ 1225.7685546875,312.4677734375,19.7578125 },
	{ 1226.4248046875,333.4755859375,19.5546875 },
}

function createOystersKlamat ()
	local usedNumbers = {}
	for i = 1, 5 do
		local num = math.random ( 1, #oysterPlaces )
		while usedNumbers[num] == true do
			num = math.random ( 1, #oysterPlaces )
		end		
		usedNumbers[num] = num
		local createdPickup = createPickup ( oysterPlaces[num][1],oysterPlaces[num][2],oysterPlaces[num][3], 3, 953 )
		setElementData ( createdPickup, "oysterKL", true )
	end
end