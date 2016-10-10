local radLevel
local currentRadZone
local radZoneCheckTimer 
local screenWidth, screenHeight = guiGetScreenSize()
seperator = dxCreateTexture ( "glow_messages_radiation_seperator_right.dds", "argb" )
arrow = dxCreateTexture ( "glow_messages_radiation_seperator_arrow.dds", "argb" )

function checkRadZone ()
	if isElement ( currentRadZone ) and isElementWithinColShape (localPlayer,currentRadZone) then
		local xC, yC, zC = getElementPosition ( currentRadZone )
		local xP, yP, zP = getElementPosition ( localPlayer )
		local distance = getDistanceBetweenPoints2D ( xP, yP, xC, yC )
		local radius = getElementData ( currentRadZone, 'radius' ) or 10
		local level = getElementData ( currentRadZone, 'level' ) or 10
		local onepercent = level/radius
		local radiation = math.floor(level-onepercent*distance)
		if radiation < 1 then radiation = 1 end
		local str_type = "low"
		if radiation > 3 and radiation < 6 then
			str_type = "med"
		elseif radiation >= 6 then
			str_type = "hi"
		end
		playSound ( "sounds/"..str_type.."/"..str_type.."_"..tostring(math.random(1,3))..".mp3" )
		radLevel = radiation
	else
		if isTimer (radZoneCheckTimer) then
			killTimer (radZoneCheckTimer)
		end
		removeEventHandler ( "onClientRender", root, renderRadInfo )
	end
end

function onClientColShapeHit( theElement, matchingDimension )
    if theElement == getLocalPlayer() and getElementData ( source, "radZone" ) then
		if isTimer ( radZoneCheckTimer ) then
			killTimer ( radZoneCheckTimer )
			removeEventHandler ( "onClientRender", root, renderRadInfo )
		end
		radLevel = 0
		currentRadZone = source
		radZoneCheckTimer = setTimer (checkRadZone,1000,0)
		addEventHandler ( "onClientRender", root, renderRadInfo )
    end
end
addEventHandler("onClientColShapeHit",getRootElement(),onClientColShapeHit)

function renderRadInfo ( )
	if radLevel then
		dxDrawImage ( screenWidth-512, 0, 512, 128, seperator, 0, 0, 0, tocolor ( 255, 50, 50 ) )
		local maxRad = getElementData ( localPlayer, "rplvl" )*100
		local x = 295/maxRad*getElementData(localPlayer, "rad" )-365
		dxDrawImage ( screenWidth+x, 20, 64, 32, arrow, 0, 0, 0, tocolor ( 255, 50, 50 ) ) -- -365 ноль -75 максимум
		dxDrawText ( "+"..tostring(radLevel).." РАД/СЕК", screenWidth, 52, screenWidth-50, screenHeight, tocolor ( 255, 50, 50 ), 2, "default-bold", "right" )
	end
end
