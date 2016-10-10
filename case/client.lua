local itemsOrder = {}
local screenWidth,screenHeight = guiGetScreenSize()
local itemSize = 128
local betweenItems = 5
local caseRenderTarget
local itemsInRow = 3
local stopOnItem = 19
local itemsInCase = stopOnItem+2
local forText = 20
local timeGoing = 7000
local progressPerFrame = stopOnItem/timeGoing
local arrow
local vtec
local arrowSize = 64
local vtecSizeX, vtecSizeY = 128, 64
local additTextSize = 65
local backSizeX, backSizeY = itemsInRow*(itemSize+betweenItems), itemSize+vtecSizeY+arrowSize+forText+additTextSize
local posX, posY = screenWidth/2-backSizeX/2, screenHeight/2-backSizeY/2
local progress
local lastX = betweenItems
local openingGoing
local itemOffset

local items = {
	{name = "Броня Рейнджера",color = tocolor(182,182,255),id=98,quant=1}, -- 1
	{name = "Силовая броня",color = tocolor(255,50,50),id=99,quant=1}, -- 2
	{name = "Нитки и иголка (x10)",color = tocolor(255,255,255),id=73,quant=10}, -- 3
	{name = "Ткани (x10)",color = tocolor(255,255,255),id=72,quant=10}, -- 4
	{name = "Броня солдата",color = tocolor(182,182,255),id=96,quant=1}, -- 5 
	{name = "9-мм пистолет",color = tocolor(255,255,255),id=129,quant=1}, -- 6
	{name = "9-мм пистолет+",color = tocolor(182,182,255),id=132,quant=1}, -- 7
	{name = "Мария",color = tocolor(182,182,255),id=133,quant=1}, -- 8
	{name = "12,7-мм пистолет",color = tocolor(255,255,255),id=138,quant=1}, -- 9
	{name = "Охотничий револьвер",color = tocolor(255,255,255),id=144,quant=1}, -- 10
	{name = "10-мм пистолет",color = tocolor(255,255,255),id=34,quant=1}, -- 11
	{name = "Револьвер Магнум кал. 357",color = tocolor(255,255,255),id=140,quant=1}, -- 12
	{name = "10-мм пистолет-пулемёт",color = tocolor(255,255,255),id=35,quant=1}, -- 13
	{name = "10-мм пистолет+",color = tocolor(182,182,255),id=148,quant=1}, -- 14
	{name = "Бластер Чужих",color = tocolor(255,50,50),id=143,quant=1}, -- 15
	{name = "Винтовка Гаусса",color = tocolor(255,50,50),id=136,quant=1}, -- 16
}

function loadCasesData ()
	arrow = dxCreateTexture ( "arrow.dds" )
	vtec = dxCreateTexture ( "vtec.dds" )
	for i, v in ipairs ( items ) do
		v.loaded = exports.pipboy:getItemTexture(v.id)	
	end
end

function showCaseOpening (pack)
	if openingGoing then
		return false
	end
	triggerServerEvent("case:selectRandomItem",getLocalPlayer(),pack)
	openingGoing = true
end

function recieveCaseOpening(itemsO)
	if not arrow or not vtec or not items[1].loaded then
		loadCasesData ()
	end
	itemsOrder = itemsO
	caseRenderTarget = dxCreateRenderTarget( (itemSize+betweenItems)*itemsInCase+betweenItems*itemsInCase, itemSize+20 )
	if caseRenderTarget then
		dxSetRenderTarget( caseRenderTarget )
			for i = 1, itemsInCase do
				local item = items[itemsOrder[i]]
				dxDrawImage ( (i-1)*(itemSize+betweenItems), 0, itemSize, itemSize, item.loaded, 0, 0, 0, item.color )
				dxDrawLine ( (i-1)*(itemSize+betweenItems), 0, (i-1)*(itemSize+betweenItems)+itemSize, 0, tocolor ( 255, 182, 66 ), 2 )
				dxDrawLine ( (i-1)*(itemSize+betweenItems), 0, (i-1)*(itemSize+betweenItems), itemSize+forText, tocolor ( 255, 182, 66 ), 2 )
				dxDrawLine ( (i-1)*(itemSize+betweenItems)+itemSize, 0, (i-1)*(itemSize+betweenItems)+itemSize, itemSize+forText, tocolor ( 255, 182, 66 ), 2 )
				dxDrawLine ( (i-1)*(itemSize+betweenItems)+itemSize, 0, (i-1)*(itemSize+betweenItems)+itemSize, itemSize+forText, tocolor ( 255, 182, 66 ), 2 )
				dxDrawLine ( (i-1)*(itemSize+betweenItems), itemSize+forText, (i-1)*(itemSize+betweenItems)+itemSize, itemSize+forText, tocolor ( 255, 182, 66 ), 2 )
				dxDrawText ( item.name, (i-1)*(itemSize+betweenItems), itemSize-10, (i-1)*(itemSize+betweenItems)+itemSize, itemSize+forText, tocolor ( 255, 182, 66 ), 0.9, "default-bold","center", "top", false, true)
			end
		dxSetRenderTarget()
	end
	itemOffset = math.random (-itemSize/2,itemSize/2)
	progress = 0
	addEventHandler( "onClientRender", root, drawCaseItems )
	setTimer (hideCaseOpening,timeGoing+4000,1)
	setTimer(playSound,2000,1,"slot.ogg")
