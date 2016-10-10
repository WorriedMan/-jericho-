local samaraBoxes={}

function createSamaraBoxes ()
	local box1 = createObject ( 14538, -246.10000610352, 1486.1999511719, 69.5 )
	local box2 = createObject ( 14538, -246.10000610352, 1488.8000488281, 69.5, 0, 0, 180 )
	--toggleControl ( source, "fire", false )
	setElementDimension ( box1, getElementData ( source, "playerid" ) )
	setElementDimension ( box2, getElementData ( source, "playerid" ) )
	setElementPosition ( localPlayer, -245.414, 1486.2, 68.9062 )
	setElementDimension ( source, getElementData ( source, "playerid" ) )
	table.insert ( samaraBoxes, box1 )
	table.insert ( samaraBoxes, box2 )
	setTimer ( function ()
					triggerClientEvent ( source, "playSamaraSoundS", source )
					local x,y,z = getElementPosition ( source )
					local samara = createPed ( 14, -244.91934204102,1487.1560058594,68.90625 )
					setElementData ( samara, "npc-ped", true )
					setElementDimension ( samara, getElementData ( source, "playerid" ) )
					setElementRotation ( samara, 0, 0, findRotation ( -244.91934204102,1487.1560058594, x, y ) )
					setElementRotation ( source, 0, 0, findRotation ( x, y, -244.91934204102,1487.1560058594 ) )
					table.insert ( samaraBoxes, samara )
					local createdColShape = createColSphere ( -244.91934204102,1487.1560058594,68.90625, 1.5 )
					table.insert ( samaraBoxes, createdColShape )
					setElementDimension ( createdColShape, getElementData ( source, "playerid" ) )
					setElementData ( createdColShape, "action", true )
					setElementData ( createdColShape, "type", 1 )
					setElementData ( createdColShape, "place", 2 )
					setElementData ( createdColShape, "live", 2 )
					setElementData ( createdColShape, "id", 5 )
				end, 4000, 1 )
end

function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end


function destroySamaraBoxes ()
	setElementDimension ( source, 0 )
	setElementPosition ( source, -269,1489,75 )
	setElementDimension ( source, 0 )
	local id = tonumber(getElementData ( source, "playerid" ))
	for i = 1, #samaraBoxes do
		if isElement ( samaraBoxes[i] ) then
			if getElementDimension ( samaraBoxes[i] ) == id then
				destroyElement ( samaraBoxes[i] )
				samaraBoxes[i] = nil
			end
		end
	end
end

addEvent( "destroySamaraBoxesС", true )
addEventHandler( "destroySamaraBoxesС", getRootElement(), destroySamaraBoxes )

samaraStart = createColSphere ( -255,1530,75, 2 )

function samaraHittedStart ( player, matchingDimension )
	if not matchingDimension then return true end
	outputChatBox ( tostring(getElementData ( player, "quest_ring" )) )
 	if getElementData ( player, "quest_ring" ) == 1 then
		createSamaraBoxes ( player )
	elseif getElementData ( player, "quest_ring" ) == 5 then
		createSamaraBoxes ( player )
	end
end
addEventHandler ( "onColShapeHit", samaraStart, samaraHittedStart )