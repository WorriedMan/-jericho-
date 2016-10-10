things = { -- название вес, цвета, функция, что то, не стак
	{ "Стимулятор", 0.2, 255, 255, 255, "useAidInventory()", false, false }, -- 1
	{ "Шашлык из белки", 0.1, 255, 255, 255, "eatSmallRat()", false, false }, -- 2
	{ "Шашлык из игуаны", 0.2, 255, 255, 255, "eatMedRat()", false, false }, -- 3
	{ "Радотаракан", 0.2, 255, 255, 255, "eatBigRat()", false, false }, -- 4
	{ "Чистая вода", 0.5, 255, 255, 255, "drinkCleanWater()", false, false }, -- 5
	{ "Винт", 1, 0, 255, 0, "usePsycho()", false, false }, -- 6
	{ "Антирад", 1, 0, 255, 0, "useAntiRad()", false, false }, -- 7
	{ "Пропуск в Союз Ученых", 0, 205, 203, 48, "usePropSU()", false, false }, -- 8
	{ "Пропуск в Новый Вегас", 0, 205, 203, 48, "usePropNV()", false, false }, -- 9
	{ "Рука гуля", 2, 255, 255, 255, "eatZombHand()", false, false }, -- 10
	{ "Виски", 0.5, 255, 255, 255, "drinkBeer()", false, false }, -- 11
	{ "Водка", 0.5, 255, 255, 255, "drinkVodka()", false, false }, -- 12
	{ "Самогон", 0.6, 255, 255, 255, "drinkSamogon()", false, false }, -- 13
	{ "АнтиРад костюм", 10, 255, 255, 255, "wearAntiRad()", false, true }, -- 14
	{ "Святой Грааль", 5, 255, 255, 255, "useHolyGraal()", false, false }, -- 15
	{ "Нечестивый Грааль", 0, 255, 255, 255, "useDarkGraal()", false, false }, -- 16
	{ "Шпинат", 0.1, 255, 50, 50, "eatSpinach()", false, false }, -- 17
	{ "Тушенка", 0.2, 255, 255, 255, "eatTushonka()", false, false }, -- 18
	{ "Консервы", 0.2, 255, 255, 255, "eatKonserv()", false, false }, -- 19
	{ "Пакетик орехов", 0.1, 255, 255, 255, "eatNuts()", false, false },  -- 20
	{ "Монеты Сьерра Мадре", 0.01, 255, 255, 255, "useMadreCoins()", false, false },  -- 21
	{ "Зараженная вода", 0.6, 255, 255, 255, "useNukeWater()", false, false },  -- 22
	{ "Сумка", 5, 255, 255, 255, "useBag()", false, false }, --23
	{ "Китайский автомат", 8, 255,255,255, "equipAK()", false, true }, -- 24
	{ "Патроны 5.56", 0.01, 255,255,255, "equipAmmoAUTO()", false, false }, -- 25
	{ "Кий", 2, 0,0,0,"equipPoolCue()", false, true }, -- 26
	{ "Бензопила", 10, 0,0,0,"equipChanSaw()", false, true }, -- 27
	{ "Лопата", 2, 0,0,0,"equipShovel()", false, true }, -- 28
	{ "Катана", 1, 0,0,0,"equipKatana()", false, true }, -- 29
	{ "Винтовка", 2, 0,0,0,"equipRifle()", false, true }, -- 30
	{ "Бесшумный", 0.5, 0,0,0,"equipSilenced()", false, true }, -- 31
	{ "Снайперская винтовка", 5, 0,0,0,"equipSniper()", false, true }, -- 32
	{ "Шотган", 3, 0,0,0,"equipShotgun()", false, true }, -- 33
	{ "10мм пистолет", 1, 0,0,0,"equipDesert()", false, true }, -- 34
	{ "10мм SMG", 3, 0,0,0,"equipMP5()", false, true }, -- 35
	{ "Американская винтовка",3, 0,0,0,"equipM4()", false, true }, -- 36
	{ "Дубинка", 2, 0,0,0,"equipBaton()", false, true }, -- 37
	{ "Боевой шотган", 7, 0,0,0,"equipCShot()", false, true }, -- 38
	{ "Горбомет - 1", 10, 0,0,0,"equipFlamethrower()", false, true }, -- 39
	{ "Обрез", 2, 0,0,0,"equipSawed()", false, true }, -- 40
	{ "Супер дубина", 5, 0,0,0,"equipSledge()", false, true }, -- 41
	{ ".50 патроны", 0.01, 0,0,0,"equipSnipAm()", false, false }, -- 42 
	{ "10мм авто. патроны", 0.05, 0,0,0,"equipMP5Am()", false, false }, -- 43
	{ ".32 патроны", 0.01, 0,0,0,"equipPistolAm()", false, false }, -- 44
	{ "10 мм патроны", 0.05, 0,0,0,"equipDesertAm()", false, false }, -- 45
	{ "Дробь", 0.05, 0,0,0,"equipShotAm()", false, false }, -- 46
	{ ".308 патроны", 0.01, 0,0,0,"equipTec9Am()", false, false }, -- 47
	{ "12.7 патроны", 0.02, 0,0,0,"equipM4Am()", false, false }, -- 48
	{ "Гриб", 0.5, 0,0,0,"eatFungus()", false, false }, -- 49
	{ "Сансет саспарилла", 1, 0,0,0, "drinkSunset()", false, false }, -- 50
	{ "Крышка", 0.005, 0,0,0, "useCap()", false, false }, -- 51
	{ "Зажигалка", 0.01, 0,0,0, "makeFire()", false, false }, -- 52
	{ "Заколка", 0.001, 0,0,0, "usePin()", false, false }, -- 53
	{ "Сумка доктора", 3, 0,0,0, "useDoctorBag()", false, false }, -- 54
	{ "Хлам", 3, 0, 0, 0, "useJunk()", false, false }, -- 55
	{ "Пустой шприц", 0.01, 0,0,0, "useMorph()", false, false }, --56
	{ "Ядер-Кола", 1, 0,0,0, "drinkCola()", false, false }, -- 57
	{ "Антирад таблетки", 0.01, 0,0,0, "useTablets()", false, false }, -- 58
	{ "Свежее яблоко", 0.5, 0,0,0, "eatApple()", false, false }, -- 59
	{ "Пустая банка", 0.3, 0,0,0, "useContainer()", false, false }, -- 60
	{ "Гвозди", 0.5, 0,0,0, "useSpikes()", false, false }, -- 61
	{ "Гильзы дробь", 0.001, 0,0,0, "useShell()", false, false }, -- 62
	{ "Гильзы .50", 0.001, 0, 0, 0, "useShell()", false, false}, -- 63
	{ "Гильзы 10 мм", 0.001, 0, 0, 0, "useShell()", false, false }, -- 64
	{ "Гильзы .32", 0.001, 0, 0, 0, "useShell()", false, false }, -- 65
	{ "Гильзы .308", 0.001, 0, 0, 0, "useShell()", false, false }, -- 66
	{ "Гильзы 12.7", 0.003, 0, 0, 0, "useShell()", false, false }, -- 67
	{ 'Свинец', 0.001, 0,0,0, "useLead()", false, false }, -- 68
	{ 'Набор \'Для патронов\'', 2, 0, 0, 0, "usePowderPack()", false, false }, -- 69
	{ 'Порох', 0.001, 0, 0, 0, 'usePowder()', false, false }, -- 70
	{ 'Капсюль', 0.0001, 0, 0, 0, 'usePrimer()', false, false }, -- 71
	{ 'Ткани', 2, 0, 0, 0, "useTissue()", false, false }, -- 72
	{ 'Нитки и иголка', 0.1, 0, 0, 0, "useStrings()", false, false }, -- 73
	{ 'Мистер Рукоблуд-1000П', 7, 0, 0, 0, "useCraftMachine()", false, true }, -- 74
	{ 'Спусковой механизм', 1.5, 0, 0, 0, "useWeaponPart()", false, true }, -- 75
	{ 'Прицел', 1, 0, 0, 0, "useWeaponPart()", false, true }, -- 76
	{ 'Деревянный приклад', 0.7, 0, 0, 0, "useWeaponPart()", false, true }, -- 77
	{ 'Средний ствол', 0.5, 0, 0, 0, "useWeaponPart()", false, true }, -- 78
	{ 'Ствол (шотган)', 0.5, 0, 0, 0, "useWeaponPart()", false, true }, -- 79
	{ 'Зарядник (винтовка)', 0.3, 0, 0, 0, "useWeaponPart()", false, true }, -- 80
	{ 'Ствол (винтовка)', 0.4, 0, 0, 0, "useWeaponPart()", false, true }, -- 81
	{ 'Зарядник (кит. винтовка)', 0.5, 0, 0, 0, "useWeaponPart()", false, true }, -- 82
	{ 'Магазин (кит. винтовка)', 0.3, 0, 0, 0, "useWeaponPart()", false, true }, -- 83
	{ 'Ствол (кит. винтовка)', 0.3, 0, 0, 0, "useWeaponPart()", false, true }, -- 84
	{ 'Ствол (ам. винтовка)', 0.2, 0, 0, 0, "useWeaponPart()", false, true }, -- 85
	{ 'Магазин (ам. винтовка)', 0.1, 0, 0, 0, "useWeaponPart()", false, true }, -- 86
	{ 'Зарядник (ам. винтовка)', 0.1, 0, 0, 0, "useWeaponPart()", false, true }, -- 87
	{ 'Стелс-бой', 1, 0, 0, 0, "useStealthBoy()", false, true }, -- 88
	{ 'Сломанные очки', 0.1, 0, 0, 0, "useDestroyedGlass()", false, false }, -- 89
	{ 'Новые очки', 0.1, 0, 0, 0, "useNewGlass()", false, false }, -- 90
	{ 'Стеклышки', 0.05, 0, 0, 0, "useGlassPart()", false, false }, -- 91
	{ 'Оправа очков', 0.05, 0, 0, 0, "useGlassBody()", false, false }, -- 92
	{ 'Зарядник минигана', 3, 0, 0, 0, "useWeaponPart()", false, true }, -- 93
	{ 'Миниган', 10, 0, 0, 0, "equipMinigun()", false, true }, -- 94
	{ 'Скотч', 0.5, 0, 0, 0, "useJunk()", false, false }, -- 95
	{ 'Броня солдата', 5, 0, 0, 0, "wearSoldArmor()", false, true }, -- 96
	{ 'Броня Тесла', 20, 0, 0, 0, "wearTeslaArmor()", false, true }, -- 97
	{ 'Рэйнджер', 10, 0, 0, 0, "wearRangerArmor()", false, true }, -- 98
	{ 'T51-B', 20, 0, 0, 0, "wearEnclaveArmor()", false, true }, -- 99
	{ "Средняя сумка", 6, 255, 255, 255, "useMedBag()", false, false}, -- 100
	{ "Большая сумка", 7, 255, 255, 255, "useBigBag()", false, false }, -- 101
	{ "Журнал \"Диванный Патритот\" (стр.23)", 0.1, 255, 255, 255, "readPatriot23()", false, false }, -- 102
	{ "Журнал \"Диванный Патритот\" (стр.12)", 0.1, 255, 255, 255, "readPatriot12()", false, false }, -- 103
	{ "Журнал \"Диванный Патритот\" (стр.8)", 0.1, 255, 255, 255, "readPatriot8()", false, false }, -- 104
	{ "Журнал \"Диванный Патритот\" (стр.4)", 0.1, 255, 255, 255, "readPatriot4()", false, false }, -- 105
	{ "Журнал \"Диванный Патритот\" (стр.25)", 0.1, 255, 255, 255, "readPatriot25()", false, false }, -- 106
	{ "Письмо неизвестного", 0, 255, 255, 255, "readSamaraLetter()", false, false }, -- 107
	{ "Письмо Аргаила", 0, 255, 255, 255, "readArgailLetter()", false, false }, -- 108
	{ "Кислородный накопитель", 0.5, 255, 255, 255, "useUnderWaterOxygen()", false, false }, -- 109
	{ "Синяя эссенция", 0.1, 255, 255, 255, "useRedEssence()", false, false }, -- 110
	{ "Топливо", 5, 255, 255, 255, "equipFlameAmmo()", false, false }, -- 111
	{ "Пустой бак", 3, 255, 255, 255, "useEmptyFuel()", false, false }, -- 112
	{ 'T52-C', 0, 0, 0, 0, "wearT52Armor()", false, true }, -- 113
	{ 'Броня рейдера', 5, 0, 0, 0, "wearRaiderArmor()", false, true }, -- 114
	{ 'Броня Изгоев', 5, 0, 0, 0, "wearFereroArmor()", false, true }, -- 115
	{ 'Броня МВ', 5, 0, 0, 0, "wearMvArmor()", false, true }, -- 116
	{ 'Лазерный пистолет', 5, 0, 0, 0, "equipLASER()", false, true }, -- 117
	{ 'Батарея', 0.5, 0, 0, 0, "equipAmmoLASER()", false, false }, -- 118
	{ 'Пустая батарея', 0.5, 0, 0, 0, "useWeaponPart()", false, false }, -- 119
	{ 'Дрова', 5, 0, 0, 0, "makeFire()", false, false }, -- 120
	{ 'Записка', 0, 0, 0, 0, "useKlamatLetter()", false, false }, -- 121
	{ 'Непонятный предмет', 0, 0, 0, 0, "useUnknownThing()", false, false }, -- 122
	{ 'Ремонтный набор', 2, 0, 0, 0, "useRepairKit()", false, false }, -- 123
	{ 'Мистер Хранитель-П', 2, 0, 0, 0, "placeSafe()", false, false }, -- 124
	{ "Журнал \"Диванный Патритот\" (стр.32)", 0.1, 255, 255, 255, "readPatriot32()", false, false }, -- 125
	{ "Заколка", 0.2, 255, 255, 255, "useBobbyPin()", false, false }, -- 126
	{ "Броня Сталкера", 15, 255, 255, 255, "wearStulkerArmor()", false, false }, -- 127
	{ "Рука мутанта", 5, 255, 255, 255, "checkMutantHand()", false, false }, -- 128
}

