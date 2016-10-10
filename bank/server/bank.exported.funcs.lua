
--[[

    Resource:   bank (written by 50p)
    Version:    2.2
    
    Filename:   bank.exported.funcs.lua

]]


--[[
	getBankID
	
	@params
		marker/string bankMarker (marker element or bank name)
	@returns
		bank ID if bankMarker is a bank marker or correct bank name, false otherwise
]]
function getBankID( bankMarker )
	if type( bankMarker ) == "userdata" and getElementType( bankMarker ) == "marker" then
		for k, v in pairs( banksInfo ) do
			if banksInfo[ k ].marker == bankMarker then
				return k
			end
		end
	elseif type( bankMarker ) == "string" then
		for k, v in pairs( banksInfo ) do
			if banksInfo[ k ].name == bankMarker then
				return k
			end
		end
	end
	return false
end


--[[
	getBankPosition
	
	@params
		marker/string/int bank (marker element, bank name or bank ID)
	@returns
		X, Y and Z coords if 'bank' is a bank marker, correct bank name or bank ID, false otherwise
]]
function getBankPosition( bank )
	if type( bank ) == "userdata" and getElementType( bank ) == "marker" then
		for k, v in pairs( banksInfo ) do
			if banksInfo[ k ].marker == bank then
				return getElementPosition( bank )
			end
		end
	elseif type( bank ) == "string" then
		for k, v in pairs( banksInfo ) do
			if banksInfo[ k ].name == bank then
				return getElementPosition( banksInfo[ k ].marker );
			end
		end
	elseif type( bank ) == "integer" then
		local banks = countBanks( )
		if bank > 0 and bank <= banks then
			if banksInfo[ bank ].marker then
				return getElementPosition( banksInfo[ bank ].marker )
			end
		end
	end
	return false
end


--[[
	getBankMarker
	
	@params
		int/marker bankID
	@returns
		marker element if bankID is valid ID, false otherwise
]]
function getBankMarker( bankID )
	if type( bankID ) == "number" and bankID <= countBanks( ) and bankID > 0 then
		return banksInfo[ bankID ].marker
	elseif type( bankID ) == "string" then
		for k, v in pairs( banksInfo ) do
			if banksInfo[ k ].name == bankID then
				return banksInfo[ k ].marker
			end
		end
	end
	return false
end


--[[
	getBankName
	
	@params
		int bankID
	@returns
		string which contains name of the bank, false otherwise
]]
function getBankName( bankID )
	if type( bankID ) == "number" then
		if bankID <= countBanks( ) and bankID > 0 then
			return banksInfo[ bankID ].name
		end
	elseif type( bankID ) == "userdata" and getElementType( bankID ) == "marker" then
		for i = 0, countBanks() do
			if banksInfo[ i + 1 ].marker == bankID then
				return banksInfo[ i + 1 ].name
			end
		end
	end
	return false
end


--[[
	setBankName
	
	@params
		int/marker/string bankID
		string newname (new name of bank)
	@returns
		true if bank's name has been changed successfully, false otherwise
]]
function setBankName( bankID, newname )
	if type( bankID ) == "number" and type( newname ) == "string" then
		if bankID <= countBanks( ) and bankID > 0 then
			banksInfo[ bankID ].name = newname
			return true
		end
	elseif ( type( bankID ) == "userdata" and type( newname ) == "string" and getElementType( bankID ) == "marker" ) or
		( type( bankID ) == "string" and type( newname ) == "string" ) then
		bankID = getBankID( bankID )
		if bankID then
			banksInfo[ bankID ].name = newname
			return true
		end
	end
	return false
end


--[[
	getBankMarkers
	
	@params
	
	@returns
		table of bank markers, false if there is no bank found
]]
function getBankMarkers( )
	local markers = { }
	for k, v in pairs( banksInfo ) do
		table.insert( markers, banksInfo[ k ].marker )
	end
	if #markers > 0 then
		return markers
	end
	return false
end


