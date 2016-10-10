local localPlayer = getLocalPlayer ()

-- Престон

function praston_talk_RC ()
	showQuestWindow ( "Доктор Престон", "Здравствуйте. Что вам надо в лаборатории Ривет Сити?", "Я хотел бы купить лекарств", "exports.traders:showTraderWindow(\"preston\")", "Я хочу задать вопрос", "prat_quest_RC()", "Я случайно сюда забрел", "", "0", "" )
end

function prat_quest_RC() 
	showQuestWindow ( "Доктор Престон", "И что вас интересует?", "Вы из Союза Ученых?", "prat_su_RC()", "Как у вас тут ситуация с лекарствами?", "prat_lek_RC()", "Я передумал", "", "0", "" )
end

function prat_su_RC ()
	showQuestWindow ( "Доктор Престон", "В какой-то мере. Давно я там работал, когда там еще производились исследования. Но, потом появился Моряк Попай и все пошло коту под хвост. В конце-концов все жители разбежались, остались лишь Катерина Минет, да Попай. Хотя, я думаю и они уже мертвы.", "Там полно военных и жителей", "prat_su_lie_RC()", "У меня есть еще вопрос", "prat_quest_RC()", "Я пошел", "", "0", "" )
end

function prat_su_lie_RC ()
	showQuestWindow ( "Доктор Престон", "Ха. Ты не понял что-ли? Это все роботы, все военные, что там находятся. Там поди-ка еще и комендант есть? Ты не пробовал спросить у него имя?", "Ну... Она Гражданский Комендант", "prat_su_com_RC()", "У меня есть еще вопрос", "prat_quest_RC()", "Я пошел", "", "0", "" )
end

function prat_su_com_RC ()
	showQuestWindow ( "Доктор Престон", "Ну-ну. Модель \"Комендантотрон - 2000\". Довольно старая разработка. Послушай. Не суйся в пустныю, там все поехавшие.", "Спасибо за информацию", "", "Учту, но у меня есть еще вопрос", "prat_quest_RC()", "0", "", "0", "" )
end

function prat_lek_RC ()
	showQuestWindow ( "Доктор Престон", "Неплохо, знаешь-ли. Мы хорошо обеспечены ими, благодоря удачному расположению. В Ривет Сити приходит много торговцев из города, которые за копейки продают найденные лекарства.", "Спасибо за информацию", "", "У меня есть еще вопрос", "prat_quest_RC()", "0", "", "0", "" )
end

-- Вилкс

function wilks_talk_RC ()
	showQuestWindow ( "Брайан Уилкс", "Добро пожаловать, я - глава совета Ривет Сити, Брайан Уилкс. Чем могу помочь?", "Есть задания для путешественника?", "wilks_task_RC()", "Я хочу спросить про Ривет Сити", "wilks_quest_RC()", "Да ничем", "", "0", "" )
end

function wilks_task_RC ()
	showQuestWindow ( "Брайан Уилкс", "У меня нету, но спроси у механика, что стоит в коридоре, он говорил, что ему нужна какая-то вещь.", "Спасибо", "", "Я хочу спросить про Ривет Сити", "wilks_quest_RC()", "0", "", "0", "" )
end

function wilks_quest_RC ()
	showQuestWindow ( "Брайан Уилкс", "Говори.", "Авианосец? Почему??", "wilks_ship_RC()", "Гулей в округе не много?", "wilks_ghoul_RC()", "0", "", "0", "" )
end

function wilks_ship_RC ()
	showQuestWindow ( "Брайан Уилкс", "Ну, кучка ребят собрались вместе и превратили заброшенный авианосец в город. Круто, да?", "Эээ... Ага...", "", "У меня есть еще вопрос", "wilks_quest_RC()", "0", "", "0", "" )
end

function wilks_ghoul_RC ()
	showQuestWindow ( "Брайан Уилкс", "Вот знаешь, раньше было очень сложно, но сейчас все более-менее нормально стало, гули почему-то идут на север, к Бай Сайду. Говорят, мост вообще до краев заполнен ими.", "Надо будет проверить", "", "У меня есть еще вопрос", "wilks_quest_RC()", "0", "", "0", "" )
end

-- Бонни 