currArmorInvID = 0

inventory = {}

function useRepairKit ()
	if getElementData ( localPlayer, "repair_ready" ) then
		exports.pipboy:addInfoBox("Вы уже используете набор оружейника", 2)
	else
		exports.pipboy:addInfoBox("Выберите предмет для починки и нажмите на него")
		setElementData ( localPlayer, "repair_ready", true )
	end
end

function repairItem (slot_id, amount)
	if slot_id and amount and slot_id > 0 and inventory[slot_id] and inventory[slot_id][3] then
		if inventory[slot_id][3]+amount > 100 then
			inventory[slot_id][3] = 100
		else
			inventory[slot_id][3] = inventory[slot_id][3]+amount
		end
		exports.pipboy:addInfoBox ( "Состояние\""..things[inventory[slot_id][1]][1].."\" теперь составляет "..inventory[slot_id][3],3)
	end
end

function useUnderWaterOxygen ()
	if isElementInWater ( localPlayer ) then
		if getPedOxygenLevel ( localPlayer ) > 700 then
			exports.pipboy:addInfoBox ( 'Ваш уровень кислорода итак слишком высок', 2 )
		else
			setPedOxygenLevel ( localPlayer, 1000 )
		end
	else
		exports.pipboy:addInfoBox ( 'Эти накопители работают только под водой', 3 )
	end
end

