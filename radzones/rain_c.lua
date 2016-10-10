local radLevel = 0
local screenWidth, screenHeight = guiGetScreenSize()

function renderRainRadInfo ( )
	if getElementData ( localPlayer, "radRain" ) and exports.utils:isPlayerInBuilding() then
		return true
	end
	dxDrawImage ( screenWidth-512, 0, 512, 128, seperator, 0, 0, 0, tocolor ( 255, 50, 50 ) )
	local maxRad = getElementData ( localPlayer, "rplvl" )*100
	local x = 295/maxRad*getElementData(localPlayer, "rad" )-365
	dxDrawImage ( screenWidth+x, 20, 64, 32, arrow, 0, 0, 0, tocolor ( 255, 50, 50 ) ) -- -365 ноль -75 максимум
	dxDrawText ( "+"..string.sub(tostring(radLevel),1,3).." РАД/СЕК", screenWidth, 52, screenWidth-50, screenHeight, tocolor ( 255, 50, 50 ), 2, "default-bold", "right" )
end

function onClientColShapeHit( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) then
        if getElementData ( source, 'rainCircle' ) then
			if not getElementData ( localPlayer, 'rainCircleLink' ) then
				setElementData ( localPlayer, 'rainCircleLink', source )
				checkRainPlayer ()
			end
		end
    end
end
addEventHandler("onClientColShapeHit",getResourceRootElement(),onClientColShapeHit)

function checkRainPlayer ()
	local rainCircle = getElementData ( localPlayer, 'rainCircleLink' )
	if not isElement ( rainCircle ) then stopRain(true); return true end
	if not isElementWithinColShape ( localPlayer, rainCircle ) then stopRain(true); return true end
	local xC, yC, zC = getElementPosition ( rainCircle )
	local xP, yP, zP = getElementPosition ( localPlayer )
	local distance = getDistanceBetweenPoints2D ( xP, yP, xC, yC )
	local radius = getElementData ( rainCircle, 'radius' )
	local perc = radius/100
	local level = ((radius-distance)/perc/100)+((radius-distance)/perc/100)
	setRainLevel ( level )
	if level > 0.5 and not getElementData ( localPlayer, 'inRadZone' ) and not getElementData ( localPlayer, "safezone.id" ) then
		if radLevel == 0  then
			setElementData ( localPlayer, 'radRain', true )
			addEventHandler ( "onClientRender", root, renderRainRadInfo )
			rainRadSound = playSound ( "sounds/low/low_"..tostring(math.random(1,3))..".mp3" )
			if isElement ( rainRadSound ) then
				setTimer ( changeRainZoneSound, getSoundLength ( rainRadSound )*1000, 1 )
			end
		end
		radLevel = level*3
		if getElementData ( localPlayer, "perk16" ) then
			radLevel = radLevel*0.5
		end
		if not exports.utils:isPlayerInBuilding() then
			exports.players:givePlayerRadClient (radLevel)
			if getElementData ( localPlayer, 'perk22' ) and getElementData ( localPlayer, "antiRadWear" ) == 0 then
				local h = getElementData ( localPlayer, 'health' )
				local maxHealth = getElementData ( localPlayer, 'maxHealth' )
				if h < maxHealth then
					if h+level > maxHealth then
						setElementData ( localPlayer, 'health', maxHealth )
					else
						setElementData ( localPlayer, 'health', h+level )
					end
				end
			end
		end
	elseif level <= 0.5 and radLevel > 0 then
		removeEventHandler ( "onClientRender", root, renderRainRadInfo )
		setElementData ( localPlayer, 'radRain', false )
		if isElement(rainRadSound) then
			destroyElement(rainRadSound)
		end
		radLevel = 0
	end
	setTimer ( checkRainPlayer, 2000, 1 )
end

function stopRain ( wr )
	if wr then
		setElementData ( localPlayer, 'rainCircleLink', false )
		setRainLevel ( 0 )
	end
	if radLevel > 0 then
		setElementData ( localPlayer, 'radRain', false )
		removeEventHandler ( "onClientRender", root, renderRainRadInfo )
		if isElement(rainRadSound) then
			destroyElement(rainRadSound)
		end
	end
end

function changeRainZoneSound ()
	if isElement ( rainRadSound ) then 
		destroyElement ( rainRadSound )
		if getElementData ( localPlayer, "radRain" ) then
			local rain = getRainLevel ()
			local str_type
			if rain < 0.9 then
				str_type = 'low'
			elseif rain < 1.5 then
				str_type = 'med'
			else
				str_type = 'hi'
			end
			rainRadSound = playSound ( "sounds/"..str_type.."/"..str_type.."_"..tostring(math.random(1,3))..".mp3" )
			if isElement ( rainRadSound ) then
				setTimer ( changeRainZoneSound, getSoundLength ( rainRadSound )*1000, 1 )
			end
		end
	end
end