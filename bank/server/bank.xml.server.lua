
--[[

    Resource:   bank (written by 50p)
    Version:    2.3
    
    Filename:   bank.xml.server.lua

]]


bankSQLInfo = { }
banksInfo = { }


function bankInit( )
	local useATMs = get( "bank.useATMs" )
    local xml_root = xmlLoadFile( "bank.locations.xml" )
    local banks = 0
    while( xmlFindChild( xml_root, "bank", banks ) ) do
		local markerSize
        local tempID = banks+1
        banksInfo[ tempID ] = { }
        
        local bank_node = xmlFindChild( xml_root, "bank", banks )
        banksInfo[ tempID ].name = xmlNodeGetAttribute( bank_node, "name" )
		banksInfo[ tempID ].useBlip = xmlNodeGetAttribute( bank_node, "blip" ) or true
		banksInfo[ tempID ].depositAllowed = xmlNodeGetAttribute( bank_node, "depositAllowed" ) or true
		
        local bank_loc = xmlFindChild( bank_node, "location", 0 )
        banksInfo[ tempID ].posX = tonumber( xmlNodeGetAttribute( bank_loc, "posX" ) )
        banksInfo[ tempID ].posY = tonumber( xmlNodeGetAttribute( bank_loc, "posY" ) )
        banksInfo[ tempID ].posZ = tonumber( xmlNodeGetAttribute( bank_loc, "posZ" ) )
        banksInfo[ tempID ].interior = tonumber( xmlNodeGetAttribute( bank_loc, "interior" ) ) or 0;
		markerSize = tonumber( xmlNodeGetAttribute( bank_loc, "markerSize" ) ) or 2
		exports.dtext:create3DText ( banksInfo[ tempID ].posX,banksInfo[ tempID ].posY,banksInfo[ tempID ].posZ+1, "Банк", 0, 128, 0, 255, "bank" )
		banksInfo[ tempID ].marker = createMarker( 
													banksInfo[ tempID ].posX,
													banksInfo[ tempID ].posY,
													banksInfo[ tempID ].posZ-.9,
													"cylinder", markerSize, 250, 0, 0, 100 )
		setElementInterior( banksInfo[ tempID ].marker, banksInfo[ tempID ].interior );
		if useATMs and xmlNodeGetAttribute( bank_loc, "ATM" ) == "true" then
			local rot = tonumber( xmlNodeGetAttribute( bank_loc, "ATMRot" ) ) or 0.0
			local x, y, z = banksInfo[ tempID ].posX, banksInfo[ tempID ].posY, banksInfo[ tempID ].posZ
			x = x + math.sin( math.rad( rot ) ) * .6
			y = y + math.cos( math.rad( rot ) ) * .6
			banksInfo[ tempID ].ATM = createObject( 2942, x, y, z-.35, 0, 0, (360-rot) ) 
			setElementInterior( banksInfo[ tempID ].ATM, tonumber( xmlNodeGetAttribute( bank_loc, "interior" ) ) or 0 )
			setElementParent( banksInfo[ tempID ].ATM, banksInfo[ tempID ].marker )
		end

        if xmlFindChild( bank_node, "entrance", 0 ) then
            banksInfo[ tempID ].entrance = { }
            local entrance_node = xmlFindChild( bank_node, "entrance", 0 )
            banksInfo[ tempID ].entrance.posX = xmlNodeGetAttribute( entrance_node, "posX" )
            banksInfo[ tempID ].entrance.posY = xmlNodeGetAttribute( entrance_node, "posY" )
            banksInfo[ tempID ].entrance.posZ = xmlNodeGetAttribute( entrance_node, "posZ" )
            banksInfo[ tempID ].entrance.interior = tonumber( xmlNodeGetAttribute( entrance_node, "interior" ) ) or 0;
            banksInfo[ tempID ].entrance.teleX = xmlNodeGetAttribute( entrance_node, "teleX" )
            banksInfo[ tempID ].entrance.teleY = xmlNodeGetAttribute( entrance_node, "teleY" )
            banksInfo[ tempID ].entrance.teleZ = xmlNodeGetAttribute( entrance_node, "teleZ" )
            banksInfo[ tempID ].entrance.teleRot = xmlNodeGetAttribute( entrance_node, "teleRot" )
            banksInfo[ tempID ].entrance.teleInterior = xmlNodeGetAttribute( entrance_node, "teleInterior" )
            banksInfo[ tempID ].entrance.marker = createMarker(
                                                                banksInfo[ tempID ].entrance.posX,
                                                                banksInfo[ tempID ].entrance.posY,
                                                                banksInfo[ tempID ].entrance.posZ-1,
                                                                "cylinder", 1.5, 250, 250, 0, 100 )
            --local blip = createBlipAttachedTo( banksInfo[ tempID ].entrance.marker, 52 )
			local col = createColTube( banksInfo[ tempID ].entrance.posX, banksInfo[ tempID ].entrance.posY, banksInfo[ tempID ].entrance.posZ-180, 150, 360 )
			setElementParent( banksInfo[ tempID ].entrance.marker, col )
			setElementInterior( banksInfo[ tempID ].entrance.marker, banksInfo[ tempID ].entrance.interior );
			
        elseif ( type( banksInfo[ tempID ].useBlip ) == "boolean" and banksInfo[ tempID ].useBlip == true )
			or ( type( banksInfo[ tempID ].useBlip ) == "string" and banksInfo[ tempID ].useBlip == "true" )
		then
			local col = createColTube( banksInfo[ tempID ].posX, banksInfo[ tempID ].posY, banksInfo[ tempID ].posZ-180, 150, 360 )
			setElementParent( banksInfo[ tempID ].marker, col )
        end
        if xmlFindChild( bank_node, "exit", 0 ) and banksInfo[ tempID ].entrance then
            banksInfo[ tempID ]._exit = { }
            local exit_node = xmlFindChild( bank_node, "exit", 0 )
            banksInfo[ tempID ]._exit.posX = xmlNodeGetAttribute( exit_node, "posX" )
            banksInfo[ tempID ]._exit.posY = xmlNodeGetAttribute( exit_node, "posY" )
            banksInfo[ tempID ]._exit.posZ = xmlNodeGetAttribute( exit_node, "posZ" )
            banksInfo[ tempID ]._exit.interior = tonumber( xmlNodeGetAttribute( exit_node, "interior" ) ) or 0;
            banksInfo[ tempID ]._exit.teleX = xmlNodeGetAttribute( exit_node, "teleX" )
            banksInfo[ tempID ]._exit.teleY = xmlNodeGetAttribute( exit_node, "teleY" )
            banksInfo[ tempID ]._exit.teleZ = xmlNodeGetAttribute( exit_node, "teleZ" )
            banksInfo[ tempID ]._exit.teleRot = xmlNodeGetAttribute( exit_node, "teleRot" )
            banksInfo[ tempID ]._exit.teleInterior = xmlNodeGetAttribute( exit_node, "teleInterior" )
            banksInfo[ tempID ]._exit.marker = createMarker( 
                                                            banksInfo[ tempID ]._exit.posX,
                                                            banksInfo[ tempID ]._exit.posY,
                                                            banksInfo[ tempID ]._exit.posZ-1,
                                                            "cylinder", 1.5, 250, 250, 0, 100 )
			setElementInterior( banksInfo[ tempID ]._exit.marker, banksInfo[ tempID ]._exit.interior );
        end
        banks = banks + 1
    end
	
	bankSQLInfo.tab = get( "bank.SQLTable" )
	bankSQLInfo.username = get( "bank.SQLUserNameField" )
	bankSQLInfo.balance = get( "bank.SQLMoneyField" )
	if not bankSQLInfo.tab then
		bankSQLInfo.tab = "bank_accounts"
	end
	if not bankSQLInfo.username then
		bankSQLInfo.username = "username"
	end
	if not bankSQLInfo.balance then
		bankSQLInfo.balance = "balance"
	end
end