function readArgailLetter ()
	--outputChatBox ( getElementData ( localPlayer, 'quest_her' ) )
	if getElementData ( localPlayer, 'quest_her' ) == 1 then
		local text = "Даа... А ведь я не писал ничего с тех пор, как началась вся эта катавасия с бомбами. Но сегодня я взял в руки карандаш и бумагу, чтоб рассказать тебе, путник, что со мной произошло. Ровно семь дней назад я встретил ее в Союзе Ученых, зайдя в черный проход у магазина. Семь дней... Говорят, бог потратил на сотворение земли семь дней. Сегодня седьмой день, с момента нашей встречи, и сегодня мы встретимся вновь. Я прочел за эту неделю столько книг, сколько не прочел за всю свою жизнь до этого. Я прочел легенды про вампиров, про приведения, по оживших мертвецов, поэтому я полностью готов к нашей встречи: серебрянные пули, святая вода, осиновый кол, и немного виски. Я надеюсь победить ее сегодня. \n\n-Гуль Аргаил"
		exports.pipboy:closePipBoy ()
		exports.pipboy:showTextField ( 'argail_letter', text, 1.3 )
		if getElementData ( localPlayer, "quest_ring" ) == 0 then
			exports.pipboy:addInfoBox("Получено задание \"Неделя\"", 2 )
			setElementData ( localPlayer, 'quest_ring', 1 )
		end
		setElementData ( localPlayer, 'quest_her', 2 )
	end
end

function readSamaraLetter ()
	local text = "Ты далеко не первый, кто туда зашел. Но ты первый, с кем я решил связаться, ты первый, кто может победить ее. Встретимся в Новом Вегасе. Я буду в черном плаще в баре Мегатонна."
	exports.pipboy:closePipBoy ()
	exports.pipboy:showTextField ( 'unknown_letter', text, 1.3 )
	if getElementData ( localPlayer, "quest_ring" ) <= 2 then
		setElementData ( localPlayer, 'quest_ring', 3 )
	end
end


function useKlamatLetter ()
	local text = "Спасибо за крутой самогонный аппарат, Боб! Хочешь вернуть - приезжай к нам в Роадтаун, поговорим."
	exports.pipboy:closePipBoy ()
	exports.pipboy:showTextField ( 'letter_klamat', text, 1.3 )
	if getElementData ( localPlayer, "quest_whiskey" ) <= 2 then
		setElementData ( localPlayer, 'quest_whiskey', 3 )
	end
end

function readPatriot23 ()
	local text = "              Диванный патритот\n\nНам пишет Дженни Боб из Вашингтона: \"Здравствуйте, Сэм Чарльз! Меня очень беспокоит вся эта ситуация с коммунистами, расскажите пожалуйста, как собрать миниган в домашних условиях?\"\n\nЗдравствуйте, Дженни. Да, ситуация с красной заразой сейчас серьезная, вот, что вам понадобится:\n - 6 винтовок\n - 1 зарядник минигана\n - 1  лента скотча\n - 1 пачка гвоздей. Собрать зарядник минигана очень просто! Для эт...\n\n                                    Стр.23"
	exports.pipboy:closePipBoy ()
	exports.pipboy:showTextField ( 'patriot23', text, 1.5 )
	setElementData ( localPlayer, "inventoryAllowed", 1 )
	exports.pipboy:addCraftRecipe ( 19, 102 )
end

function readPatriot32 ()
	local text = "              Диванный патритот\n\nКак часто с вами случалсь такая беда, что находясь в дороге, у вас вдруг ломался радио приемник, во время проигрывания вашей любимой песни? Со мной так было часто, и я ничего с этим не мог поделать. До недавних пор. Ведь совсем недавно, комания РобКо выпустила революционный предмет! \"Мистер Рукоблуд-1000П\". Нажмите на нем всего одну синюю кнопку, и перед вам откроется привычный интерфейс Мистера Рукоблуда-1000 (c) РобКо. Вы успеете починить свой приемник еще до окончания той песни!! \"Мистер Рукоблуд-1000П\" легок, мал, и стоит всего...\n\n                                    Стр.32"
	exports.pipboy:closePipBoy ()
	exports.pipboy:showTextField ( 'patriot32', text, 1.5 )
	setElementData ( localPlayer, "inventoryAllowed", 1 )
	setElementData ( localPlayer, "use_mrhandy", 1 )
	-- exports.pipboy:addCraftRecipe ( 19, 102 )
end

function readPatriot12 ()
	local text = "              Диванный патритот\n\nочень важная вещь, ведь патроны нужны всегда. На самом деле, если у вас есть гильза нужного калибра, то заправить ее не представляет труда. Для этого надо: \n\n - 1 капсюль\n - 1 пакетик пороха\n - 1 свинцовый шарик. \n\nА чтобы сделать взрывающийся патрон, вам надо...\n\n                                    Стр.12"
	exports.pipboy:showTextField ( 'patriot12', text, 1.7 )
	exports.pipboy:closePipBoy ()
	setElementData ( localPlayer, "inventoryAllowed", 1 )
end

function readPatriot8 ()
	local text = "              Диванный патритот\n\nПоэтому, вам стоит знать, как сделать из зараженной радиацией водой обычную, пригодную для питья воду. Для этого вам надо купить \"Антирад таблетки\" от компании \"РобКо\" в ближайшем супермаркете (всего за 9.99$ за таблетку!) и поместить их на 5 минут в бутылку с зараженной водой. Эффект будет просто потрясающим!\n\n                                    Стр.8"
	exports.pipboy:showTextField ( 'patriot8', text, 1.7 )
	exports.pipboy:closePipBoy ()
	setElementData ( localPlayer, "inventoryAllowed", 1 )
end

function readPatriot4 ()
	local text = "              Диванный патритот\n\nНу, а закончим разбор строения винтовок, нашей \"Американской винтовки\". Конечно, для нее нужен 1 спусковой механизм, 1 приклад (подойдет даже деревянный), ствол, магазин и зарядник. Строение - проще простого, собрал в гараже - и на Аляску, убивать красную заразу!\n\n                                    Стр.4"
	exports.pipboy:showTextField ( 'patriot4', text, 1.7 )
	exports.pipboy:closePipBoy ()
	setElementData ( localPlayer, "inventoryAllowed", 1 )
end

function readPatriot25 ()
	local text = "              Диванный патритот\n\nОбычная броня солдата, которая защитит вас от не слишком сильного урона (порядка 5%) и позволит быстрее восстановить силы, собирается достаточно просто. Но, об этом мы напишем в следующем номере, а пока только ингредиенты:\n - 6 тканей\n - 2 нитки с иголками\n - 90 свинца\nНу, чтож, до скорого! И пусть бог хранит Америку!\n\n                                    Стр.25"
	exports.pipboy:showTextField ( 'patriot25', text, 1.7 )
	exports.pipboy:closePipBoy ()
	exports.pipboy:addCraftRecipe ( 20, 106 )
	setElementData ( localPlayer, "inventoryAllowed", 1 )
end

local localPlayer = getLocalPlayer()
local visibled = 0

-- function showInventoryWindow ()
	-- if visibled == 0 then

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),
    function ( startedRes )
		bindKey("i", "down", createInventoryWindow)
		if getElementData ( localPlayer, "online" ) == 1 then
			local temp_inv = getElementData ( localPlayer, "temp_inv" )
			if temp_inv then
				inventory = temp_inv
				setElementData ( localPlayer, "temp_inv", nil )
			else
				triggerServerEvent ( 'askInventoryFromServer', localPlayer )
			end
		end
    end
)	
	
function createInventoryWindow ()
	if getElementData ( localPlayer, "online" ) == 1 and inventory then
		exports.pipboy:createPipBoyInv ()
	end
end

-- Полезные функции

function closeInventoryWindow ()
	exports.pipboy:closePipBoy ()
end

function getPlayerItemByID ( id )
	for i = 1, #inventory do 
		if inventory[i][1] == id and inventory[i][2] > 0 then
			return i
		end
	end
	return false
end

function getItemsTable ()
	return inventory
end

function getItemAmount ( id )
	
	--if things[id][8] then
		local quant = 0
		for i = 1, #inventory do 
			if inventory[i][1] == id then
				quant = quant+inventory[i][2]
			end
		end
		return quant
	-- else
		-- for i = 1, #inventory do 
			-- if inventory[i][1] == id then
				-- return inventory[i][2]
			-- end
		-- end
	-- end
	--return false
end

function getItemAmountOld ( id )
	local items = getItemsLargeNull()
	for i = 1, #items do 
		if items[i][1] == id then
			return items[i][2]
		end
	end
	return false
