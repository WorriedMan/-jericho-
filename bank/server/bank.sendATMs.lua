--[[

    Resource:   bank (written by 50p)
    Version:    2.2
    
    Filename:   bank.sendATMs.lua

]]

addEvent( "bank_giveMeATMs", true )

addEventHandler( "bank_giveMeATMs", resourceRoot,
	function( )
		local atms = { }
		for k, v in ipairs( banksInfo ) do
			local atm = banksInfo[ k ].ATM;
			if atm then
				table.insert( atms, atm );
			end
		end
		triggerClientEvent( client, "bank_takeATMs", client, atms );
	end
)
