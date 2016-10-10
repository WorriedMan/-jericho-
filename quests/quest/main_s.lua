function giveClientWeaponS ( weap, ammo )
	if getPedWeapon ( source, getSlotFromWeapon ( weap ) ) ~= 0 then
		giveWeapon ( source, getPedWeapon ( source, getSlotFromWeapon ( weap ) ), ammo, true )
	else
		giveWeapon ( source, weap, ammo, true )
	end
end
addEvent( "giveClientWeapon", true )
addEventHandler( "giveClientWeapon", getRootElement(), giveClientWeaponS )

function giveClientMoneyS ( amount )
	exports.inventory:givePlayerItemServerWW ( source, 51, amount )
	exports.pipboy:addInfoBox ( "Вы получили "..amount.." КР.", 3, source )
end
addEvent( "giveClientMoney", true )
addEventHandler( "giveClientMoney", getRootElement(), giveClientMoneyS )

function takeClientMoneyS ( amount )
	exports.inventory:removePlayerItemServer ( source, 51, amount )
end
addEvent( "takeClientMoney", true )
addEventHandler( "takeClientMoney", getRootElement(), takeClientMoneyS )

function replaceClientWeaponS ( weap, ammo )
	giveWeapon ( source, weap, ammo, true )
end
addEvent( "replaceClientWeapon", true )
addEventHandler( "replaceClientWeapon", getRootElement(), replaceClientWeaponS )