function bonny_talk_RC ()
	showQuestWindow ( "Красотка Бонни", "В баре \"У руля\" всегда рады новым посетителям, чем могу помочь?", "Выпить есть-что?", "exports.traders:showTraderWindow(\"bonny\")", "Хочу обсудить с тобой местные слухи", "bonny_sluh_RC()", "Я не пью", "", "0", "" )
end

function bonny_sluh_RC ()
	if exports.inventory:getPlayerCaps () >= 500 then
		showQuestWindow ( "Красотка Бонни", "Всего 500 крышек, и я расскажу тебе все, что твориться в Ривет Сити", "Держи", "bonny_sluh_give_RC()", "Пфф, я сам все узнаю", "", "Лучше покажи мне свою выпивку", "exports.traders:showTraderWindow(\"bonny\")", "0", "" )
	else
		showQuestWindow ( "Красотка Бонни", "Всего 500 крышек, и я расскажу тебе все, что твориться в Ривет Сити", "У меня нету столько денег", "", "Пфф, я сам все узнаю", "", "Лучше покажи мне свою выпивку", "exports.traders:showTraderWindow(\"bonny\")", "0", "" )
	end
end

function bonny_sluh_give_RC ()
	triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 500 )
	showQuestWindow ( "Красотка Бонни", "Наш механик сказал, что ему нужна какая-то деталь для генератора, он хорошо заплатит тому, кто ее принесет. Вон он, стоит на балконе напротив гостинницы. Это все слухи.", "ЧТО?! ВЕРНИ ДЕНЬГИ, ШАРЛАТАНКА", "bonny_sluh_ret_RC()", "Спасибо за информацию", "", "Покажи мне свою выпивку", "exports.traders:showTraderWindow(\"bonny\")", "0", "" )
end

function bonny_sluh_ret_RC ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 100 )
	showQuestWindow ( "Красотка Бонни", "Ладно, ладно, не кричи красавчик. Вот 100 крышек.", "Хоть что-то", "", "Чтоб я еще хоть раз с тобой связался", "", "Покажи мне свою выпивку", "exports.traders:showTraderWindow(\"bonny\")", "0", "" )
end


-- Фэтси

function fatsy_talk_RC ()
	showQuestWindow ( "Худышка Фетси", "Приветики, ты в магазине продуктов Худышки Фетси.", "Я хочу купить продуктов", "exports.traders:showTraderWindow(\"fatsy\")", "Ты случайно не знакома с Толстушкой Бэтси?", "fatsy_batsy_RC()", "Я пойду", "", "0", "" )
end

function fatsy_batsy_RC ()
	showQuestWindow ( "Худышка Фетси", "Конечно! Это моя сестричка, она вроде в Новой Деревне проживает. Еще у меня есть сестричка Толстушка Метси, что работает на Торговом Посту Караванщиков.", "Я хочу купить продуктов", "exports.traders:showTraderWindow(\"fatsy\")", "Много-же вас", "", "0", "", "0", "" )
end


-- Снаряд
function gun_talk_RC ()
	showQuestWindow ( "Снаряд", "Оружейный Магазин Снаряда и Шрапнели ряд приветствовать нового посетителя.", "Я хочу купить оружие", "exports.traders:showTraderWindow(\"bullet\")", "Снаряда и Шрапнели? А где-же тогда Шрапнель?", "gun_shrap_RC()", "Я пожалуй пойду", "", "0", "" )
end

function gun_shrap_RC ()
	showQuestWindow ( "Снаряд", "Шрапнель пал смертью храбрых в борьбе с выходцем из убежища, когда тот пытался его загипнотизировать. Так что я теперь один.", "Я хочу купить оружие", "exports.traders:showTraderWindow(\"bullet\")", "Я пожалуй пойду", "", "0", "", "0", "" )
end

-- Вера Уизерспун

