local moveTimer = nil
moveAvailable = 1

-- Новая Деревня
function dylan_Carn_Q ()
	showQuestWindow ( "Боб Дилан", "Приветствую тебя, странник, что надо?", "Кто вы такие?", "dylan_story_Carn_Q()", "Вам нужна помощь?", "dylan_help_Carn_Q()", "Вы сможете меня доставить в другое поселение?", "dylan_move_Carn_Q()", "Да ничего", "" )
end

function dylan_first_done_Carn_Q ()
	showQuestWindow ( "Боб Дилан", "Приветствую тебя, странник, ты нашел мои \"лекарства\"?", "Да, вот они", "dylan_help_d_Carn_Q()", "Нет пока...", "", "0", "dylan_move_Carn_Q()", "0", "" )
end

function dylan_story_Carn_Q ()
	showQuestWindow ( "Боб Дилан", "Наша организация назвается \"Караванщики\". Мы занимаемся доставкой и торговлей различными товарами между выжившими поселениями по всему штату.", "Значит где то еще есть поселения?", "dylan_life_Carn_Q()", "Вам нужна помощь?", "dylan_help_Carn_Q()", "Вы сможете меня доставить в другое поселение?", "dylan_move_Carn_Q()", "Спасибо за информацию", "" )
	--showQuestWindow ( "Bob Dylan", "We are the \"Caravanners\". We trading with all survived settlements all over this state.", "This mean that there is another settlements?", "dylan_life_Carn_Q()", "Do you need any help?", "dylan_help_Carn_Q()", "Can you drive me to another settlement?", "dylan_move_Carn_Q()", "Thank you for information", "" )
end

function dylan_life_Carn_Q ()
	--showQuestWindow ( "Bob Dylan", "Well... Yes... There are a lot of settlements, but this insane government of New Country doesn't allow their citizens to move across state. Let's close this theme. ", "Do you need any help?", "dylan_help_Carn_Q()", "Can you drive me to another settlement?", "dylan_move_Carn_Q()", "As you want", "", "0", "" )
	showQuestWindow ( "Боб Дилан", "Эээ... Ну... Есть, да, только я тебе об этом не говорил, правительство местных деревень не любит об этом распространяться. Давай закончим этот разговор, ни к чему хорошему он не приведет. ", "Вам нужна помощь?", "dylan_help_Carn_Q()", "Вы сможете меня доставить в другое поселение?", "dylan_move_Carn_Q()", "Как знаешь", "", "0", "" )
end

function dylan_help_Carn_Q()
	if getElementData ( localPlayer, "detective_quest" ) == 0 then
		showQuestWindow ( "Боб Дилан", "В данный момент нет, кампания процветает. Хотя... Есть тут одно деликатное дельце...", "Говори, что надо?", "dylan_help_s_Carn_Q()", "0", "", "0", "", "0", "" )
	else
		showQuestWindow ( "Боб Дилан", "Больше заданий у меня пока нет", "Вы сможете меня доставить в другое поселение?", "dylan_move_Carn_Q()", "Как знаешь", "", "0", "", "0", "" )
	end
end

function dylan_help_s_Carn_Q()
	showQuestWindow ( "Боб Дилан", "Отправляйся в Эль Кебрадос, там есть детективное агенство, ну ты его сразу увидишь, там есть два пакета в закрытой частью, ключи от этой части здания я тебе дам. Пакеты эти необычные, а с волшебным порошком. Привези мне эти два пакета.", "А что насчет награды?", "dylan_help_rew_Carn_Q()", "0", "", "0", "", "0", "" )
end

function dylan_help_rew_Carn_Q ()
	showQuestWindow ( "Боб Дилан", "Спрашиваешь тоже. Конечно будет тебе награда. Целых 1000 крышек и все то, что ты найдешь в агенстве помимо моих пакетов.", "Ок, я в деле!", "dylan_help_yes_Carn_Q()", "Не, извини, у меня есть другие дела.", "", "0", "", "0", "" )
end

