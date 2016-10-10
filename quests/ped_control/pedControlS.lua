

function explodeVehicleDeath ( )
	if not isPedDead ( source ) then
		local x,y,z = getElementPosition ( source )
		createExplosion ( x, y, z, 8 )
	end
end

addEvent( "explodeVehicleDeath", true )
addEventHandler( "explodeVehicleDeath", getRootElement(), explodeVehicleDeath )


function pedUnLookS ( )
	--outputChatBox ( string.gsub ( "timer_ped_/", "/", getElementData ( myped, "name") ) )
	setElementData ( getElementData ( source, "ped_dialog" ), "dialog", getElementData ( getElementData ( source, "ped_dialog" ), "dialog" ) - 1 )
end

addEvent( "pedUnLookC", true )
addEventHandler( "pedUnLookC", getRootElement(), pedUnLookS )

function pedLookAndStopS ( myped )
	setElementData ( myped, "dialog", getElementData ( myped, "dialog" ) + 1 )
	setPedAnimation ( myped )
end

addEvent( "pedLookAndStop", true )
addEventHandler( "pedLookAndStop", getRootElement(), pedLookAndStopS )

function pedSightCalculatedS ( answer, ped )
    if answer == 1 then
		 setPedAnimation(ped, "ped", "WALK_civi", -1, 1, 1, 0)
	else
		setPedAnimation ( ped )
		local rotation = math.random( 0, 360 )
		setElementRotation ( ped, 0,0, rotation )
	end
end
addEvent( "pedSightCalculated", true )
addEventHandler( "pedSightCalculated", getRootElement(), pedSightCalculatedS )

function aorderTank ( source )
	nv_insane = createPed ( 11, -255.11328125,2756.5771484375,62.6875 )
	setTimer ( calculatePeds, 2000, 0, nv_insane )
	setElementData ( nv_insane, "dialog", 0 )
	--setPedControlState ( myped, "walk", true )
	--setPedControlState ( myped, "forwards", true )
	--setTimer ( pedControlStop, 3000, 1 )
end

--addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), aorderTank )
 
function sendPedsToPlayersS ( )
--	triggerClientEvent ( source, "sendPedsToPlayers", source, nv_insane )
end
addEventHandler ( "onPlayerJoin", getRootElement(), sendPedsToPlayersS )

function calculatePeds ( myped )
	if getElementData ( myped, "dialog" ) == 0 then
		if getElementSyncer ( myped ) and getElementType(getElementSyncer ( myped )) == "player" then
			triggerClientEvent ( getElementSyncer ( myped ), "calculatePedSight", getElementSyncer ( myped ), myped )
			return true
		end
	end
end

function getPositionInfrontOfElement(element, meters)
    if not element or not isElement(element) then
        return false
    end
    if not meters then
        meters = 3
    end
    local posX, posY, posZ = getElementPosition(element)
    local _, _, rotation = getElementRotation(element)
    posX = posX - math.sin(math.rad(rotation)) * meters
    posY = posY + math.cos(math.rad(rotation)) * meters
    return posX, posY, posZ
end

npcPeds={}
actColShapes={}
playSUsoldAnim = 0

function playSoldAnimSU()
	if playSUsoldAnim == 0 then
		setPedAnimation ( npcPeds.su0, "SWAT", "swt_sty", 1, false, false, false, true )
		playSUsoldAnim = 1
		setTimer ( function () playSUsoldAnim = 0 end, 10000, 1 )
	end
end

deadPeds = {
	{ x = 212.80859375, y = 1855.51953125, z = 13.016319274902, model = 287 },
}

function createDeadPeds ()
	for i = 1, #deadPeds do
		local createdPed = createPed ( deadPeds[i].model, deadPeds[i].x, deadPeds[i].y, deadPeds[i].z )
		killPed ( createdPed )
	end
end

createDeadPeds ()

