function loadRadZones ()
	local radzones = getElementsByType ( "radzone" )
	for i,radzoneNum in ipairs(radzones) do
		local radzone = createColSphere ( tonumber(getElementData ( radzoneNum, "posX" )), tonumber(getElementData ( radzoneNum, "posY" )), tonumber(getElementData ( radzoneNum, "posZ" )), tonumber(getElementData ( radzoneNum, "size" )) )
		setElementData ( radzone, "radZone", true )
		setElementData ( radzone, "level", tonumber(getElementData ( radzoneNum, "level" )) )
		setElementData ( radzone, "radius", tonumber(getElementData ( radzoneNum, "size" )) )
		createObject ( 2079, tonumber(getElementData ( radzoneNum, "posX" )), tonumber(getElementData ( radzoneNum, "posY" )), tonumber(getElementData ( radzoneNum, "posZ" )), 0, 0, math.random ( 0,360 ) ) -- 322
		local bomb = createObject ( 1636, tonumber(getElementData ( radzoneNum, "posX" )), tonumber(getElementData ( radzoneNum, "posY" )), tonumber(getElementData ( radzoneNum, "posZ" )), math.random ( 280,350 ), math.random ( 0,360 ), math.random ( 0,360 ) )
		setObjectScale ( bomb, 3 )
	end	
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), loadRadZones )
 
function radShapeEntered ( player, level )
	if getElementData ( player, "inRadZone" ) == false and getElementModel ( player ) ~= 244 and getElementModel ( player ) ~= 257 and not getElementData ( player, "norLiveKileld" ) then
		if getElementData ( player, "antiRadWear" ) == 0 then
			setTimer ( givePlayerRadZone, 1000, 1, player, level )
			setElementData ( player, "radZoneID", source )
			if getElementData ( player, "perk16" ) then
				exports.players:givePlayerRad ( player, math.ceil(level/2) )
			else
				exports.players:givePlayerRad ( player, level )
			end
		end
		setElementData ( player, "inRadZone", true )
	end
end

function givePlayerRadZone ( player, level )
	if getElementData ( player, "inRadZone" ) then
		if isElement ( getElementData ( player, "radZoneID" ) ) then
			if isElementWithinColShape ( player, getElementData ( player, "radZoneID" ) ) then
				if getElementData ( player, "antiRadWear" ) == 0 then
					local xC, yC, zC = getElementPosition ( getElementData ( player, "radZoneID" ) )
					local xP, yP, zP = getElementPosition ( player )
					local distance = getDistanceBetweenPoints2D ( xP, yP, xC, yC )
					local radius = getElementData ( getElementData ( player, "radZoneID" ), 'radius' )
					local onepercent = level/radius
					local radiation = math.floor(level-onepercent*distance)
					if radiation < 1 then radiation = 1 end
					exports.players:givePlayerRad ( player, radiation )
					if getElementData ( player, 'perk22' ) and getElementData ( player, "antiRadWear" ) == 0 then
						local h = getElementData ( player, 'health' )
						local maxHealth = getElementData ( player, 'maxHealth' )
						if h < maxHealth then
							if h+level > maxHealth then
								setElementData ( player, 'health', maxHealth )
							else
								setElementData ( player, 'health', h+level )
							end
						end
					end
				end
				setTimer ( givePlayerRadZone, 1000, 1, player, level )
			else
				setElementData ( player, "radZoneID", nil )
			end
		end
	end
end

function radZoneEnter ( hitter, matchingDimension )
	if getElementData ( source, "radZone" ) then
		if getElementType ( hitter ) == "player" then
			radShapeEntered ( hitter, getElementData ( source, "level" ) )	
		end
	end
end
addEventHandler ( "onColShapeHit", getResourceRootElement(), radZoneEnter )
 
function radZoneExit ( hitter, matchingDimension )
	if getElementData ( source, "radZone" ) then
		if getElementType ( hitter ) == "player" then
			setElementData ( hitter, "inRadZone", false )
		end
	end
end
addEventHandler ( "onColShapeLeave", getResourceRootElement(), radZoneExit )