function vera_talk_RC ()
	if getElementData ( localPlayer, "nat" ) == 6 then
		if getElementData ( localPlayer, "vera_talked" ) == false then
			showQuestWindow ( "Вера Уизерспун", "Добрый день, как вам аренда койки в мое гостиннице?", "Все хорошо", "outputChatBox ( \"Вера Уизерспун: Я рада!\", 255,255,255 )", "Клопы меня всю ночь доставали", "vera_t_clop_RC()", "Койка не очень", "outputChatBox ( \"Вера Уизерспун: Лучше вы вряд-ли где-то найдете\", 255,255,255 )", "0", "" )
		else
			showQuestWindow ( "Вера Уизерспун", "Добрый день, как вам аренда койки в мое гостиннице?", "Все хорошо", "outputChatBox ( \"Вера Уизерспун: Я рада!\", 255,255,255 )", "Клопы меня всю ночь доставали", "outputChatBox ( \"Вера Уизерспун: Да, вы уже говорили об этом сегодня\", 255,255,255 )", "Койка не очень", "outputChatBox ( \"Вера Уизерспун: Лучше вы вряд-ли где-то найдете\", 255,255,255 )", "0", "" )
		end
	else
		showQuestWindow ( "Вера Уизерспун", "Добрый день, не хотите-ли арендовать комнату в моей гостиннице. Всего 100 крышек за ночь.", "Пожалуй, хочу", "vera_t_rent_RC()", "Неа", "", "0", "", "0", "" )
	end
end

function vera_t_clop_RC ()
	outputChatBox ( "Вера Уизерспун: Что?! Извиняюсь, я вам верну часть денег.", 255,255,255 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 30 )
	exports.players:givePlayerXPClient ( 20 )
	setElementData ( localPlayer, "vera_talked", true )
end

function vera_t_rent_RC ()
	outputChatBox ( "Вера Уизерспун: Отлично, выбирайте любую койку.", 255,255,255 )
	outputChatBox ( "Теперь вы будете появлятся в Гостиннице Ривет Сити за 100 крышек.", 153,153,204 )
	setElementData ( localPlayer, "nat", 6 )
end

-- Профессор Горбов

function gorbov_talk_RC ()
	if getElementData ( localPlayer, "quest_fire" ) == 0 then
		showQuestWindow ( "Горбов", "Доброго здоровьица, я - профессор Горбов, разработчик огнемета \"Горбомет - 1\"", "Я не слышал о таком оружии", "gorbov_start_RC()", "Я слышал ты торгуешь всяким мусором", "gorbov_show_trade_", "*пройти мимо*", "outputChatBox ( \"Горбов: Занятой? Приходи в другой раз!\", 255,255,255 )", "0", "" )
	else
		showQuestWindow ( "Горбов", "Доброго здоровьица. Хочешь прикупить баки для топлива от \"Горбомета - 1\"?", "Да", "exports.traders:showTraderWindow(26)", "*пройти мимо*", "outputChatBox ( \"Горбов: Занятой? Приходи в другой раз!\", 255,255,255 )", "0", "", "0", "" )
	end
end

function gorbov_change_RC ()
	local ess = getElementData ( localPlayer, "quest_fire" )
	triggerServerEvent ( "giveClientWeapon", getLocalPlayer(), 37, 10*ess )  
	setElementData ( localPlayer, "quest_fire", 1 )
	outputChatBox ( "Горбов: Держи "..(10*ess).." зарядов, заходи еще.", 255,255,255 )
end

function gorbov_start_RC ()
	showQuestWindow ( "Горбов", "Ещеб, ведь существуют только два экземпляра этого оружия, притом оба у меня!", "Можешь продать один из них?", "gorbov_s_sell_RC()", "0", "", "0", "", "0", "" )
end

function gorbov_s_sell_RC ()
	--if getElementData ( localPlayer, "quest_meh" ) == 8 then
		-- if exports.inventory:getPlayerCaps ( ) > 5000 then
			-- showQuestWindow ( "Горбов", "Конечно! Всего 15000 крышек и один из двух экземпляров \"Горбомет - 1\" будет твоим! Хотя, для тебя 5000 крышек, мне ведь механик рассказывал, что ты сделал.", "Вот твои деньги", "gorbov_s_give_RC( 1 )", "Как-нибуть в другой раз", "outputChatBox ( \"Горбов: Занятой? Приходи еще.\", 255,255,255 )", "0", "", "0", "" )
		-- else
		--	showQuestWindow ( "Горбов", "Конечно! Всего 15000 крышек и один из двух экземпляров \"Горбомет - 1\" будет твоим! Хотя, для тебя 5000 крышек, мне ведь механик рассказывал, что ты сделал.", "У меня не столько денег", "outputChatBox ( \"Горбов: Приходи в другой раз!\", 255,255,255 )", "0", "", "0", "", "0", "" )
		-- end
	-- else
		-- if exports.inventory:getPlayerCaps ( ) > 5000 then
			-- showQuestWindow ( "Горбов", "Конечно! Всего 15000 крышек и один из двух экземпляров \"Горбомет - 1\" будет твоим!", "Вот твои деньги", "gorbov_s_give_RC( 2 )", "Как-нибуть в другой раз", "outputChatBox ( \"Горбов: Занятой? Приходи еще.\", 255,255,255 )", "0", "", "0", "" )
		-- else
			-- showQuestWindow ( "Горбов", "Конечно! Всего 15000 крышек и один из двух экземпляров \"Горбомет - 1\" будет твоим!", "У меня не столько денег", "outputChatBox ( \"Горбов: Приходи в другой раз!\", 255,255,255 )", "0", "", "0", "", "0", "" )
		-- end
	-- end
