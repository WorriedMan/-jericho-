local screenWidth,screenHeight = guiGetScreenSize()
local color = tocolor ( 255, 182, 66 )

texturesTable = {

	-- pip.lua
	{ "texture", ":players/inter.dds" },
	{ "boyTex", "media/pip.dds" },
	{ "timeTex", "media/numbers.png" },
	{ "monTex", "media/months.png" },
	{ "settlement", "media/icon_map_settlement.dds" },
	{ "encamp", "media/icon_map_encampment.dds" },
	{ "undiscovered", "media/icon_map_undiscovered.dds" },
	{ "military", "media/icon_map_military.dds" },
	
	-- barter.lua
	{ "arrow", "media/up.dds" },
	{ "b_arrow", "media/barter_arrow.dds" },
	
	--craft.lua
	{ "mrCraft", "media/craft.png" },
	
	--inventory.lua


	{ "kis", "media/inv/nvdlc01items_cloud_kis_lethal.dds" },
	{ "madre", "media/inv/nvdlc01items_sierra_madre_chip.dds" },
	{ "stim", "media/inv/items_stimpack.dds" },
	{ "water", "media/inv/items_water.dds" },
	{ "squirrel", "media/inv/items_squirrel_stick.dds" },
	{ "iguana", "media/inv/items_iguana_stick.dds" },
	{ "roach", "media/inv/items_roach_meat.dds" },
	{ "psycho", "media/inv/item_psycho.dds" },
	{ "antirad", "media/inv/items_radaway.dds" },
	{ "passsu", "media/inv/item_passcard.dds" },
	{ "passnv", "media/inv/item_torini_card.dds" },

	{ "whiskey", "media/inv/items_whiskey.dds" },
	{ "samogon", "media/inv/items_drink.dds" },
	{ "vodka", "media/inv/items_vodka.dds" },
	{ "spinach", "media/inv/item_xander_root.dds" },
	{ "arad", "media/inv/apperal_enclave_scientist.dds" },

	{ "sgr", "media/inv/karma_saintly.dds" },
	{ "egr", "media/inv/karma_evil.dds" },

	{ "stew", "media/inv/items_stew.dds" },
	{ "seeds", "media/inv/items_seeds.dds" },
	{ "pork", "media/inv/items_pork_beans.dds" },
	{ "dog", "media/inv/item_human_flesh.dds" },
	{ "bag", "media/inv/missing_image.dds" },

	{ "ak", "media/inv/assault_rifle.dds" },
	{ "round5_56", "media/inv/items_5.56mm_rounds.dds" },
	{ "cue", "media/inv/weapons_pool_cue.dds" },
	{ "chain", "media/inv/weapons_chainsaw.dds" },
	{ "shovel", "media/inv/weapons_shovel.dds" },
	{ "katana", "media/inv/weapons_katana.dds" },
	{ "rifle", "media/inv/weapons_rifle.dds" },
	{ "silen", "media/inv/weapons_silenced_22_pistol.dds" },
	{ "sniper", "media/inv/weapons_sniper_rifle.dds" },
	{ "shotgun", "media/inv/weapons_single_shotgun.dds" },
	{ "desert", "media/inv/weapons_10mm_pistol.dds" },
	{ "mp5", "media/inv/weapons_10mm_submachine_gun.dds" },
	{ "m4", "media/inv/weapons_american_assault_rifle.dds" },
	{ "baton", "media/inv/weapons_baton.dds" }, -- полицейская дубинка
	{ "cshot", "media/inv/weapons_combat_shotgun.dds" },
	{ "flamer", "media/inv/weapons_flamer.dds" },
	{ "sawed", "media/inv/weapons_sawed_off_shotgun.dds" },
	{ "supersled", "media/inv/weapons_supersledge.dds" },
	
	{ "snipAm", "media/inv/items_.50_bmg.dds" },
	{ "snipAmShell", "media/inv/items_.50_bmg_shell.dds" },
	{ "mp5Am", "media/inv/items_10mm_rounds.dds" },
	{ "mp5AmShell", "media/inv/items_10mm_rounds_shell.dds" },
	{ "pistolAm", "media/inv/items_.32calibur.dds" },
	{ "pistolAmShell", "media/inv/items_.32calibur_shell.dds" },
	{ "desrtAm", "media/inv/items_.45-70.dds" },
	{ "dsrtAmShell", "media/inv/items_.45-70_shell.dds" },
	{ "shotAm", "media/inv/items_40mm.dds" },
	{ "shotAmShell", "media/inv/items_40mm_shell.dds" },
	{ "tec9Am", "media/inv/items_.308_ammo.dds" },
	{ "tec9AmShell", "media/inv/items_.308_ammo_shell.dds" },
	{ "m4AmShell", "media/inv/items_12.7mm_ammo_shell.dds" },
	{ "m4Am", "media/inv/items_12.7mm_ammo.dds" },

	{ "fungus", "media/inv/fungus.dds" },
	{ "sunset", "media/inv/sunset.dds" },
	{ "cap", "media/inv/cap.dds" },
	{ "lighter", "media/inv/lighter.dds" },
	{ "pin", "media/inv/pin.dds" },
	{ "doctor_bag", "media/inv/item_doctors_bag.dds" },
	{ "junk", "media/inv/item_junk.dds" },
	{ "morph", "media/inv/item_morphine.dds" },
	{ "cola", "media/inv/cola.dds" },
	{ "tablets", "media/inv/tablets.dds" },
	{ "apple", "media/inv/items_apple.dds" },
	{ "cont", "media/inv/items_empty_container.dds" },
	{ "spikes", "media/inv/spikes.dds" },
	{ "powder", "media/inv/item_antivenom.dds" },
	
	{ "wBase", "media/inv/items_base.dds" },
	{ "scope", "media/inv/items_scope.dds" },
	{ "stock", "media/inv/items_stock.dds" },
	{ "barrel", "media/inv/items_barrel.dds" },
	{ "shotBarrel", "media/inv/items_shot_tube.dds" },
	{ "rifleCust", "media/inv/items_rifle_cust.dds" },
	{ "rifleBarrel", "media/inv/items_rifle_tube.dds" },
	{ "kitCust", "media/inv/items_kit_cust.dds" },
	{ "amerMag", "media/inv/items_kit_mag.dds" },
	{ "kitBarrel", "media/inv/items_kit_base.dds" },
	{ "amerBarrel", "media/inv/items_amer_barrel.dds" },
	{ "kitMag", "media/inv/items_amer_mag.dds" },
	{ "stealth", "media/inv/items_stealthboy.dds" },
	{ "minigun", "media/inv/weapons_minigun.dds" },
	{ "ncr", "media/inv/apperal_ncr_fatigues_armor.dds" },
	{ "tesla", "media/inv/apperal_tesla_armor.dds" },
	{ "ranger", "media/inv/apparel_ncr_ranger_combat_armor.dds" },
	{ "enclave", "media/inv/apperal_enclave_power_armor.dds" },
	{ "patriot", "media/inv/items_skill_mags_melee.dds" },
	{ "scroll", "media/inv/items_scroll.dds" },
	{ "jet", "media/inv/item_jet.dds" },
	{ "flamer_fuel", "media/inv/items_flamer_fuel.dds" },
	{ "venom", "media/inv/item_bleak_venom.dds" },
	{ "raider", "media/inv/apperal_raider_armor_3.dds" },
	{ "laser", "media/inv/weapons_laser_pistol.dds" },
	{ "fusion", "media/inv/items_fusion_cell.dds" },
	{ "repair", "media/inv/item_repair_kit.dds" },
	{ "safe", "media/inv/perk_long_haul.dds" },
	{ "bobby_pin", "media/inv/item_bobby_pin.dds" },
	{ "ninemmpistol", "media/inv/weapons_9mm_pistol.dds" },
	{ "ninemmammo", "media/inv/items_9mm_ammo.dds" },
	{ "ninemmsmg", "media/inv/weapons_9mm_smg.dds" },
	{ "twelvesmg", "media/inv/weapons_12.7mm_smg.dds" },
	{ "gauss", "media/inv/weapons_gauss_rifle.dds" },
	{ "twelvepistol", "media/inv/weapons_12.7mm_pistol.dds" },
	{ "magnumrevolver", "media/inv/weapons_.357_revolver.dds" },
	{ "magnumammo", "media/inv/items_.357_magnum_round.dds" },
	{ "alien", "media/inv/weapons_alien_blaster.dds" },
	{ "huntrevolver", "media/inv/weapons_hunting_revolver.dds" },
	{ "rangerrevolver", "media/inv/weapons_ranger_sequoia.dds" },
	{ "lunchbox", "media/inv/item_lunchbox.dds" },
	{ "infiltrator", "media/inv/weapons_infiltrator_rifle.dds" },
	

}

