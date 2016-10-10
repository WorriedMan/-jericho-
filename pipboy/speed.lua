local sw,sh = guiGetScreenSize()
local main_color = tocolor ( 98, 150, 52 ) -- цвет
local main_colorb = tocolor ( 0, 0, 0 ) -- цвет


function drawingSpeedInfo ()
	if getElementData ( localPlayer, "speedShow" ) then
		dxDrawLine ( sw/2-150, 10, sw/2-110, 10, main_color )
		dxDrawLine ( sw/2-150, 10, sw/2-150, 30, main_color )
		dxDrawLine ( sw/2-110, 10, sw/2-110, 30, main_color )
		dxDrawLine ( sw/2-110, 30, sw/2-150, 30, main_color )
		dxDrawText (gettok(tostring(getVehicleSpeed()),1,46), sw/2-150, 11, sw/2-115, 31, main_colorb, 1, "default-bold", "right", "center", false, false )
		dxDrawText (gettok(tostring(getVehicleSpeed()),1,46), sw/2-150, 10, sw/2-115, 30, main_color, 1, "default-bold", "right", "center", false, false )
		dxDrawText ("СКО", sw/2-180, 11, sw/2-155, 31, main_colorb, 1, "default-bold", "right", "center", false, false )
		dxDrawText ("СКО", sw/2-180, 10, sw/2-155, 30, main_color, 1, "default-bold", "right", "center", false, false )
		
		-- средний прямоугольник
			
			dxDrawLine ( sw/2-20, 10, sw/2+20, 10, main_color )
			dxDrawLine ( sw/2-20, 10, sw/2-20, 30, main_color )
			dxDrawLine ( sw/2+20, 10, sw/2+20, 30, main_color )
			dxDrawLine ( sw/2+20, 30, sw/2-20, 30, main_color )
		--
		
		-- высота
			dxDrawLine ( sw/2+110, 10, sw/2+150, 10, main_color )
			dxDrawLine ( sw/2+150, 10, sw/2+150, 30, main_color )
			dxDrawLine ( sw/2+110, 10, sw/2+110, 30, main_color )
			dxDrawLine ( sw/2+110, 30, sw/2+150, 30, main_color )
				local x,y,z = getElementPosition ( localPlayer )
				dxDrawText (gettok(tostring(z),1,46), sw/2+110, 11, sw/2+145, 31, main_colorb, 1, "default-bold", "right", "center", false, false )		
				dxDrawText (gettok(tostring(z),1,46), sw/2+110, 10, sw/2+145, 30, main_color, 1, "default-bold", "right", "center", false, false )
			dxDrawText ("ВЫС", sw/2+155, 11, sw/2+180, 31, main_colorb, 1, "default-bold", "right", "center", false, false )		
			dxDrawText ("ВЫС", sw/2+155, 10, sw/2+180, 30, main_color, 1, "default-bold", "right", "center", false, false )
		--
	end
	
end

addEventHandler ( "onClientRender", getRootElement(), drawingSpeedInfo )

function getVehicleSpeed()
    if isPedInVehicle(localPlayer) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(localPlayer))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 155
    else
		 local vx, vy, vz = getElementVelocity(localPlayer)
        return math.sqrt(vx^2 + vy^2 + vz^2) * 155
	end
    return 0
end