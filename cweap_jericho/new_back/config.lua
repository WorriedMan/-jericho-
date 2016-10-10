-- Типы оружий:
-- colt 45
-- silenced
-- deagle
-- uzi
-- mp5
-- ak-47
-- m4
-- tec-9
-- rifle
-- sniper
-- minigun

weaponStats = {-- x вперед y вбок z вверх
	--["Название пушки"] = { kind = тип, shoot_fast = можно ли стрелять не прицеливаясь (как пистолетом), offset = { x = отступ относительно x координаты дула, y = ..y координаты, z = ..z координаты }, fire_rate = скорость стрельбы, props = {["weapon property 1"] = значение, ["weapon property 2"] = значение, ["weapon property n"] = значение}}
	--["AKM"] = { kind = "ak-47", shoot_fast = false, offset = {x = 0, y = 0, z = 0, rx = 180, ry = 83, rz = 187}, fire_rate = 100, props = {["accuracy"] = 1, ["weapon_range"] = 150}},
	["9-мм пистолет"] = { kind = "silenced", id = 23, damage = 16, noise = 1, fire_rate = 326, crit_chance = 1, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.25, y = 0.03, z = 0.125}, object = 1858, camshake = 0.1, sound_folder = "colt45", clip = 13, props = { ["accuracy"] = { 0.5, 0.5, 0.5 } },mod_name="colt45", reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["9-мм пистолет+"] = { kind = "silenced", id = 23, damage = 16, noise = 1, fire_rate = 326, crit_chance = 1, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.25, y = 0, z = 0.12}, object = 1859, camshake = 0.1, sound_folder = "colt45", clip = 26, props = { ["accuracy"] = { 0.5, 0.5, 0.5 } },mod_name="colt45ex", reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["Мария"] = { kind = "silenced", id = 23, damage = 20, noise = 1, fire_rate = 263, crit_chance = 2, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.25, y = 0.03, z = 0.125}, object = 1669, camshake = 0.1, sound_folder = "colt45", clip = 13, props = { ["accuracy"] = { 0.8, 0.8, 0.8 } },mod_name="maria", reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["Китайский автомат"] = { kind = "ak-47", id = 30, noise = 1, shoot_fast = false, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.6, y = 0, z = 0.1, rx = 0, ry = 270, rz = 0}, object = 1857, fire_rate = 100, camshake = 0.1, sound_folder = "akm", clip = 10, props = { ["accuracy"] = { 1, 1, 1 }, ["weapon_range"] = {150,150,150}},mod_name="akm", reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["9-мм пистолет-пулемёт"] = { kind = "uzi", id = 28, noise = 1, damage = 14, fire_rate = 90, crit_chance = 0.08, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.55, y = -0.03, z = 0.23}, object = 2812, camshake = 0.2, sound_folder = "colt45", clip = 30, props = { ["accuracy"] = { 0.2, 0.2, 0.2 } },mod_name="coltmachine", reload_anim = {{"UZI","UZI_reload"},{"UZI","UZI_crouchreload"}},},
	["10-мм пистолет-пулемёт"] = { kind = "mp5", id = 29, noise = 1, damage = 14, fire_rate = 111, crit_chance = 0.09, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.55, y = -0.05, z = 0.26}, object = 1860, camshake = 0.1, sound_folder = "10mm", clip = 30, props = { ["accuracy"] = { 0.18, 0.18, 0.18 } },mod_name="10mmsmg", reload_anim = {{"TEC","TEC_reload"},{"TEC","TEC_crouchreload"}},},
	["12,7-мм пистолет-пулемёт"] = { kind = "mp5", id = 29, noise = 1, damage = 36, fire_rate = 111, crit_chance = 0.09, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.55, y = 0.025, z = 0.13}, object = 372, camshake = 0.2, sound_folder = "127mm", clip = 21, props = { ["accuracy"] = { 0.19, 0.19, 0.19 } },mod_name="127smg", reload_anim = {{"TEC","TEC_reload"},{"TEC","TEC_crouchreload"}},},
	["Винтовка Гаусса"] = { kind = "sniper", id = 34, damage = 120, noise = 1, crit_chance = 2, fire_rate = 333, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 1.15, y = -0.1, z = 0.28}, object = 1861, camshake = 1, sound_folder = "gauss", clip = 5, props = { ["accuracy"] = { 0.95, 0.95, 0.95 } },mod_name="gauss", reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["12,7-мм пистолет"] = { kind = "silenced", id = 23, damage = 40, noise = 1, crit_chance = 1, fire_rate = 366, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.25, y = 0.03, z = 0.125}, object = 1862, camshake = 0.2, sound_folder = "127mm", clip = 7, props = { ["accuracy"] = { 0.6, 0.6, 0.6 } },mod_name="127pistol", reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["12,7-мм пистолет+"] = { kind = "silenced", id = 23, damage = 40, noise = 1, crit_chance = 1, fire_rate = 366, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.25, y = 0.03, z = 0.125}, object = 1862, camshake = 0.2, sound_folder = "127mm", clip = 14, props = { ["accuracy"] = { 0.6, 0.6, 0.6 } }, reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["Револьвер Магнум кал. 357"] = { kind = "silenced", id = 23, noise = 1, damage = 26, crit_chance = 1, fire_rate = 571, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.25, y = 0, z = 0.115}, object = 1863, camshake = 0.1, sound_folder = "357magnum", mod_name="357magnum", clip = 6, props = { ["accuracy"] = { 0.4, 0.4, 0.4 } }, reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["Бластер Чужих"] = { kind = "silenced", id = 23, damage = 75, noise = 1, disable_model = true, crit_chance = 100, fire_rate = 571, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.25, y = 0, z = 0.115}, object = 1864, camshake = 0.1, sound_folder = "alien", mod_name="alien", clip = 10, props = { ["accuracy"] = { 1.0, 1.0, 1.0 } }, reload_anim = {{"PYTHON","python_reload"},{"PYTHON","python_crouchreload"}},},
	["Охотничий револьвер"] = { kind = "silenced", id = 23, damage = 58, noise = 1, crit_chance = 1, fire_rate = 667, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.25, y = 0, z = 0.115}, object = 1865, camshake = 0.2, sound_folder = "huntingrevolver", mod_name="hunting_revolver", clip = 5, props = { ["accuracy"] = { 0.7, 0.7, 0.7 } }, reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	--["Секвойя рейнджера"] = { kind = "silenced", id = 23, damage = 62, noise = 1, crit_chance = 1.5, fire_rate = 600, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.25, y = 0, z = 0.115}, object = 1866, camshake = 0.2, sound_folder = "huntingrevolver", mod_name="ranger", clip = 5, props = { ["accuracy"] = { 0.8, 0.8, 0.8 } }, reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["Секвойя рейнджера"] = { kind = "silenced", id = 23, damage = 62, noise = 1, crit_chance = 1.5, fire_rate = 600, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.25, y = 0, z = 0.115}, object = 1866, camshake = 0.2, sound_folder = "huntingrevolver", mod_name="ranger", clip = 500, props = { ["accuracy"] = { 0.8, 0.8, 0.8 } }, reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["10-мм пистолет"] = { kind = "silenced", id = 23, damage = 22, noise = 1, crit_chance = 1, fire_rate = 363, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.25, y = 0, z = 0.115}, object = 1867, camshake = 0.2, sound_folder = "10mm", mod_name="10mmpistol", clip = 12, props = { ["accuracy"] = { 0.6, 0.6, 0.6 } }, reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["10-мм пистолет+"] = { kind = "silenced", id = 23, damage = 22, noise = 1, crit_chance = 1, fire_rate = 363, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.25, y = 0, z = 0.115}, object = 1867, camshake = 0.2, sound_folder = "10mm", clip = 24, props = { ["accuracy"] = { 0.6, 0.6, 0.6 } }, reload_anim = {{"COLT45","colt45_reload"},{"COLT45","colt45_crouchreload"}},},
	["Китайский автомат"] = { kind = "ak-47", id = 30, damage = 16.5, noise = 1, crit_chance = 0.125, fire_rate = 125, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.6, y = 0, z = 0.08}, object = 1868, camshake = 0.3, sound_folder = "akm", clip = 24, mod_name="akm", props = { ["accuracy"] = { 0.4, 0.4, 0.4 } }, reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Китайский автомат+"] = { kind = "ak-47", id = 30, damage = 16.5, noise = 1, crit_chance = 0.125, fire_rate = 125, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.6, y = 0, z = 0.08}, object = 1868, camshake = 0.3, sound_folder = "akm", clip = 48, mod_name="akm", props = { ["accuracy"] = { 0.4, 0.4, 0.4 } }, reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Китайский автомат Джерико"] = { kind = "ak-47", id = 30, damage = 16.5, noise = 1, crit_chance = 0.125, fire_rate = 125, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.6, y = 0, z = 0.08}, object = 1868, camshake = 0.3, sound_folder = "akm", clip = 24, mod_name="akm", props = { ["accuracy"] = { 0.4, 0.4, 0.4 } }, reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Штурмовая винтовка"] = { kind = "ak-47", id = 30, damage = 13, noise = 1, crit_chance = 0.13, fire_rate = 125, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.6, y = 0, z = 0.08}, object = 1869, camshake = 0.3, sound_folder = "m4", clip = 24, mod_name="m4", props = { ["accuracy"] = { 0.5, 0.5, 0.5 } }, reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Штурмовая винтовка+"] = { kind = "ak-47", id = 30, damage = 13, noise = 1, crit_chance = 0.13, fire_rate = 125, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.6, y = 0, z = 0.08}, object = 1869, camshake = 0.3, sound_folder = "m4", clip = 48, mod_name="m4", props = { ["accuracy"] = { 0.5, 0.5, 0.5 } }, reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Снайперская винтовка"] = { kind = "sniper", id = 34, damage = 40, noise = 1, crit_chance = 5, fire_rate = 909, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.6, y = 0, z = 0.08}, object = 1870, camshake = 0.5, sound_folder = "sniper", clip = 5, mod_name="sniper", props = { ["accuracy"] = { 0.96, 0.96, 0.96 } }, reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Винтовка резервиста"] = { kind = "sniper", id = 34, damage = 40, noise = 1, crit_chance = 5, fire_rate = 625, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.6, y = 0, z = 0.08}, object = 1870, camshake = 0.3, sound_folder = "sniper", clip = 3, mod_name="sniper", props = { ["accuracy"] = { 0.93, 0.93, 0.93 } }, reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Винтовка «Виктория»"] = { kind = "sniper", id = 34, damage = 40, noise = 1, crit_chance = 3, fire_rate = 952, object_offset = {x = 0.02, y = 0, z = 0, rx = -5, ry = 260, rz = 0}, offset = {x = 0.6, y = 0, z = 0.08}, object = 1870, camshake = 0.3, sound_folder = "sniper", clip = 5, mod_name="sniper", props = { ["accuracy"] = { 0.96, 0.96, 0.96 } }, reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Инфильтратор"] = { kind = "ak-47", id = 30, noise = 1.5, damage = 25, fire_rate = 125, crit_chance = 0.5, object_offset = {x = 0, y = 0, z = 0, rx = -5, ry = 270, rz = 0}, offset = {x = 0.55, y = -0.03, z = 0.23}, object = 1871, camshake = 0.1, sound_folder = "m4", clip = 24, props = { ["accuracy"] = { 0.6, 0.6, 0.6 } },mod_name="infi", reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Дырокол"] = { kind = "ak-47", id = 30, noise = 1.5, damage = 35, fire_rate = 125, crit_chance = 0.5, object_offset = {x = 0, y = 0, z = 0, rx = 0, ry = 270, rz = 0}, offset = {x = 0.55, y = -0.03, z = 0.23}, object = 1871, camshake = 0.1, sound_folder = "m4", clip = 24, props = { ["accuracy"] = { 0.75, 0.75, 0.75 } },mod_name="infi", reload_anim = {{"RIFLE","RIFLE_load"},{"RIFLE","RIFLE_crouchload"}},},
	["Кий"] = { damage = 30, id = 2, onehand = true },
	["Лопата"] = { damage = 20, id = 2, onehand = true },
	["Дубинка"] = { damage = 28, id = 2, onehand = true },
	["Бензопила"] = { damage = 35, id = 2, onehand = true },
	["Катана"] = { damage = 50, id = 2, onehand = true },
	["Супердубина"] = { damage = 100, id = 2, onehand = true },


}