ready = 0

t = {}

function loadTextures ()
	local totalItems = #texturesTable
	local perc = 100/totalItems
	--addEventHandler ( "onClientRender", root, function () if ready < 100 then outputChatBox ('Готово: '..tostring(ready)..'%') end end )
	for i = 1, totalItems do
		t[texturesTable[i][1]] = dxCreateTexture ( texturesTable[i][2] )
		--assert(loadstring(texturesTable[i][1]..' = dxCreateTexture ( "'..texturesTable[i][2]..'" )'))()
	end
	mapIcons = {
		{ 335, 60, t.settlement, t.settlement_inv, "ElQuebrados", "Эль Кебрадос" },
		{ 405, 123, t.encamp, t.encamp_inv, "ScienceUnion", "Союз Ученых" },
		{ 375, 95, t.encamp, t.encamp_inv, "NewCountry", "Новая Деревня" },
		{ 480, 130, t.encamp, t.encamp_inv, "trade", "Торговый пост" }, 
		{ 555, 208, t.encamp, t.encamp_inv, "klamat", "Кламат" },
		{ 243, 185, t.encamp, t.encamp_inv, "rc","Ривет Сити"},
		{ 287, 223, t.settlement, t.settlement_inv, "coll", "Вест Сайд" },
		{ 402, 55, t.encamp, t.encamp_inv, "NewVegas", "Новый Вегас" },
		{ 370, 50, t.settlement, t.settlement_inv, "Hostel", "Хостел" },
		{ 545, 310, t.settlement, t.settlement_inv, "Roadtown", "Роадтаун" },
	}
	things = { -- название, описание,  вес, не удаляется при использовании, квестовый, имеется ли состояние
		{ t.stim, "Стимулятор", "Здр. +100; Гол. +5;",0.2, false, false, false }, -- 1
		{ t.squirrel, "Шашлык из белки", "Здр. +5; Рад. +5; Гол. -5;",0.1, false, false, false }, -- 2
		{ t.iguana, "Шашлык из игуаны", "Здр. +5; Рад. +10; Гол. -10;",0.2, false, false, false }, -- 3
		{ t.roach, "Радотаракан", "Здр. +40; Рад. +30; Гол. -25;",0.2, false, false, false }, -- 4
		{ t.water, "Чистая вода", "Здр. +40; Рад. -20; Гол. -1;",0.5, false, false, false }, -- 5
		{ t.psycho, "Винт", "ОД +10; Гол. +10;",1, false, false, false }, -- 6
		{ t.antirad, "Антирад", "Выводит радиацию из организма. Гол. +10;",1, false, false, false }, -- 7
		{ t.passsu, "Карта доступа", "С помощью этой карты, вы можете проникнуть в Союз Ученых", 0, true, true }, -- 8
		{ t.passnv, "Приглашение", "С помощью этого приглашения, вы можете проникнуть в Новый Вегас", 0, true, true }, -- 9
		{ t.dog, "Рука гуля", "Здр. +30; Рад. +30; Гол. -30;",2, false, false, false }, -- 10
		{ t.whiskey, "Виски", "Здр. +10; Рад. -10; Гол. -5;",0.5, false, false, false }, -- 11
		{ t.vodka, "Водка", "Здр. +20; Рад. -20; Гол. -2", 0.5, false, false, false }, -- 12
		{ t.samogon, "Самогон", "Рад. -20; Здр. -5; Гол. -7;",0.6, false, false, false }, -- 13
		{ t.arad, "АнтиРад костюм", "Защита от внешней радиации.",10, true, false, false }, -- 14
		{ t.sgr, "Святой грааль", "Выводит всю Рад.; Восст. Здр.",5, false, false, false }, -- 15
		{ t.egr, "Нечестивый грааль", "Выводит всю Рад.",0, false, false, false }, -- 16
		{ t.spinach, "Шпинат", "Выводит всю Рад. из организма.",0.1, false, false, false }, -- 17
		{ t.stew, "Тушенка", "Полностью убирает Гол.",0.2, false, false, false }, -- 18
		{ t.pork, "Консервы", "Гол. -20;",0.2, false, false, false }, -- 19
		{ t.seeds, "Пакетик орехов", "Гол. -5;",0.1, false, false, false },  -- 20
		{ t.madre, "М. Сьерра Мадре", "Монета из казино Сьерра Мадре", 0.1, true, false, false },  -- 21
		{ t.water, "Зараженная вода", "Восстанавливает 30 Здр.; +20 Рад.", 0.6, false, false, false },  -- 22
		{ t.bag, "Сумка", "Макс. вес - 30 кг", 5, true, false, false }, -- 23
		{ t.ak, "Китайский автомат", "УВС: 132", 7, true, false, true }, -- 24
		{ t.round5_56, "Патроны 5,56-мм", "", 0.01, true, false, false }, -- 25
		{ t.cue, "Кий", "УРН: 30", 2, true, false, true }, -- 26
		{ t.chain, "Бензопила", "УРН: 35", 10, true, false, true }, -- 27
		{ t.shovel, "Лопата", "УРН: 20", 2, true, false, true }, -- 28
		{ t.katana, "Катана", "УРН: 50", 1, true, false, true }, -- 29
		{ t.rifle, "Винтовка", "УРН: 52; УВС: 72", 2, true, false, true }, -- 30
		{ t.silen, "Бесшумный", "УРН: 10; УВС: 35", 0.5, true, false, true }, -- 31
		{ t.sniper, "Снайперская винтовка", "УВС: 42.9", 8, true, false, true }, -- 32
		{ t.shotgun, "Дробовик", "УРН: 70; УВС: 46", 3, true, false, true }, -- 33
		{ t.desert, "10-мм пистолет", "УВС: 60.5", 3, true, false, true }, -- 34
		{ t.mp5, "10-мм пистолет-пулемёт", "УВС: 171", 5, true, false, true }, -- 35
		{ t.m4, "Штурмовая винтовка", "УВС: 104", 7, true, false, true }, -- 36
		{ t.baton, "Дубинка", "УРН: 28", 2, true, false, true }, -- 37
		{ t.cshot, "Боевой дробовик", "УРН: 67; УВС: 268", 7, true, false, true }, -- 38
		{ t.flamer, "Горбомет - 1", "УРН: 16", 10, true, false, true }, -- 39
		{ t.sawed, "Обрез", "УРН: 100; УВС: 238", 2, true, false, true }, -- 40
		{ t.supersled, "Суперкувалда", "УРН: 100", 5, true, false, true }, -- 41
		{ t.snipAm, ".50 патроны", "Патроны для винтовки", 0.01, true, false, false }, -- 42 
		{ t.mp5Am, "10мм авто. патроны", "Патроны для 10 мм SMG", 0.05, true, false, false }, -- 43
		{ t.pistolAm, ".32 патроны", "Для пистолета калибра .32", 0.01, true, false, false }, -- 44
		{ t.desrtAm, "10-мм патроны", "", 0.05, true, false, false }, -- 45
		{ t.shotAm, "Дробь", "Для дробовиков", 0.05, true, false, false }, -- 46
		{ t.tec9Am, ".308 патроны", "Патроны для TEC-9", 0.01, true, false, false }, -- 47
		{ t.m4Am, "12.7 патроны", "", 0.02, true, false, false }, -- 48
		{ t.fungus, "Гриб", "5 секунд беск. ОД; Рад. +5;", 0.5, false, false, false }, -- 49 
		{ t.sunset, "Сансет саспарилла", "Гол. -2; Здр. +10", 1, false, false, false }, -- 50
		{ t.cap, "Крышка", "", 0.001, true, false, false }, -- 51
		{ t.lighter, "Зажигалка", "", 0.01, true, false, false }, -- 52
		{ t.pin, "Заколка", "", 0.001, true, false, false }, -- 53
		{ t.doctor_bag, "Сумка доктора", "", 3, false, false, false }, -- 54
		{ t.junk, "Хлам", "", 3, true, false, false }, -- 55
		{ t.morph, "Пустой шприц", "", 0.01, true, false, false }, -- 56
		{ t.cola, "Ядер-Кола", "3 секунд беск. ОД; Рад. +8; Гол. -2", 1, false, false, false }, -- 57
		{ t.tablets, "Антирад таблетки", "", 0.01, true, false, false }, -- 58
		{ t.apple, "Свежее яблоко",  "Здр. +3; Гол. -7;", 0.5, false, false, false }, -- 59
		{ t.cont, "Пустая банка", "", 0.3, true, false, false }, -- 60
		{ t.spikes, "Гвозди", "", 0.5, true, false, false }, -- 61
		{ t.shotAmShell, "Гильзы дробь", "", 0.005, true, false, false }, -- 62
		{ t.snipAmShell, "Гильзы .50", "", 0.01, true, false, false }, -- 63
		{ t.dsrtAmShell, "Гильзы 10 мм", "", 0.001, true, false, false }, -- 64
		{ t.pistolAmShell, "Гильзы .32", "", 0.001, true, false, false }, -- 65
		{ t.tec9AmShell, "Гильзы .308", "", 0.001, true, false, false }, -- 66
		{ t.m4AmShell, "Гильзы 12.7", "", 0.003, true, false, false }, -- 67
		{ t.junk, 'Свинец', "", 0.001, true, false, false }, -- 68
		{ t.junk, 'Набор \'Порох + Капсюли\'', '', 2, false, false, false }, -- 69
		{ t.powder, 'Порох', '', 0.001, true, false, false }, -- 70
		{ t.junk, 'Капсюль', '', 0.0001, true, false, false }, -- 71
		{ t.junk, 'Ткани', '', 2, true, false, false }, -- 72
		{ t.junk, 'Нитки и иголка', "", 0.1, true, false, false }, -- 73 
		{ t.mrCraft, 'Мистер Рукоблуд-1000П', '', 7, true, false, true }, --74
		{ t.wBase, 'Спусковой механизм', '', 1.5, true, false, true }, -- 75
		{ t.scope, 'Прицел', '', 1, true, false, true }, -- 76
		{ t.stock, 'Деревянный приклад', '', 0.7, true, false, true }, -- 77
		{ t.barrel, 'Средний ствол', '', 0.5, true, false, true }, -- 78
		{ t.shotBarrel, 'Ствол (дробовик)', '', 0.5, true, false, true }, -- 79
		{ t.rifleCust, 'Зарядник (винтовка)', '', 0.3, true, false, true }, -- 80
		{ t.rifleBarrel, 'Ствол (винтовка)', '', 0.4, true, false, true }, -- 81
		{ t.kitCust, 'Зарядник (кит. винтовка)', '', 0.5, true, false, true }, -- 82
		{ t.kitMag, 'Магазин (кит. винтовка)', '', 0.3, true, false, true }, -- 83
		{ t.kitBarrel, 'Ствол (кит. винтовка)', '', 0.3, true, false, true }, -- 84
		{ t.amerBarrel, 'Ствол (ам. винтовка)', '', 0.2, true, false, true }, -- 85
		{ t.amerMag, 'Магазин (ам. винтовка)', '', 0.1, true, false, true }, -- 86
		{ t.kitCust, 'Зарядник (ам. винтовка)', '', 0.1, true, false, true }, -- 87
		{ t.stealth, 'Стелс-бой', '', 1, true, false, true }, -- 88
		{ t.junk, 'Сломанные очки', '', 0.1, true, true, false }, -- 89
		{ t.junk, 'Новые очки', '', 0.1, true, true, false }, -- 90
		{ t.junk, 'Стеклышки', '', 0.05, true, true, false }, -- 91
		{ t.junk, 'Оправа очков', '', 0.05, true, true, false }, -- 92
		{ t.kitCust, 'Зарядник минигана', '', 3, true, false, true }, -- 93
		{ t.minigun, 'Миниган', 'УРН: 10', 10, true, false, true }, -- 94
		{ t.junk, 'Скотч', '', 0.5, true, false, false }, -- 95
		{ t.ncr, 'Броня солдата', 'ПУ 10;+2 ВЫН;', 5, true, false, true }, -- 96
		{ t.tesla, 'Броня Тесла', 'ПУ 30;РЗ;+2 СИЛ;+1 ВЫН;+1 МЕТ.', 20, true, false, true }, -- 97
		{ t.ranger, 'Рейнджер', 'ПУ 20;РЗ;+2 МЕТ.', 10, true, false, true }, -- 98
		{ t.enclave, 'T51-B', 'ПУ 25;РЗ;+1 СИЛ;+1 МЕТ.', 20, true, false, true }, -- 99
		{ t.bag, "Средняя сумка", "Макс. вес - 70 кг", 6, true, false, false }, -- 100
		{ t.bag, "Большая сумка", "Макс. вес - 100 кг", 7, true, false, false }, -- 101
		{ t.patriot, 'Патритот (стр.23)', '', 0.1, true, false, false }, -- 102
		{ t.patriot, 'Патритот (стр.12)', '', 0.1, true, false, false }, -- 103
		{ t.patriot, 'Патритот (стр.8)', '', 0.1, true, false, false }, -- 104
		{ t.patriot, 'Патритот (стр.4)', '', 0.1, true, false, false }, -- 105
		{ t.patriot, 'Патритот (стр.25)', '', 0.1, true, false, false }, -- 106
		{ t.scroll, 'Письмо неизвестного', '', 0, true, true, false }, -- 107
		{ t.scroll, 'Письмо Аргаила', '', 0, true, true, false }, -- 108
		{ t.jet, 'Кислородный накопитель', '', 0.5, false, false, false }, -- 109
		{ t.venom, 'Синяя эссенция', '', 0.1, false, false, false }, -- 110
		{ t.flamer_fuel, 'Топливо', 'Для \"Горбомет - 1\"', 5, false, false, false }, -- 111
		{ t.flamer_fuel, 'Пустой бак', 'Для \"Горбомет - 1\"', 3, false, false, false }, -- 112
		{ t.enclave, 'T-52C', 'ПУ 25; РЗ; +3 СИЛ; +4 ВЫН; +3 МЕТ.', 0, true, false, true }, -- 113
		{ t.raider, 'Броня рейдера', 'ПУ 4; +1 СИЛ; +3 ВЫН.', 5, true, false, true }, -- 114
		{ t.raider, 'Броня Изгоев', 'ПУ 5; +2 СИЛ; +2 МЕТ.', 5, true, false, true }, -- 115
		{ t.raider, 'Броня МВ', 'ПУ 6; РЗ; +3 СИЛ; +2 ВЫН; +2 МЕТ.', 5, true, false, true }, -- 116
		{ t.laser, 'Лазерный пистолет', 'УРН: 75; УВС: 150', 5, true, false, true }, -- 117
		{ t.fusion, 'Батарея', 'Для лазерного пистолета', 0.5, true, false, false }, -- 118
		{ t.fusion, 'Пустая батарея', '', 0.1, true, false, false }, -- 119
		{ t.junk, 'Дрова', 'Дрова из сосны', 4, false, false, false }, -- 120
		{ t.scroll, 'Записка', '', 0, true, true, false }, -- 121
		{ t.bag, 'Непонятный предмет', '', 0, true, true, false }, -- 122
		{ t.repair, 'Ремонтный набор', 'Восстанавливает 50% состояния предмета', 2, true, false, false }, -- 123
		{ t.safe, 'Мистер Хранитель-П', 'Защитите свои предметы паролем!', 2, true, false, false }, -- 124
		{ t.patriot, 'Патритот (стр.32)', '', 0.1, true, false, false }, -- 125
		{ t.bobby_pin, 'Заколка', 'Позволяет открыть закрытый замок', 0.2, true, false, false }, -- 126
		{ t.enclave, 'Броня Сталкера', '', 15, true, false, false }, -- 127
		{ t.dog, 'Рука мутанта', 'Несъедобна', 5, true, true, false }, -- 128
		{ t.ninemmpistol, '9-мм пистолет', 'УВС: 49', 1.5, true, false, true }, -- 129
		{ t.ninemmammo, '9-мм патроны', '', 0.01, true, false, false }, -- 130
		{ t.pistolAmShell, "Гильзы 9-мм", "", 0.001, true, false, false }, -- 131
		{ t.ninemmpistol, '9-мм пистолет+', 'УВС: 49. Увеличена обойма.', 1.5, true, false, true }, -- 132
		{ t.ninemmpistol, 'Мария', 'УВС: 74', 1, true, false, true }, -- 133
		{ t.ninemmsmg, '9-мм пистолет-пулемёт', 'УВС: 154', 4, true, false, true }, -- 134
		{ t.twelvesmg, '12,7-мм пистолет-пулемёт', 'УВС: 324', 5, true, false, true }, -- 135
		{ t.gauss, 'Винтовка Гаусса', 'УВС: 360', 7, true, false, true }, -- 136
		{ t.fusion, 'Микроядерная батарея', '', 0.1, true, false, false }, -- 137
		{ t.twelvepistol, '12,7-мм пистолет', 'УВС: 109', 3.5, true, false, true }, -- 138
		{ t.twelvepistol, '12,7-мм пистолет+', 'УВС: 109. Увеличена обойма.', 3.5, true, false, true }, -- 139
		{ t.magnumrevolver, 'Револьвер Магнум кал. 357', 'УВС: 45.5', 2, true, false, true }, -- 140
		{ t.magnumammo, "Патрон кал. 357 'Магнум'", '', 0.035, true, false, false }, -- 141
		{ t.pistolAmShell, "Гильза .357 'Магнум'", '', 0.03, true, false, false }, -- 142
		{ t.alien, 'Бластер Чужих', 'УВС: 131.3. Микроядерные батареи.', 2, true, false, true }, -- 143
		{ t.huntrevolver, 'Охотничий револьвер', 'УВС: 87. Патрон .45-70', 4, true, false, true }, -- 144
		{ t.rangerrevolver, 'Секвойя рейнджера', 'УВС: 104. Патрон .45-70', 4, true, false, true }, -- 145
		{ t.desrtAm, "Патрон кал. 45-70", '', 0.065, true, false, false }, -- 146
		{ t.dsrtAmShell, "Гильза кал. 45-70", '', 0.06, true, false, false }, -- 147
		{ t.desert, "10-мм пистолет+", "УВС: 60.5. Увеличена обойма.", 3, true, false, true }, -- 148
		{ t.ak, "Китайский автомат+", "УВС: 132. Увеличена обойма.", 7, true, false, true }, -- 149
		{ t.ak, "Китайский автомат Джерико", "УВС: 132. Не ломается.", 7, true, false, true }, -- 150
		{ t.lunchbox, "Ланчбокс Волт-Тек №1", "Учавствуйте в беспроигрышной лотерее и выиграйте Винтовку Гаусса!", 0, false, false, false }, -- 151
		{ t.m4, "Штурмовая винтовка+", "УВС: 104. Увеличена обойма", 7, true, false, true }, -- 152
		{ t.m4AmShell, "Гильзы 5,56-мм", "", 0.001, true, false, false }, -- 153
		{ t.tec9Am, "Патрон кал. 308", '', 0.055, true, false, false }, -- 154
		{ t.tec9AmShell, "Гильза кал. 308", '', 0.05, true, false, false }, -- 155
		{ t.sniper, "Винтовка резервиста", "УВС: 64", 10, true, false, true }, -- 156
		{ t.sniper, "Винтовка «Виктория»", "УВС: 42", 8, true, false, true }, -- 157
		{ t.lunchbox, "Ланчбокс Волт-Тек №2", "Учавствуйте в беспроигрышной лотерее и выиграйте Силовую броню!", 0, false, false, false }, -- 158
		{ t.infiltrator, "Инфильтратор", "УВС: 200. Патроны: 5,56-мм.", 7, true, false, true }, -- 159
		{ t.infiltrator, "Дырокол", "УВС: 280. Патроны: 5,56-мм.", 7, true, false, true }, -- 160
		{ t.dog, "Сырая рука гуля", "", 3, false, false, false }, -- 161
	}