npcCfg = { -- скин, x, y, z, поворот, имя, оружие, переменная, интерьер, анимация блок, анимация блок, анимация название, синхронизация, здание
	{ 133,-590.6376953125,2017.2724609375,60.381847381592, 16.559387207031, "Ополченец", 25, "sc1", 0, nil, nil, false, true },
	{ 159,-653.6083984375,2068.6318359375,60.186485290527,152.52276611328, "Ополченец", 33, "sc2", 0, nil, nil, false, true },
	{ 158,-676.681640625,2049.6474609375,60.3828125,311.70062255859, "Ополченец", 25, "sc3", 0, nil, nil, false, true },
	{ 132,-752.6416015625,2044.125,60.3828125,350.16983032227, "Ополченец", 33, "sc4", 0, nil, nil, false, true },
	{ 133,-876.7109375,1950.5009765625,60.119209289551,77.248809814453, "Ополченец", 33, "sc5", 0, nil, nil, false, true },
	{ 285,-366.470703125,1407.6494140625,59.031494140625,244, "Капитан Членс", 0, "su0", 0, nil, nil, true, true },
	{ 285,-265.259765625,1535.7763671875,75.5625,15.021301269531, "Солдат", 31, "su1", 0, nil, nil, false, true },
	{ 285,-363.591796875,1404.12890625,58.766437530518,290.45272827148, "Солдат", 31, "su2", 0, nil, nil, false, true },
	{ 285,247.6962890625,1797.5517578125,7.4140625,351.40032958984, "Солдат", 31, "su3", 0, nil, nil, false, true },
	{ 285,-326.736328125,1536.7802734375,75.5625,260.3662109375, "Солдат", 31, "su4", 0, nil, nil, false, true },
	{ 285,256.6767578125,1850.0576171875,8.7578125,353.74044799805, "Солдат", 31, "su5", 0, nil, nil, false, true },
	{ 285,-349.2197265625,1402.376953125,58.511966705322,100.49621582031, "Солдат", 31, "su5", 0, nil, nil, false, true },
	{ 133,-322.8994140625,2672.416015625,62.72730255127,266.79330444336, "Бандит", 30, "nv1", 0, nil, nil, false, true },
	{ 34,-254.8955078125,2601.2978515625,62.858154296875,274.25863647461, "Бандит", 29, "nv2", 0, nil, nil, false, true },
	{ 159,-176.44140625,2656.7109375,62.967678070068,43.300537109375, "Бандит", 29, "nv3", 0, nil, nil, false, true },
	{ 158,-227.15234375,2709.890625,62.984329223633,135.35089111328, "Бандит", 30, "nv4", 0, nil, nil, false, true },
	{ 132,-210.267578125,2713.0693359375,62.979370117188,186.89402770996, "Бандит", 29, "nv5", 0, nil, nil, false, true },
	{ 118,-223.4775390625,2643.9013671875,62.96418762207,170.28796386719, "Бандит", 29, "nv6", 0, nil, nil, false, true },
	{ 117,-249.0634765625,2799.771484375,62.194034576416,242.17808532715, "Бандит",  30, "nv7", 0, nil, nil, false, true },
	{ 120,-288.9287109375,2690.0185546875,62.8125,5.0345764160156, "Бандит", 30, "nv8", 0, nil, nil, false, true },
	{ 112,-301.4482421875,2620.0673828125,63.523143768311,310.1789855957, "Бандит", 27, "nv9", 0, nil, nil, false, true },
	{ 112,-953.544921875,1871.1142578125,5, 230, "Охранник банка", 30, "nv10", 17, nil, nil, false, true },
	{ 288,-1532.0859375,2601.240234375,55.692333221436, 260, "Луис Суарес", 0, "suarez", 0, "COP_AMBIENT", "Coplook_loop", true, true },
	{ 181,494.5654296875,-77.5634765625,998.7578125,260, "Бармен", 0, "bar", 11, "CLOTHES", "CLO_Pose_Loop", true, true },
	{ 33,511.966947,-76.3755636,998.7578125,87.603576660156, "Странник", 0, "stranger", 11, "BD_FIRE", "M_smklean_loop", true, true },
	{ 132,504.57421875,-69.763671875,998.7578125,93.701080322266, "Вышибала", 0, "kicker", 11, "COP_AMBIENT", "Coplook_loop", false, true },
	{ 239,-637.73046875,2067.8916015625,60.3828125, 177, "Большой Билл", 0, "bigbill", 0, nil, nil, false, true },
	{ 82,-795.4423828125,2025.6337890625,60.390625, 0, "Стэн Марш", 0, "stanmarsh", 0, "DEALER", "DEALER_IDLE", false, true },
	{ 11, -954.361328125,1913.330078125,5, 90, "Кэти Перри", 0, "katy", 17, nil, nil, false, 3, true },
	{ 128, -943.900390625,1947.31640625,5, 180, "Джон Початок", 0, "johnpocha", 17, nil, nil, false, 3, true },
	--{ 128, -943.900390625,1947.31640625,5, 180, "John Maize", 0, "johnpocha", 17, nil, nil, false, 3, true },
	{ 11,-650.4912109375,1774.0537109375,12069.620117188, 84, "Эми Макдональд", 0, "amy", 1, "ped", "woman_idlestance", false, true },
	{ 71, -1526.802734375,2592.462890625,55.8359375, 0, "Медик", 0, "medic", 0, nil, nil, false, true },
	{ 30, 244.6357421875,1877.6357421875,8.7578125, 180, "Бандит", 0, "bandit", 0, nil, nil, false, true }, 
	{ 33, -756.6962890625,2748.484375,45.7734375 , 0, "Продавец", 0, "motel", 0, nil, nil, false, true },
	{ 248, -162.6318359375,2671.7265625,62.683616638184,27.924926757812, "Караванщик", 27, "car1", 0, nil, nil, false, true }, -- Новый Вегас
	{ 32, -173.48046875,2681.0947265625,62.683616638184,269.34219360352, "Караванщик", 30, "car2", 0, nil, nil, false, true },
	{ 68, -160.9365234375,2673.4130859375,62.683616638184,11.80224609375, "Джонни Кэш", 0, "cash", 0, nil, nil, false, true },
	{ 66, -160.4453125,2681.5654296875,62.585910797119,123.83154296875, "Караванщик", 30, "car3", 0, nil, nil, false, true },
	{ 248, -825.8232421875,2039.2919921875,60.186485290527,111.92218017578, "Караванщик", 27, "car4", 0, nil, nil, false, true }, -- Новая деревня
	{ 71, -832.2724609375,2033.9462890625,60.1875,159.07073974609, "Караванщик", 27, "car5", 0, nil, nil, false, true },
	--{ 43, -830.587890625,2042.517578125,60.3828125,213.42091369629, "Боб Дилан", 0, "dylan", 0, "DEALER", "DEALER_IDLE", false, true },
	{ 43, -830.587890625,2042.517578125,60.3828125,213.42091369629, "Боб Дилан", 0, "dylan", 0, "DEALER", "DEALER_IDLE", false, true },
	{ 128, -364.3330078125,1544.3740234375,75.5625,123.1174316406, "Караванщик", 31, "car6", 0, nil, nil, false, true }, -- Союз Ученых
	{ 103, -370.51953125,1546.17578125,75.5625,182.09294128418, "Караванщик", 27, "car7", 0, nil, nil, false, true },
	{ 82, -366.2333984375,1549.408203125,75.5625,172.98510742188, "Марти Роббинс", 0, "robbins", 0, nil, nil, false, true },
	{ 1, 239.8623046875,1848.599609375,8.7578125, 289.5, "Моряк Попай", 0, "popeye", 0, nil, nil, false, true },
	{ 282, 274.775390625,1866.7900390625,8.7578125,270.14419555664, "Гражданский Комендант", 0, "comrade", 0, nil, nil, false, true },
	{ 138, -295.2529296875,1546.88671875,75.359375,275.52209472656, "Катерина Минет", 31, "minet", 0, nil, nil, false, true }, 
	{ 20, -255.11328125,2756.5771484375,62.6875, 0, "Чудак", 0, "fool", 0, "RAPPING", "RAP_A_Loop", false, true }, 
	{ 133,2463.6962890625,2380.23828125,-39.3671875,151.71527099609, "Бандит", 30, "nv8", 0, nil, nil, false, true },
	{ 34,2475.8115234375,2373.8671875,-39.3671875,31.028594970703, "Бандит", 29, "nv9", 0, nil, nil, false, true },
	{ 159,2471.2114257813,2363.4265136719,-33.598827362061,270.20462036133, "Бандит", 29, "nv10", 0, nil, nil, false, true },
	{ 158,2470.3657226563,2363.6706542969,-27.793750762939,267.55139160156, "Бандит", 30, "nv11", 0, nil, nil, false, true },
	{ 132,2465.927734375,2360.4633789063,-21.9921875,5.1444396972656, "Бандит", 29, "nv12", 0, nil, nil, false, true },
	{ 118,2453.896484375,2365.1147460938,-21.9921875,260.34423828125, "Бандит", 29, "nv13", 0, nil, nil, false, true },
	{ 83,2445.2679142508478,2362.974400973368,-22.684859466553,261.4758605957, "Сэм Смит",  0, "nv_mayor", 0, "INT_OFFICE", "OFF_Sit_Idle_Loop", false, true },
	{ 33,548.71899414063,-2437.6540527344,1198.2409667969,82.467407226563, "011001000110111101100011",  0, "doc", 0, "COP_AMBIENT", "Coplook_loop", false, true },
	{ 117,1728.884765625,-1902.6923828125,66.6142578125,157.01623535156, "Наемник", 25, "car8", 2, nil, nil, false, true },
	{ 159,1691.578125,-1903.81640625,66.6279296875,240.35981750488, "Наемник", 33, "car9", 2, nil, nil, false, true },
	{ 132,1692.328125,-1929.626953125,68.096839904785,318.67153930664, "Наемник", 33, "car10", 2, nil, nil, false, true },
	{ 133,1716.4013671875,-1926.22265625,68.096092224121,65.498748779297, "Наемник", 33, "car11", 2, nil, nil, false, true },
	{ 34,1751.3974609375,-1916.296875,68.094192504883,83.088134765625, "Наемник", 29, "car12", 2, nil, nil, false, true },
	{ 44,1710.3759765625,-1929.7392578125,68.093521118164,359.14031982422, "Бобби Чарльтон", 0, "bobby", 2, nil, nil, false, true },
	{ 151,1738.9643554688,-1927.6259765625,68.0908203125,278.90045166016, "Толстушка Мэтси", 0, "matsy", 2, nil, nil, false, true },
	{ 156,1702.6494140625,-1930.78125,68.092758178711,57.687347412109, "Морган Фриман", 0, "freman", 2, nil, nil, false, true },
	{ 43,1080.53125,1226.3134765625,10.8203125,350.8235168457, "Наемник", 29, "car6", 0, nil, nil, false, true },
	{ 71,1062.4560546875,1296.181640625,10.8203125,289.0739440918, "Наемник", 29, "car13", 0, nil, nil, false, true },
	{ 248,1072.826171875,1357.3359375,10.8203125,96.469665527344, "Наемник", 25, "car14", 0, nil, nil, false, true },
	{ 128,1053.3271484375,1321.7431640625,10.8203125, 329.57015991211, "Наемник", 33, "car15", 0, nil, nil, false, true },
	{ 68,1692.328125,-1929.626953125,68.096839904785,318.67153930664, "Наемник", 31, "car16", 0, nil, nil, false, true },
	{ 32,1716.4013671875,-1926.22265625,68.096092224121,65.498748779297, "Наемник", 32, "car17", 0, nil, nil, false, true },
	{ 114,-2148.1652832031,-170.32695007324,42.979686737061, 242, "Коллекционер", 32, "col8", 0, nil, nil, false, true },
	{ 115,-2151.7060546875,-186.5712890625,41.129737854004,321.51705932617, "Коллекционер", 32, "col2", 0, nil, nil, false, true },
	{ 116,-2198.2958984375,-274.49688720703,51.378124237061,82.445434570313, "Коллекционер", 32, "col3", 0, nil, nil, false, true },
	{ 109,-2100.8530273438,-276.32284545898,51.378124237061,166.00872802734, "Коллекционер", 32, "col4", 0, nil, nil, false, true },
	{ 108,-2103.8344726563,-172.65449523926,51.378124237061,49.832000732422, "Коллекционер", 32, "col4", 0, nil, nil, false, true },
	{ 102,-2133.62109375,-83.5859375,35.3203125,294.52322387695, "Коллекционер", 32, "col4", 0, nil, nil, false, true },
	{ 105,-2167.287109375,-197.1142578125,35.3203125,237.86038208008, "Xzibit", 5, "xzibit", 0, "DEALER", "DEALER_IDLE", false, true },
	{ 43, -2134.671875,-167.7109375,35.3203125,311.71710205078, "Караванщик", 27, "car19", 0, nil, nil, false, true }, -- караванщик в вс
	{ 128, -2131.3759765625,-160.873046875,35.3203125,155.77478027344, "Караванщик", 31, "car20", 0, nil, nil, false, true }, -- караванщик в вс
	{ 248, -2134.3193359375,-164.07421875,35.3203125,277.80728149414, "Джимми Роджерс", 0, "rodgers", 0, nil, nil, false, true },
	{ 36,-2994.3876953125,463.2060546875,4.9140625,273.06658935547, "Ополченец", 25, "riv1", 0, nil, nil, false, true },
	{ 32,-3025.048828125,500.3369140625,9.5062503814697,269.28176879883, "Ополченец", 33, "riv2", 0, nil, nil, false, true },
	{ 44,-3013.888671875,469.994140625,9.5062503814697,243.27673339844, "Ополченец", 25, "riv3", 0, nil, nil, false, true },
	{ 43,-3006.3125,393.0625,9.5062503814697,85.834747314453, "Ополченец", 33, "riv4", 0, nil, nil, false, true },
	{ 58,-3030.3935546875,378.224609375,9.4546880722046,307.67407226563, "Ополченец", 33, "riv5", 0, nil, nil, false, true },
	{ 70,-3007.8017578125,403.5673828125,9.5062503814697,127.67681884766, "Доктор Престон", 0, "preston", 0, nil, nil, false, true },
	{ 57,-3007.6357421875,372.4921875,9.5062503814697,84.774536132813, "Брайан Уилкс", 0, "wilks", 0, nil, nil, false, true },
	{ 41,-3009.2255859375,378.66015625,9.5062503814697,64.839538574219, "Худышка Фетси", 0, "fatsy", 0, nil, nil, false, true },
	{ 312,-3032.322265625,391.1884765625,9.4546880722046,240.16204833984, "Снаряд", 0, "gun", 0, nil, nil, false, true },
	{ 131,-3017.0703125,511.384765625,9.5062503814697,193.95834350586, "Красотка Бонни", 0, "bonny", 0, nil, nil, false, true },
	
	{ 108,2269.927734375,1626.927734375,1084.2564697266,2.2989196777344, "Великий Хан", 31, "han1", 1, nil, nil, false, true },
	{ 109,2269.826171875,1668.578125,1084.2564697266,172.75439453125, "Великий Хан", 11, "han2", 1, nil, nil, false, true },
	{ 110,2271.0673828125,1654.3251953125,1084.234375,135.15310668945, "Великий Хан", 35, "han3", 1, nil, nil, false, true },
	{ 133,2268.60546875,1640.66015625,1084.234375,10.758544921875, "Великий Хан", 24, "han4", 1, nil, nil, false, true },
	{ 186,2271.1962890625,1646.921875,1084.234375,84.708618164063, "Бенни", 24, "benny", 1, nil, nil, false, true },
	
	{ 192, -3006.4287109375,450.896484375,9.5442724227905,45.547241210938, "Вера Уизерспун", 0, "vera", 0, nil, nil, false, true },
	{ 50, -3032.482421875,428.95703125,9.5517873764038,336.04119873047, "Механик", 0, "meh", 0, nil, nil, false, true },
	{ 209, -3015.2373046875,389.9853515625,16.589061737061,75.232757568359, "Горбов", 0, "gorb", 0, nil, nil, false, true },
	
	{ 303, -2022.44140625,-115.982421875,1035.171875,279.21905517578, "Караванщик", 0, "car21", 3, "SHOP", "SHP_Serve_Loop", false, true }, -- караванщик в рс
	{ 15, -2131.3759765625,-160.873046875,35.3203125,155.77478027344, "Караванщик", 31, "car22", 3, nil, nil, false, true }, -- караванщик в рс
	{ 67, -2916.8330078125,498.9775390625,4.9140625,225.33027648926, "Караванщик", 27, "car23", 0, nil, nil, false, true }, -- караванщик в рс
	{ 124, -2913.4794921875,485.94921875,4.9140625,299.90661621094, "Караванщик", 31, "car24", 0, nil, nil, false, true }, -- караванщик в рс
	{ 136, -2919.83203125,486.19140625,4.9065704345703,195.90295410156, "Караванщик", 27, "car25", 0, nil, nil, false, true }, -- караванщик в рс
	{ 290,-2033.4921875,-115.869140625,1035.171875,236.60792541504, "Карл Перкинс", 22, "perk", 3, "SMOKING", "M_Smk_loop", false, true },
	{ 161,-2026.052734375,-114.0712890625,1035.171875,141.03637695313, "Караванщик", 25, "car26", 3, nil, nil, false, true },
	
	{ 112,-2918.1999, 428.39, 4.9000, 266, "Охранник банка", 25, "bank2", 0, nil, nil, false, true }, -- охрана в Ривет СИти
	{ 184,-2918.1000, 426, 4.900, 268, "Охранник банка", 32, "bank3", 0, nil, nil, false, true }, -- охрана в Ривет СИти
	
	{ 121,2328.9033203125,8.1318359375,26.524442672729,182.27969360352, "Сайаг", 0, "syag", 0, nil, nil, false, true }, -- бармен в Кламате
	{ 184,-2918.1000, 426, 4.900, 268, "Охранник банка", 32, "bank3", 0, nil, nil, false, true }, -- охрана в Ривет СИти
	{ 125, 2343.7548828125,69.826171875,26.3359375,170.91967773438, "Гай Кларк", 0, "clurk", 0, nil, nil, false, true },
	{ 184, 2353.2451171875,75.6455078125,26.484375,137.08123779297, "Банкир", 22, "bankKL", 0, nil, nil, false, true },
	{ 71, 2353.2412109375,71.8193359375,26.484375,138.98193359375, "Охранник банка", 31, "bankKL1", 0, nil, nil, false, true },
	{ 111, 2348.3249511719,74.657424926758,26.658796310425,183.13664245605, "Охранник банка", 29, "bankKL2", 0, nil, nil, false, true },
	{ 103, 2346.064453125,70.517578125,26.336982727051,136.77362060547, "Караванщик", 25, "car27", 0, nil, nil, false, true },
	{ 161, 2338.12890625,69.3701171875,26.478719711304,210.98741149902, "Караванщик", 33, "car28", 0, nil, nil, false, true },
	{ 242, 2324.1572265625,63.4453125,26.4921875, 169.49694824219, "Бак Дантон", 5, "bdan", 0, nil, nil, false, true }, 
	{ 241, 2325.4453125,60.5927734375,26.484382629395,92.899047851563, "Чак Дантон", 0, "cdan", 0, nil, nil, false, true }, 
	{ 163, 1607.9484375,-1585.2573193359,2074.03125,3.5074157714844, "Пол Мидлтон", 0, "poul", 0, "INT_OFFICE", "OFF_Sit_Idle_Loop", false, true }, -- главный полицейский кламата
	{ 228, 1624.8935546875,-1583.7855224609,2074.03125,74.903167724609, "Джереми Кларксон", 0, "jer", 0, "DEALER", "DEALER_IDLE", false, true }, -- мэр кламата
	{ 130, 2933.46875,-1530.1552734375,1932.7952880859,265.79354858398, "Салли Уилсон", 0, "sally", 0, nil, nil, false, true }, -- Салли Уилсон
	{ 135, 2332.986328125,35.8779296875,26.675220489502,261.71755981445, "Джерико", 0, "jericho", 0, nil, nil, false, true }, -- Джерико
	{ 162, -961.4541015625,1946.7158203125,9,232.90547180176, "Продавец оружия", 0, "ncseller", 17, nil,nil,false, true }, -- НД прод ору
	{ 258, -653.8759765625,1758.2783203125,12035.9179687, 0, "Букер ДеВитт", 0, "buker", 1, nil, nil, false, true }, -- Букер ДеВитт
	{ 153, -675.8896484375,2075.4287109375,60.381847381592, 220, "Роберт Мэйфлауэр", 0, "robert", 0, nil, nil, false, true }, 
	{ 235, -287.13671875,2764.291015625,62.122226715088, 287.20623779297, "Герберт Дешвуд", 0, "herbert", 0, nil, nil, false, true }, 
	{ 22, 2218, -1552, 2.2, 161, "Нельсон Джефферсон", 32, "road1", 0, nil, nil, false, true }, 
	{ 22, 2196, -1553, 5.5, 242, "Брайан Гриффин", 28, "road2", 0, "ped", "WEAPON_CROUCH", false, false },  -- GUN_BUTT
	{ 23, 2202, -1569, 14.69, 252, "Бобби МакГи", 34, "road3", 0, "ped", "GUN_BUTT", false, false }, 
	{ 153, 2142, -1546.5, 2.42, 270, "Роберт Мэйфлауэр", 0, "robert2", 0, nil, nil, false, false }, 
	{ 125, 2178.5, -1536.29, 2.2, 174, "Зеленый Барт", 33, "willys1", 0, nil, nil, false, false },
	{ 100, 2177, -1538, 2.2, 350, "Кид", 31, "willys2", 0, nil, nil, false, false }, 
	{ 66, 2179, -1537, 2.2, 54, "Мо Саммерс", 28, "willys3", 0, nil, nil, false, false }, 
	{ 248, 2174, -1535, 2.2, 166, "Вилли", 0, "willy", 0, nil, nil, false, false }, 
	{ 193, 2173, -1552, 2.2, 128, "Вэнди Стотч", 0, "wendy", 0, nil, nil, false, false }, 
	{ 291, 2326, -1.1, 26.5, 278, "Виски-Боб", 0, "wbob", 0, nil, nil, false, false }, 
	{ 268, 1757.5, -3159, 2.29, 168, "Баттерс Стотч", 0, "batters", 0, nil, nil, false, false }, 
	{ 296, -232.47, 2710.15, 63, 184, "Распорядитель арены", 0, "zombiearena", 0, "COP_AMBIENT", "Coplook_loop", true, true }, 
	
	
	{ 11, -267.809, 1518.44, 75.56, 119, "Лиз Вотфорд", 0, "lizwatfard", 0, "ped", "cower", true, true }, 
	
	
}

