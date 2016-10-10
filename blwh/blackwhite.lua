local screenX, screenY = guiGetScreenSize()
local screenSource = dxCreateScreenSource(screenX, screenY)
local renderShader = false

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
    if getVersion ().sortable < "1.1.0" then
        outputChatBox("Resource is not compatible with this client.")
        return
	else
		blackWhiteShader, blackWhiteTec = dxCreateShader("fx/blackwhite.fx")
		
        if (not blackWhiteShader) then
            outputChatBox("Could not create shader. Please use debugscript 3.")
		else
			outputChatBox("shader " .. blackWhiteTec .. " was started.")
        end
    end
end)

addEventHandler("onClientPreRender", getRootElement(),
function()
    if (blackWhiteShader) and renderShader then
        dxUpdateScreenSource(screenSource)     
        dxSetShaderValue(blackWhiteShader, "screenSource", screenSource)
        dxDrawImage(0, 0, screenX, screenY, blackWhiteShader)
    end
end)

addEventHandler ( "onClientElementDataChange", getRootElement(),
function ( dataName, old )
	if source == localPlayer and getElementType ( source ) == "player" and dataName == "health" then
		local blood = getElementData ( source, "health" ) or 1
		local maxhealth = getElementData ( source, "maxHealth" ) or 100
		if blood/maxhealth < 0.1 then
			renderShader = true
		else
			renderShader = false
		end
	end
end )
