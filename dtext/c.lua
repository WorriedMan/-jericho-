triggerServerEvent ( "onLoadSettings", getRootElement ( ) )

function toboolean ( v ) if v == "false" then return false elseif v == "true" then return true else return nil end end

addEvent ( "onClientLoadSettings", true )
addEventHandler ( "onClientLoadSettings", getRootElement ( ),
function ( settings )
    if type(settings) == "table" then
        defscale   = settings["scale"]
        defr       = settings["r"]
        defg       = settings["g"]
        defb       = settings["b"]
        defa       = settings["a"]
        defdd      = settings["dd"]
        defscale3d = settings["s3d"]
        deffont    = settings["f"]
    end
end )

--The 3D Text part
addEventHandler ( "onClientRender", getRootElement ( ),
function ( )
    --if dedfdd ~= nil then
		local px, py, pz = getElementPosition ( getLocalPlayer ( ) )
		for i, t in ipairs ( getElementsByType ( "text" ) ) do
	   	 local cx, cy, cz = getElementPosition ( t )
			local dist = getDistanceBetweenPoints3D ( px, py, pz, cx, cy, cz )
			
			--Check if the distance between player and text drawing distance is same or less
			if defdd and dist then
				if dist <= defdd then
					local scx, scy = getScreenFromWorldPosition ( cx, cy, cz, -50, true )
					if isLineOfSightClear ( px, py, pz, cx, cy, cz, true, true, true, true, true ) and scx and scy then
						
						--The text default parameters
						local alpha   = defa
						local r       = defr
						local g       = defg
						local b       = defb
						local scale   = defscale
						local scale3d = defscale3d
						
						--Custom scale config
						if getElementData ( t, "scale", false ) then scale = getElementData ( t, "scale", false ) end
						
						--Scale 3D config
						if scale3d == true then scale = scale * ( ( defdd - dist ) / defdd ) end
						
						--Loads the text and stops function if there is no text loaded
						local text  = getElementData ( t, "text" )
						if not text or text == "" then return end
						
						--If the text has custom colors, load them
						local c     = getElementData ( t, "rgba" )
						if c and type ( c ) == "table" then r = c[1] g = c[2] b = c[3] alpha = c[4] end
						
						--Draw the text
						dxDrawText ( text, scx, scy, scx, scy, tocolor ( r, g, b, alpha ), scale, deffont, "center", "center" )
						
					else alpha = 0 
					end
				else alpha = 0
				end
			end
		end
	--end
end )

--Exported function
function create3DText ( x, y, z, t, r, g, b, a, id )
    --Check arguments
    --if not x or not y or not z or not t then return false end
    
    --Create the text
    local text = createElement ( "text"                    )
    
    --If the text wasn't created, stop function
    --if not text then return false end
    
    --Required Arguments
    setElementPosition         ( text, x,      y, z, false )
    setElementData             ( text, "text", t, true     )
    
    --Optional Arguments
    ----RGBA
    if r and g and b and a then setElementData ( text, "rgba", { r, g, b, a }, true ) end
    ----ID
    if id then setElementID ( text, id ) end
    
    --If all was OK, returns the text element
    return text
end