weaponModels = {
	["Инфильтратор"] = { coords = {3,0.19,-0.15,-0.1,0,270,0}, id = 30, model = 1871},
	["Дырокол"] = { coords = {3,0.19,-0.15,-0.1,0,270,0}, id = 30, model = 1871},
	["Китайский автомат"] = { coords = {3,0.19,-0.15,-0.1,0,270,0}, id = 30, model = 1857},
	["Китайский автомат+"] = { coords = {3,0.19,-0.15,-0.1,0,270,0}, id = 30, model = 1868},
	["Китайский автомат Джерико"] = { coords = {3,0.19,-0.15,-0.1,0,270,0}, id = 30, model = 1868},
	["Штурмовая винтовка"] = { coords = {3,0.19,-0.15,-0.1,0,270,0}, id = 30, model = 1869},
	["Штурмовая винтовка+"] = { coords = {3,0.19,-0.15,-0.1,0,270,0}, id = 30, model = 1869},
	["9-мм пистолет"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1858},
	["9-мм пистолет+"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1859},
	["Мария"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1669},
	["9-мм пистолет-пулемёт"] = { coords = {14,0.11,0,0,180,90,270}, id = 28, model = 2812},
	["10-мм пистолет-пулемёт"] = { coords = {14,0.11,0.07,0,180,90,270}, id = 29, model = 1860},
	["12,7-мм пистолет-пулемёт"] = { coords = {14,0.11,0.07,0,180,90,270}, id = 29, model = 372},
	["Винтовка Гаусса"] = { coords = {3,0.19,-0.31,-0.1,0,270,-90}, id = 34, model = 1861},
	["12,7-мм пистолет"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1862},
	["12,7-мм пистолет+"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1862},
	["Револьвер Магнум кал. 357"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1863},
	["Бластер Чужих"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1864},
	["Охотничий револьвер"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1865},
	["Секвойя рейнджера"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1866},
	["10-мм пистолет"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1867},
	["10-мм пистолет+"] = { coords = {14,0.11,0,0,180,90,270}, id = 23, model = 1867},
	["Снайперская винтовка"] = { coords = {3,0.19,-0.31,-0.1,0,270,-90}, id = 34, model = 1870},
	["Винтовка резервиста"] = { coords = {3,0.19,-0.31,-0.1,0,270,-90}, id = 34, model = 1870},
	["Винтовка «Виктория»"] = { coords = {3,0.19,-0.31,-0.1,0,270,-90}, id = 34, model = 1870},

}