end

function getItemIDFromPosition ( pos )
	if inventory[pos] then
		return inventory[pos][1]
	end
	return false
end


function getItemAmountByID ( id )
	if inventory[id] then
		return inventory[id][2]
	end
	return false
end


-- function getItemAmount ( id )
	-- return inventory[id][2] or 0
-- end

function getPlayerItemAmount ( id )
	return getItemAmount ( id )
end

setElementData ( localPlayer, 'fireAllowed', true )

function getPlayerItemPosFromNull (item_pos, item_id)
	local off = 0
	for i,v in ipairs ( inventory ) do
		if v[2] <= 0 then
			off = 0+1
		end
		if i == item_pos then
			if item_id == v[1] then
				return item_id-off
			else
				return false
			end
		end
	end
	return false
end

function getItemsLargeNull ()
	local tableItems = {}
	for i = 1, #inventory do 
		if inventory[i][2]> 0 then
			--- ид предмета, количество, название, вес, состояние, ид в инвентаре
			table.insert ( tableItems, { inventory[i][1], inventory[i][2], things[inventory[i][1]][1], things[inventory[i][1]][2], inventory[i][3], i } )
		end
	end
	return tableItems
end

function setPlayerRandItem ()
	local itemsTable = getItemsLargeNull ()
	if itemsTable then
		setElementData ( localPlayer, 'randomItem', itemsTable[math.random ( 1, #itemsTable )][1] )
	end
end

addEvent( "setPlayerRandItemS", true )
addEventHandler( "setPlayerRandItemS", getRootElement(), setPlayerRandItem )

local firstLaunch = true

function updateInventoryFromServerC ( invTable )
	inventory = invTable
	if firstLaunch then
		firstLaunch = false
		moretthanzero = false
		for i, item in ipairs ( inventory ) do
			if things[item[1]][8] then
				if item[2] > 1 then
					for i = 1, item[2]-1 do
						table.insert(inventory,{item[1], 1, math.random(0,100)})
					end
					inventory[i][3] = math.random(0,100)
					moretthanzero = true
					inventory[i][2] = 1
				end
				if #item < 3 then
					inventory[i][3] = math.random(0,100)
					moretthanzero = true
				end
			end
		end
		if moretthanzero then
			triggerServerEvent ( "updatePlayerInventory", localPlayer, inventory )
		end
	end
end

addEvent( "updateInventoryFromServer", true )
addEventHandler( "updateInventoryFromServer", getRootElement(), updateInventoryFromServerC )

function invOldWayLoadedC ( )
	inventory = {}
	for i = 1, 20 do
		if getElementData ( localPlayer, 'item'..tostring(i)..'_t' ) ~= 0 and getElementData ( localPlayer, 'item'..tostring(i)..'_q' ) > 0 then
			table.insert ( inventory, { getElementData ( localPlayer, 'item'..tostring(i)..'_t' ), getElementData ( localPlayer, 'item'..tostring(i)..'_q' ) } )
		end
	end
	triggerServerEvent ( "updatePlayerInventory", localPlayer, inventory )
end

addEvent( "invOldWayLoaded", true )
addEventHandler( "invOldWayLoaded", getRootElement(), invOldWayLoadedC )


--
function givePlayerItem ( id, quant, effects,qty )
	if id and quant then
		if getElementData ( localPlayer, "invWeight" )+things[id][2] <= getElementData ( localPlayer, "maxWeight" ) or effects then
			if not things[id][8] then
				if getPlayerItemByID ( id ) then
					local present = getPlayerItemByID ( id )
					local alreadyQuant = inventory[present][2]
					if currAmmo > 0  then
						if currAmmoInvID == id then
							if currAmmoAmount == 0 and not getElementData ( localPlayer, "safezone.id" ) then
								toggleControl ( "fire", true )
							end
							currAmmoAmount = currAmmoAmount+quant
							setElementData ( localPlayer, "currAmmoAmount", currAmmoAmount )
							triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, currAmmo, currAmmoAmount, false )
						end
					end
					inventory[present][2] = alreadyQuant + quant
				else
					table.insert ( inventory, { id, quant} )
				end
			else
				for i = 1, quant do
					table.insert ( inventory, { id, 1, qty or math.random(0,100)} )
				end
			end
			triggerServerEvent ( "updatePlayerInventory", localPlayer, inventory )
			if not effects then
				exports.pipboy:addInfoBox("Вы положили в инвентарь "..tostring(quant).." "..things[id][1],2)
				playSound ( "sound/ui_items_generic_up_0"..tostring(math.random(1,4))..".wav" )
				checkPlayerWeight ()
			end
			return true
		else
			exports.pipboy:addInfoBox ("Вы не можете взять больше предметов из-за перегруза",3 )
			return false
		end
	end
end

addEvent( "givePlayerItemS", true )
addEventHandler( "givePlayerItemS", getRootElement(), givePlayerItem )

function givePlayerItemWW ( id, quant, effects,qty )
	if id and quant then
		if not things[id][8] then
			if getPlayerItemByID ( id ) then
				local present = getPlayerItemByID ( id )
				local alreadyQuant = inventory[present][2]
				if currAmmo > 0  then
					if currAmmoInvID == id then
						if currAmmoAmount == 0 and not getElementData ( localPlayer, "safezone.id" ) then
							toggleControl ( "fire", true )
						end
						currAmmoAmount = currAmmoAmount+quant
						setElementData ( localPlayer, "currAmmoAmount", currAmmoAmount )
						triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, currAmmo, currAmmoAmount, false )
					end
				end
				inventory[present][2] = alreadyQuant + quant
			else
				table.insert ( inventory, { id, quant,qty or math.random(0,100)} )
			end
		else
			for i = 1, quant do
				table.insert ( inventory, { id, 1, qty or math.random(0,100)} )
			end
		end
			triggerServerEvent ( "updatePlayerInventory", localPlayer, inventory )
			if not effects then
				exports.pipboy:addInfoBox("Вы положили в инвентарь "..tostring(quant).." "..things[id][1],2)
				playSound ( "sound/ui_items_generic_up_0"..tostring(math.random(1,4))..".wav" )
				checkPlayerWeight ()
			end
		end
end

addEvent( "givePlayerItemWW", true )
addEventHandler( "givePlayerItemWW", getRootElement(), givePlayerItemWW )

function removePlayerItem ( id, quant )
	if things[id][8] and quant > 1 then
		for i = 1, quant do
			local slotID = getPlayerItemByID ( id )
			if slotID and inventory[slotID][2] > 0 then
				local ammo = false
				if id == currAmmoInvID then
					ammo = true
				end
				if id == currArmorInvID then
					armor = true
				end
				inventory[slotID][2] = 0
				if ammo then
					triggerServerEvent ( "takePlayerCustomWeaponC", localPlayer )
					currAmmoAmount = 0
					currAmmoInvSlot = 0
					setElementData ( localPlayer, "currAmmoAmount", 0 )
					toggleControl ( "fire", false )
				elseif armor then
					triggerServerEvent ( "useArmor", localPlayer, 0 )
					currArmorInvID = 0
				elseif id == 14 then
					triggerServerEvent ( "useAntiRadWear", localPlayer, 0 )
				end
			else
				break
			end
		end
		checkPlayerWeight ()
		return true
	else
		local slotID = getPlayerItemByID ( id )
		if slotID then
			local wasQuant = inventory[slotID][2]
			if wasQuant > 0 then
				local ammo = false
				if id == currAmmoInvID then
					ammo = true
				end
				if id == currArmorInvID then
					armor = true
				end
				if wasQuant > quant then						
					inventory[slotID][2] = wasQuant - quant
					if ammo then
						currAmmoAmount = currAmmoAmount-quant
						setElementData ( localPlayer, "currAmmoAmount", currAmmoAmount )
						triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, currAmmo, currAmmoAmount, false )
					end
				elseif wasQuant == quant then
					inventory[slotID][2] = 0
					if ammo then
						triggerServerEvent ( "takePlayerCustomWeaponC", localPlayer )
						currAmmoAmount = 0
						currAmmoInvSlot = 0
						setElementData ( localPlayer, "currAmmoAmount", 0 )
						toggleControl ( "fire", true )
					elseif armor then
						removeArmorBuffs ()
						triggerServerEvent ( "useArmor", localPlayer, 0 )
						currArmorInvID = 0
					elseif id == 14 then
						triggerServerEvent ( "useAntiRadWear", localPlayer, 0 )
					end
				else
					inventory[slotID][2] = 0
					if ammo then
						triggerServerEvent ( "takePlayerCustomWeaponC", localPlayer )
						currAmmoAmount = 0
						currAmmoInvSlot = 0
						setElementData ( localPlayer, "currAmmoAmount", 0 )
						toggleControl ( "fire", true )
					elseif armor then
						triggerServerEvent ( "useArmor", localPlayer, 0 )
						currArmorInvID = 0
					elseif id == 14 then
						triggerServerEvent ( "useAntiRadWear", localPlayer, 0 )
					end
				end
				triggerServerEvent ( "updatePlayerInventory", localPlayer, inventory )
				return true
			end
			checkPlayerWeight ()
		end
	end
	return false
