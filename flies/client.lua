local sw,sh = guiGetScreenSize()
local off = 0
fliesTable = {}

function addElementFlies (ped,size)
outputChatBox ("FLIES ADUD")
	setElementData ( ped, "flies_dead",true)
	setElementData ( ped, "flies_dead_num",size)
	if not fliesTable[ped] then
		local tmpTable = {}
		for i = 1, size do
			table.insert ( tmpTable, { x = math.random ( -15,15 ), y = math.random ( -15,15 ) } )
		end
		fliesTable[ped] = tmpTable
	end
end


addEvent("addElementFliesEvent", true)
addEventHandler("addElementFliesEvent", root, addElementFlies)

function startDrawingFlies ()
	if getElementData ( source, "flies_dead" ) then
		if not fliesTable[source] then
			local size = getElementData ( source, "flies_dead_num" )
			local tmpTable = {}
			for i = 1, size do
				tmpTable.x = math.random ( -15,15 )
				tmpTable.y = math.random ( -15,15 )
			end
			fliesTable[source] = tmpTable
		end
	end
end

function stopDrawingFlies ()
	if getElementData ( source, "flies_dead" ) then
		if fliesTable[element] then
			fliesTable[element] = nil
		end
	end
end

addEventHandler( "onClientElementStreamIn", root, startDrawingFlies )
addEventHandler( "onClientElementStreamOut", root, stopDrawingFlies )

function drawingFlies ()
	local x_player, y_player, z_player = getElementPosition ( localPlayer )
	for i, t_place in pairs ( fliesTable ) do
		if isElement (i) then
			local x_elem, y_elem, z_elem = getElementPosition ( i )
			for b, v in pairs ( t_place ) do
				local xp,yp,dist = getScreenFromWorldPosition ( x_elem, y_elem, z_elem+1,5,false)
				if xp and yp and dist then
					local curScale = 2/(dist*0.15)
					if ( curScale > 0.1 and dist < 20 and isLineOfSightClear ( x_player, y_player, z_player,x_elem, y_elem, z_elem+1.5, true, true, true, true, true, true, true) ) then
						--for i, v in ipairs (flies_table) do
							dxDrawImage ( xp+v.x, yp+v.y, curScale, curScale, "fly.png",0,0,0,tocolor(0,0,0))
							v.x, v.y = v.x+math.random(-3,3), v.y+math.random(-3,3)
							if v.x > 50 then
								v.x = 48
							end
							if v.x < -50 then
								v.x = -48
							end
							if v.y > 50 then
								v.y = 48
							end
							if v.y < -50 then
								v.y = -48
							end
						--end
					end
				end
			end
		end
	end	
end

addEventHandler ( "onClientRender", getRootElement(), drawingFlies )