fullStatsWindowShowing = false

local function statsButtonClicked (button)
	if button.name == 'turn_muuav' then
		setElementData ( localPlayer, "speedShow", true)
		destroyPipButtonByName ('turn_muuav')
	elseif button.name == "show_perks" then
		deleteFullStatsButtons ()
		createPerksWindow()
	end
end

function createFullStatsWindow ()
	fullStatsWindowShowing = true
	if not getElementData ( localPlayer, "speedShow" ) then
		createPipButton ( "turn_muuav", xPip+300, yPip+100, 195, 30, "Активировать модуль УУиВ", 1.2, 255, 182, 66, "default" )
	end
	createPipButton ( "show_perks", xPip+300, yPip+200, 90, 30, "МОИ ПЕРКИ", 1.2, 255, 182, 66, "default" )
	addEventHandler ( 'pipButtonClicked', root, statsButtonClicked)
end

function deleteFullStatsButtons ()
	destroyPipButtonByName ('turn_muuav')
	destroyPipButtonByName ('show_perks')
	fullStatsWindowShowing = false
	removeEventHandler ( 'pipButtonClicked', root, statsButtonClicked)
end	

function renderFullStatsWindow ()
	--dxDrawText ( 'PipBoy-2000 (c) поймал 4 радиостанции, \nвыберите одну для прослушивания.', xPip+300, yPip+40, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 0.7, myFont )
	if getElementData ( localPlayer, "speedShow" ) then
		dxDrawText ( 'Модуль УУиВ активирован.', xPip+300, yPip+105, screenWidth, screenHeight, tocolor ( 255, 255, 200 ), 0.7, myFont )
	end
	dxDrawText ( 'Голод: '..(getElementData (localPlayer, "eat") or 0 ).."%", xPip+300, yPip+140, screenWidth, screenHeight, tocolor ( 255, 255, 200 ), 0.7, myFont )
	dxDrawText ( 'Сопротивление урону (СУ): '..(getElementData (localPlayer, "tempdt") or 0 ).." ед.", xPip+300, yPip+170, screenWidth, screenHeight, tocolor ( 255, 255, 200 ), 0.7, myFont )
--	dxDrawText ( 'Громкость: '..string.sub(tostring(soundVolume), 1, 4 ), xPip+350, yPip+330, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.4, "default" )
end
addEvent ( "pipButtonClicked", true )