--[[
	getBankEntranceMarker
	
	@params
		int bankID
	@returns
		bank entrance marker, false otherwise
]]
function getBankEntranceMarker( bankID )
	local banks = countBanks( )
	if type( bankID ) == "number" and bankID <= banks and bankID > 0 then
		return banksInfo[ bankID ].entrance.marker
	elseif ( type( bankID ) == "userdata" and getElementType( bankID ) == "marker" ) or ( type( bankID ) == "string" ) then
		bankID = getBankID( bankID )
		if bankID then
			if banksInfo[ bankID ].marker and banksInfo[ bankID ].entrance then
				return banksInfo[ bankID ].entrance.marker
			end
		end
	end
	return false
end


--[[
	getBankExitMarker
	
	@params
		int bankID
	@returns
		table of bank exit markers, false otherwise
]]
function getBankExitMarker( bankID )
	local banks = countBanks( )
	if type( bankID ) == "number" and bankID <= banks and bankID > 0 then
		return banksInfo[ bankID ]._exit.marker
	elseif ( type( bankID ) == "userdata" and getElementType( bankID ) == "marker" ) or ( type( bankID ) == "string" ) then
		bankID = getBankID( bankID )
		if bankID then
			if banksInfo[ bankID ].marker and banksInfo[ bankID ]._exit then
				return banksInfo[ bankID ]._exit.marker
			end
		end
	end
	return false
end


--[[
	countBanks
	
	@params
	
	@returns
		integer representing number of banks, false otherwise
]]
function countBanks( )
	local banks_num = 0
	for k, v in pairs( banksInfo ) do
		banks_num = banks_num + 1
	end
	return banks_num
end


--[[
	getBankAccountBalance
	
	@params
		string accountName (name of account you want to get the balance of)
	@optional params
		table SQLdata
	@returns
		integer representing balance of the account, false otherwise
]]
function getBankAccountBalance( accountName, SQLdata )
	if isElement( accountName ) and getElementType( accountName ) == "player" then
		local account = getPlayerAccount( accountName );
		return tonumber( getAccountData( account, "bank.balance" ) );
		--accountName = getPlayerName( accountName )
	elseif type( accountName ) ~= "string" then
		return false
	end
	
	--[[ SQLdata = SQLdata or { ["tab"] = bankSQLInfo.tab, ["balance"] = bankSQLInfo.balance, ["username"] = bankSQLInfo.username }
	local balance
	if type( SQLdata ) == "table" and SQLdata.tab and SQLdata.balance and SQLdata.username then
		balance = executeSQLSelect( SQLdata.tab, SQLdata.balance, SQLdata.username .." = \""..accountName.."\"", 1 )
	else
		balance = executeSQLSelect( bankSQLInfo.tab, bankSQLInfo.balance, bankSQLInfo.username .." = \""..accountName.."\"", 1 )
	end
	if balance then 
		return tonumber( balance[ 1 ][ bankSQLInfo.balance ] )
	end ]]
	return false
end


--[[
	setBankAccountBalance
	
	@params
		string accountName (name of account you want to change the balance of)
		string/int amount (new balance)
		table SQLdata
	@returns
		bool true if new balance has been set successfully, false otherwise
]]
function setBankAccountBalance( accountName, newbalance, SQLdata )
	if type( accountName ) == "userdata" and getElementType( accountName ) == "player" then
		accountName = getPlayerAccount( accountName );
		--accountName = getPlayerName( accountName )
	elseif type( accountName ) ~= "string" then
		return false
	end
	if type( newbalance ) ~= "number" then
		return false
	end
	
	if type( newbalance ) == "number" then
		return setAccountData( accountName, "bank.balance", newbalance );
	end
	
	--[[
	SQLdata = SQLdata or { ["tab"] = bankSQLInfo.tab, ["balance"] = bankSQLInfo.balance, ["username"] = bankSQLInfo.username }
	if type( SQLdata ) == "table" and SQLdata.tab and SQLdata.balance and SQLdata.username then
		local exec = executeSQLUpdate( SQLdata.tab, SQLdata.balance .. " = "..tostring( newbalance ), SQLdata.username .. " = \""..accountName.."\"" )
		if exec then
			local client = getPlayerFromName( accountName )
			if isPlayerInBank( client ) then
				playersAccount[ client ]:setBalance( newbalance )
				triggerClientEvent( client, "bank_updateMyBalance", root, playersAccount[ client ].balance )
			end
			return newbalance
		end
	end ]]
	return false 
