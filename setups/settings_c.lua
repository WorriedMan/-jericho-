weaponsDamage = { 
	[0] = 15, -- кулаки
	[1] = 20, -- 
	[2] = 38, -- клюшка
	[3] = 28, -- nightstick
	[4] = 36, -- нож
	[5] = 100, -- суперкувалда
	[6] = 20, -- лопата
	[7] = 30, -- бильярд
	[8] = 50, -- катана
	[9] = 35, -- бензопила
	
	[22] = 75, -- colt
	[23] = 10, -- бесшумный
	[24] = 40, -- 10 мм пистолет
	[25] = 70, -- шотган
	[26] = 100, -- sawnoff
	[27] = 67, -- spaz 12
	[28] = 20, -- uzi
	[29] = 19, -- 10 мм
	[30] = 16, -- китайская винтовка
	[31] = 13, -- американская винтовка
	[32] = 15, -- tec 9
	[33] = 70, -- деревенская винтовка
	[34] = 100, -- снайперская винтовка
	
	[37] = 16, -- горбомет
	[38] = 12, -- минигун
}


armorDT = { -- не используется
	[96] = 10,
	[97] = 30,
	[98] = 20,
	[99] = 25,
	[113] = 25,
	[114] = 4,
	[115] = 5,
	[116] = 6,
}


function loadSettingsClient ()
	--triggerServerEvent ( "askWeaponsDamage", localPlayer )
	triggerEvent ( 'weaponsDamageSendClient', source, weaponsDamage )
end

addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), loadSettingsClient )

function askWeaponsDamageS ()
	triggerEvent ( 'weaponsDamageSendClient', source, weaponsDamage )
end 

addEvent( "askWeaponsDamage", true )
addEventHandler( "askWeaponsDamage", root, askWeaponsDamageS )