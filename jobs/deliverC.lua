function createTripMarkerC ( x, y, z )
	tripMarker = createMarker ( x, y, z, "checkpoint", 5, 255, 51, 51 )
	addEventHandler ( "onClientMarkerHit", tripMarker, tripMarkerHit )
end

addEvent( "createTripMarker", true )
addEventHandler( "createTripMarker", getRootElement(), createTripMarkerC )

function tripMarkerHit ( hitPlayer, matchingDimension )
	if source == tripMarker then
		destroyElement ( source )
		triggerServerEvent ( "finishTripPost", getLocalPlayer() ) 
	end
end

function destroyTripMarkerC ( )
	removeEventHandler ( "onClientMarkerHit", tripMarker, tripMarkerHit )
	destroyElement ( tripMarker )
end

addEvent( "destroyTripMarker", true )
addEventHandler( "destroyTripMarker", getRootElement(), destroyTripMarkerC )