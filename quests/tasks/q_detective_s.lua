
function loadDetDoor()
	detectiveDoor = createObject ( 1495, 1277.3115234, -996.0531006, 6644.7319336, 0, 0, 270 )
	local detColShape = createColSphere (  1276.8935546875,-997.5087890625,6645.7319335938, 1 )
	setElementData ( detColShape, "action", true )
	setElementData ( detColShape, "type", 5 )
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), loadDetDoor )

function openDetectiveDoor ( )
	moveObject ( detectiveDoor, 3000, 1277.3000000, -994.599000, 6644.7000000 )
	setTimer ( function () moveObject ( detectiveDoor, 2000, 1277.3115234, -996.0531006, 6644.7319336 ) end, 5000, 1 )
end