pckCfg = { -- координаты, ид, интерьер
	{ -235.8759765625,2711.4921875,62.9765625, 1239, 0 }, -- арена
	{ -284.72265625,2655.4208984375,62.756195068359, 1239, 0 }, -- поездка
	{ -572.5166015625,2022.857421875,60.3828125, 1239, 0 },
	{ -168.669921875,2707.10546875,62.525890350342, 1239, 0 },
	{ -253.77354431152,1495.8074951172,76.01212310791, 1239, 0},
	{ 419.1611328125,2477.0849609375,16.492168426514, 1318, 0 },
	{ 1367.5576171875,248.2109375,19.566932678223, 1318, 0 },
}

cshpCfg = { -- координаты, деревня, тип (солдат - 1, жители - 2), ид в деревне
	{ -653.6083984375,2068.6318359375,60.186485290527, 1, 1, 1 },
	{ -676.681640625,2049.6474609375,60.3828125, 1, 1, 2 },
	{ -752.6416015625,2044.125,60.3828125, 1, 1, 3 },
	{ -876.7109375,1950.5009765625,60.119209289551, 1, 1, 4 },
	{ -590.6376953125,2017.2724609375,60.381847381592, 1, 1, 5 },
	{ -265.259765625,1535.7763671875,75.5625, 2, 1, 1 }, -- Начало СУ
	{ -363.591796875,1404.12890625,58.766437530518, 2, 1, 2 },
	{ 247.6962890625,1797.5517578125,7.4140625, 2, 1, 3 },
	{ -326.736328125,1536.7802734375,75.5625, 2, 1, 4 },
	{ 256.6767578125,1850.0576171875,8.7578125, 2, 1, 5 },
	{ -349.2197265625,1402.376953125,58.511966705322, 2, 1, 6 }, 
	{ -322.8994140625,2672.416015625,62.72730255127, 3, 1, 1 }, -- Начало НВ
	{ -176.44140625,2656.7109375,62.967678070068, 3, 1, 2 }, -- Мегатонна
	{ -254.8955078125,2601.2978515625,62.858154296875, 3, 1, 3 },
	{ -227.15234375,2709.890625,62.984329223633, 3, 1, 4 },
	{ -210.267578125,2713.0693359375,62.979370117188, 3, 1, 5 },
	{ -223.4775390625,2643.9013671875,62.96418762207, 3, 1, 6 },
	{ -249.0634765625,2799.771484375,62.194034576416, 3, 1, 7 },
	{ -301.4482421875,2620.0673828125,63.523143768311, 3, 1, 8 },
	{ -953.544921875,1871.1142578125,5, 1, 2, 1 }, -- охранник банка нд
	{ -1532.0859375,2601.240234375,55.692333221436, 1, 2, 2 }, -- Луис Суарес
	{ -637.73046875,2067.8916015625,60.3828125, 1, 2, 3 }, -- Большой Билл
	{ -795.4423828125,2025.6337890625,60.390625, 1, 2, 4 }, -- Стэн Марш
	{ -954.361328125,1913.330078125,5, 1, 2, 5 }, -- Кэти Пэрри
	{ -943.900390625,1947.31640625,5, 1, 2, 6 }, -- Джон Початок
	{ -652.2197265625,1773.9267578125,12069.620117188, 1, 2, 7 }, -- Эми Макдональд
	{ 494.525390625,-76.0400390625,998.7578125, 3, 2, 1 }, -- Бармен
	{ 511.966947,-76.3755636,998.7578125, 3, 2, 2 }, -- Странник
	{ 504.57421875,-69.763671875,998.7578125, 3, 2, 3 }, -- Вышибала
	{ -288.9287109375,2690.0185546875,62.8125, 3, 2, 4 }, -- Охранник Механика
	{ -366.2333984375,1549.408203125,75.5625, 2, 2, 1 }, -- Марти Роббинс су
 	{ -830.587890625,2042.517578125,60.3828125, 1, 2, 8 }, -- Боб Дилан НД
	{ -961.4541015625,1946.7158203125,9, 1, 2, 10 }, -- продавец оружия в Новой Деревне
	{ -160.9365234375,2673.4130859375,62.683616638184, 3, 2, 5 }, -- Джонни Кэш
	{ 239.8623046875,1848.599609375,8.757812, 2, 2, 2 }, -- Моряк Попай
	{ 274.775390625,1866.7900390625,8.7578125, 2, 2, 3 }, -- гражданский комендант
	{ -295.2529296875,1546.88671875,75.359375, 2, 2, 4 }, -- Катерина Минет
	{ -255.11328125,2756.5771484375,62.6875, 3, 2, 6 }, -- Чудак
	{ 2447.470703125,2362.9545898438,-21.984859466553, 3, 2, 7 },
	{ 548.71899414063,-2437.6540527344,1198.2409667969, 1, 2, 9 }, -- док в подлодке
	{ 1710.9228515625,-1928.2822265625,68.094589233398, 4, 2, 1 }, -- чарльтон
	{ 1740.3139648438,-1927.34375,68.096702575684, 4, 2, 2 }, -- мэтси
	{ 1702.6494140625,-1930.78125,68.092758178711, 4, 2, 3 }, -- фриман
	{ -2148.1652832031,-170.32695007324,42.979686737061, 5, 1, 1 }, -- коллекционеры
	{ -2151.7060546875,-186.5712890625,41.129737854004, 5, 1, 1 },
	{ -2198.2958984375,-274.49688720703,51.378124237061, 5, 1, 2 },
	{ -2100.8530273438,-276.32284545898,51.378124237061, 5, 1, 3 },
	{ -2103.8344726563,-172.65449523926,51.378124237061, 5, 1, 4 },
	{ -2133.62109375,-83.5859375,35.3203125, 5, 1, 5 },
	{ -2167.287109375,-197.1142578125,35.3203125, 5, 2, 1 }, -- xzibit
	{ -2134.3193359375,-164.07421875,35.3203125, 5, 2, 2 }, -- роджерс
	{ -3007.8017578125,403.5673828125,9.5062503814697, 6, 2, 1 }, -- престон
	{ -3007.6357421875,372.4921875,9.5062503814697, 6, 2, 2 }, -- вилкс, мэр ривет сити
	{ -3010.7509765625,379.12890625,9.5062503814697, 6, 2, 3 }, -- худышка фетси
	{ -3032.322265625,391.1884765625,9.4546880722046, 6, 2, 4 }, -- снаряд
	{ -3016.9765625,510.029296875,9.5062503814697, 6, 2, 5 }, -- крастока бонни
	{ 2271.1962890625,1646.921875,1084.234375, 6, 2, 6 }, -- бенни
	{ -3006.4287109375,450.896484375,9.5442724227905, 6, 2, 7 }, -- вера
	{ -3032.482421875,428.95703125,9.5517873764038, 6, 2, 8 }, -- механик
	{ -3015.2373046875,389.9853515625,16.589061737061, 6, 2, 9 }, -- горбов
	{ -2033.4921875,-115.869140625,1035.171875, 6, 2, 10 }, -- Карл Перкинс
	{ 2328.6923828125,6.7646484375,26.525939941406, 7, 2, 1 }, -- Сайаг
	-- 7 2 2 - боб райт
	{ 2343.7548828125,69.826171875,26.3359375,7,2,3 }, -- караванщик Гай Кларк
	{ 2324.1572265625,63.4453125,26.4921875, 7, 2, 4 }, -- Бак Дантон
	{ 2325.4453125,60.5927734375,26.484382629395, 7, 2, 5 }, -- Чак Дантон
	{ 1607.9484375,-1585.2573193359,2074.03125, 7, 2, 6 }, -- Пол Мидлтон
	{ 1624.8935546875,-1583.7855224609,2074.03125, 7, 2, 7 }, -- Кларксон
	-- 7 2 8 Генри Эдем
	-- 7 2 9 слушатель 1
	-- 7 2 10 слушатель 2
	-- 7 2 11 охранник
	{ 2934.732421875,-1529.8525390625,1932.7952880859, 7, 2, 12 }, -- Салли Уилсон
	{ 2332.986328125,35.8779296875,26.675220489502, 7, 2, 13 }, -- Джерико
	{ -653.8759765625,1758.2783203125,12035.9179687, 1, 2, 11 }, -- Букер ДеВитт
	{ -675.8896484375,2075.4287109375,60.381847381592, 1, 2, 12 }, -- Роберт Мэйфлауэр
	{ -287.13671875,2764.291015625,62.122226715088, 3, 2, 8 }, -- Херберт
	{ 2141, -1546, 2.4, 8, 2, 1 }, -- Роберт Мэйфлауэр Роадтаун
	{ 2178.5, -1536.29, 2.2, 8, 1, 1 }, -- Зеленый Барт
	{ 2177, -1538, 2.2, 8, 1, 2 }, -- Кид
	{ 2179, -1537, 2.2, 8, 1, 3 }, -- Мо Саммерс
	{ 2174, -1535, 2.2, 8, 2, 4 }, -- Вилли самый высокий ид в Роадтауне
	{ 2173, -1552, 2.2, 8, 2, 2 }, -- Вэнди Стотч
	{ 2326, -1.1, 26.5, 7, 2, 14 }, -- Виски-Боб
	{ 1757.5, -3159, 2.29, 8, 2, 3 }, -- Баттерс
	{ -1526.953125,2593.1484375,55.8359375,1,2,13}, -- медик, продает пропуск в су
	{ 244.8212890625,1876.6123046875,8.7578125,2,2,6}, -- бандит, продает пропуск в нв
	{ -232.47, 2710.15, 63, 3, 2, 9}, -- распорядитель арены 3
	
	{ -267.809, 1518.44, 75.56, 2, 2, 7}, -- Лиз Вотфорд
	
}