end

addEvent( 'case:recieveCaseOpening', true );
addEventHandler( 'case:recieveCaseOpening', root, recieveCaseOpening )

function hideCaseOpening()
	removeEventHandler( "onClientRender", root, drawCaseItems )
	caseRenderTarget = nil
	openingGoing = false
end

function isOpeningGoing ()
	return openingGoing
end

function drawCaseItems()
	if lastX <= (stopOnItem-(itemsInRow-2))*(itemSize+betweenItems)+itemOffset then
		lastX = interpolateBetween (0,0,0,(stopOnItem-2)*(itemSize+betweenItems)+itemOffset,0,0,progress,"InOutQuad")
		progress = progress+progressPerFrame
	end
	dxDrawRectangle ( posX, posY-vtecSizeY, backSizeX, backSizeY, tocolor ( 0, 10, 0, 180 ) )
	if caseRenderTarget then
		dxDrawImageSection ( posX, posY, (itemSize+betweenItems)*itemsInRow, itemSize+20, lastX, 0, (itemSize+betweenItems)*itemsInRow, itemSize+20, caseRenderTarget )
	end
	dxDrawImage ( posX+((itemSize+betweenItems)*itemsInRow)/2-arrowSize/2, posY+itemSize+forText-arrowSize/2, arrowSize, arrowSize, arrow, 180, 0, 0, tocolor ( 255, 182, 66 ) )
	dxDrawImage ( posX+((itemSize+betweenItems)*itemsInRow)/2-vtecSizeX/2, posY-vtecSizeY, vtecSizeX, vtecSizeY, vtec, 180, 0, 0, tocolor ( 255, 182, 66 ) )
	if progress < 1 then
		dxDrawText ( "Система случайного* подбора выбирает вам приз!", posX, posY+itemSize+forText+10, posX+backSizeX, posY+itemSize+forText+10+30, tocolor ( 255, 182, 66 ), 1, "default-bold","center", "top")
		dxDrawText ( "* под случайным понимается НЕЗАВИСИМЫЙ ОТ ПРЯМОГО ВОЗДЕЙСТВИЯ ИЗВНЕ выбор, производимый внутренним процессором ланчбокса, разработанным в компании Волт-Тек. Выбор производится на основании времени, местоположения, погодных условий, курса акций Волт-Тек, наличия зарезервированного места в убежище компании Волт-Тек у владельца ланчбокса и других СЕКРЕТНЫХ факторов, на которые не может повлиять ни владелец ланчбокса, ни производитель. С полным перечнем факторов можно ознакомиться по запросу суда. Данная информация не может быть использована против компании Волт-Тек в суде.", posX, posY+itemSize+forText+30, posX+backSizeX, posY+itemSize+forText+10+30, tocolor ( 255, 182, 66 ), 0.8, "default-bold","center", "top", false, true)
	else
		dxDrawText ( "Поздравляем! Вы выиграли:\n"..items[itemsOrder[stopOnItem]].name, posX, posY+itemSize+forText+10, posX+backSizeX, posY+itemSize+forText+10+30, tocolor ( 255, 182, 66 ), 1.2, "default-bold","center", "top")
	end
end