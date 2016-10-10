--[[

    Resource:   bank (written by 50p)
    Version:    2.3
    
    Filename:   bank.collision.client.lua

]]

addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource( ) ),
	function( )
		triggerServerEvent( "bank_giveMeATMs", root );
	end
)

addEvent( "bank_takeATMs", true );
addEventHandler( "bank_takeATMs", g_root, 
	function( ATMs )
		for k, atm in pairs( ATMs ) do
			setElementCollisionsEnabled( atm, false );
		end
	end
)