function dylan_help_yes_Carn_Q ()
	showQuestWindow ( "Боб Дилан", "Вот держи ключи. И, кстати, даже не пытайся вскрыть те пакеты, они взрываются, если попытаться их открыть обычным способом.", "Ладно-ладно...", "dylan_help_begin_Carn_Q()", "0", "", "0", "", "0", "" )
end

function dylan_help_begin_Carn_Q()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "detective_quest", 1 )
	exports.pipboy:addInfoBox("Получено задание \"Спецдоставка\"", 3 )
	updateCompassAdditMarker ( 2, 1 )
	narko_det = createPickup ( 1291.2724609375,-1015.8310546875,6645.731933593, 3, 1279, 30000)
	adren_det = createPickup ( 1312.5546875,-989.447265625,6645.7319335938, 3, 1279, 30000 )
end

function dylan_help_d_Carn_Q()
	showQuestWindow ( "Боб Дилан", "Отлично, с тобой приятно иметь дело, приходи еще, может будет у меня еще заданьице для тебя. И ключики я заберу, они мне еще пригодятся.", "А деньги где мои???", "dylan_help_done_Carn_Q()", "0", "", "0", "", "0", "" )
end

function dylan_help_done_Carn_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "detective_quest", 6 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 1000 )
	outputChatBox ("Боб Дилан: Извини, забыл, вот твои 1000 крышек", 255, 255, 255 )
	exports.achievments:givePoint ( 1 )
	updateCompassAdditMarker ( 2, 6 )
end

function dylan_move_Carn_Q()
	showQuestWindow ( "Боб Дилан", "Куда хочешь? Учти, поездка в Союз Ученых и Новый Вегас обойдется тебе в 100 крышек, а в Ривет Сити 300 крышек", "Союз Ученых", "dylan_su_Carn_Q()", "Новый Вегас", "dylan_nv_Carn_Q()", "Ривет Сити", "dylan_rivet_Carn_Q()", "Я передумал", "" )
end

