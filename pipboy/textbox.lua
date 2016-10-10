local alpha = 0
local adText = ""
local fadeOut = true
local size = 0.9
local showingText = false
local fadeIn = false
local imageNum = 0

local iconGift = dxCreateTexture ( "media/icons/glow_message_giftbox.dds" )
local iconMap = dxCreateTexture ( "media/icons/glow_message_map.dds" )
local iconRadio = dxCreateTexture ( "media/icons/glow_message_radio_tower.dds" )

local images = {
	iconGift,
	iconMap,
	iconRadio
}

local messagesList = {}

function addInfoBox ( text, time, image )
	if getElementData ( localPlayer, "online" ) == 1 then
		time = time or 10
		if showingText then
			table.insert ( messagesList, { text, time, image } )
		else
			showInfoBox ( text, time, image )
		end
	end
end

addEvent( "addInfoBoxServer", true )
addEventHandler( "addInfoBoxServer", getRootElement(), addInfoBox )

function showInfoBox ( text, time, image )
	playSound ("media/msg.wav")
	showingText = true
	adText = text
	imageNum = image
	addEventHandler ( "onClientRender", root, renderTextBox )
	setTimer ( function () fadeIn = true fadeOut = false end, time*1000+1000, 1 )
	if string.len(text) > 54 then
		size = 0.7
	else
		size = 0.9
	end
end

addEvent ( "fadedIn", true )
addEventHandler("fadedIn", root, function()
	removeEventHandler ( "onClientRender", root, renderTextBox )
	alpha = 0
	fadeOut = true
	showingText = false
	if #messagesList > 0 then
		while #messagesList > 0 and adText == messagesList[1][1] do
			table.remove ( messagesList, 1 )
		end
		if #messagesList > 0 then
			showInfoBox ( messagesList[1][1], messagesList[1][2] )
		end
	end
end)

function renderTextBox ( )
	dxDrawText ( adText, screenWidth-260, screenHeight - 220, screenWidth-45, screenHeight-125, tocolor ( 255, 182, 66,alpha ), size, myFont, 'center', 'center', false, true )
	dxDrawImageSection ( screenWidth-280, screenHeight - 220, 256, 128, 515, 130, 256, 128, texture, 0, 0, 0, tocolor ( 255, 182, 66,alpha ) )
	dxDrawImageSection ( screenWidth-280, screenHeight - 240, 256, 128, 515, 130, 256, 128, texture, 180, 0, 0, tocolor ( 255, 182, 66,alpha ) )
	if imageNum then
		if imageNum > 0 then
			dxDrawImage ( screenWidth-220, screenHeight - 324, 128, 128, images[imageNum], 0, 0, 0, tocolor ( 255, 182, 66,alpha ) )
		end
	end
	if fadeIn then
		alpha = alpha-10
		if alpha < 10 then
			fadeIn = false
			triggerEvent ( "fadedIn", root )
		end
	end
	if fadeOut then
		alpha = alpha+10
		if alpha > 245 then
			alpha = 255
			fadeOut = false
		end
	end
end