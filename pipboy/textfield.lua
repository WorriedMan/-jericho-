local adText = ""
local showingText = false
local idText = ""
local size = 1.5
local xBart = screenWidth/2-225
local yBart = screenHeight/2-240
local closeSel = false

function showTextField ( textid, text, tsize )
	if not showingText then
		showingText = true
		adText = text
		size = tsize or 1.5
		setTimer ( showCursor, 500, 1, true )
		closeLab = guiCreateLabel ( xBart+180, yBart+445, 95, 30, '', false )
		setElementData ( closeLab, 'closeTextLab', true )
		addEventHandler( "onClientMouseEnter", closeLab, closeLabEntered, false )
		addEventHandler( "onClientMouseLeave", closeLab, closeLabLeaved, false )
		addEventHandler( "onClientGUIClick", closeLab, closeLabClicked, false )
		addEventHandler ( "onClientRender", root, renderTextField )
	else
		destroyTextField ()
		if idText ~= textid then
			showTextField ( textid, text, tsize )
		end
	end
end

local text = "              Диванный патритот\n\nНам пишет Дженни Боб из Вашингтона: \"Здравствуйте, Сэм Чарльз! Меня очень беспокоит вся эта ситуация с коммунистами, расскажите пожалуйста, как собрать миниган в домашних условиях?\"\n\nЗдравствуйте, Дженни. Да, ситуация с красной заразой сейчас серьезная, вот, что вам понадобится:\n - 6 винтовок\n - 1 зарядник минигана\n - 1  лента скотча\n - 1 пачка гвоздей. Собрать зарядник минигана очень просто! Для эт...\n\n                                    Стр.22"

function destroyTextField ()
	if showingText then
		if isElement ( closeLab ) then
			destroyElement ( closeLab )
		end
		showCursor ( false )
		adText = ""
		idText = ""
		removeEventHandler ( "onClientRender", root, renderTextField )
		closeSel = false
		showingText = false
	end
end

function closeLabEntered ()
	if getElementData ( source, 'closeTextLab' ) then
		closeSel = true
		playSound ( "media/sound/ui_pipboy_select.wav" )
	end
end

function closeLabLeaved ()
	if getElementData ( source, 'closeTextLab' ) then
		closeSel = false
	end
end

function closeLabClicked ()
	if getElementData ( source, 'closeTextLab' ) then
		destroyTextField ()
	end
end


function renderTextField ()
	dxDrawRectangle ( xBart, yBart, 450, 480, tocolor ( 0, 30, 0, 250 ) )
	dxDrawLine ( xBart, yBart, xBart, yBart+480, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart, yBart+480, xBart+450, yBart+480, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart+450, yBart+480, xBart+450, yBart, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawLine ( xBart, yBart, xBart+450, yBart, tocolor ( 255, 182, 66 ), 1.5 )
	dxDrawText ( adText, xBart+10, yBart+5, xBart+420, yBart+445, tocolor ( 255, 182, 66 ), size, 'default-bold', "left", "top", false, true )
	dxDrawText ( 'Закрыть', xBart+180, yBart+445, xBart+420, yBart+490, tocolor ( 255, 182, 66 ), 1.8, 'default-bold', "left", "top", false, true )
	if closeSel then
		dxDrawLine ( xBart+175, yBart+445, xBart+280, yBart+445, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+175, yBart+445, xBart+175, yBart+475, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+175, yBart+475, xBart+280, yBart+475, tocolor ( 255, 182, 66 ), 1.3 )
		dxDrawLine ( xBart+280, yBart+475, xBart+280, yBart+445, tocolor ( 255, 182, 66 ), 1.3 )
	end
end
