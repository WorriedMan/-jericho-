settingTable = {
['xpPower'] = 10,
['thingsInOne'] = 1,
['chanseLoot'] = 1,
['hpPerLevel'] = 20,
['damagePerLevel'] = 1, 
}

-- weaponsDamage = { 
	-- [0] = 15, -- кулаки
	-- [1] = 20, -- 
	-- [2] = 38, -- клюшка
	-- [3] = 25, -- nightstick
	-- [4] = 30, -- нож
	-- [5] = 100, -- суперкувалда
	-- [6] = 20, -- лопата
	-- [7] = 30, -- бильярд
	-- [8] = 50, -- катана
	-- [9] = 35, -- бензопила
	
	-- [22] = 75, -- colt
	-- [23] = 10, -- бесшумный
	-- [24] = 40, -- 10 мм пистолет
	-- [25] = 70, -- шотган
	-- [26] = 100, -- sawnoff
	-- [27] = 67, -- spaz 12
	-- [28] = 20, -- uzi
	-- [29] = 19, -- 10 мм
	-- [30] = 16, -- китайская винтовка
	-- [31] = 13, -- американская винтовка
	-- [32] = 15, -- tec 9
	-- [33] = 70, -- деревенская винтовка
	-- [34] = 100, -- снайперская винтовка
	
	-- [37] = 16, -- горбомет
	-- [38] = 12, -- минигун
-- }


weaponsChangeFR = {
	[25] = 1.5,
	[22] = 0.5,
	[23] = 0.28,
	[24] = 0.36,
	[26] = 0.42,
	[27] = 0.25,
	[29] = 0.11,
	[30] = 0.125,
	[31] = 0.08,
	[33] = 0.94,
	[34] = 1,
	[38] = 0.05
	
}

function loadWeaponsFR ()
	for i, v in pairs ( weaponsChangeFR ) do
		setWeaponProperty ( i, "pro", "anim_loop_stop", 0.2+v)
		setWeaponProperty ( i, "poor", "anim_loop_stop", 0.2+v)
		setWeaponProperty ( i, "std", "anim_loop_stop", 0.2+v)
	end
end


function loadSettings ()
	triggerEvent ( "settingsChanged", root, settingTable )
	triggerEvent ( "weaponsDamageSend", root, weaponsDamage )
	loadWeaponsFR()
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), loadSettings )

function askWeaponsDamageS ()
	triggerClientEvent ( source, 'fromServerWeaponsDamage', source, weaponsDamage )
end 

addEvent( "askWeaponsDamage", true )
addEventHandler( "askWeaponsDamage", root, askWeaponsDamageS )

function getServerSetting ( name )
	if settingTable[name] then
		return settingTable[name]
	else
		return false
	end
end