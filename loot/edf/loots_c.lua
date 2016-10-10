radZoneLabel = nil
localPlayer = getLocalPlayer ()
lootPlaces = nil
pressAllowed = 0

lootItems = {
	{ 1, 6 },
	{ 2, 1 },
	{ 3, 2 },
	{ 4, 2 },
	{ 5, 3 },
	{ 6, 8 },
	{ 7, 8 },
	{ 10, 1 },
	{ 11, 1 },
	{ 12, 2 },
	{ 13, 2 },
	{ 14, 15 },
	{ 15, 500 },
	{ 16, 100 },
	{ 17, 1 },
	{ 21, 1 },
}

function getLootState ( id )
	if lootPlaces[id] then
		return lootPlaces[id][3]
	end
end

function checkLootPlace( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) then
		if getElementData ( source, "loot" ) then
			bindKey ( "E", "down", checkLootPlacePress, getElementData ( source, "ident" ), getElementData ( source, "level" ), getElementData ( source, "zloot" ), source )
		end
    end
end
addEventHandler("onClientColShapeHit",getRootElement(),checkLootPlace)

function checkLootPlaceLeave( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) then
		if getElementData ( source, "loot" ) then
			unbindKey ( "E", "down", checkLootPlacePress )
		end
    end
end
addEventHandler("onClientColShapeLeave",getRootElement(),checkLootPlaceLeave)

function checkLootPlacePress ( key, keyState, ident, level, zloot, loot )
	if pressAllowed == 0 then
		pressAllowed = 1
		setTimer ( function () pressAllowed = 0 end, 3000, 1 )
		if loot then
			if zloot then
				unbindKey ( "E", "down", checkLootPlacePress )
				if destroyElement ( loot ) then
					local randItem = math.random ( 1, #lootItems )
					local chanceToItem = math.random ( 1, 2*lootItems[randItem][2] )
					if chanceToItem == 1 then
						exports.inventory:givePlayerItem ( lootItems[randItem][1], 1 )
					else
						outputChatBox ( "На гуле ничего нет" , 255, 255, 255) --http://a2.rimg.info/090139780ff9c2e613f78976d03f6be2.gif
					end
				end
			else
				if lootPlaces[ident][3] == 0 then
					local chanceToChange = math.random ( 1, level  )
					for i = 1, chanceToChange do
						local ammoritem = 1
						local weapSlot = math.random ( 2, 6 )
						local weapInSlot = getPedWeapon ( localPlayer, weapSlot )
						local ammo = getPedTotalAmmo ( localPlayer, weapSlot )
						if ammo > 0 then
							if getElementData ( localPlayer, "fammoPerk" ) then ammoritem = math.random ( 1, 3 ) end
						end
						if ammoritem < 2 then
							local randItem = math.random ( 1, #lootItems )
							local chanceToItem = math.random ( 1, lootItems[randItem][2] )
							if chanceToItem == 1 then
								exports.inventory:givePlayerItem ( lootItems[randItem][1], 1 )
							else
								if getElementData ( localPlayer, "findPerk" ) then
									if chanceToItem == 2 then
										exports.inventory:givePlayerItem ( lootItems[randItem][1], 1 )
									else
										outputChatBox ( "Ящик пуст" , 255, 255, 255)
									end
								else
									outputChatBox ( "Ящик пуст" , 255, 255, 255)
								end
							end
						else
							triggerServerEvent ( "giveLootAmmo", getLocalPlayer(), weapInSlot ) 
						end
					end
					lootPlaces[ident][3] = 1
				else
					outputChatBox ( "Вы уже смотрели этот ящик" , 255, 255, 255)
				end
			end
		end
	end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),
    function ( startedRes )
        triggerServerEvent ( "loadLootPlacesC", getLocalPlayer() ) 
    end
);

function recieveLootPlace ( lootPlacesTable )
	lootPlaces = lootPlacesTable
end

addEvent( "sendLootPlaceS", true )
addEventHandler( "sendLootPlaceS", getRootElement(), recieveLootPlace )

function sendLootPlaceAlone ( lootTable )
	table.insert(lootPlaces, lootTable )
end

addEvent( "sendLootPlaceAloneS", true )
addEventHandler( "sendLootPlaceAloneS", getRootElement(), sendLootPlaceAlone )