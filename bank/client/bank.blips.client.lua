  
--[[

    Resource:   bank (written by 50p)
    Version:    2.3
    
    Filename:   bank.blips.client.lua

]]

addEventHandler( "onClientColShapeHit", getResourceRootElement( getThisResource( ) ),
	function( element )
		if ( getElementType( element ) == "player" ) and element == getLocalPlayer( ) then
			local child = getElementChild( source, 0 )
			if getElementType( child ) == "marker" then
				local blip = createBlipAttachedTo( child, 52 )
				setElementParent( blip, child )
			end
		end
	end
)

addEventHandler( "onClientColShapeLeave", getResourceRootElement( getThisResource( ) ),
	function( element )
		if ( getElementType( element ) == "player" ) and element == getLocalPlayer( ) then
			local child = getElementChild( source, 0 )
			if getElementType( child ) == "marker" then
				for k, blip in pairs( getElementChildren( child ) ) do
					if getElementType( blip ) == "blip" then
						destroyElement( blip )
					end
				end
			end
		end
	end
)
