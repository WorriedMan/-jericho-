settingTable = {
['xpPower'] = 2,
['thingsInOne'] = 1,
['chanseLoot'] = 1,
['hpPerLevel'] = 20,
['damagePerLevel'] = 1, 
}

weaponsDamage = { 
	[0] = 15, -- кулаки
	[1] = 20, -- 
	[2] = 25, -- клюшка
	[3] = 25, -- nightstick
	[4] = 30, -- нож
	[5] = 200, -- суперкувалда
	[6] = 30, -- лопата
	[7] = 30, -- бильярд
	[8] = 50, -- катана
	[9] = 35, -- бензопила
	
	[22] = 350, -- colt
	[23] = 50, -- бесшумный
	[24] = 80, -- 10 мм пистолет
	[25] = 200, -- шотган
	[26] = 220, -- sawnoff
	[27] = 230, -- spaz 12
	[28] = 20, -- uzi
	[29] = 40, -- 10 мм
	[30] = 70, -- китайская винтовка
	[31] = 80, -- американская винтовка
	[32] = 30, -- tec 9
	[33] = 120, -- деревенская винтовка
	[34] = 200, -- снайперская винтовка
	
	[37] = 30, -- горбомет
	[38] = 10, -- минигун
}


function loadSettings ()
	triggerEvent ( "settingsChanged", root, settingTable )
	triggerEvent ( "weaponsDamageSend", root, weaponsDamage )
	
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