function dylan_su_Carn_Q()
	if moveAvailable == 1 then
		if getElementData ( localPlayer, "sckey" ) == 1 then
			if exports.inventory:getPlayerCaps() >= 100 then
				moveToSU_Carn_Q()
			else
				showQuestWindow ( "Боб Дилан", "Извини, дружок, деньжат то у тебя не хватает.", "Да, есть такое дело", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
			end
		else
			showQuestWindow ( "Боб Дилан", "Извини, дружок, если у тебя нету пропуска в Союз Ученых, мы не сможем тебя туда доставить.", "Жаль, я тогда вернусь, когда у меня будет пропуск", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Боб Дилан: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function dylan_nv_Carn_Q()
	if moveAvailable == 1 then
		if getElementData ( localPlayer, "nwkey" ) == 1 then
			if exports.inventory:getPlayerCaps ( ) >= 100 then
				moveToNV_Carn_Q()
			else
				showQuestWindow ( "Боб Дилан", "Извини, дружок, деньжат то у тебя не хватает.", "Да, есть такое дело", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
			end
		else
			showQuestWindow ( "Боб Дилан", "Извини, дружок, если я тебя доставлю в Новый Вегас, а у тебя не будет пропуска, то мы огребем проблем.", "Жаль, я тогда вернусь, когда у меня будет пропуск", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Боб Дилан: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function dylan_rivet_Carn_Q()
	if moveAvailable == 1 then
		if exports.inventory:getPlayerCaps() >= 300 then
			moveToRivet_Carn_Q()
		else
			showQuestWindow ( "Боб Дилан", "Извини, дружок, деньжат то у тебя не хватает.", "Да, есть такое дело", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Боб Дилан: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

-- Союз Ученых

function rob_meh_begin_Carn_Q ()
	outputChatBox ("Марти Роббинс: Давай, до свидания", 255,255,255 )
	setElementData ( localPlayer, "quest_meh", 3 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	updateCompassAdditMarker ( 6, 3 )
end

function rob_Carn_Q ()
	showQuestWindow ( "Марти Роббинс", "Доброй ночи.", "Кто вы такие?", "rob_story_Carn_Q()", "Вы сможете меня доставить в другое поселение?", "rob_move_Carn_Q()", "И тебе того-же", "", "Может продадите оружие?", "robbins_weapons_Carn()" )
end

function robbins_weapons_Carn ()
	outputChatBox ("Марти Роббинс: Да, у нас большой ассортимент", 255,255,255 )
	exports.traders:showTraderWindow("nc_weap")
end

function rob_story_Carn_Q ()
	showQuestWindow ( "Марти Роббинс", "Спроси лучше у Боба Дилана, он главный представитель Каравнщиков в пустыне. Боб находится в Новой Деревне.", "Вы сможете меня доставить в другое поселение?", "rob_move_Carn_Q()", "Ладно", "", "0", "", "0", "" )
end

function rob_move_Carn_Q()
	showQuestWindow ( "Марти Роббинс", "Поездка в Новую Деревню и Новый Вегас стоит 100 крышек. В Кламат 300 крышек. Пункт назначения?", "Новая Деревня", "rob_nc_Carn_Q()", "Новый Вегас", "rob_nv_Carn_Q()",  "Кламат", "rob_kl_Carn_Q()", "Я передумал", "" )
end

function rob_nc_Carn_Q()
	if moveAvailable == 1 then
		if exports.inventory:getPlayerCaps ( ) >= 100 then
			moveToNC_Carn_Q()
		else
			showQuestWindow ( "Марти Роббинс", "Деньги где?", "Не хватает немного...", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Марти Роббинс: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function rob_nv_Carn_Q()
	if moveAvailable == 1 then
		if getElementData ( localPlayer, "nwkey" ) == 1 then
			if exports.inventory:getPlayerCaps ( ) >= 100 then
				moveToNV_Carn_Q()
			else
				showQuestWindow ( "Марти Роббинс", "Деньги где?", "Не хватает немного...", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
			end
		else
			showQuestWindow ( "Марти Роббинс", "Без пропуска я не смогу тебя доставить в Новый Вегас.", "Ептэ", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Марти Роббинс: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function rob_kl_Carn_Q()
	if moveAvailable == 1 then
		if getElementData ( localPlayer, "nwkey" ) == 1 then
			if exports.inventory:getPlayerCaps ( ) >= 300 then
				moveToKL_Carn_Q()
			else
				showQuestWindow ( "Марти Роббинс", "Деньги где?", "Не хватает немного...", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
			end
		else
			showQuestWindow ( "Марти Роббинс", "Без пропуска я не смогу тебя доставить в Новый Вегас.", "Ептэ", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Марти Роббинс: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

-- Новый Вегас

function cash_Carn_Q ()
	showQuestWindow ( "Джонни Кэш", "Привет, я Джонни Кэш. Что тебе надо от Караванщиков?", "Вы сможете меня доставить в другое поселение?", "cash_move_Carn_Q()", "Ничего", "", "Я хочу купить оружие", "cash_weapons_Carn()", "0", "" )
end

function cash_weapons_Carn ()
	outputChatBox ("Джонни Кэш: Вот, наши цены лучшие во всем штате.", 255,255,255 )
	exports.traders:showTraderWindow("nv_weap")
end

function cash_move_Carn_Q ()
	showQuestWindow ( "Джонни Кэш", "Всего 100 крышек, и мы доставим тебя куда угодно.", "Я хочу в Новую Деревню", "cash_nc_Carn_Q()", "В Союз Ученых!", "cash_su_Carn_Q()", "На Торговый Пост.", "cash_tp_Carn_Q()", "Я передумал", "" )
end

function cash_nc_Carn_Q()
	if moveAvailable == 1 then
		if exports.inventory:getPlayerCaps ( ) >= 100 then
			moveToNC_Carn_Q()
		else
			showQuestWindow ( "Джонни Кэш", "Денег не хватает? Ничем не могу помочь.", "Арррр", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Джонни Кэш: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function random_cash_move_Carn_Q()
	if math.random ( 1, 100 ) > 70 then
		showQuestWindow ( "Джонни Кэш", "Ты знаешь наш тайный пароль? Ну тогда отправляйся бесплатно.", "Ура", "suc_cash_move_Carn_Q()", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
	end
end

function suc_cash_move_Carn_Q ()
	moveToSU_Carn_Q()
end

function cash_su_Carn_Q()
	if moveAvailable == 1 then
		if getElementData ( localPlayer, "sckey" ) == 1 then
			if exports.inventory:getPlayerCaps ( ) >= 100 then
				moveToSU_Carn_Q()
			else
				showQuestWindow ( "Джонни Кэш", "Денег не хватает? Ничем не могу помочь.", "Арррр", "random_cash_move_Carn_Q()", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
			end
		else
			showQuestWindow ( "Джонни Кэш", "Ты не сможешь пройти через контроль в Союзе Ученых без пропуска.", "Мда", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Джонни Кэш: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function cash_tp_Carn_Q()
	if moveAvailable == 1 then
		if getElementData ( localPlayer, "sckey" ) == 1 then
			if exports.inventory:getPlayerCaps ( ) >= 100 then
				moveToTP_Carn_Q()
			else
				showQuestWindow ( "Джонни Кэш", "Денег не хватает? Ничем не могу помочь.", "Арррр", "random_cash_move_Carn_Q()", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
			end
		else
			showQuestWindow ( "Джонни Кэш", "Ты не сможешь пройти через контроль в Союзе Ученых без пропуска.", "Мда", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Джонни Кэш: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function moveToNC_Carn_Q()
	triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 100 )
	moveAvailable = 0
	outputChatBox ("Караванщик: Пункт назначения - Новая Деревня, до туда не долго ехать", 255,255,255 )
	setTimer ( function () 
					setElementDimension ( localPlayer, 10 ) 
					setCameraMatrix ( 0, 0, 0 )
				end, 1000, 1 ) 
	fadeCamera ( false )
	setTimer ( function ()
					fadeCamera ( true )
					setCameraTarget ( localPlayer )
					setElementPosition ( localPlayer, -825.96484375,2035.544921875,60.1875 )
					setElementDimension ( localPlayer, 0 )
					outputChatBox ("Караванщик: Приехали в Новую Деревню, будь тут осторожен.", 255,255,255 )
					setTimer ( function() moveAvailable = 1 end, 600000, 1 )
				end, 4000, 1 )
end

function moveToSU_Carn_Q()
	triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 100 )
	moveAvailable = 0
	outputChatBox ("Караванщик: Отправляемся в Союз Ученых", 255,255,255 )
	setTimer ( function () 
					setElementDimension ( localPlayer, 10 ) 
					setCameraMatrix ( 0, 0, 0 )
				end, 1000, 1 )
	fadeCamera ( false )
	setTimer ( function ()
					fadeCamera ( true )
					setElementPosition ( localPlayer, -367.1943359375,1543.6328125,75.5625 )
					setElementDimension ( localPlayer, 0 )
					triggerServerEvent ( 'clearPlayerInterior', localPlayer )
					setCameraTarget ( localPlayer )
					outputChatBox ("Караванщик: Приехали в Союз Ученых, рекомендую тут закупиться лекарствами.", 255,255,255 )
					setTimer ( function() moveAvailable = 1 end, 600000, 1 )
				end, 4000, 1 )
end

function moveToNV_Carn_Q()
	triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 300 )
	moveAvailable = 0
	outputChatBox ("Караванщик: Усаживайся, дорога будет долгая.", 255,255,255 )
	setTimer ( function () 
					setElementDimension ( localPlayer, 10 ) 
					setCameraMatrix ( 0, 0, 0 )
				end, 1000, 1 )
	fadeCamera ( false )
	setTimer ( function ()
					fadeCamera ( true )
					setCameraTarget ( localPlayer )
					setElementPosition ( localPlayer, -167.7099609375,2680.25390625,62.683616638184 )
					setElementDimension ( localPlayer, 0 )
					triggerServerEvent ( 'clearPlayerInterior', localPlayer )
					outputChatBox ("Караванщик: Приехали в Новый Вегас, удачи.", 255,255,255 )
					setTimer ( function() moveAvailable = 1 end, 600000, 1 )
				end, 7000, 1 )
end

function moveToKL_Carn_Q()
	moveAvailable = 0
	triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 300 )
	outputChatBox ("Караванщик: Усаживайся, дорога длинная и опасная.", 255,255,255 )
	setTimer ( function () 
					setElementDimension ( localPlayer, 10 ) 
					setCameraMatrix ( 0, 0, 0 )
				end, 1000, 1 )
	fadeCamera ( false )
	setTimer ( function ()
					fadeCamera ( true )
					setCameraTarget ( localPlayer )
					setElementPosition ( localPlayer, 2337.9541015625,65.974609375,26.478975296021 )
					setElementDimension ( localPlayer, 0 )
					triggerServerEvent ( 'clearPlayerInterior', localPlayer )
					outputChatBox ("Караванщик: Приехали в Кламат, удачи.", 255,255,255 )
					setTimer ( function() moveAvailable = 1 end, 600000, 1 )
				end, 4000, 1 )
end

function moveToRivet_Carn_Q()
	moveAvailable = 0
	triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 300 )
	outputChatBox ("Караванщик: Пункт назначения - Ривет Сити.", 255,255,255 )
	setTimer ( function () 
					setElementDimension ( localPlayer, 10 ) 
					setCameraMatrix ( 0, 0, 0 )
				end, 1000, 1 )
	fadeCamera ( false )
	setTimer ( function ()
					fadeCamera ( true )
					setCameraTarget ( localPlayer )
					setElementPosition ( localPlayer, -2916.654296875,488.943359375,4.9140625 )
					setElementDimension ( localPlayer, 0 )
					triggerServerEvent ( 'clearPlayerInterior', localPlayer )
					outputChatBox ("Караванщик: Приехали в Ривет Сити, удачи.", 255,255,255 )
					setTimer ( function() moveAvailable = 1 end, 600000, 1 )
				end, 4000, 1 )
end

function moveToTP_Carn_Q()
	moveAvailable = 0
	triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 100 )
	outputChatBox ("Караванщик: Усаживайся, скоро будем на Торговом Посту.", 255,255,255 )
	setTimer ( function () 
					setElementDimension ( localPlayer, 10 ) 
					setCameraMatrix ( 0, 0, 0 )
				end, 1000, 1 )
	fadeCamera ( false )
	setTimer ( function ()
					fadeCamera ( true )
					setCameraTarget ( localPlayer )
					setElementPosition ( localPlayer, 1079.845703125,1264.9228515625,10.8203125 )
					setElementDimension ( localPlayer, 0 )
					triggerServerEvent ( 'clearPlayerInterior', localPlayer )
					outputChatBox ("Караванщик: Приехали на Торговый Пост, удачи.", 255,255,255 )
					setTimer ( function() moveAvailable = 1 end, 600000, 1 )
				end, 4000, 1 )
end

-- Вест Сайд

function rodg_Carn_Q ()
	showQuestWindow ( "Джимми Роджерс", "Здравствуй странник, я представитель фракции караванщиков в Вест Сайде. Что хочешь?", "Вы сможете меня доставить в другое поселение?", "rodg_move_Carn_Q()", "Можно у вас что-нибуть купить?", "exports.traders:showTraderWindow(\"west_car\")", "Ничего", "", "0", "" )
end

function rodg_move_Carn_Q ()
	showQuestWindow ( "Джимми Роджерс", "Извини, доставка отсюда не производится, путь слишком опасный.", "Можно у вас что-нибуть купить?", "exports.traders:showTraderWindow(\"west_car\")", "Жалко", "", "0", "", "0", "" )
end

-- Кламат

function guy_Carn_Q ()
	showQuestWindow ( "Гай Кларк", "Здравствуй, я представитель Караванщиков в Кламате. Чего тебе надо?", "Можно вам продать товары?", "guy_sell_Carn_Q()", "Довезете меня до другого поселения?", "guy_drive_Carn_Q()", "Можете рассказать о Кламате?", "guy_tell_Carn_Q()", "Да ничего", "" )
end

function guy_sell_Carn_Q ()
	outputChatBox ( "Гай Кларк: Показывай, что хочешь продать.", 255,255,255 )
	exports.traders:showSellWindow ("klamat_weap")
end

function guy_drive_Carn_Q ()
	if getElementData ( localPlayer, "quest_prob" ) > 5 then
		showQuestWindow ( "Гай Кларк", "Можем довезти до Нового Вегаса, поездка обычно стоит 400 крышек, но мне Боб Райт рассказывал, что ты ему помог, так что мы довезем тебя за 50 крышек. Согласен?", "Да, поехали", "guy_SU_Carn_Q()", "Я передумал", "", "0", "", "0", "" )
	else
		showQuestWindow ( "Гай Кларк", "Можем довести до Нового Вегаса, поездка стоит 400 крышек. Согласен?", "Да, поехали", "guy_SU_Carn_Q()", "Я передумал", "", "0", "", "0", "" )
	end
end

function guy_SU_Carn_Q()
	if moveAvailable == 1 then
		local price = 400
			if getElementData ( localPlayer, "quest_prob" ) > 5 then price = 50 end
			if exports.inventory:getPlayerCaps ( ) >= price then
				triggerServerEvent ( "takeClientMoney", getLocalPlayer(), price )
				moveAvailable = 0
				outputChatBox ("Караванщик: Отправляемся в Новый Вегас", 255,255,255 )
				setTimer ( function () 
								setElementDimension ( localPlayer, 10 ) 
								setCameraMatrix ( 0, 0, 0 )
							end, 1000, 1 )
				fadeCamera ( false )
				setTimer ( function ()
					fadeCamera ( true )
					setCameraTarget ( localPlayer )
					setElementPosition ( localPlayer, -167.7099609375,2680.25390625,62.683616638184 )
					setElementDimension ( localPlayer, 0 )
					triggerServerEvent ( 'clearPlayerInterior', localPlayer )
					outputChatBox ("Караванщик: Приехали в Новый Вегас, удачи.", 255,255,255 )
					setTimer ( function() moveAvailable = 1 end, 600000, 1 )
				end, 7000, 1 )
			else
				outputChatBox ("Гай Кларк: А деньжат-то не хватает.", 255,255,255 )
			end
	else
		outputChatBox ("Гай Кларк: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function guy_tell_Carn_Q ()
	showQuestWindow ( "Гай Кларк", "Да что можно сказать, поселение как поселение, ничего особенного. В основном сюда везут находки из пригорода Лос Сантоса. Мэр тут душевный человек, но в последнее время начал набирать популярность Генри Эдем, он хочет стать новым мэром, а потом захватить все остальные поселения. Во у человека фантазия-то.", "Почему?", "guy_t_why_Carn_Q()", "Можно вам продать товары?", "guy_sell_Carn_Q()", "Довезете меня до другого поселения?", "guy_drive_Carn_Q()", "Спасибо за информацию", "" )
end

function guy_t_why_Carn_Q ()
	showQuestWindow ( "Гай Кларк", "Давай прикинем, что ему придется сделать, чтоб захватить хотя-бы поселения в пустыне. Новым Вегасом управляют бандиты, хорошо обученые бандиты, которые в прошлом были военными. Фанатики Новой Деревни будут до последней капли крови биться за свою деревню. Ну а у Союза Ученых, говорят, под холмом спрятана целая армия роботов. Так-что Эдем, можно сказать, проиграл еще до начала какой-либо битвы.", "Мда", "", "Можно вам продать товары?", "guy_sell_Carn_Q()", "Довезете меня до другого поселения?", "guy_drive_Carn_Q()", "Спасибо за информацию", "" )
end

function talkGunSeller ()
	exports.traders:showTraderWindow("caravan_weap")
end