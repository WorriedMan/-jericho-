local ambiSound = nil
local stopAmbiSoundTimer = nil
local checkDesertTimer = nil
local ambiSmallSound = nil
local checkDesertTimerSmall = nil
local checkCitySmallTimer = nil
local citySmallSound = nil

local lvCol = createColPolygon ( -2843.0703125,-505.2607421875, -1268.5712890625,-428.5712890625, -2897.142578125,1551.427734375, -1448.5712890625,1500 )
local sfCol = createColPolygon ( 1152.48046875,673.2060546875, 994.28515625,2880, 2828.5712890625,2871.42773437, 2880,882.8564453125 )
local lsCol = createColPolygon ( 1327.056640625,-2624.5478515625, 1001.482421875,-1877.1650390625, 99.42578125,-1663.775390625,250.3134765625,-1018.1513671875, 2860.1943359375,-863.8359375,2827.2275390625,-2658.193359375 )

function onClientColShapeHit( theElement, matchingDimension )
	if matchingDimension and theElement == getLocalPlayer () then
		setTimer ( playCitySmallAmbient, 1000, 1 )
	end
end

function onClientColShapeLeave( theElement, matchingDimension )
	if isTimer ( checkCitySmallTimer ) and theElement == localPlayer then
		killTimer ( checkCitySmallTimer )
	end
end

addEventHandler("onClientColShapeHit",lvCol,onClientColShapeHit)
addEventHandler("onClientColShapeLeave",lvCol,onClientColShapeHit)
addEventHandler("onClientColShapeHit",sfCol,onClientColShapeHit)
addEventHandler("onClientColShapeLeave",sfCol,onClientColShapeHit)
addEventHandler("onClientColShapeHit",lsCol,onClientColShapeHit)
addEventHandler("onClientColShapeLeave",lsCol,onClientColShapeHit)

function playCitySmallAmbient ()
	if getElementData ( localPlayer, "loged" ) then
		if ( not isElement ( ambiSound )) and ( not isElement ( ambiSmallSound )) and not getElementData ( localPlayer, "safezone.id" ) and (getElementDimension ( localPlayer ) == 0) and (getElementInterior ( localPlayer ) == 0) and ( getElementData ( localPlayer, "radioNV" ) == false ) then
			if not isElement(citySmallSound) then
				if math.random ( 1,3 ) == 1 then 
					local sound = 1
					local ambiString = "crumbling"
					if math.random ( 1, 2 ) ==  1 then
						sound = math.random ( 1,11 )
					else
						sound = math.random ( 1,18 )
						ambiString = "creaking"
					end
					soundString = tostring ( sound )
					if sound < 10 then
						soundString = "0"..soundString
					end
					citySmallSound = playSound ( "/city/"..ambiString.."/amb_r_"..ambiString.."_"..soundString..".ogg" )
					setSoundVolume ( citySmallSound, 0.6 )
					ambiSmallSoundTimer = setTimer ( stopAmbiSound, math.floor (getSoundLength ( citySmallSound ))*1000, 1 )
				end
			end
			checkCitySmallTimer = setTimer ( playCitySmallAmbient, 20000, 1 )
		else
			if not isElement(citySmallSound) then
				checkCitySmallTimer = setTimer ( playCitySmallAmbient, 10000, 1 )
			else
				stopSound ( citySmallSound )
				citySmallSound = nil
				killTimer ( checkCitySmallTimer )
				checkCitySmallTimer = setTimer ( playCitySmallAmbient, 60000, 1 )
			end
		end
	else
		checkCitySmallTimer = setTimer ( playCitySmallAmbient, 50000, 1 )
	end
end

local desertSounds = {
	"wast1.ogg",
	"wast2.ogg",
	"wast3.ogg",
	"wast4.ogg",
	"wast5.ogg",
	"wast6.ogg",
	"wast7.ogg",
	"wast8.ogg",
	"wast9.ogg",
	"wast10.ogg",
}

local ambiMusVariants = {
	'day',
	'creepy',
	'peaceful',
}

