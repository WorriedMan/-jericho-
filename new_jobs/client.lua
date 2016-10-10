	ncWorkPickup = createPickup ( -728.4619140625,2069.6240,60.3347, 3, 1239 )
	nvWorkPickup = createPickup ( -271.740234375,2691.828125,62.6875, 3, 1239 )
	scWorkPickup = createPickup ( -288.1234,1495.157,76.21, 3, 1239 )
	rivetWorkPickup = createPickup ( -2989.453,481.403,4.914, 3, 1239 )
	roadtownWorkPickup = createPickup ( 2152.636, -1556.29, 2.492, 3, 1239 )
local myWorkingMarker
local myWork = false
	
function workPickup(player)
	if player ~= localPlayer then return end
	if not myWork then
		destroyMyWorkingMarker()
		if source == ncWorkPickup then
			exports.pipboy:addInfoBox("Толстушке Бэтси нужен человек, который привезет ей несколько пачек чая для похудения", 3 )
			exports.pipboy:addInfoBox("Чтобы принять эту работу, нажмите E", 2 )
			bindKey ( "E", "down", startFindWork, 1 )
			local colshape = getElementColShape ( source )
			addEventHandler( "onClientColShapeLeave", colshape, workPickupLeave ) 
		elseif source == nvWorkPickup then
			exports.pipboy:addInfoBox("Старый Генри ищет смелого парня, который смог бы найти для него пару колод карт", 3 )
			exports.pipboy:addInfoBox("Чтобы принять эту работу, нажмите E", 2 )
			bindKey ( "E", "down", startFindWork, 2 )
			local colshape = getElementColShape ( source )
			addEventHandler( "onClientColShapeLeave", colshape, workPickupLeave ) 
		elseif source == scWorkPickup then
			exports.pipboy:addInfoBox("Отец Фифан ищет помошника, который добудет для него несколько библий", 3 )
			exports.pipboy:addInfoBox("Чтобы принять эту работу, нажмите E", 2 )
			bindKey ( "E", "down", startFindWork, 3 )
			local colshape = getElementColShape ( source )
			addEventHandler( "onClientColShapeLeave", colshape, workPickupLeave ) 
		elseif source == rivetWorkPickup then
			exports.pipboy:addInfoBox("Доктору Стрэнджлаву надо найти немного ядерного материала.", 3 )
			exports.pipboy:addInfoBox("Чтобы принять эту работу, нажмите E", 2 )
			bindKey ( "E", "down", startFindWork, 4 )
			local colshape = getElementColShape ( source )
			addEventHandler( "onClientColShapeLeave", colshape, workPickupLeave ) 
		elseif source == roadtownWorkPickup then
			exports.pipboy:addInfoBox("Вы нашли объявление о поиске деталей для автомобиля.", 3 )
			exports.pipboy:addInfoBox("Чтобы принять эту работу, нажмите E", 2 )
			bindKey ( "E", "down", startFindWork, 5 )
			local colshape = getElementColShape ( source )
			addEventHandler( "onClientColShapeLeave", colshape, workPickupLeave ) 
		end
	end
end

addEventHandler ( "onClientPickupHit", getResourceRootElement(), workPickup )

function workPickupLeave (player)
	if player == localPlayer then
		removeEventHandler( "onClientColShapeLeave", source, workPickupLeave ) 
		unbindKey ( "E", "down", startFindWork )
	end
end

function startFindWork ( key, state, city )
	if not myWork then
		unbindKey ( "E", "down", startFindWork )
		local coord
		if city == 1 then
			coord = getRandomCoordDesert()
		elseif city == 2 then
			coord = getRandomCoordLV()
		elseif city == 3 then -- Фифан
			coord = getRandomCoordChiliad()
		elseif city == 4 then
			coord = getRandomCoordSF()
		elseif city == 5 then
			coord = getRandomCoordLS()
		end
		myWork = city
		exports.pipboy:addInfoBox( "Вы получили на карту PipBoy отметку с примерным положением цели",4 )
		exports.pipboy:addMapIcon( coord[1],coord[2],coord[3],3,"Цель" )
		myWorkingMarker = createMarker ( coord[1],coord[2],coord[3], "checkpoint", 3, 255, 102, 204, 0 )
		addEventHandler( "onClientMarkerHit", myWorkingMarker, workPlaceHit )
		addEventHandler( "onClientMarkerLeave", myWorkingMarker, workPlaceLeave )
	end
end

function workPlaceHit(player)
	if player == localPlayer then
		if source == myWorkingMarker then
			exports.pipboy:addInfoBox( "Нажмите кнопку У для поиска",3 )
			bindKey ( "E", "down", startFindPlace )
		end
	end
end

function workPlaceLeave(player)
	if player == localPlayer then
		if source == myWorkingMarker then
			exports.pipboy:addInfoBox( "Нажмите кнопку У для поиска",3 )
			unbindKey ( "E", "down", startFindPlace )
		end
	end
end

function startFindPlace ( key )
	if myWork then
		local x, y, z = getElementPosition ( localPlayer )
		local xm, ym, zm = getElementPosition(myWorkingMarker)
   		if myWork == 1 or math.random(1, 20) > 1 then
			if myWork == 1 then
				exports.pipboy:addInfoBox( "Вы нашли несколько пачек чая для похудения! Награда: 80 крышек",3 )
				triggerServerEvent("giveClientMoney",localPlayer,80)
			elseif myWork == 2 then
				if not giveRandomLanchBox(80) then
					exports.pipboy:addInfoBox( "Вы нашли несколько колод игральных карт! Награда: 500 крышек",3 )
					triggerServerEvent("giveClientMoney",localPlayer,500)
				end
			elseif myWork == 3 then
				if not giveRandomLanchBox(70) then
					exports.pipboy:addInfoBox( "Вы нашли библию! Награда: 700 крышек",3)
					triggerServerEvent("giveClientMoney",localPlayer,700)
				end
			elseif myWork == 4 then
				if not giveRandomLanchBox(60) then
					exports.pipboy:addInfoBox( "Вы нашли ядерный материал! Награда: 350 крышек",3)
					triggerServerEvent("giveClientMoney",localPlayer,350)
				end
			elseif myWork == 5 then
				if not giveRandomLanchBox(50) then
					exports.pipboy:addInfoBox( "Вы нашли запчасти от автомобиля! Награда: 150 крышек",3)
					triggerServerEvent("giveClientMoney",localPlayer,150)
				end
			end
		else
		    exports.pipboy:addInfoBox( "Здесь ничего нету, наверное вас обманули...",3)
		end
		unbindKey ( "E", "down", startFindPlace )
  		myWork = false
		triggerServerEvent("givePlayerGroupRating",localPlayer,10)
		exports.pipboy:deleteMapIconByText( "Цель" )
  		destroyMyWorkingMarker()
	end
end

function giveRandomLanchBox(maxnum)
	if math.random(1,maxnum) == 1 then
		exports.pipboy:addInfoBox( "Вы нашли Ланчбокс Волт-Тек!!! Быстрее открывайте его!",3 )
		if math.random(1,2) == 1 then
			exports.inventory:givePlayerItemWW(151,1)
		else
			exports.inventory:givePlayerItemWW(158,1)
		end
		return true
	end					
	return false
end

function destroyMyWorkingMarker()
	if isElement(myWorkingMarker) then
		destroyElement(myWorkingMarker)
	end
end

function moveMe ()
		local xm, ym, zm = getElementPosition(myWorkingMarker)
	setElementPosition ( localPlayer,xm, ym, zm )
end

addCommandHandler("kek",moveMe)
