
--[[

    Resource:   bank (written by 50p)
    Version:    2.2
    
    Filename:   bank.script.server.lua

]]


resourceRoot = getResourceRootElement( getThisResource() )
root = getRootElement( )

playerInMarker = { }

table.size = function ( tab )
	local i = 0;
	for k, v in pairs( tab ) do
		i = i + 1;
	end
	return i;
end


function resourceStarted( )
	
    bankInit( )

	
end

addEventHandler( "onResourceStart", resourceRoot, resourceStarted )


function bank_playerLogout( oldAccount, currentAccount )
	if isGuestAccount( currentAccount ) == true and isGuestAccount( oldAccount ) ~= true and getAccountName( oldAccount ) == playersAccount[ source ]:accountname() then
		playerInMarker[ source ] = false
	end
end
addEventHandler( "onPlayerLogout", root, bank_playerLogout )


function playerEnterMarker( marker )
	if ( not isPedOnGround ( source ) ) or ( doesPedHaveJetPack ( source ) ) or 
		( isPedInVehicle ( source ) ) or ( getControlState ( source, "aim_weapon" ) ) then return end
		
    for k, v in pairs( banksInfo ) do
    	if marker == banksInfo[ k ].marker then
			local triggered = triggerEvent( "onPlayerEnterBank", source, banksInfo[ k ].marker, banksInfo[ k ].ATM )
			if triggered then
	    		setControlState( source, "forwards", false )
	    		setControlState( source, "backwards", false )
	    		setControlState( source, "left", false )
	    		setControlState( source, "right", false )
	    		--outputChatBox( tostring( playersAccount[ source ].balance ) );
	    		local try = triggerClientEvent( source, "bank_showBankAccountWnd", source, getPlayerName ( source ), tostring(getElementData ( source, "bmoney")), banksInfo[ k ].name, banksInfo[ k ].marker, banksInfo[ k ].depositAllowed )
	    		if not try then
	    			setTimer( triggerClientEvent, 100, 1, source, "bank_showBankAccountWnd", source, playersAccount[ source ]:accountname(), tostring( playersAccount[ source ].balance ), banksInfo[ k ].name, banksInfo[ k ].marker, banksInfo[ k ].depositAllowed )
	    		end
	    		playerInMarker[ source ] = marker
			end
			break
    	elseif banksInfo[ k ].entrance and marker == banksInfo[ k ].entrance.marker then
    		fadeCamera( source, false, 1 )
    		setTimer( setElementInterior, 1100, 1, source, 
                                                banksInfo[ k ].entrance.teleInterior,
                                                banksInfo[ k ].entrance.teleX,
                                                banksInfo[ k ].entrance.teleY,
                                                banksInfo[ k ].entrance.teleZ )
			setTimer( setElementPosition, 1150, 1, source, 
                                                banksInfo[ k ].entrance.teleX,
                                                banksInfo[ k ].entrance.teleY,
                                                banksInfo[ k ].entrance.teleZ )
    		--setTimer( setPedRotation, 1100, 1, source, 90 )
    		setTimer( setPedRotation, 1100, 1, source, 90 )
    		setTimer( fadeCamera, 1100, 1, source, true, 1 )
    		setTimer( setCameraTarget, 1150, 1, source );
            break
    	elseif banksInfo[ k ]._exit and marker == banksInfo[ k ]._exit.marker then
    		fadeCamera( source, false, 1 )
    		setTimer( setElementInterior, 1100, 1, source, 
                                                banksInfo[ k ]._exit.teleInterior,
                                                banksInfo[ k ]._exit.teleX,
                                                banksInfo[ k ]._exit.teleY,
                                                banksInfo[ k ]._exit.teleZ )
    		--setTimer( setPedRotation, 1100, 1,
    		setTimer( setPedRotation, 1100, 1, source, banksInfo[ k ]._exit.teleRot )
    		setTimer( fadeCamera, 1100, 1, source, true, 1 )
    		setTimer( setCameraTarget, 1150, 1, source );
            break
    	end
    end
end
addEventHandler( "onPlayerMarkerHit", root, playerEnterMarker )

function playerLeaveBank( marker )
	if playerInMarker[ source ] then
	    for k, v in ipairs( banksInfo ) do
	        if marker == banksInfo[ k ].marker then
				triggerEvent( "onPlayerLeaveBank", source, marker, banksInfo[ k ].ATM )
	            triggerClientEvent( source, "bank_hideBankAccountWnd", source )
	            playerInMarker[ source ] = false
	            break
	        end
	    end
	end
end
addEventHandler( "onPlayerMarkerLeave", root, playerLeaveBank )


function withdrawMoney( player, money )
	local playerBankID = getBankID( getPlayerBank( player ) )
	if type( money ) == 'number' and getElementData ( player, "bmoney" ) < money then
		triggerClientEvent( player, "bank_showWarningMessage", player, "У вас нет столько денег на счету!" )
	elseif type( money ) == 'string' and money == 'all' then
		money = getElementData ( player, "bmoney" )
		if money > 0 then
			local atm = ( banksInfo[ playerBankID ].ATM and true or false )
			local triggered = triggerEvent( "onPlayerWithdrawMoney", player, getPlayerBank( player ), money, atm )
			if triggered then
				setElementData ( player, "bmoney", getElementData ( player, "bmoney" )-money )
				exports.inventory:givePlayerItemServerWW ( player, 51, money )
				triggerClientEvent( player, "bank_updateMyBalance", player, getElementData ( player, "bmoney" ) )
			end
		else
			triggerClientEvent( player, "bank_showWarningMessage", player, "You have no money in your\naccount!" )
		end
    else
		if money > 0 then
			local atm = ( banksInfo[ playerBankID ].ATM and true or false )
			local triggered = triggerEvent( "onPlayerWithdrawMoney", player, getPlayerBank( player ), money, atm )
			if triggered then
				--outputChatBox( "You've withdrawn $"..tostring( money )..".", player, 255, 255, 0 )
				exports.inventory:givePlayerItemServerWW ( player, 51, money )
				setElementData ( player, "bmoney", getElementData ( player, "bmoney" )-money )
				triggerClientEvent( player, "bank_updateMyBalance", player, getElementData ( player, "bmoney" ) )
			end
		end
	end
end
addEvent( "bank_withdrawMoney", true )
addEventHandler( "bank_withdrawMoney", root, withdrawMoney )


function depositMoney( player, money )
	local playerBankID = getBankID( getPlayerBank( player ) )
	if type( money ) == 'number' and exports.inventory:getPlayerCaps(player) >= money then
		local atm = ( banksInfo[ playerBankID ].ATM and true or false )
		local triggered = triggerEvent( "onPlayerDepositMoney", player, getPlayerBank( player ), money, atm )
		if triggered then
			setElementData ( player, "bmoney", getElementData ( player, "bmoney" ) + money )
			exports.inventory:removePlayerItemServer ( player, 51, money )
			triggerClientEvent( player, "bank_updateMyBalance", player, getElementData ( player, "bmoney" ) )
		end
    elseif type( money ) == 'string' and money == 'all' then
		money = exports.inventory:getPlayerCaps(player)
		if money == 0 then 
			triggerClientEvent( player, "bank_showWarningMessage", player, "You have no money to deposit!" )
			return
		end
		local atm = ( banksInfo[ playerBankID ].ATM and true or false )
		local triggered = triggerEvent( "onPlayerDepositMoney", player, getPlayerBank( player ), money, atm )
		if triggered then
			setElementData ( player, "bmoney", getElementData ( player, "bmoney" ) + money )
	        exports.inventory:removePlayerItemServer ( player, 51, money )
			triggerClientEvent( player, "bank_updateMyBalance", player, getElementData ( player, "bmoney" ) )
		end
	else
		triggerClientEvent( player, "bank_showWarningMessage", player, "Insufficient founds!" )
	end
end
addEvent( "bank_depositMoney", true )
addEventHandler( "bank_depositMoney", root, depositMoney )

-- _setPlayerMoney = setPlayerMoney; -- just in case copy the function
-- function setPlayerMoney( player, money )
	-- takePlayerMoney( player, getPlayerMoney( player ) );
	-- givePlayerMoney( player, money );
-- end