vehCfg = { -- модель, координаты, поворот, двигатель, фары
	{ 455, -158.92578125,2669.2333984375,63.400146484375, 0,0,23.340667724609, true, 2 }, -- корованщики грузовик нв
	{ 515, -161.16796875,2684.556640625,63.532386779785, 0,0,69.318664550781, true, 2 }, -- караванщики роадтрэйн нв
	{ 490, -175.25,2683.26171875,62.809059143066,0,0,177.18682861328, true, 2 }, -- кораван фбр
	{ 470, -367.8447265625,1414.265625,59.136840820313,0,0,283.12088012695, true, 2 }, -- су въезд
	{ 470, -351.8408203125,1409.7470703125,58.813632965088,0,0,197.93406677246, true, 2}, -- су въезд 2
	{ 605, -824.2919921875,2040.6611328125,60.004997253418,0,0,182.72526550293, true, 2 }, -- корованщики грузовик нд
	{ 499, -832.8994140625,2035.6806640625,60.180652618408,0,0,276.61538696289, true, 2 }, -- караванщики тачка нд
	{ 579, -369.4990234375,1548.9130859375,75.493644714355,0,0,151.9560546875, true, 2 }, -- корованщики грузовик су
	{ 508, -362.8994140625,1546.712890625,75.937507629395,0,0,195.03297424316, true, 2 }, -- караванщики тачка су
	{ 573, -2136.697265625,-165.6181640625,35.970684051514,0,0,167.8681640625, true, 2 }, -- караванщики в св дюна
	{ 525, -2133.8173828125,-158.2880859375,35.197380065918,0,0,261.49450683594, true, 2 }, -- караванщики в св тачка
	
	{ 504, -2914.3681640625,484.126953125,4.7062935829163,0,0,224.83515930176, true, 2 }, -- караванщики в рс
	{ 528, -2910.13671875,500.19140625,4.9564709663391,0,0,269.31869506836, true, 2 }, -- караванщики в рс
	{ 479, -2923.90625,506.3056640625,4.7079405784607,0,0,83.824188232422, false, 0 }, -- караванщики в рс
	{ 440, -2918.560546875,499.001953125,5.0305442810059,0,0,352.13186645508, true, 2 }, -- караванщики в рс
	
	{ 478, 2346.2060546875,72.892578125,26.315660476685,0,0,222.02197265625, false, 0 },
	{ 440, 2338.7041015625,72.439453125,26.500356674194,0,0,137.87228393555, false, 0 },
	
}

