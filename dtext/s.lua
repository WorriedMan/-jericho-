addEvent ( "onLoadSettings", true )

function loadText ( resource )
    --if not resource and source then resource = source elseif not resource and not source then return end
    for i, t in ipairs ( xmlNodeGetChildren ( xmlLoadFile ( "texts.xml" ) ) ) do
        local text = createElement     ( "text" )
        
        local x  = xmlNodeGetAttribute ( t, "x" )
        local y  = xmlNodeGetAttribute ( t, "y" )
        local z  = xmlNodeGetAttribute ( t, "z" )
        local tt = xmlNodeGetAttribute ( t, "t" )
        setElementPosition ( text, tonumber ( x ), tonumber ( y ), tonumber ( z ), false )
        setElementData ( text, "text", tt )
    end
end

addEventHandler ( "onResourceStart", getResourceRootElement ( ), loadText )

function create3DText ( x, y, z, t, r, g, b, a, id, inter )
    --Check parameters
    --if not x or not y or not z or not t then return false end
    
    --Create the text
    local text = createElement ( "text" )
    
    --If the text wasn't created, stop function
    --if not text then return false end
    
    --Now the other data
    setElementPosition ( text, tonumber ( x ), tonumber ( y ), tonumber ( z ), false )
	if inter and inter ~= 0 then setElementInterior ( text, inter ) end
    setElementData             ( text, "text", t, true     )
    
    --Optional Parameters
    --RGBA
    if r and g and b and a then setElementData ( text, "rgba", { r, g, b, a }, true ) end
    --ID
    if id then setElementID ( text, id ) end
    
    --If all was OK, returns the text element
    return text
end

function toboolean ( v ) if v == "false" then return false elseif v == "true" then return true else return nil end end

addEventHandler ( "onLoadSettings", getRootElement ( ),
function ( )
local rn    = getResourceName ( getThisResource ( ) )
settings = {
    ["scale"] = tonumber  ( get ( rn..".*scale"        ) ),
    ["r"]     = tonumber  ( get ( rn..".*red"          ) ),
    ["g"]     = tonumber  ( get ( rn..".*green"        ) ),
    ["b"]     = tonumber  ( get ( rn..".*blue"         ) ),
    ["a"]     = tonumber  ( get ( rn..".*alpha"        ) ),
    ["dd"]    = tonumber  ( get ( rn..".*drawDistance" ) ),
    ["s3d"]   = toboolean ( get ( rn..".*scale3D"      ) ),
    ["f"]     = get ( rn..".*font"         ),
}
triggerClientEvent ( "onClientLoadSettings", getRootElement ( ), settings  )
end )