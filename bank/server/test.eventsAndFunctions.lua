
--[[

    Resource:   bank (written by 50p)
    Version:    2.1
    
    Filename:   test.eventsAndFunctions.lua

]]


local bankResource = getResourceFromName( "bank" )

-----------------------------------------------------------

addEventHandler( "onPlayerWithdrawMoney", getRootElement( ),
	function( bankMarker, amount, atm )
	-- remove -[[ and ]] below to enable withdrawal limits
	--[[
		if amount > 1000 and atm then
			outputChatBox( "You can't withdraw so much money from ATM!", source )
			cancelEvent( )
			return
		end
	]]
		outputChatBox( "You have withdrawn $"..tostring( amount ), source, 0, 255, 0 )
	end
)

-----------------------------------------------------------

addEventHandler( "onPlayerDepositMoney", getRootElement( ),
	function( bankMarker, amount, atm )
		outputChatBox( "You have deposited $"..tostring( amount ), source, 255, 0, 255 )
	end
)

-----------------------------------------------------------

addEventHandler( "onPlayerTransferMoney", getRootElement( ),
	function( bankMarker, amount, receiver, atm )
		outputChatBox( "You have transfered $"..tostring( amount ).." to "..getClientName( receiver )..".", source, 255, 0, 0 )
		outputChatBox( "You have been sent $"..tostring( amount ).." from ".. getClientName( source )..".", receiver, 255, 255, 0 )
	end
)

-----------------------------------------------------------

addEventHandler( "onPlayerEnterBank", getRootElement( ),
	function( bankMarker, atm )
		if not atm then
			local players = call( bankResource, "getPlayersInBank", bankMarker )
			local bankname = call( bankResource, "getBankName", bankMarker )
			outputChatBox( "You are in '".. bankname .."'. There are "..tostring( #players ).." people in this bank.", source )
			local balance = call( bankResource, "getBankAccountBalance", source )
			if balance then
				outputChatBox( "Bank account balance: ".. tostring( balance ), source )
			end
		end
	end
)

-----------------------------------------------------------

addEventHandler( "onPlayerLeaveBank", getRootElement( ),
	function( bankMarker, atm )
		local bankName = call( bankResource, "getBankName", bankMarker )
		outputChatBox( "You left '".. bankName.."'.", source, 255, 255, 0 )
	end
)


