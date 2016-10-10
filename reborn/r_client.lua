local soulMarkers = {}

function startRebornEffectsC ()
	setTimer ( function ()
					triggerServerEvent ( "soulsCollected", localPlayer , false)
					for i, v in ipairs ( soulMarkers ) do
						if isElement ( v ) then
							destroyElement ( v )
						end
						soulMarkers [i] = nil
					end
				end, 40000, 1 )
    setWeather ( 19 )
	setSkyGradient ( 255, 0, 0, 0, 0, 0 )
	local x,y,z=getElementPosition ( localPlayer )
	local level = getElementData ( localPlayer, "rplvl" )
	local range = 100
	if level < 5 then
		range = 15
	elseif level >= 5 and level < 10 then
		range = 20
	elseif level >= 10 and level < 20 then
		range = 30
	end
	for i = 1, getElementData ( localPlayer, "rplvl" )*3 do
		local xp,yp = math.random ( x-range,x+range ), math.random ( y-range, y+range )
		--local createdMarker = createMarker ( xp,yp, getGroundPosition ( xp,yp, z ), "corona", math.random(2,6), math.random(0,255), math.random(0,255), math.random(0,255) )
		local createdMarker = createPickup ( xp,yp, getGroundPosition ( xp,yp, z )+1, 3, 1276 )
		setElementData ( createdMarker, "soulMarker", true ) 
		table.insert ( soulMarkers, createdMarker )
		createExplosion ( xp,yp, getGroundPosition ( xp,yp, z ), 12 )
	end
	addEventHandler ( "onClientPickupHit", getRootElement(), soulMarkerHitted )
end
addEvent( "startRebornEffects", true )
addEventHandler( "startRebornEffects", getRootElement(), startRebornEffectsC )

function soulMarkerHitted ( hitPlayer, matchingDimension )
	if hitPlayer == localPlayer then
		if getElementData ( source, "soulMarker" ) then
			destroyElement ( source )
			if getElementData ( hitPlayer, "soulParts" ) > 1 then
				setElementData ( hitPlayer, "soulParts", getElementData ( hitPlayer, "soulParts" )-1 )
				exports.pipboy:addInfoBox("Осталось собрать осколков: "..tostring(getElementData ( hitPlayer, "soulParts" )),1)
			else
				removeEventHandler ( "onClientPickupHit", getRootElement(), soulMarkerHitted )
				triggerServerEvent ( "soulsCollected", localPlayer, true )
				for i, v in ipairs ( soulMarkers ) do
					if isElement ( v ) then
						destroyElement ( v )
					end
					soulMarkers [i] = nil
				end
			end
		end
	end
end

function stopRebornEffectsC ( weat, toweat )
    setWeather ( weat )
	resetSkyGradient ()
end
addEvent( "stopRebornEffects", true )
addEventHandler( "stopRebornEffects", getRootElement(), stopRebornEffectsC )