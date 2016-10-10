localPlayer = getLocalPlayer ()
planeblip = nil

function checkStuntPlaneC ( stuntPlaneS )
	addEventHandler("onClientVehicleExplode", stuntPlaneS, onPlaneDestroy)
	planemark = createMarker ( 384.5380859375,2494.755859375,17.035684585571, "ring" )
	setElementRotation ( planemark, 90,90,90 )
	addEventHandler( "onClientMarkerHit", planemark, planeMarkerHit )
	setElementData ( localPlayer, "planenum", 1 )
	planeblip = createBlipAttachedTo ( planemark, 5 ) 
	addEventHandler("onClientRender",root, createDXMsg )

	showPlayerHudComponent ( "radar", true)
end

-- addCommandHandler ("start1", start_Main_Q)

-- addEventHandler("onClientVehicleExplode", getRootElement(), onPlaneDestroy)

function onPlaneDestroy ( source )

		outputChatBox("Задание провалено!")

end


addEvent( "checkStuntPlaneS", true )
addEventHandler( "checkStuntPlaneS", getRootElement(), checkStuntPlaneC )

-- закрываем знакомство

-- закрываем Суареса

function finish()

end

function planeMarkerHit ( hitElement, matchingDimension )
	local planenum = getElementData ( localPlayer, "planenum" )
	destroyElement ( planemark )
	destroyElement ( planeblip )
			

	if planenum == 1 then
		planemark = createMarker ( 253.5009765625,2505.3564453125,45.585803985596, "ring" )
		setElementRotation ( planemark, 0,0,117.16271972656 )
	end
	if planenum == 2 then
		planemark = createMarker ( 152.380859375,2395.9296875,59.573097229004, "ring" )
		setElementRotation ( planemark, 0,0,95.859924316406 )
	end
	if planenum == 3 then
		planemark = createMarker ( -15.20703125,2334.8876953125,59.989284515381, "ring" )
		setElementRotation ( planemark, 0,0,95.859924316406 )
	end
	if planenum == 4 then
		planemark = createMarker ( -139.3974609375,2417.6552734375,66.124488830566, "ring" )
		setElementRotation ( planemark, 0,0,95.859924316406 )
	end
	if planenum == 5 then
		planemark = createMarker ( -332.4443359375,2498.61328125,58.658695220947, "ring" )
		setElementRotation ( planemark, 0,0,95.859924316406 )
	end
	if planenum == 6 then
		planemark = createMarker ( -404.49609375,2523.3623046875,59.440845489502, "ring" )
		setElementRotation ( planemark, 0,0,95.859924316406 )
	end
	if planenum == 7 then
		planemark = createMarker ( -315.908203125,2588.232421875,68.318412780762, "ring" )
		setElementRotation ( planemark, 0,0,95.859924316406 )
	end
	if planenum == 8 then
		planemark = createMarker ( -261.0107421875,2679.4208984375,88.726669311523, "ring" )
		setElementRotation ( planemark, 0,0,95.859924316406 )
	end
	if planenum == 9 then
		planemark = createMarker ( -160.01953125,2674.900390625,79.377098083496, "ring" )
		setElementRotation ( planemark, 0,0,265.93087768555 )
	end
	if planenum == 10 then
		planemark = createMarker ( -57.8671875,2631.83984375,79.751571655273, "ring" )
		setElementRotation ( planemark, 0,0,256.52642822266 )
	end
	if planenum == 11 then
		planemark = createMarker ( 7.8828125,2576.2099609375,84.942314147949, "ring" )
		setElementRotation ( planemark, 0,0,197.6223449707 )
	end
	if planenum == 12 then
		planemark = createMarker ( 30.4091796875,2450.7529296875,74.69303894043, "ring" )
		setElementRotation ( planemark, 0,0,182.26872253418 )
	end
	if planenum == 13 then
		planemark = createMarker ( 11.498046875,2338.2587890625,60.250469207764, "ring" )
		setElementRotation ( planemark, 0,0,157.51611328125 )
	end
	if planenum == 14 then
		planemark = createMarker ( -37.6484375,2238.1884765625,54.070205688477, "ring" )
		setElementRotation ( planemark, 0,0,150.93521118164 )
	end
	if planenum == 15 then
		planemark = createMarker ( -102.9619140625,2163.873046875,55.926887512207, "ring" )
		setElementRotation ( planemark, 0,0,123.67224121094 )
	end
	if planenum == 16 then
		planemark = createMarker ( -180.3447265625,2111.9873046875,30.842733383179, "ring" )
		setElementRotation ( planemark, 0,0,122.73287963867 )
	end
	if planenum == 17 then
		planemark = createMarker ( -258.501953125,2087.8896484375,39.273429870605, "ring" )
		setElementRotation ( planemark, 0,0,84.192260742188 )
	end
	if planenum == 18 then
		planemark = createMarker ( -317.166015625,2100.2080078125,52.609477996826, "ring" )
		setElementRotation ( planemark, 0,0,81.374237060547 )
	end
	if planenum == 19 then
		planemark = createMarker ( -380.927734375,2095.2490234375,69.053398132324, "ring" )
		setElementRotation ( planemark, 0,0,106.43991088867 )
	end
	if planenum == 20 then
		planemark = createMarker ( -477.7705078125,2076.6728515625,81.947036743164,0,0,114.27328491211, "ring" )
		setElementRotation ( planemark, 0,0,114.27328491211 )
	end
	if planenum == 21 then
		planemark = createMarker ( -573.22265625,2109.8251953125,86.694763183594, "ring" )
		setElementRotation ( planemark, 0,0,61.005249023438 )
	end
	if planenum == 22 then
		planemark = createMarker ( -610.185546875,2194.6376953125,66.751075744629, "ring" )
		setElementRotation ( planemark, 0,0,3.9798583984375 )
	end
	if planenum == 23 then
		planemark = createMarker ( -585.1904296875,2315.525390625,88.633644104004, "ring" )
		setElementRotation ( planemark, 0,0,313.84298706055 )
	end
	if planenum == 24 then
		planemark = createMarker ( -520.6923828125,2396.8173828125,91.266906738281, "ring" )
		setElementRotation ( planemark, 0,0,328.25726318359 )
	end
	if planenum == 25 then
		planemark = createMarker ( -494.41796875,2531.1630859375,81.885894775391, "ring" )
		setElementRotation ( planemark, 0,0,3.666748046875 )
	end
	if planenum == 26 then
		planemark = createMarker ( -536.3955078125,2650.4423828125,72.302406311035, "ring" )
		setElementRotation ( planemark, 0,0,42.207366943359 )
	end
	if planenum == 27 then
		planemark = createMarker ( -602.306640625,2712.0732421875,81.125267028809, "ring" )
		setElementRotation ( planemark, 0,0,53.485015869141 )
	end
	if planenum == 28 then
		planemark = createMarker ( -671.5361328125,2752.2587890625,90.076812744141, "ring" )
		setElementRotation ( planemark, 0,0,63.197082519531 )
	end	
	setMarkerTarget ( planemark, getElementPosition ( localPlayer ) )
	planeblip = createBlipAttachedTo ( planemark, 5 ) 
	setElementData ( localPlayer, "planenum", planenum + 1 )
	addEventHandler( "onClientMarkerHit", planemark, planeMarkerHit )
	if planenum == 29 then
		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		setControlState ( "enter_exit", true )
		outputChatBox("Спасибо за просмотр видео о ходе разработке", 0,153,51)
		addEventHandler("onClientRender",root, createDXMsg )
		setTimer (
	function ()
		removeEventHandler ( "onClientRender",root, createDXMsg )
	end, 3500, 1 )
		removeEventHandler( "onClientMarkerHit", swype, MarkerHit )

  		setElementPosition ( theVehicle, xpos, ypos, zpos )
  		setElementRotation ( theVehicle, getElementData ( theVehicle, "angle" ))
	end
end 
local screenX,screenY = guiGetScreenSize()  -- Get players resolution.
x = screenX/3
y = screenY/1.5

function startSwype ( commandName )
	if tonumber(getElementData ( localPlayer, "work" )) == 3 then
	    if isPedInVehicle ( localPlayer ) then
			if getElementModel ( getPedOccupiedVehicle ( localPlayer ) ) == 574 then
				swype = createMarker ( -289.736328125,2644.2568359375,62.867656707764, "checkpoint" )
				addEventHandler( "onClientMarkerHit", swype, MarkerHit )
				setElementData ( localPlayer, "swype", 1 )
				outputChatBox ("Подсказка: Отправляйтесь по отметкам чистить улицы", source, 255,255,255 )
			else
				outputChatBox("Ошибка: В этой машине нельзя чистить улицы", 102, 0, 0)
			end
		else
		    outputChatBox("Ошибка: Вы не в машине", 102, 0, 0)
		end
	else
		outputChatBox("Ошибка: Вы не работаете чистильщиком улиц", 102, 0, 0)
	end
end
addCommandHandler ( "swype", startSwype )