end

addEvent( "removePlayerItemS", true )
addEventHandler( "removePlayerItemS", getRootElement(), removePlayerItem )

function removePlayerItemByPos ( pos, quant )
	--outputDebugString ('inventory '..tostring(inventory[pos]))
	if inventory[pos] then
		local wasQuant = inventory[pos][2]
		local id = inventory[pos][1]
		--outputDebugString ('pos already '..tostring(id).." "..tostring(wasQuant))
		if wasQuant > 0 then
			local ammo = false
			if id == currAmmoInvID then
				ammo = true
			end
			if pos == currArmorInvID then
				armor = true
			end
			if wasQuant > quant then						
				inventory[pos][2] = wasQuant - quant
				if ammo then
					currAmmoAmount = currAmmoAmount-quant
					setElementData ( localPlayer, "currAmmoAmount", currAmmoAmount )
					triggerServerEvent ( "givePlayerCustomAmmoC", localPlayer, currAmmo, currAmmoAmount, false )
				end
			else
				inventory[pos][2] = 0
				if ammo then
					triggerServerEvent ( "takePlayerCustomWeaponC", localPlayer )
					currAmmoAmount = 0
					currAmmoInvSlot = 0
					currAmmoInvID = 0
					setElementData ( localPlayer, "currAmmoAmount", 0 )
					toggleControl ( "fire", true )
				elseif armor then
					removeArmorBuffs ()
					triggerServerEvent ( "useArmor", localPlayer, 0 )
					currArmorInvID = 0
					currArmorInvSlot = 0
				elseif id == 14 then
					triggerServerEvent ( "useAntiRadWear", localPlayer, 0 )
				end
			end
			triggerServerEvent ( "updatePlayerInventory", localPlayer, inventory )
			return true
		end
		checkPlayerWeight ()
	end
	return false
end

addEvent( "removePlayerItemByPosS", true )
addEventHandler( "removePlayerItemByPosS", getRootElement(), removePlayerItemByPos )

function checkPlayerWeight ()
	if not getElementData ( localPlayer, 'tempbreath' ) then
		setElementData ( localPlayer, 'tempbreath', 0 )
	end
	if not getElementData ( localPlayer, 'breath' ) then
		setElementData ( localPlayer, 'breath', 0 )
	end
	local lastWeight = getElementData ( localPlayer, "overWeight" )
	local totalWeight = 0
	for i = 1, #inventory do 
		if inventory[i][2] > 0 then
			local quant = inventory[i][2]
			local id = inventory[i][1]
			local plus = 0
			if id > 0 then
				plus = things[id][2]*quant
			end
			totalWeight = totalWeight+plus
		end
	end
	setElementData ( localPlayer, "invWeight", totalWeight )
	triggerServerEvent ( "calculateInvWeightC", localPlayer, totalWeight )
	local startVal = 2*(getElementData ( localPlayer, "rplvl" )-1)
	if getElementData ( localPlayer, "perk15" ) then startVal=startVal+20 end
	if getElementData ( localPlayer, "perk24" ) then startVal=startVal+20 end
	if getElementData ( localPlayer, "perk25" ) then startVal=startVal+20 end
	if getElementData ( localPlayer, "useArmor" ) == 5 then startVal=startVal+50 end
	if getElementData ( localPlayer, "useArmor" ) == 8 then startVal=startVal+40 end
	if getElementData ( localPlayer, "vip" ) then startVal=startVal+startVal/100*20 end
	if getElementData ( localPlayer, "eat" ) >= 80 then startVal=startVal-startVal/100*10 end 
	setElementData ( localPlayer, "maxWeight", 15+startVal+getElementData ( localPlayer, 'breath' )*5+getElementData ( localPlayer, 'tempbreath' )*5 )
	if totalWeight > 15+startVal+getElementData ( localPlayer, 'breath' )*5+getElementData ( localPlayer, 'tempbreath' )*5 then 
		setElementData ( localPlayer, "overWeight", true )
		if not lastWeight then
			exports.pipboy:addInfoBox("Вы перегружены и будете получать на 50% больше урона",4)
		end
		toggleControl ( "sprint", false )
		toggleControl ( "jump", false )
		return true
	end
	toggleControl ( "sprint", true )
	toggleControl ( "jump", true )
	setElementData ( localPlayer, "overWeight", false )
end

curr_inv_slot = 0

function useItem (id,invslot)
	if invslot then
		curr_inv_slot = invslot
	end
	assert(loadstring(things[id][6]))()
end


animAvail = true

function playEatAnimation ( num )
	if animAvail then
		triggerServerEvent ( "eatAnimation", localPlayer, num )
		animAvail = false
		setTimer ( function () animAvail = true end, 3000, 1 )
	end
end

function checkNotInArmor ()
	if getElementData ( localPlayer, "useArmor" ) > 0 or getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ( 'Вы размазали все по шлему, наверно стоит снять броню для начала', 3 )
		return false
	else
		return true
	end
end

-- Использование предметов

function useAidInventory () -- аптечка
	local hp_to_give = 120
	if getElementData ( localPlayer, "perk30") then
		hp_to_give = hp_to_give+hp_to_give/4
	end
	exports.players:givePlayerNewHealth ( hp_to_give )
	exports.sweetyRP:sendActionMessageClient(2)
	exports.players:givePlayerEatClient ( 5 )
end

function eatSmallRat ()
	if checkNotInArmor () then
		exports.players:givePlayerNewHealth ( 20 )
		exports.sweetyRP:sendActionMessageClient(1)
		exports.pipboy:addInfoBox("Вы получили 10 пунктов радиации",3)
		setElementData ( localPlayer, "rad", getElementData ( localPlayer, "rad" ) + 10 )
		exports.players:givePlayerRadClient ( 10 )
		exports.players:takePlayerEatClient ( 10 )
		playEatAnimation ( 1 )
	end
end

function eatMedRat ()
	if checkNotInArmor () then
		exports.sweetyRP:sendActionMessageClient(1)
		exports.players:givePlayerNewHealth ( 30 )
		exports.pipboy:addInfoBox("Вы получили 20 пунктов радиации",3)
		setElementData ( localPlayer, "rad", getElementData ( localPlayer, "rad" ) + 20 )
		exports.players:givePlayerRadClient ( 20 )
		exports.players:takePlayerEatClient ( 15 )
		playEatAnimation ( 1 )	
	end
end

function eatBigRat ()
	if checkNotInArmor () then
		exports.players:givePlayerNewHealth ( 40 )
		exports.sweetyRP:sendActionMessageClient(1)
		exports.pipboy:addInfoBox("Вы получили 30 пунктов радиации",3)
		setElementData ( localPlayer, "rad", getElementData ( localPlayer, "rad" ) + 30 )
		exports.players:givePlayerRadClient ( 30 )
		exports.players:takePlayerEatClient ( 25 )
		playEatAnimation ( 1 )
	end
end