end

function getItemTexture(id)	
	if things and things[id]  then
		return things[id][1]
	else
		return false
	end
end

addtionalSettings = {
	[89] = { checkondrop = function() return false end},
	[90] = { checkondrop = function() return false end},
	[91] = { checkondrop = function() return false end},
	[92] = { checkondrop = function() return false end},
	[107] = { checkondrop = function() return getElementData(localPlayer, "quest_ring" ) >= 3 end},
	[108] = { checkondrop = function() return getElementData(localPlayer, "quest_her" ) == 3 end},
	[128] = { checkondrop = function() return getElementData(localPlayer, "quest_check" ) == 11 end},

}

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),loadTextures)	
things={}

local numero = 11
local iTotal = 0

inv = nil

local clickTimeout = 0

local page = 0
local prevSel = false
local over = false
local itsel = false
local selectedLabel = 0 
shortCutAllowed = true
setElementData ( localPlayer, "inventoryAllowed", 1 )

-- Новые
local cursorOnItem

local cursorOnNextPage
local cursorOnPrevPage

local cursorOnUseItem
local cursorOnDropItem

local dropTimeout = 0

function playUiFocus()
	playSound ( "media/sound/ui_menu_focus.wav" )
end

function renderInventory ( )
	local x, y = xPip+175, yPip+10
	local num = 0
	local total = 0
	local itemFound = false
	for i = 1+(12*page), #inv do
		if over then break end
		if inv[i][1] > 0 and inv[i][2] > 0 then
			px = x+65+90*num -- 80
			num = num+1
			total = total+1
			dxDrawImage ( px, y, 128, 128, things[inv[i][1]][1], 0, 0, 0, color )	
			if isCursorInPosition( px+20, y+25, 70, 90) then
				cursorOnItem = i
				itemFound = true
				dxDrawLine ( px+20, y+25, px+20, y+115, tocolor ( 255, 182, 66 ), 2 )
				dxDrawLine ( px+20, y+115, px+95, y+115,tocolor ( 255, 182, 66 ), 2 )
				dxDrawLine ( px+95, y+115, px+95, y+25, tocolor ( 255, 182, 66 ), 2 )
				dxDrawLine ( px+20, y+25, px+95, y+25, tocolor ( 255, 182, 66 ), 2 )
			end
			dxDrawText ( things[inv[i][1]][2], px+20, y+100, px+95, y+130, tocolor ( 255, 182, 66 ), 0.9, "default-bold","left", "top", false, true)
			if inv[i][2] > 1 then
				dxDrawText ( inv[i][2], px+75, y+75, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default-bold" )
			end
			if total%4 == 0 then
				y = y + 95 -- 75
				num = 0
			end
			if total == 12 then
				over = true
			end
		end
	end
	if cursorOnItem and not itemFound then
		cursorOnItem = nil
	end
	if itsel then
		if inv[selectedLabel][5] and inv[selectedLabel][5] < 100 and getElementData ( localPlayer, "repair_ready" ) and inv[selectedLabel][1] ~= 123 then
			dxDrawText ( "РЕМОНТИРОВАТЬ", xPip+285, yPip+325, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default" )
		else
			dxDrawText ( "ИСПОЛЬЗОВАТЬ", xPip+285, yPip+325, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default" )
		end
		if isCursorInPosition( xPip+285, yPip+325, 140, 25) then
			dxDrawLine ( xPip+285, yPip+325, xPip+285, yPip+350, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+285, yPip+350, xPip+425, yPip+350, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+425, yPip+350, xPip+425, yPip+325, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+285, yPip+325, xPip+425, yPip+325, tocolor ( 255, 182, 66 ), 2 )
			if not cursorOnUseItem then
				playUiFocus()
			end
			cursorOnUseItem = true
		elseif cursorOnUseItem then
			cursorOnUseItem = false
		end
		dxDrawText ( "ВЫБРОСИТЬ", xPip+285, yPip+355, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default" )
		if isCursorInPosition( xPip+285, yPip+355, 140, 25) then
			dxDrawLine ( xPip+285, yPip+355, xPip+285, yPip+380, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+285, yPip+380, xPip+395, yPip+380, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+395, yPip+380, xPip+395, yPip+355, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+285, yPip+355, xPip+395, yPip+355, tocolor ( 255, 182, 66 ), 2 )
			if not cursorOnDropItem then
				playUiFocus()
			end
			cursorOnDropItem = true
		elseif cursorOnDropItem then
			cursorOnDropItem = false
		end
	else
		if cursorOnUseItem then
			cursorOnUseItem = false
		end
		if cursorOnDropItem then
			cursorOnDropItem = false
		end
	end
	if over and iTotal > 1 then
		dxDrawText ( "СЛЕД. СТРАНИЦА", xPip+450, yPip+325, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default" )
		if isCursorInPosition( xPip+450, yPip+325, 150, 25) then
			dxDrawLine ( xPip+450, yPip+325, xPip+450, yPip+350, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+450, yPip+350, xPip+600, yPip+350, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+600, yPip+350, xPip+600, yPip+325, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+450, yPip+325, xPip+600, yPip+325, tocolor ( 255, 182, 66 ), 2 )
			if not cursorOnNextPage then
				playUiFocus()
			end
			cursorOnNextPage = true
		elseif cursorOnNextPage then
			cursorOnNextPage = false
		end
	elseif cursorOnNextPage then
		cursorOnNextPage = false
	end
	if page > 0 then
		dxDrawText ( "ПРЕД. СТРАНИЦА", xPip+450, yPip+355, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1.5, "default" )
		if isCursorInPosition( xPip+450, yPip+355, 150, 25) then
			dxDrawLine ( xPip+450, yPip+355, xPip+450, yPip+380, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+450, yPip+380, xPip+600, yPip+380, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+600, yPip+380, xPip+600, yPip+355, tocolor ( 255, 182, 66 ), 2 )
			dxDrawLine ( xPip+450, yPip+355, xPip+600, yPip+355, tocolor ( 255, 182, 66 ), 2 )
			if not cursorOnPrevPage then
				playUiFocus()
			end
			cursorOnPrevPage = true
		elseif cursorOnPrevPage then
			cursorOnPrevPage = false
		end
	
	elseif cursorOnPrevPage then
		cursorOnPrevPage = false
	end
	over = false
	drawKeyBoxes ()
end

function initializeInventory ( )
	local x, y = xPip+200, yPip+10
	page = 0
	nxtSel = false
	prevSel = false
	over = false
	itsel = false
	selectedLabel = 0 
	inv = exports.inventory:getItemsLargeNull() -- вес, ид, количество
	exports.inventory:checkPlayerWeight()
	wei = getElementData ( localPlayer, "invWeight" )
	mWei = getElementData ( localPlayer, "maxWeight" )
	calculateTotalItems ()
	weightLabel = guiCreateLabel ( xPip+440, yPip+435, 180, 15, "ВЕС: "..wei.."/"..mWei.." кг", false )
	stateLabel = guiCreateLabel ( xPip+290, yPip+435, 180, 15, "ССТ: -", false )
	descrLabel = guiCreateLabel ( xPip+280, yPip+385, 300, 45, "Добро пожаловать в МУЛВ-К (Мастер Учета Личных Вещей - Карманный). Выберите предмет.", false )
	guiLabelSetColor ( weightLabel, 152, 114, 54 )
	guiLabelSetColor ( stateLabel, 152, 114, 54 )
	guiLabelSetColor ( descrLabel, 152, 114, 54 )
	guiSetFont ( descrLabel, "default-bold-small" )
	guiLabelSetHorizontalAlign ( descrLabel, "left", true )
	showInv = true
	bindKey("mouse1","down",playerClickedInInventory)
end

shortCut = {
	{ 0, 0 },
	{ 0, 0 },
	{ 0, 0 },
	{ 0, 0 },
	{ 0, 0 },
	{ 0, 0 },
	{ 0, 0 },
	{ 0, 0 },
	{ 0, 0 },
}

local shortLabelGlow = 0

function loadShortCutsC (shortT)
	if shortT[1] and type(shortT[1]) == "table" and #shortT[1] == 2 and #shortT == 9 then
		setElementData ( localPlayer, "cutsTable", shortCut )
	else
		shortT = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}}
		setElementData ( localPlayer, "cutsTable", shortT )
	end
	shortCut = shortT
	bindKey ( "1", "down", useShortCut )
	bindKey ( "2", "down", useShortCut )
	bindKey ( "3", "down", useShortCut )
	bindKey ( "4", "down", useShortCut )
	bindKey ( "5", "down", useShortCut )
	bindKey ( "6", "down", useShortCut )
	bindKey ( "7", "down", useShortCut )
	bindKey ( "8", "down", useShortCut )
	bindKey ( "9", "down", useShortCut )
end

addEvent( "loadedShortCuts", true )
addEventHandler( "loadedShortCuts", getRootElement(), loadShortCutsC )

addEventHandler( "onClientResourceStart", getResourceRootElement( ),
    function ( startedRes )
		if getElementData ( localPlayer, "online" ) == 1 then
			loadShortCutsC ( getElementData ( localPlayer, "cutsTable" ) )
		end	
    end
);


function drawKeyBoxes ()
	local pX, pY = screenWidth/2-350, screenHeight-100
	for i = 1, #shortCut do
		dxDrawText ( i, pX+60, pY, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1, myFont )
		local selectedShort = false
		if isCursorInPosition(pX+15, pY, 65, 80) then
			dxDrawRectangle ( pX+15, pY, 65, 80, tocolor ( 255, 182, 66, 30 ) )
			shortLabelGlow = i
			selectedShort = true
		end
		if not selectedShort and shortLabelGlow == i then
			shortLabelGlow = 0
		end 
		if shortCut[i][1] and shortCut[i][1] ~= 0 then
			dxDrawImage ( pX, pY, 90, 90, things[shortCut[i][2]][1], 0, 0, 0, color )
		end
		dxDrawLine ( pX+15, pY, pX+80, pY, color, 1.5 )
		dxDrawLine ( pX+15, pY, pX+15, pY+80, color, 1.5 )
		dxDrawLine ( pX+80, pY, pX+80, pY+80, color, 1.5 )
		pX = pX+80
	end
end

function useShortCut ( but )
	if shortCutAllowed then
		shortCutAllowed = false
		setTimer ( function () shortCutAllowed = true end, 2000, 1 )
		if getElementData ( localPlayer, "inventoryAllowed" ) == 1 then
			local id = tonumber(but)
			if id then
				if shortCut[id][1] and shortCut[id][1] ~= 0 then
					if (shortCut[id][2] == 23) then
						if getElementData ( localPlayer, "rplvl" ) < 3 then
							outputChatBox ( 'Вы не можете использовать сумку до 3 уровня', 255, 150, 150 )
							return true
						end
					end
					local amount = exports.inventory:getItemAmountByID ( shortCut[id][1] )
					if amount > 0 then
						if not things[shortCut[id][2]][5] then
							exports.inventory:removePlayerItemByPos ( shortCut[id][1], 1 )
						end
						exports.inventory:useItem ( shortCut[id][2], shortCut[id][1] )
						if exports.inventory:getItemAmountByID ( shortCut[id][1] ) == 0 then
							shortCut[id] = { 0, 0 }
							setElementData ( localPlayer, "cutsTable", shortCut )
						end
					else
						shortCut[id] = { 0, 0}
						setElementData ( localPlayer, "cutsTable", shortCut )
					end
				end
			end
		end
	end
end

function calculateTotalItems ()	
	local temp = 0
	for i = 1, #inv do
		if inv[i][2] > 0 then
			temp = temp+1
		end
	end
	iTotal = math.ceil ( temp/11 )
end

function nextPage ()
	if iTotal > page+1 then
		page = page+1
		itsel = false
		playSound ( "media/sound/ui_pipboy_select.wav" )
	end
end

function prevPage ()
	if page > 0 then
		page = page-1
		itsel = false
		playSound ( "media/sound/ui_pipboy_select.wav" )
	end
end

function invClicked ()
	if getElementData ( source, "invLabel" ) then
		itsel = true
		selectedLabel = getElementData ( source, "invLabelNUM" )
		local id = getElementData ( source, "invLabelID" )
		guiSetText ( descrLabel, things[id][2].."\n"..things[id][3].." Вес "..things[id][4].." кг" )
		if things[id][7] and inv[selectedLabel][5] then
			guiSetText ( stateLabel, "ССТ: "..tostring(math.floor(inv[selectedLabel][5])).."%")
			if inv[selectedLabel][5] < 20 then
				guiLabelSetColor ( stateLabel, 255, 114, 54 )
			elseif inv[selectedLabel][5] > 80 then
				guiLabelSetColor ( stateLabel, 152, 255, 54 )
			end
    else
			guiSetText ( stateLabel, "ССТ: -")
			guiLabelSetColor ( stateLabel, 152, 114, 54 )
		end
	--	if things[id][7] then
	--		guiSetText ( stateLabel, "Сост.: "..inv[selectedLabel][2].."/100" )
	--	end
	end
end

function useButton ()
	local id = selectedLabel
	local quant = inv[id][2]
	local itemID = tonumber(inv[id][1])
	playSound ( "media/sound/ui_pipboy_select.wav" )
	if (itemID == 23) then
		if getElementData ( localPlayer, "rplvl" ) < 3 then
			outputChatBox ( 'Вы не можете использовать сумку до 3 уровня', 255, 150, 150 )
			return true
		end
	end
	if inv[selectedLabel][5] and inv[selectedLabel][5] < 100 and getElementData ( localPlayer, "repair_ready" ) then
		exports.inventory:repairItem(inv[id][6],50)
		setElementData ( localPlayer, "repair_ready", false )
		closeInventory()
		pipClose()
		exports.inventory:removePlayerItem ( 123, 1 )
		return true
	end
	if things[itemID][7] and inv[id][5] <= 0 then
		addInfoBox ( "Снаряжение сломано, для использования его необходимо отремонтировать", 2 )
		return true
	end
	if not things[itemID][5] then
		if inv[id][2] > 0 then
			inv[id][2] = quant-1
		end
		if quant-1 == 0 then
			calculateTotalItems ()
			guiSetText ( descrLabel, "Добро пожаловать в МУЛВ-К (Мастер Учета Личных Вещей - Карманный). Выберите предмет." )
			itsel = false
			selectedLabel = 0 
		end
		exports.inventory:removePlayerItemByPos ( inv[id][6], 1 )
		exports.inventory:checkPlayerWeight ()
		wei = getElementData ( localPlayer, "invWeight" )
		mWei = getElementData ( localPlayer, "maxWeight" )
		guiSetText ( weightLabel, "ВЕС: "..wei.."/"..mWei.." кг" )
		if things[itemID][7] and inv[id][5] then
			guiSetText ( stateLabel, "ССТ: "..tostring(math.floor(inv[id][5])).."%")
			if inv[id][5] < 20 then
				guiLabelSetColor ( stateLabel, 255, 114, 54 )
			elseif inv[id][5] > 80 then
				guiLabelSetColor ( stateLabel, 152, 255, 54 )
			end
		else
			guiSetText ( stateLabel, "ССТ: -")
			guiLabelSetColor ( stateLabel, 152, 114, 54 )
		end
	end
	exports.inventory:useItem ( itemID, inv[id][6] )
end

local hisClickTimes = 0
local clicked2secondsAgoHis = false
local clickedHisTimer = nil
local prevItemClicked = 0

function dropButton ()
	local id = selectedLabel
	local quant = inv[id][2]
	if things[inv[id][1]][6] and addtionalSettings[inv[id][1]] and not addtionalSettings[inv[id][1]].checkondrop() then
		addInfoBox ( "Это квестовый предмет, его нельзя выкинуть, пока не завершен квест.", 2 )
		return true
	end
	if inv[id][1] ~= 8 and inv[id][1] ~= 9 then
		if not clicked2secondsAgoHis or prevItemClicked ~= inv[id][1] then
			hisClickTimes = 0
		end
		prevItemClicked = inv[id][1]
		hisClickTimes = hisClickTimes+1
		clicked2secondsAgoHis = true
		if isTimer ( clickedHisTimer ) then
			killTimer ( clickedHisTimer )
		end
		clickedHisTimer = setTimer ( function () clicked2secondsAgoHis = false end, 1000, 1 )
		local quanttmp = 1
		if hisClickTimes > 5 then
			quanttmp = ( inv[id][2] < 5 and inv[id][2] ) or 5
		end
		if hisClickTimes > 10 then
			quanttmp = ( inv[id][2] < 10 and inv[id][2] ) or 10
		end
		exports.inventory:removePlayerItemByPos ( inv[id][6], quanttmp )
		if inv[id][2] >= quanttmp then
			inv[id][2] = quant-quanttmp
		else
			inv[id][2] = 0
		end
		if inv[id][2] == 0 then
			calculateTotalItems ()
			guiSetText ( descrLabel, "Добро пожаловать в МУЛВ-К (Мастер Учета Личных Вещей - Карманный). Выберите предмет." )
			itsel = false
			selectedLabel = 0 
		end
		playSound ( "media/sound/ui_pipboy_select.wav" )
		playSound ( "media/sound/ui_items_generic_down.wav" )
		exports.inventory:checkPlayerWeight ()
		wei = getElementData ( localPlayer, "invWeight" )
		mWei = getElementData ( localPlayer, "maxWeight" )
		guiSetText ( weightLabel, "Вес: "..wei.."/"..math.floor(mWei).." кг" )
		if things[inv[id][1]][7] and inv[id][5] then
			guiSetText ( stateLabel, "ССТ: "..tostring(math.floor(inv[id][5])))
			if inv[id][5] < 20 then
				guiLabelSetColor ( stateLabel, 255, 114, 54 )
			elseif inv[id][5] > 80 then
				guiLabelSetColor ( stateLabel, 152, 255, 54 )
			end
		else
			guiSetText ( stateLabel, "ССТ: -")
			guiLabelSetColor ( stateLabel, 152, 114, 54 )
		end
	end
end

addEventHandler( "onClientMouseEnter", getResourceRootElement(), 
    function(aX, aY)
		if getElementData ( source, "shortLabel" ) then
			shortLabelGlow = getElementData ( source, "shortLabelID" )
			playSound ( "media/sound/ui_menu_focus.wav" )
		end
		if showMap and getElementData ( source, "mapIcon" ) then
			selMapIcon = getElementData ( source, "mapIconID" )
			selectedType = 2
		end
		if showMap and getElementData ( source, "mapAdditIcon" ) then
			selMapIcon = getElementData ( source, "mapIconID" )
			selectedType = 1
		end
    end
)

addEventHandler("onClientMouseLeave", getRootElement(), function(aX, aY)
	if showMap and getElementData ( source, "mapIcon" ) then
		selMapIcon = 0
	end
	if showMap and getElementData ( source, "mapAdditIcon" ) then
		selMapIcon = 0
	end
end)

function closeInventory ()
	setElementData ( localPlayer, "inventoryAllowed", 1 )
	destroyElement ( weightLabel )
	destroyElement ( descrLabel )
	destroyElement ( stateLabel )
	unbindKey("mouse1","down",playerClickedInInventory)
	inv = nil
	local page = 0
	local nxtSel = false
	local prevSel = false
	local over = false
	local itsel = false
	local selectedLabel = 0 
end

function playerClickedInInventory ()
	if clickTimeout+200 > getTickCount() then return end
	clickTimeout = getTickCount()
	if cursorOnItem then
		selectedLabel = cursorOnItem
		itsel = true
		local id = inv[selectedLabel][1]
		guiSetText ( descrLabel, things[id][2].."\n"..things[id][3].." Вес "..things[id][4].." кг" )
		if things[id][7] and inv[selectedLabel][5] then
			guiSetText ( stateLabel, "ССТ: "..tostring(math.floor(inv[selectedLabel][5])).."%")
			if inv[selectedLabel][5] < 20 then
				guiLabelSetColor ( stateLabel, 255, 114, 54 )
			elseif inv[selectedLabel][5] > 80 then
				guiLabelSetColor ( stateLabel, 152, 255, 54 )
			end	
		end
	elseif cursorOnNextPage then
		nextPage()
	elseif cursorOnPrevPage then
		prevPage()
	elseif cursorOnUseItem then
		useButton()
	elseif cursorOnDropItem then
		if dropTimeout > getTickCount() then
			dropButton()
		else
			dropTimeout = getTickCount()+500
		end
	elseif shortLabelGlow > 0 then
		playSound ( "media/sound/ui_pipboy_select.wav" )
		if selectedLabel then
			shortCut[shortLabelGlow][1] = inv[selectedLabel][6]
			shortCut[shortLabelGlow][2] = inv[selectedLabel][1]
		else
			shortCut[shortLabelGlow][1] = 0
			shortCut[shortLabelGlow][2] = 0
		end
		setElementData ( localPlayer, "cutsTable", shortCut )
	end
end

function isCursorInPosition ( x, y, w, h )
	if not isCursorShowing () then return false end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	if ( cx > x and cx < x + w ) and ( cy > y and cy < y + h ) then
		return true  
	else
		return false
	end
end