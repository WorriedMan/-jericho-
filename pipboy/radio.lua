radioWindowShowing = false
soundVolume = 0.6
currentlyPlaying = 1

function createRadioWindow ()
	radioWindowShowing = true
	createPipButton ( "radio_nv", xPip+300, yPip+100, 175, 30, "Радио \"Нового Вегаса\"", 1.2, 255, 255, 200, "default" )
	createPipButton ( "radio_old", xPip+300, yPip+140, 145, 30, "\"Big Band Cantina\"", 1.2, 255, 255, 200, "default" )
	createPipButton ( "radio_old2", xPip+300, yPip+180, 135, 30, "\"Old World Blues\"", 1.2, 255, 255, 200, "default" )
	createPipButton ( "radio_country", xPip+300, yPip+220, 175, 30, "Радио \"Новой Деревни\"", 1.2, 255, 255, 200, "default" )
	createPipButton ( "radio_old3", xPip+300, yPip+260, 180, 30, "*название неизвестно*", 1.2, 255, 255, 200, "default" )
	createPipButton ( "sound_p", xPip+300, yPip+365, 115, 20, "ГРОМКОСТЬ +", 1.1, 255, 182, 66, "default" )
	createPipButton ( "sound_m", xPip+430, yPip+365, 115, 20, "ГРОМКОСТЬ -", 1.1, 255, 182, 66, "default" )
end

function deleteRadioButtons ()
	destroyPipButtonByName ('radio_nv')
	destroyPipButtonByName ('radio_old')
	destroyPipButtonByName ('radio_old2')
	destroyPipButtonByName ('radio_country')
	destroyPipButtonByName ('radio_old3')
	destroyPipButtonByName ('sound_p')
	destroyPipButtonByName ('sound_m')
end	

function renderRadioWindow ()
	dxDrawText ( 'PipBoy-2000 (c) поймал 5 радиостанции, \nвыберите одну для прослушивания.', xPip+300, yPip+40, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 0.7, myFont )
	dxDrawText ( 'Громкость: '..string.sub(tostring(soundVolume), 1, 4 ), xPip+350, yPip+330, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.4, "default" )
	if currentlyPlaying > 0 then
		dxDrawRectangle ( xPip+500, cubesCoords[currentlyPlaying], 16, 16, tocolor ( 255, 255, 200 )  )
	end
end

function infoButtonClicked (button)
	if button.name == 'sound_p' then
		if soundVolume < 1 then
			soundVolume = soundVolume+0.1
			if radioCh then
				setSoundVolume ( radioCh, soundVolume )
			end
		end
	elseif button.name == 'sound_m' then
		if soundVolume > 0.1 then
			soundVolume = soundVolume-0.1
			if radioCh then
				setSoundVolume ( radioCh, soundVolume )
			end
		end
	elseif button.name == 'radio_nv' then
		 startRadio (1)
	elseif button.name == 'radio_old' then
		startRadio (2)
	elseif button.name == 'radio_old2' then
		startRadio (3)
	elseif button.name == 'radio_country' then
		startRadio (4)
	elseif button.name == 'radio_old3' then
		startRadio (5)
	end
end

cubesCoords = {
	yPip+105,
	yPip+145,
	yPip+185,
	yPip+225, 
	yPip+265,

}

radioChannels = {
	"http://listen.streamlicensing.com/1464_128.pls",
	"http://calmradio.com/playlists-free/postwarhits.pls",
	"http://addictedtoradio.com/Listen/PLS/1CFM16710.pls",
	"http://radiochoice.net/listen/bigoldies.pls",
	"http://www.977music.com/itunes/oldies.pls",
}

function startRadio (id)
	--if alarm then
	if currentlyPlaying ~= id or not getElementData(localPlayer,"radioNV") then
		addInfoBox ( 'Радио включается, подождите', 2 )
		if radioCh then
			stopSound ( radioCh )
		end
		radioCh = playSound ( radioChannels[id] )
		currentlyPlaying = id
		setSoundVolume ( radioCh, soundVolume )
		setElementData ( localPlayer, "radioNV", true )
		alarm = false
	else
		alarm = true
		stopSound ( radioCh )
		radioCh = nil
		setElementData ( localPlayer, "radioNV", false )
		--currentlyPlaying = 0
	end
end

addEvent ( "pipButtonClicked", true )
addEventHandler ( 'pipButtonClicked', root, infoButtonClicked)