function drinkCleanWater ()
	if checkNotInArmor () then
		exports.players:givePlayerNewHealth ( 40 )
		exports.sweetyRP:sendActionMessageClient(3)
		exports.pipboy:addInfoBox("Вы вывели из организма 20 пунктов радиации",3)
		exports.players:takePlayerRadClient ( 20 )
		exports.players:takePlayerEatClient ( 1 )
		playEatAnimation ( 2 )
	end
end

function usePsycho ()
	exports.sweetyRP:sendActionMessageClient(5)
	exports.players:givePlayerEatClient ( 10 )
	exports.players:givePlayerAV ( 10 )
	--exports.seizure:startSEIZURE()
end

function useAntiRad ()
	exports.players:takePlayerRadClient ( 0 )
	exports.sweetyRP:sendActionMessageClient(5)
	exports.players:givePlayerEatClient ( 10 )
	if getElementData ( localPlayer, "perk11" ) then
		local health = getElementData ( localPlayer, 'health' )
		local half = math.floor ( health/2 )
		exports.players:givePlayerNewHealth ( half )
		if health+half >= getElementData ( localPlayer, 'maxHealth' ) then
			exports.pipboy:addInfoBox("Вы вывели из организма радиацию и восстановили здоровье", 4 )
		else
			exports.pipboy:addInfoBox("Вы вывели из организма радиацию и восстановили "..half.." единиц здоровья", 3 )
		end
	else
		exports.pipboy:addInfoBox("Вы вывели из организма всю радиацию", 3 )
	end
end

function usePropSU ()
	exports.pipboy:addInfoBox ("С помощью этого пропуска, вы можете проникнуть в Союз Ученых", 3 )
end

function usePropNV ()
	exports.pipboy:addInfoBox ("С помощью этого пропуска, вы можете проникнуть в Новый Вегас", 3 )
end

function eatZombHand ()
	if checkNotInArmor () then
		exports.players:givePlayerNewHealth ( 50 )
		exports.sweetyRP:sendActionMessageClient(4)
		exports.pipboy:addInfoBox("Вы получаете 30 пунктов радиации", 3 )
		setElementData ( localPlayer, "rad", getElementData ( localPlayer, "rad" ) + 30 )
		exports.players:givePlayerRadClient ( 30 )
		exports.players:takePlayerEatClient ( 30 )
		playEatAnimation ( 1 )
	end
end

function drinkBeer ()
	if checkNotInArmor () then
		exports.players:givePlayerNewHealth ( 10 )
		exports.sweetyRP:sendActionMessageClient(7)
		exports.pipboy:addInfoBox("Вы вывели из организма 10 пунктов радиации", 3 )
		exports.players:takePlayerRadClient ( 10 )
		exports.players:takePlayerEatClient ( 5 )
		playEatAnimation ( 2 )
	end
end

function drinkVodka ()
	if checkNotInArmor () then
		exports.players:givePlayerNewHealth ( 20 )
		exports.sweetyRP:sendActionMessageClient(8)
		exports.pipboy:addInfoBox("Вы вывели из организма 20 пунктов радиации", 3 )
		exports.players:takePlayerRadClient ( 20 )
		exports.players:takePlayerEatClient ( 2 )
		playEatAnimation ( 2 )
	end
end

function drinkSamogon ()
	if checkNotInArmor () then
		exports.players:givePlayerNewHealth ( 20 )
		exports.sweetyRP:sendActionMessageClient(9)
		exports.pipboy:addInfoBox("Вы вывели из организма 20 пунктов радиации", 3 )
		exports.players:takePlayerRadClient ( 20 )
		exports.players:takePlayerEatClient ( 7 )
		playEatAnimation ( 2 )
	end
end

function wearAntiRad ()
	local antiRadWear = getElementData ( localPlayer, "antiRadWear" )
	if getElementData ( localPlayer, "useArmor" ) > 0 then 
		exports.pipboy:addInfoBox ('Сначала снимите броню', 2)
		return true
	end
	if antiRadWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		triggerServerEvent ( "useAntiRadWear", localPlayer, 1 )
		setElementData ( localPlayer, "antiRadWear", 1 )
	elseif antiRadWear == 1 then
		triggerServerEvent ( "useAntiRadWear", localPlayer, 2 )
		setElementData ( localPlayer, "antiRadWear", 0 )
	end
end