function playDesertSmallAmbient ()
	if getElementData ( localPlayer, "loged" ) then
		if ( not isElement ( ambiSound )) and not getElementData ( localPlayer, "safezone.id" ) and (getElementDimension ( localPlayer ) == 0) and (getElementInterior ( localPlayer ) == 0) and ( getElementData ( localPlayer, "radioNV" ) == false ) then
			if not isElement(ambiSmallSound) then
				if math.random ( 1,3 ) == 1 then 
					local sound = math.random ( 1,121 )
					soundString = tostring ( sound )
					if sound < 10 then
						soundString = "0"..soundString
					end
					if sound < 100 then
						soundString = "0"..soundString
					end
					local ambistring = math.random(1,#ambiMusVariants)
					ambiSmallSound = playSound ( "/mus/inc/"..ambistring.."/mus_inc_"..ambistring.."-"..soundString..".ogg" )
					setSoundVolume ( ambiSmallSound, 0.6 )
					ambiSmallSoundTimer = setTimer ( stopAmbiSound, math.floor (getSoundLength ( ambiSmallSound ))*1000, 1 )
				end
			end
			checkDesertTimerSmall = setTimer ( playDesertSmallAmbient, 20000, 1 )
		else
			if not isElement(ambiSmallSound) then
				checkDesertTimerSmall = setTimer ( playDesertSmallAmbient, 10000, 1 )
			else
				stopSound ( ambiSmallSound )
				ambiSmallSound = nil
				killTimer ( ambiSmallSoundTimer )
				checkDesertTimerSmall = setTimer ( playDesertSmallAmbient, 60000, 1 )
			end
		end
	else
		checkDesertTimerSmall = setTimer ( playDesertSmallAmbient, 50000, 1 )
	end
end

function playDesertAmbient ()
	if getElementData ( localPlayer, "online" ) == 1 then
		if not getElementData ( localPlayer, "safezone.id" ) and (getElementDimension ( localPlayer ) == 0) and (getElementInterior ( localPlayer ) == 0) and ( getElementData ( localPlayer, "radioNV" ) == false ) then
			if not isElement(ambiSound) then
				if math.random ( 1,3 ) == 1 then 
					local sound = math.random ( 1,4 )
					ambiSound = playSound ( desertSounds[sound] )
					ambiSoundTimer = setTimer ( stopAmbiSound, math.floor (getSoundLength ( ambiSound ))*1000, 1 )
				end
			end
			checkDesertTimer = setTimer ( playDesertAmbient, 5000, 1 )
		else
			if not isElement(ambiSound) then
				checkDesertTimer = setTimer ( playDesertAmbient, 10000, 1 )
			else
				stopSound ( ambiSound )
				ambiSound = nil
				killTimer ( ambiSoundTimer )
				checkDesertTimer = setTimer ( playDesertAmbient, 240000, 1 )
			end
		end
	else
		checkDesertTimer = setTimer ( playDesertAmbient, 10000, 1 )
	end
end

function stopAmbiSound ()
	if isElement(ambiSound) then
		destroyElement ( ambiSound )
		ambiSound = nil
		setTimer ( playDesertAmbient, 300000, 1 )
		killTimer ( checkDesertTimer )
	end
	if isElement(ambiSmallSound) then
		destroyElement ( ambiSmallSound )
		ambiSmallSound = nil
		setTimer ( playDesertSmallAmbient, 30000, 1 )
		killTimer ( checkDesertTimerSmall )
	end
	if isElement(citySmallSound) then
		destroyElement ( citySmallSound )
		citySmallSound = nil
		setTimer ( playDesertAmbient, 60000, 1 )
		if isTimer ( checkCitySmallTimer ) then
			killTimer ( checkCitySmallTimer )
		end
	end
end

addEventHandler ( "onClientResourceStart",  getResourceRootElement(getThisResource()), 
	function ()
		setTimer ( playDesertAmbient, 180000, 1 )
		setTimer ( playDesertSmallAmbient, 30000, 1 )
	end)