function loadServerPeds ()	
	for i = 1, #npcCfg do
		
		local createdText = exports.dtext:create3DText ( npcCfg[i][2], npcCfg[i][3], npcCfg[i][4]+1.2, npcCfg[i][6], 255, 255, 255, 255, "npc", npcCfg[i][9] )
		local createdPed = createPed ( npcCfg[i][1], npcCfg[i][2], npcCfg[i][3], npcCfg[i][4], npcCfg[i][5], npcCfg[i][12] )
		npcPeds[npcCfg[i][8]] = createdPed
		--table.insert ( actColShapes, createdColShape )
		setElementFrozen ( npcPeds[npcCfg[i][8]], true )
		setElementData ( npcPeds[npcCfg[i][8]], "npc-ped", true )
		setElementData ( npcPeds[npcCfg[i][8]], "npc-name", npcCfg[i][8] )
		setElementData ( npcPeds[npcCfg[i][8]], "npc-weap", npcCfg[i][7] )
		if npcCfg[i][13] and type (npcCfg[i][13]) == "number" then setElementData ( npcPeds[npcCfg[i][8]], "build", npcCfg[i][13] ) end
		setElementInterior ( npcPeds[npcCfg[i][8]], npcCfg[i][9] )
		setElementInterior ( createdText, npcCfg[i][9] )
		if npcCfg[i][7] ~= 0 then
			giveWeapon ( npcPeds[npcCfg[i][8]], npcCfg[i][7], 30, true )
		end
		if npcCfg[i][10] ~= nil then
			local repeatanim = true
			if type (npcCfg[i][13]) == "boolean" then
				repeatanim = npcCfg[i][13]
			else
				repeatanim = npcCfg[i][14] or false 
			end
			setPedAnimation ( npcPeds[npcCfg[i][8]], npcCfg[i][10], npcCfg[i][11], -1, repeatanim, false, false, true )
			setElementData ( npcPeds[npcCfg[i][8]], "pedAnimRepeat", repeatanim )
			setElementData ( npcPeds[npcCfg[i][8]], "pedAnimBlock", npcCfg[i][10] )
			setElementData ( npcPeds[npcCfg[i][8]], "pedAnimName", npcCfg[i][11] )
		end
	end							
