local rendered = 0
local width, height = guiGetScreenSize ()

addEventHandler("onClientRender", getRootElement(), function()
		for k,player in ipairs(getElementsByType("player", root, true)) do
			if player ~= localPlayer then
				setPedLookAt(player, getElementData ( player, 'lookX'), getElementData ( player, 'lookY'), getElementData ( player, 'lookZ')) 
				setPedAimTarget ( player, getElementData ( player, 'lookX'), getElementData ( player, 'lookY'), getElementData ( player, 'lookZ')) 
			else
				local lx, ly, lz = getWorldFromScreenPosition ( width*0.5, height*0.5, 10 )
				rendered = rendered+1
				if rendered > 15 then
					rendered = 0
					setElementData ( localPlayer, 'lookX', lx )
					setElementData ( localPlayer, 'lookY', ly )
					setElementData ( localPlayer, 'lookZ', lz )
				end
				setPedLookAt(localPlayer, lx, ly, lz) 
			end
		end
   
end)