end

---------------------------------------

function getPlayersInBank( bankID )
	local players = { }
	
	if type( bankID ) == "number" then
		if bankID <= countBanks( ) and bankID > 0 then
			for k, v in pairs( getElementsByType( "player" ) ) do
				if isPlayerInBank( v ) == banksInfo[ bankID ].marker then
					table.insert( players, v )
				end
			end
			return players
		end
	elseif ( type( bankID ) == "userdata" and getElementType( bankID ) == "marker" ) then
		bankID = getElementColShape( bankID )
		if bankID then
			return getElementsWithinColShape( bankID, "player" )
		end
	elseif type( bakID ) == "string" then
		bankID = getBankMarker( bankID )
		if bankID then
			return getElementsWithinColShape( bankID, "player" )
		end
	end
	return false
end


function getPlayerBank( player )
	return isPlayerInBank( player )
end


function withdrawPlayerMoney( player, amount, SQLdata )
	local accountName
	if type( player ) == "userdata" and getElementType( player ) == "player" and type( amount ) == "number" then
		accountName = getPlayerName( player )
	else
		return false
	end
	
	SQLdata = SQLdata or { ["tab"] = bankSQLInfo.tab, ["balance"] = bankSQLInfo.balance, ["username"] = bankSQLInfo.username }
	local balance
	balance = getBankAccountBalance( accountName, SQLdata )
	if balance then
		if balance - amount >= 0 then
			return setBankAccountBalance( accountName, ( balance - amount ), SQLdata )
		end
	end
	return false
end


function depositPlayerMoney( player, amount, SQLdata )
	local accountName
	if type( player ) == "userdata" and getElementType( player ) == "player" and type( amount ) == "number" then
		accountName = getPlayerName( player )
	else
		return false
	end
	
	SQLdata = SQLdata or { ["tab"] = bankSQLInfo.tab, ["balance"] = bankSQLInfo.balance, ["username"] = bankSQLInfo.username }
	local balance = getBankAccountBalance( accountName, SQLdata )
	if balance then
		if amount <= exports.inventory:getPlayerCaps(player) then
			--takePlayerMoney( player, amount )
			exports.inventory:removePlayerItemServer ( player, 51, amount )
			return setBankAccountBalance( accountName, ( balance + amount ), SQLdata )
		end
	end
	return false
end


function isPlayerInBank( player, bankID )
	if not bankID then
		for k, v in pairs( banksInfo ) do
			if isPlayerInMarker( player, banksInfo[ k ].marker ) then
				return banksInfo[ k ].marker
			end
		end
	elseif ( type( bankID ) == "userdata" ) and ( isElement( bankID ) ) 
	  and ( getElementType( bankID ) == "marker" ) and isPlayerInMarker( player, bankID ) then
		return bankID
	elseif type( bankID ) == "number" then
		if bankID > 0 and bankID <= countBanks( ) then
			if isPlayerInMarker( player, banksInfo[ bankID ].marker ) then
				return banksInfo[ bankID ].marker
			end
		end
	end
	return false
end

function getPlayerBalance( player )
	if type( player ) == "userdata" and getElementType( player ) == "player" then
		return playersAccoun[ player ].balance
	end
	return false
end

function setPlayerBalance( player, newbalance )
	if type( player ) == "userdata" and getElementType( player ) == "player" and type( newbalance ) == "number" then
		return playersAccoun[ player ]:setBalance( newbalance )
	end
	return false
end

function isPlayerInMarker( player, marker )
	local shape = getElementColShape( marker )
	return isElementWithinColShape( player, shape )
end

---------------------------------------

--[[

addCommandHandler( "getbalance", 
	function( plr, cmd, name )
		if name then
			print( getBankAccountBalance( name ) )
		end
	end
)

addCommandHandler( "setbalance", 
	function( plr, cmd, name, amount )
		if name and amount then
			print( setBankAccountBalance( name, amount ) )
		end
	end
)

]]
