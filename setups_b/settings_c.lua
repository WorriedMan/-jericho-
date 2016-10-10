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
	[24] = 350, -- 10 мм пистолет
	[25] = 200, -- шотган
	[26] = 220, -- sawnoff
	[27] = 230, -- spaz 12
	[28] = 20, -- uzi
	[29] = 30, -- 10 мм
	[30] = 70, -- китайская винтовка
	[31] = 80, -- американская винтовка
	[32] = 30, -- tec 9
	[33] = 120, -- деревенская винтовка
	[34] = 200, -- снайперская винтовка
	
	[37] = 30, -- горбомет
	[38] = 10, -- минигун
}

armorDT = {
	[96] = 10,
	[97] = 30,
	[98] = 20,
	[99] = 25,
	[96] = ,
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