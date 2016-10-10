function loadWeaponsMods ()
	for i, v in pairs (weaponStats) do
		if v.mod_name then
			local weaponTXD = engineLoadTXD ("mods/"..v.mod_name..".txd")
			engineImportTXD (weaponTXD, v.object)
			local weaponDFF = engineLoadDFF ("mods/"..v.mod_name..".dff",v.object)
			engineReplaceModel (weaponDFF, v.object)
		end
	end
	empty = engineLoadDFF ("mods/empty.dff")
	for i, v in ipairs ( weapons_toremove ) do
		engineReplaceModel (empty, v)
	end
	setWorldSoundEnabled( 5, false )
end

addEventHandler ( "onClientResourceStart",  getResourceRootElement(), loadWeaponsMods )

bindKey ( "aim_weapon", "both", 
	function ( _, state ) 
	if getPedWeaponSlot ( localPlayer ) == 6 then 
		local alpha
		if ( state == "down" ) then 
			alpha = 0 
		elseif ( state == "up" ) then 
			alpha = 255 
		end 
		if playersWeapons[localPlayer] then
			if isElement ( playersWeapons[localPlayer].object ) then
				setElementAlpha ( playersWeapons[localPlayer].object, alpha ) 
			end
		end
	end
end)