end

function loadServerPickups ()
	for i = 1, #pckCfg do
		local createdPickup = createPickup ( pckCfg[i][1], pckCfg[i][2], pckCfg[i][3], 3, pckCfg[i][4] )
		local createdColShape = createColSphere (  pckCfg[i][1], pckCfg[i][2], pckCfg[i][3]+0.5, 1 )
		setElementInterior ( createdPickup, pckCfg[i][5] )
		setElementInterior ( createdColShape, pckCfg[i][5] )
		setElementData ( createdColShape, "action", true )
		setElementData ( createdColShape, "type", 2 )
		setElementData ( createdColShape, "id", i )
	end
end

function loadServerCshp ()
	for i = 1, #cshpCfg do
		local createdColShape = createColSphere (  cshpCfg[i][1], cshpCfg[i][2], cshpCfg[i][3], 1.5 )
		setElementData ( createdColShape, "action", true )
		setElementData ( createdColShape, "type", 1 )
		setElementData ( createdColShape, "place", cshpCfg[i][4] )
		setElementData ( createdColShape, "live", cshpCfg[i][5] )
		setElementData ( createdColShape, "id", cshpCfg[i][6] )
		--setElementData ( createdColShape, "id", i )
	end
end

function loadServerVehicles ()
	for i = 1, #vehCfg do
		local createdVehicle = createVehicle ( vehCfg[i][1], vehCfg[i][2], vehCfg[i][3], vehCfg[i][4], vehCfg[i][5], vehCfg[i][6], vehCfg[i][7] )
		setElementData ( createdVehicle, "npc-ped", true )
		setVehicleEngineState ( createdVehicle, vehCfg[i][8] )
		setVehicleOverrideLights ( createdVehicle, vehCfg[i][9] )
		setVehicleLocked ( createdVehicle, true )
		setElementFrozen ( createdVehicle, true )
	end
	addEventHandler("onVehicleDamage", getRootElement(), checkNPCVehicle)
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), function () setTimer ( loadServerCshp, 1000, 1 ) end )
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), function () setTimer ( loadServerVehicles, 6000, 1 ) end )
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), function () setTimer ( loadServerPeds, 2000, 1 ) end )
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), function () setTimer ( loadServerPickups, 4000, 1 ) end )