function wearSoldArmor ()
	local armorWear = getElementData ( localPlayer, "useArmor" ) or 0
	if getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ('Сначала снимите Антирад костюм', 2)
		return true
	end
	if armorWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		triggerServerEvent ( "useArmor", localPlayer, 1 )
		setElementData ( localPlayer, "useArmor", 1 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		currArmorInvID = 96
		currArmorInvPos = curr_inv_slot
		giveArmorBuffs()
	else
		removeArmorBuffs()
		triggerServerEvent ( "useArmor", localPlayer, 0 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		setElementData ( localPlayer, "useArmor", 0 )
	end
end


armorBuffs = {
	{ strenght = 0, breath = 2, accuracy = 0, dt = 10 }, -- броня солдата
	{ strenght = 2, breath = 1, accuracy = 1, dt = 30 }, -- тесла
	{ strenght = 0, breath = 0, accuracy = 2, dt = 20 }, -- рэйнджер
	{ strenght = 1, breath = 0, accuracy = 1, dt = 25 }, -- T-51B
	{ strenght = 3, breath = 4, accuracy = 3, dt = 25 }, -- T-52
	{ strenght = 1, breath = 3, accuracy = 0, dt = 4 }, -- броня рейдера
	{ strenght = 2, breath = 0, accuracy = 2, dt = 5 }, -- броня фереро
	{ strenght = 3, breath = 2, accuracy = 3, dt = 6 }, -- броня MB (mr.freeman)
	{ strenght = 2, breath = 1, accuracy = 1, dt = 30 }, -- сталкер


	
}

function giveArmorBuffs ()
	local useArmor = getElementData ( localPlayer, "useArmor" )
	for name, num in pairs ( armorBuffs[useArmor] ) do
		if num > 0 then
			setElementData ( localPlayer, "temp"..name, ( getElementData ( localPlayer, "temp"..name ) or 0 ) + num )
		end
	end
	exports.players:calculatePlayerHP ()
	exports.players:calculatePlayerAP ()
	exports.players:calculatePlayerDamage ()
	checkPlayerWeight()
end

function calculatePlayerDT ()
	
end

function removeArmorBuffs ()
	local useArmor = getElementData ( localPlayer, "useArmor" )
	setElementData ( localPlayer, "armorSlotID", 0)
	for name, num in pairs ( armorBuffs[useArmor] ) do
		--outputChatBox ( name )
		if num > 0 then
			setElementData ( localPlayer, "temp"..name, ( getElementData ( localPlayer, "temp"..name ) or num ) - num )
		end
	end
	exports.players:calculatePlayerHP ()
	exports.players:calculatePlayerAP ()
	exports.players:calculatePlayerDamage ()
	checkPlayerWeight()
	exports.pipboy:addInfoBox ( "Вы сняли броню" )
end

function wearFereroArmor ()
	local armorWear = getElementData ( localPlayer, "useArmor" ) or 0
	if getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ('Сначала снимите Антирад костюм', 2)
		return true
	end
	if armorWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		setElementData ( localPlayer, "armorSlotID", curr_inv_slot)
		triggerServerEvent ( "useArmor", localPlayer, 7 )
		setElementData ( localPlayer, "useArmor", 7 )
		setElementData ( localPlayer, "antiRadWear", 2 )
		giveArmorBuffs()
		setElementData ( localPlayer, "armorSlotID", curr_inv_slot)
		currArmorInvID = 115
		currArmorInvPos = curr_inv_slot
	else
		removeArmorBuffs()
		triggerServerEvent ( "useArmor", localPlayer, 0 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		setElementData ( localPlayer, "useArmor", 0 )
	end
end

function wearMvArmor ()
	local armorWear = getElementData ( localPlayer, "useArmor" ) or 0
	if getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ('Сначала снимите Антирад костюм', 2)
		return true
	end
	if armorWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		setElementData ( localPlayer, "armorSlotID", curr_inv_slot)
		triggerServerEvent ( "useArmor", localPlayer, 8 )
		setElementData ( localPlayer, "useArmor", 8 )
		setElementData ( localPlayer, "antiRadWear", 2 )
		giveArmorBuffs()
		currArmorInvID = 116
		currArmorInvPos = curr_inv_slot
	else
		removeArmorBuffs()
		triggerServerEvent ( "useArmor", localPlayer, 0 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		setElementData ( localPlayer, "useArmor", 0 )
	end
end


function wearTeslaArmor ()
	local armorWear = getElementData ( localPlayer, "useArmor" ) or 0
	if getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ('Сначала снимите Антирад костюм', 2)
		return true
	end
	if armorWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		setElementData ( localPlayer, "armorSlotID", curr_inv_slot)
		triggerServerEvent ( "useArmor", localPlayer, 2 )
		setElementData ( localPlayer, "useArmor", 2 )
		setElementData ( localPlayer, "antiRadWear", 2 )
		giveArmorBuffs()
		currArmorInvID = 97
		currArmorInvPos = curr_inv_slot
	else
		removeArmorBuffs()
		triggerServerEvent ( "useArmor", localPlayer, 0 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		setElementData ( localPlayer, "useArmor", 0 )
	end
end


function wearStulkerArmor ()
	local armorWear = getElementData ( localPlayer, "useArmor" ) or 0
	if getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ('Сначала снимите Антирад костюм', 2)
		return true
	end
	if armorWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		setElementData ( localPlayer, "armorSlotID", curr_inv_slot)
		triggerServerEvent ( "useArmor", localPlayer, 9 )
		setElementData ( localPlayer, "useArmor", 9 )
		setElementData ( localPlayer, "antiRadWear", 9 )
		giveArmorBuffs()
		currArmorInvID = 127
		currArmorInvPos = curr_inv_slot
	else
		removeArmorBuffs()
		triggerServerEvent ( "useArmor", localPlayer, 0 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		setElementData ( localPlayer, "useArmor", 0 )
	end
end

function wearRangerArmor ()
	local armorWear = getElementData ( localPlayer, "useArmor" ) or 0
	if getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ('Сначала снимите Антирад костюм', 2)
		return true
	end
	if armorWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		setElementData ( localPlayer, "armorSlotID", curr_inv_slot)
		triggerServerEvent ( "useArmor", localPlayer, 3 )
		setElementData ( localPlayer, "useArmor", 3 )
		setElementData ( localPlayer, "antiRadWear", 2 )
		giveArmorBuffs()
		currArmorInvID = 98
		currArmorInvPos = curr_inv_slot
	else
		removeArmorBuffs()
		triggerServerEvent ( "useArmor", localPlayer, 0 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		setElementData ( localPlayer, "useArmor", 0 )
	end
end

function wearEnclaveArmor ()
	local armorWear = getElementData ( localPlayer, "useArmor" ) or 0
	if getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ('Сначала снимите Антирад костюм', 2)
		return true
	end
	if armorWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		setElementData ( localPlayer, "armorSlotID", curr_inv_slot)
		triggerServerEvent ( "useArmor", localPlayer, 4 )
		setElementData ( localPlayer, "useArmor", 4 )
		setElementData ( localPlayer, "antiRadWear", 2 )
		giveArmorBuffs()
		currArmorInvID = 99
		currArmorInvSlot = curr_inv_slot
	else
		removeArmorBuffs()
		triggerServerEvent ( "useArmor", localPlayer, 0 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		setElementData ( localPlayer, "useArmor", 0 )
	end
end

function wearRaiderArmor ()
	local armorWear = getElementData ( localPlayer, "useArmor" ) or 0
	if getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ('Сначала снимите Антирад костюм', 2)
		return true
	end
	if armorWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		setElementData ( localPlayer, "armorSlotID", curr_inv_slot)
		triggerServerEvent ( "useArmor", localPlayer, 6 )
		setElementData ( localPlayer, "useArmor", 6 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		giveArmorBuffs()
		currArmorInvID = 114
		currArmorInvPos = curr_inv_slot
	else
		removeArmorBuffs()
		triggerServerEvent ( "useArmor", localPlayer, 0 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		setElementData ( localPlayer, "useArmor", 0 )
	end
end

function wearT52Armor ()
	local armorWear = getElementData ( localPlayer, "useArmor" ) or 0
	if getElementData ( localPlayer, "antiRadWear" ) == 1 then 
		exports.pipboy:addInfoBox ('Сначала снимите Антирад костюм', 2)
		return true
	end
	if armorWear == 0 then
		setElementData ( localPlayer, "modelid", getElementModel ( localPlayer ) )
		setElementData ( localPlayer, "armorSlotID", curr_inv_slot)
		triggerServerEvent ( "useArmor", localPlayer, 5 )
		setElementData ( localPlayer, "useArmor", 5 )
		setElementData ( localPlayer, "antiRadWear", 2 )
		currArmorInvID = 113
		currArmorInvPos = curr_inv_slot
		giveArmorBuffs()
	else
		removeArmorBuffs()
		triggerServerEvent ( "useArmor", localPlayer, 0 )
		setElementData ( localPlayer, "antiRadWear", 0 )
		setElementData ( localPlayer, "useArmor", 0 )
	end
end

function useHolyGraal ()
	exports.pipboy:addInfoBox ( 'Вы использовали святой грааль༼ つ ◕_◕ ༽つ༼ つ ◕_◕ ༽つ',4)
	setElementData ( localPlayer, 'health', getElementData ( localPlayer, 'maxHealth' ) )
	exports.players:givePlayerXPClient ( 1488 )
	exports.players:takePlayerRadClient ( 0 )
	exports.players:takePlayerEatClient ( 0 )
end

function useDarkGraal ()
	local togive = math.random ( 1, 3)
	if togive == 1 then
		exports.pipboy:addInfoBox ( "༼ つ ◕_◕ ༽つ ЗДОРОВЬЕ ВЗАМЕН ДУШИ ༼ つ ◕_◕ ༽つ",6)
		setElementData ( localPlayer, 'health', 666 )
	elseif togive == 2 then
		exports.pipboy:addInfoBox ( "༼ つ ◕_◕ ༽つ БАБЛО ВЗАМЕН ДУШИ ༼ つ ◕_◕ ༽つ",6)
		triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 666 )
	else
		exports.pipboy:addInfoBox ( "༼ つ ◕_◕ ༽つ ЗНАНИЯ ВЗАМЕН ДУШИ ༼ つ ◕_◕ ༽つ",6)
		exports.players:givePlayerXPClient ( 666 )
	end
	exports.players:takePlayerRadClient ( 0 )
	exports.players:takePlayerEatClient ( 0 )
end 

function eatSpinach ()
	if checkNotInArmor () then
		exports.sweetyRP:sendActionMessageClient(10)
		exports.pipboy:addInfoBox("Вы вывели из организма всю радиацию", 3 )
		exports.players:takePlayerRadClient ( 0 )
		playEatAnimation ( 1 )
	end
end

function eatTushonka()
	if checkNotInArmor () then
		exports.players:takePlayerEatClient ( 0 )
		exports.sweetyRP:sendActionMessageClient(11)
		exports.pipboy:addInfoBox("Вы полностью насытились", 3 )
		playEatAnimation ( 1 )
	end
end

function eatKonserv()
	if checkNotInArmor () then
		exports.players:takePlayerEatClient ( 20 )
		exports.sweetyRP:sendActionMessageClient(12)
		exports.pipboy:addInfoBox("Ваш голод убавился", 3 )
		playEatAnimation ( 1 )
	end
end

function eatNuts()
	if checkNotInArmor () then
		exports.players:takePlayerEatClient ( 5 )
		exports.sweetyRP:sendActionMessageClient(13)
		exports.pipboy:addInfoBox("Ваш голод убавился", 3 )
		playEatAnimation ( 1 )
	end
end

function useMadreCoins ()
	if getElementData ( localPlayer, "quest_coins" ) == 0 then
		exports.pipboy:addInfoBox ("Какие-то странные монеты, не думаю, что они кому-то нужны.", 3 )
	else
		exports.pipboy:addInfoBox ("Морган Фриман заплатит по 20$ за каждую такую монету.", 3 )
	end
	exports.sweetyRP:sendActionMessageClient(14)
end

function useNukeWater ()
	exports.players:givePlayerNewHealth ( 30 )
	exports.sweetyRP:sendActionMessageClient(3)
	sendActionMessage ( 'выпивает воду' )
	if getElementData ( localPlayer, "perk1" ) then
		exports.pipboy:addInfoBox("Хорошо, что у вас свинцовое брюхо!", 4 )
	else
		exports.players:takePlayerEatClient ( 1 )
		exports.players:givePlayerRadClient ( 20 )
		exports.pipboy:addInfoBox("Вы получили 20 пунктов радиации", 3 )
	end
	playEatAnimation ( 2 )
end

function useBag ()
	exports.loot:createBagPlaceClient (1)
	exports.pipboy:closePipBoy ()
	setElementData ( localPlayer, "inventoryAllowed", 1 )
end

function useMedBag ()
	exports.loot:createBagPlaceClient (2)
	exports.pipboy:closePipBoy ()
	setElementData ( localPlayer, "inventoryAllowed", 1 )
end

function useBigBag ()
	exports.loot:createBagPlaceClient (3)
	exports.pipboy:closePipBoy ()
	setElementData ( localPlayer, "inventoryAllowed", 1 )
end

function eatFungus ()
	if checkNotInArmor () then
		setElementData ( localPlayer, "fungus", true )
		setTimer ( function () setElementData ( localPlayer, "fungus", false ) end, 5000, 1 )
		if getElementData ( localPlayer, "perk1" ) then
			exports.pipboy:addInfoBox("Хорошо, что у вас свинцовое брюхо!", 2 )
		else
			exports.players:givePlayerRadClient ( 5 )
			exports.pipboy:addInfoBox("Вы получили 5 пунктов радиации", 2 )
		end
		playEatAnimation ( 1 )
	end
end

function drinkSunset()
	if checkNotInArmor () then
		exports.players:takePlayerEatClient ( 2 )
		givePlayerItem ( 51, 1 )
		exports.players:givePlayerNewHealth ( 15 )
		sendActionMessage ( 'выпивает бутылку Сансет Саспариллы' )
		playEatAnimation ( 2 )
	end
end

function useCap ()
	exports.pipboy:addInfoBox ("Разменная валюта у некоторых торговцев", 3 )
end

function useLighter ()
	exports.pipboy:addInfoBox ("Просто зажигалка", 2 )
end

function usePin ()
	exports.pipboy:addInfoBox ("Заколка, ею можно открыть закрытую дверь", 2 )
end

function useDoctorBag ()
	local stimChance = math.random ( 1, 3 )
	if stimChance == 1 then
		givePlayerItem ( 1, math.random ( 1, 3 ) )
	end
	local stimChance = math.random ( 1, 2 )
	if stimChance == 1 then
		givePlayerItem ( 5, math.random ( 1, 2 ) )
	end
	local aradChance = math.random ( 1, 3 )
	if aradChance == 1 then
		givePlayerItem ( 7, math.random ( 1, 3 ) )
	end
	local morphChance = math.random ( 1, 2 )
	if morphChance == 1 then
		givePlayerItem ( 56, math.random ( 1, 3 ) )
	end
	givePlayerItem ( 23, 1 )
end

function useJunk ()
	exports.pipboy:addInfoBox ("Возможно, в нем есть что-то полезное", 2 )
end

function useMorph ()
	exports.pipboy:addInfoBox ("Просто пустой шприц", 1 )
end

function drinkCola ()
	if checkNotInArmor () then
		setElementData ( localPlayer, "fungus", true )
		setTimer ( function () setElementData ( localPlayer, "fungus", false ) end, 3000, 1 )
		exports.players:takePlayerEatClient ( 2 )
		givePlayerItem ( 51, 1 )
		sendActionMessage ( 'выпивает бутылку Ядер-Колы' )
		if getElementData ( localPlayer, "perk1" ) then
			exports.pipboy:addInfoBox("Хорошо, что у вас свинцовое брюхо!", 2 )
		else
			exports.players:givePlayerRadClient ( 8 )
			exports.pipboy:addInfoBox("Вы получили 8 пунктов радиации", 2 )
		end
		playEatAnimation ( 2 )
	end
end

function useTablets()
	exports.pipboy:addInfoBox ("Можно использовать для обеззораживания еды", 2 )
end

function eatApple ()
	if checkNotInArmor () then
		exports.players:takePlayerEatClient ( 7 )
		exports.players:givePlayerNewHealth ( 5 )
		sendActionMessage ( 'ест свежее яблоко' )
		playEatAnimation ( 1 )
	end
end

function useContainer ()
	exports.pipboy:addInfoBox ("Можно использовать при сдаче анализов", 1 )
end

function useSpikes ()
	exports.pipboy:addInfoBox ("Довоенные, ржавые гвозди", 1 )
end

function useShell ()
	exports.pipboy:addInfoBox ("Их можно собрать обратно в патроны", 1 )
end

function useLead ()
	exports.pipboy:addInfoBox ("Их можно собрать обратно в патроны", 1 )
end

function usePowderPack ()
	exports.pipboy:addInfoBox ("Вы разобрали этот набор", 1 )
	givePlayerItem ( 70, 30 )
	givePlayerItem ( 71, 30 )
end

function useStrings ()
	exports.pipboy:addInfoBox ("Их можно использовать при шитье", 1 )
end

function useTissue ()
	exports.pipboy:addInfoBox ("Можно использовать при крафте", 1 )
end

function makeFire ()
	if getPlayerItemAmount ( 52 ) > 0 and getPlayerItemAmount ( 120 ) > 0 then
		removePlayerItem ( 120, 1 )
		closeInventoryWindow()
		triggerServerEvent("playerPitchFire",localPlayer, getRainLevel() > 0 )
	else
		exports.pipboy:addInfoBox ("Вам нечего с этим делать", 1 )
	end
end

function givePlayerFireBenefits ()
	exports.players:givePlayerAV(4)
	exports.players:givePlayerNewHealth(getElementData ( localPlayer,"maxHealth")*0.07)
end

addEvent( "givePlayerFireBenefits", true )
addEventHandler( "givePlayerFireBenefits", getRootElement(), givePlayerFireBenefits )

function useBobbyPin ()
	exports.pipboy:addInfoBox ("Поможет вам взломать замок", 1 )
end


function useUnknownThing ()
	exports.pipboy:addInfoBox ("Непонятный предмет, ты даже не знаешь как его использовать", 3 )
end

function checkMutantHand ()
	exports.pipboy:addInfoBox ("Похоже, она уже начала разлагаться. Лучше избавиться от нее поскорее.", 3 )
end

function useStealthBoy ()
	--if getElementData ( localPlayer, 'inStealth' ) then
	--	setElementData ( localPlayer, 'inStealth', false )
	--	triggerServerEvent ( 'removePlayerFromStealth', localPlayer )
	--	setElementAlpha ( localPlayer, 255 )
	--else
	--	setElementData ( localPlayer, 'inStealth', true )
	--	triggerServerEvent ( 'putPlayerInStealth', localPlayer )
	--	setElementAlpha ( localPlayer, 50 )
	--end
end

function useCraftMachine ()
	if getElementData ( localPlayer, "use_mrhandy" ) == 1 then
		exports.pipboy:initCraft()
	else
		exports.pipboy:addInfoBox ("Непонятный механизм. На нем надпись: \"Создавайте предметы в любой момент!\"", 3 )
	end
end

function placeSafe ()
	if not exports.safezones:getPlayerZoneConfig(localPlayer).noSafes then
		exports.pipboy:closePipBoy ()
		setElementData (localPlayer,"inventoryAllowed",0) 
		exports.safes:askPasswordWindowC(1,"Установка вашего нового сейфа!")
	else
		exports.pipboy:addInfoBox ( 'Вы не можете сделать это здесь', 2 )
	end
end