end

function gorbov_s_give_RC ( coll )
	exports.players:givePlayerXPClient ( 50 )
	if coll == 1 then
		triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 5000 )
	else
		triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 15000 )
	end
	exports.inventory:givePlayerItemWW ( 39, 1 )
	showQuestWindow ( "Горбов", "Держи. Я думаю ты парень толковый, сам поймешь как им пользоваться. Вот только есть проблемка с зарядами для него.", "А что с ними не так?", "gorbov_s_pr_RC()", "0", "", "0", "", "0", "" )
end

function gorbov_s_pr_RC ()
	showQuestWindow ( "Горбов", "Патроны тут особенные, их надо получать из эссенции синих, взрывных гулей или из эссенции когтей смерти. Для этого надо в специальных баках смешать зараженную воду и эту самую эссенцию, сделать это можно на \"Рукоблуде\". Воду и бачки можешь купить у меня. Эссенцию придется собирать с дохлых синих гулей и когтей смерти.", "Хорошо", "gorbov_s_fin_RC()", "0", "", "0", "", "0", "" )
end

function gorbov_s_fin_RC ()
	setElementData ( localPlayer, "quest_fire", 1 )
	outputChatBox ( "Горбов: Буду ждать тебя.", 255,255,255 )
end

-- Перкинс

function perk_talk_RC ()
	showQuestWindow ( "Карл Перкинс", "Ты в отделении Караванщиков Ривет Сити. Что надобно?", "Довезете меня до Новой Дервени?", "perk_drive_Carn_Q()", "Могу я продать вам товары?", "perk_sell_RC()", "Как тут ваше отделение?", "perk_feel_RC()", "Ничего", "" )
end

function perk_drive_Carn_Q ()
	showQuestWindow ( "Карл Перкинс", "Конечно, отправим тебя вместе со следующим караваном. Стоить тебе это будет 350 крышек", "Поехали", "perkins_NC_Carn_Q()", "Я передумал", "", "0", "", "0", "" )
end

function perkins_NC_Carn_Q()
	if moveAvailable == 1 then
		if exports.inventory:getPlayerCaps ( ) >= 350 then
			moveToNC_Perkins_Carn_Q()
		else
			showQuestWindow ( "Карл Перкинс", "Денег не хватает? Ничем не могу помочь.", "Арррр", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Карл Перкинс: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function moveToNC_Perkins_Carn_Q ()
	triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 350 )
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
					triggerServerEvent ( 'clearPlayerInterior', localPlayer )
					outputChatBox ("Караванщик: Приехали в Новую Деревню, будь тут осторожен.", 255,255,255 )
					setTimer ( function() moveAvailable = 1 end, 600000, 1 )
				end, 4000, 1 )
end

function perk_spec_RC ()
	outputChatBox ( "Карл Перкинс: Кое-что завезут завтра.", 255,255,255 )
end

function perk_sell_RC ()
	outputChatBox ( "Карл Перкинс: Давай посмотрим, что там у тебя есть.", 255,255,255 )
	--exports.traders:showSellWindow (6)
end

function perk_feel_RC ()
	showQuestWindow ( "Карл Перкинс", "Очень даже хорошо, тут торговля идет даже лучше, чем на Торговом Посту в Лас Вентурасе. С города постоянно идут искатели, готовые продать свои находки за копейки, а все гули, зачем-то уходят из города на север.", "Есть что-нибуть особенное?", "perk_spec_RC()", "Могу я продать вам товары?", "perk_sell_RC()", "Спасибо", "outputChatBox ( \"Карл Перкинс: Всегда пожалуйста\", 255,255,255 )", "0", "" )
end
