function loadShortCuts(source, shortTable, craftTable )
	triggerClientEvent ( source, "loadedShortCuts", source, shortTable )
	triggerClientEvent ( source, "loadedCraftTable", source, craftTable )
end

function addInfoBox( text, time, player, image )
	if player then
	--	if isElement ( player ) then
			--if getElementType ( player ) == "player" then
			triggerClientEvent ( player, "addInfoBoxServer", player, text, time, image )
			--end
	--	end
		return true
	end
	triggerClientEvent ( "addInfoBoxServer", root, text, time )
end

function addMapIcon( x, y, z, icon, text, player )
	if player then
	--	if isElement ( player ) then
			--if getElementType ( player ) == "player" then
			triggerClientEvent ( player, "addMapIconServer", player, x, y, z, icon, text )
			--end
	--	end
		return true
	end
	triggerClientEvent ( "addMapIconServer", root, x, y, z, icon, text )
end

function deleteMapIcon( player, id )
	if player then
		if isElement ( player ) then
			if getElementType ( player ) == "player" then
				triggerClientEvent ( player, "deleteMapIconServer", player, id )
			end
		end
		return true
	end
end

function deleteMapIconByText( player, text )
	if player then
		if isElement ( player ) then
			if getElementType ( player ) == "player" then
				triggerClientEvent ( player, "deleteMapIconServerText", player, text )
			end
		end
		return true
	end
end

function checkAndLoadCraftPlaces ()
	for i, object in ipairs ( getElementsByType ( 'object' ) ) do
		if getElementModel ( object ) == 1770 then
			--if not getElementData ( object, 'craft' ) then
				setElementData ( object, 'craft', true )
				local x,y,z = getElementPosition ( object )
				local craftSphere = createColSphere ( x, y, z+0.3, 2 )
				setElementData ( craftSphere, "craft_place", true )
				setElementData ( craftSphere, "action", true )
				setElementData ( craftSphere, "type", 8 )
			--end
		end
	end
end

function loadCraftPlaces ( res )
	setTimer ( checkAndLoadCraftPlaces, 3000, 1 )
end

addEventHandler ( "onResourceStart", getResourceRootElement(), loadCraftPlaces )