function giveStreamedPedWeapon ()
	if getElementData ( source, "npc-weap" ) > 0 then
		giveWeapon ( source, getElementData ( source, "npc-weap" ), 1, true )
	end
end

addEvent( "giveStreamedPedWeaponC", true )
addEventHandler( "giveStreamedPedWeaponC", getRootElement(), giveStreamedPedWeapon )

-- function actColShapeHit ( hitElement, matchingDimension)
	-- if getElementType ( hitElement ) == "player" then
		-- if getElementData ( source, "action" )
			-- triggerClientEvent ( hitElement, "showActLabelS", hitElement, getElementData ( "type" ) )
		-- end
	-- end
-- end

-- addEventHandler ( "onColShapeHit", hillArea, hill_Enter )

function checkNPCVehicle()
	if getElementData ( source, "npc-ped" ) then
		cancelEvent()
	end
end

-- function getCompassNPCserver ( ped )
	-- if npcPeds[ped] then
		-- local x,y,z = getElementPosition ( npcPeds[ped] )
		-- local pBuild = getElementData ( npcPeds[ped], "build" )
		-- triggerClientEvenet ( source, "sendCompassPedPos"
	-- end
-- end

-- addEvent( "getCompassNPC", true )
-- addEventHandler( "getCompassNPC", getRootElement(), getCompassNPCserver )

rightText = nil

function createBobRight ()
	if not npcPeds['bobRight'] then
		rightCreated = true
		rightText = exports.dtext:create3DText (2332.5322265625,-3.6416015625,27.7, "Боб Райт", 255, 255, 255, 255, "npc", 0 )
		local createdPed = createPed (101, 2332.5322265625,-3.6416015625,26.558090209961, 83 )
		local createdColShape = createColSphere ( 2332.5322265625,-3.6416015625,26.558090209961, 1.5 )
		attachElements ( createdColShape, createdPed )
		attachElements ( rightText, createdPed )
		npcPeds['bobRight'] = createdPed
		setElementFrozen ( createdPed, true )
		setElementData ( createdPed, "npc-ped", true )
		setElementData ( createdPed, "npc-weap", 0 )
		setElementData ( createdColShape, "action", true )
		setElementData ( createdColShape, "type", 1 )
		setElementData ( createdColShape, "place", 7 )
		setElementData ( createdColShape, "live", 2 )
		setElementData ( createdColShape, "id", 2 )
	end
end

function destroyBobRight ()
	if npcPeds['bobRight'] then
		rightCreated = false
		local attachedElements = getAttachedElements ( npcPeds['bobRight'] )
		if ( attachedElements ) then 
			for ElementKey, ElementValue in ipairs ( attachedElements ) do
				if getElementType ( ElementValue ) == 'colshape' then
					local players = getElementsWithinColShape ( ElementValue, "player" )
					for theKey,thePlayer in ipairs(players) do
						setElementData ( thePlayer, "cshpNPC_p", 0 )
						setElementData ( thePlayer, "cshpNPC_l", 0 )
						setElementData ( thePlayer, "cshpNPC_id", 0 )
						triggerClientEvent ( thePlayer, "unShowActLabelS", thePlayer )
					end
				end
				destroyElement ( ElementValue )
			end
		end
		destroyElement ( npcPeds['bobRight'] )
		destroyElement ( rightText )
	end
end

edemCFG = {
	{ 240, 2322.2133789063,73.171676635742,27.316377639771, 154, "Джон Генри Эдем", 31, 'genryEdem', 8 },
	{ 128, 2318.5888671875,69.47265625,26.484785079956, 324, "Люк Скайуокер", 31, 'genryL1', 9 },
	{ 39, 2320.7080078125,69.611328125,26.485651016235, 337, "Лиза Симпсон", 31, 'genryL2', 10 },
	{ 276, 2318.4052734375,75.5908203125,27.316377639771, 197, "Охранник", 31, 'genryGuard', 11 },
	
}

c = {}

listEdem = false

edemPhrases = {
	"Джон Генри Эдем кричит: Уничтожим Новую Деревню и Союз Ученых!!!",
	"Джон Генри Эдем кричит: Захватим Ривет Сити!!!",
	"Джон Генри Эдем кричит: Мы подчиним себе караванщиков!!!",
	"Джон Генри Эдем кричит: Я избавлю вас от гулей и бандитов!!!",
	"Джон Генри Эдем кричит: Вернем жизнь в наш штат!!!",
	"Джон Генри Эдем кричит: Всем по дому и автомобилю!!!",
	"Джон Генри Эдем кричит: Избавимся от многочисленных банд!!!",
	"Джон Генри Эдем кричит: Заселим города!!!",
	"Джон Генри Эдем кричит: Уничтожим китайцев!!!",
	"Джон Генри Эдем кричит: Вернем связь с остальным миром!!!"
}

edemElements = {}

function consoleCreateMarker ( playerSource )
	destroyJohnEdem()
end
-- Attach the 'consoleCreateMarker' function to the "createmarker" command
addCommandHandler ( "createmarker", consoleCreateMarker )

function checkEdemShape( theElement, matchingDimension )
		if ( getElementType(theElement) == 'player' ) then
			setTimer ( shoutEdem, math.random ( 1, 2 )*1000, 1, theElement )
		end
end

function createJohnEdem ()
	if not edemElements[1] then
		for i = 1, 4 do
			local createdText = exports.dtext:create3DText (edemCFG[i][2],edemCFG[i][3],edemCFG[i][4]+1.2, edemCFG[i][6], 255, 255, 255, 255, "npc", 0 )
			local createdPed = createPed (edemCFG[i][1], edemCFG[i][2],edemCFG[i][3],edemCFG[i][4], edemCFG[i][5] )
			local createdColShape = createColSphere ( edemCFG[i][2],edemCFG[i][3],edemCFG[i][4],1.5 )
			table.insert (edemElements, createdText )
			table.insert (edemElements, createdPed )
			table.insert (edemElements, createdColShape )
			setElementData ( createdPed, "npc-ped", true )
			setElementData ( createdPed, "npc-weap", 0 )
			setElementFrozen ( createdPed, true )
			setElementData ( createdColShape, "action", true )
			setElementData ( createdColShape, "type", 1 )
			setElementData ( createdColShape, "place", 7 )
			setElementData ( createdColShape, "live", 2 )
			setElementData ( createdColShape, "id", edemCFG[i][9] )
			npcPeds[edemCFG[i][8]] = createdPed
		end
		edemShoutShape = createColSphere ( edemCFG[1][2],edemCFG[1][3],edemCFG[1][4],15 )
		table.insert ( edemElements, edemShoutShape )
		addEventHandler ( "onColShapeHit", edemShoutShape, checkEdemShape )
		edemCreated = true
	end
end

function shoutEdem ( thePlayer )
	if edemShoutShape then
		if isElementWithinColShape ( thePlayer, edemShoutShape ) then
			outputChatBox ( edemPhrases[math.random(1, #edemPhrases ) ], thePlayer, 255, 255, 255 )
			setTimer ( shoutEdem, math.random ( 10, 20 )*1000, 1, thePlayer )
		end	
	end
end

function destroyJohnEdem ()
	edemCreated = false
	for theKey,thePlayer in ipairs(edemElements) do
		destroyElement ( thePlayer )
	end
	for i = 1, #edemElements do
		table.remove ( edemElements, 1 )
	end
end

addEvent ( "onNPCTaskDone", true )

movPeds = { -- скин пушк xп yп zп ротп xк yк zк роткуд разговор (да или нет) функция перерыв
	{ 223, 31, 2321.2685546875,15.7880859375,26.476568222046, 74.969085693359,   2316.7978515625,58.4541015625,26.482677459717, 273.50607299805, true, "police_talk_KL()", 216000 },
	{ 222, 25, 2336.30859375,14.9375,26.484375,193.16732788086,   2349.001953125,-14.2587890625,26.484375,78.803375244141, true, "police_talk_KL()", 50 },
	{ 217, 22, 2334.3173828125,58.861328125,26.484304428101,286.42068481445,   2353.193359375,59.9853515625,26.484375,87.620056152344, true, "police_talk_KL()", 216000 },

}

function createMovablePeds ()
	for i = 1, #movPeds do
		local createdPed = createPed ( movPeds[i][1], movPeds[i][3],movPeds[i][4],movPeds[i][5],movPeds[i][6])
		setElementData ( createdPed, "npc-ped", true )
		setElementData ( createdPed, "npc-mov", true )
		setElementData ( createdPed, "movID", i )
		setElementData ( createdPed, "movX1", movPeds[i][3] )
		setElementData ( createdPed, "movY1", movPeds[i][4] )
		setElementData ( createdPed, "movZ1", movPeds[i][5] )
		setElementData ( createdPed, "movROT1", movPeds[i][6] )
		setElementData ( createdPed, "movX2", movPeds[i][7] )
		setElementData ( createdPed, "movY2", movPeds[i][8] )
		setElementData ( createdPed, "movZ2", movPeds[i][9] )
		setElementData ( createdPed, "movROT2", movPeds[i][10] )
		setElementData ( createdPed, "movTIME", movPeds[i][13] )
		setElementData ( createdPed, "movSTAGE", 0 )
		setElementData ( createdPed, "npc-weap", movPeds[i][2] )
		exports.npc_hlc:enableHLCForNPC (createdPed, "walk" )
		if movPeds[i][11] then
			setElementData ( createdPed, "npc-talk", true )
		end
		setElementData ( createdPed, "talk-func", movPeds[i][12] )
		setTimer ( moveTask, movPeds[i][13]*60, 1, createdPed, {"walkAlongLine", movPeds[i][3],movPeds[i][4],movPeds[i][5], movPeds[i][7],movPeds[i][8],movPeds[i][9], 3, 5} )
	end
end

function moveTask ( element, task )
	exports.npc_hlc:addNPCTask ( element, task )
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), function () setTimer ( createMovablePeds, 1000, 1 ) end )

function movingFinished ( task )
	if getElementData ( source, "npc-mov" ) then
		if getElementData ( source, "movSTAGE" ) == 0 then
			setElementRotation ( source, 0, 0, getElementData ( source, "movROT2" ) )
			setTimer ( moveTask, getElementData ( source, "movTIME" )*60, 1, source, {"walkAlongLine", task[5],task[6],task[7], task[2],task[3],task[4], 3, 5} )
			setElementData ( source, "movSTAGE", 1 )
		else
			setElementRotation ( source, 0, 0, getElementData ( source, "movROT1" ) )
			setElementData ( source, "movSTAGE", 0 )
			setTimer ( moveTask, getElementData ( source, "movTIME" )*60, 1, source, {"walkAlongLine", task[2],task[3],task[4], task[5],task[6],task[7], 3, 5} )
		end
	end
end
addEventHandler ( "npc_hlc:onNPCTaskDone", root, movingFinished )

function npcPedDied()
    if getElementData ( source, "npc-ped" ) then
		local x,y,z = getElementPosition ( source )
		--local name = 
		local dim = getElementDimension ( source )
		local int = getElementInterior ( source )
		local model = getElementModel ( source )
		local rotX, rotY, rotZ = getElementRotation ( source )
		local createdPed = createPed ( model, x, y, z, rotZ, false )
		setElementFrozen ( npcPeds[npcCfg[i][8]], true )
		setElementData ( npcPeds[npcCfg[i][8]], "npc-ped", true )
		setElementData ( npcPeds[npcCfg[i][8]], "npc-name", npcCfg[i][8] )
		setElementData ( npcPeds[npcCfg[i][8]], "npc-weap", npcCfg[i][7] )
		if npcCfg[i][13] then setElementData ( npcPeds[npcCfg[i][8]], "build", npcCfg[i][13] ) end
		setElementInterior ( npcPeds[npcCfg[i][8]], npcCfg[i][9] )
		setElementInterior ( createdText, npcCfg[i][9] )
		if npcCfg[i][7] ~= 0 then
			giveWeapon ( npcPeds[npcCfg[i][8]], npcCfg[i][7], 30, true )
		end
		if npcCfg[i][10] ~= nil then
			setPedAnimation ( npcPeds[npcCfg[i][8]], npcCfg[i][10], npcCfg[i][11], -1, true, false, false )
			setElementData ( npcPeds[npcCfg[i][8]], "pedAnimBlock", npcCfg[i][10] )
			setElementData ( npcPeds[npcCfg[i][8]], "pedAnimName", npcCfg[i][11] )
		end
	end
end
--addEventHandler("onPedWasted", root, npcPedDied)