soundTypes = {
	"fire",
	"reload",
	"equip",
	"jam",
}

weaponID = {
	[30] = true,
	[29] = true,
	[22] = true,
	[28] = true,
	[23] = true,
}

weapons_toremove = {
	--346, -- Pistol
	--347, -- Silenced Pistol
	--348, -- Desert Eagle
	--349, -- Shotgun
	--350, -- Sawn-Off Shotgun
	--351, -- Combat Shotgun
	352, -- Uzi
	353, -- MP5
	--355, -- AK-47
	--356, -- M4
	--357, -- Country Riffle
	358, -- Sniper Rifle
	--372, -- Tec-9

}

function getPlayerCurrentWeaponStats (player)
	if isElement ( player ) then
		local currentWeapon = getElementData ( player, "currentWeapon" )
		if currentWeapon and weaponStats[currentWeapon] then
			return weaponStats[currentWeapon], currentWeapon
		else
			local currentMeele = getElementData ( player, "meeleWeapon" )
			if currentMeele and weaponStats[currentMeele] then
				return weaponStats[currentWeapon], currentWeapon
			end
		end
	end
	return false
end

function getPlayerAmmoAmount (player)
	return getElementData (player, "currAmmoAmount") or 0
end

function getPlayerCurrentWeapon (player)
	return getElementData ( player, "currentWeapon" ) or "no"
end

function extendLine ( x,y,z,x2,y2,z2,length )
	local vx = x2 - x
	local vy = y2 - y
	local vz = z2 - z
	local ratio = length/(getDistanceBetweenPoints3D ( x,y,z,x2,y2,z2 ))
	vx = vx*ratio
	vy = vy*ratio
	vz = vz*ratio
	return (x + vx),(y + vy),(z + vz)
end