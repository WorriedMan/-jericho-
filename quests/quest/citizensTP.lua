local localPlayer = getLocalPlayer ()

-- Новый Вегас

-- Гражданский Комендант

function bobby_talk_TP ()
	showQuestWindow ( "Бобби Чарльтон", "Рады приветствовать тебя в магазине продуктов Караванщиков. У нас самые лучшие продукты во всей округе. Чем могу помочь?", "Покажи мне, что вы продаете.", "exports.traders:showTraderWindow(\"caravan_food\")", "Ничем, извини, что побеспокоил.", "", "0", "", "0", "" )
end

function bobby_find_TP ()
	showQuestWindow ( "Бобби Чарльтон", "Рады приветствовать тебя в магазине продуктов Караванщиков. У нас самые лучшие продукты во всей округе. Чем могу помочь?", "Меня сюда послал бармэн Мегатонны", "bobby_find_rem_TP()", "Покажи мне, что вы продаете.", "exports.traders:showTraderWindow(\"caravan_food\")", "Ничем, извини, что побеспокоил.", "", "0", "" )
end

function bobby_find_rem_TP ()
	showQuestWindow ( "Бобби Чарльтон", "А я все ждал, когда же он пошлет кого-нибуть на мои поиски. Ну что-ж, передай ему, что я теперь один из Караванщиков и не буду работать на него.", "Почему ты сделал выбор не в пользу Нового Вегаса?", "bobby_find_nv_TP()", "Хорошо, передам.", "bobby_find_ok_TP()", "0", "", "0", "" )
end

function bobby_find_nv_TP ()
	showQuestWindow ( "Бобби Чарльтон", "Ну, может Караванщики платят и меньше, но здесь гораздо безопаснее. Зомби меньше, бандитов меньше, в городе нет никакой радиации, а мне уже лет то много. Просто хочется дожить свои годы, никого не трогая, ни с кем не воюя, и где-нибуть здесь умереть от старости, а не от шальной пули, как это часто случается в пустыне.", "Возможно ты прав. Я передам ему.", "bobby_find_ok_TP()", "Нет, ты не прав, но я передам что ты сказал.", "bobby_find_ok_TP()", "0", "", "0", "" )
end

function bobby_find_ok_TP ()
	outputChatBox ("Бобби Чарльтон: Думай как хочешь.", 255,255,255 )
	setElementData ( localPlayer, "quest_findtp", 3 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	updateCompassAdditMarker ( 3, 3 )
end

-- Мэтси

function matsy_talk_TP ()
	showQuestWindow ( "Толстушка Мэтси", "Ммм... Давненько у меня не было такого аппетитного посетителя...", "Ээй, потише, я хочу только посмотреть на ваши лекарства.", "exports.traders:showTraderWindow(\"caravan_medic\")", "Толстушка Мэтси? А ты знаешь Толстушку Бэтси?", "matsy_batsy_TP()", "Лучше-ка я пойду отсюда", "", "0", "" )
end

function matsy_batsy_TP ()
	showQuestWindow ( "Толстушка Мэтси", "Эта жирная корова все-еще жива? Я ее сестра-близняшка. Но мы с ней поссорились и теперь она заняля, в прямом смысле, дом в Новой Деревне, а я работаю тут, на посту караванщиков.", "Покажи, что вы продаете", "exports.traders:showTraderWindow(\"caravan_medic\")", "Как интересно, но мне пора бежать.", "", "0", "", "0", "" )
end

-- Фриман
function freeman_find_and_coins_TP ()
	showQuestWindow ( "Морган Фриман", "Добро пожаловать на торговый пост караванщиков.", "Что это за место?", "freeman_place_TP()", "Я ищу Бобби Чарльтона", "freeman_find_a_TP()", "Помощь не нужна?", "freeman_coins_a_TP()", "И тебе не хворать.", "" )
end

function freeman_find_TP ()
	showQuestWindow ( "Морган Фриман", "Добро пожаловать на торговый пост караванщиков.", "Что это за место?", "freeman_place_TP()", "Я ищу Бобби Чарльтона", "freeman_find_a_TP()", "И тебе не хворать.", "", "0", "" )
end

function freeman_find_a_TP ()
	outputChatBox ("Морган Фриман: Пройди чуть дальше, он торгует продуктами.", 255,255,255 )
	setElementData ( localPlayer, "quest_findtp", 2 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	updateCompassAdditMarker ( 3, 2 )
end

function freeman_coins_TP ()
	showQuestWindow ( "Морган Фриман", "Добро пожаловать на торговый пост караванщиков.", "Что это за место?", "freeman_place_TP()", "Помощь не нужна?", "freeman_coins_a_TP()", "И тебе не хворать.", "", "Есть место в караване? Мне надо в Новый Вегас", "freeman_to_NV()" )
end

function freeman_to_NV ()
	if moveAvailable == 1 then
		if getElementData ( localPlayer, "nwkey" ) == 1 then
			if exports.inventory:getPlayerCaps ( ) >= 100 then
				moveToNV_Carn_Q()
			else
				showQuestWindow ( "Морган Фриман", "100 крышек стоит поездка, приходи когда они у тебя будут", "Не хватает немного...", "", "0", "", "0", "", "0", "" )
			end
		else
			showQuestWindow ( "Морган Фриман", "Без пропуска я не смогу тебя доставить в Новый Вегас.", "Ептэ", "", "0", "dylan_nv_Carn_Q()", "0", "", "0", "" )
		end
	else
		outputChatBox ("Морган Фриман: Приходи через некоторое время, нам надо подготовить автомобиль.", 255,255,255 )
		outputChatBox ("Поездку можно совершить один раз в 10 минут." )
	end
end

function freeman_coins_a_TP ()
	showQuestWindow ( "Морган Фриман", "Ну, мне бы пригодилась помощь. Видишь ли, я тут коллекционирую монетки из казино Сьерра Мадре, поэтому я готов заплатить тебе по 20 крышек за каждую такую монету.", "Вот это да, но как я узнаю эти монеты?", "freeman_coins_look_TP()", "0", "freeman_coins_a_TP()", "0", "", "0", "" )
end

function freeman_coins_look_TP ()
	exports.inventory:givePlayerItem ( 21, 1 )
	showQuestWindow ( "Морган Фриман", "Вот, держи одну такую монету, по ней ты поймешь как они выглядят.", "Ага, спасибо, как найду такие, обязательно приду к тебе", "freeman_coins_start_TP()", "0", "freeman_coins_a_TP()", "0", "", "0", "" )
end

function freeman_coins_start_TP ()
	outputChatBox ("Морган Фриман: Буду ждать тебя.", 255,255,255 )
	setElementData ( localPlayer, "quest_coins", 1 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
end

function freeman_coins_sell_TP ()
	showQuestWindow ( "Морган Фриман", "Принес мне монет Сьерра-Мадре?", "Вот, есть немного.", "freeman_coins_sell_true_TP()", "Нет пока", "", "0", "", "0", "" )
end

function freeman_coins_sell_true_TP ()
	local coinsQuant = exports.inventory:getItemAmount (21)
	exports.inventory:removePlayerItem ( 21, coinsQuant-1 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), coinsQuant*20 )
	outputChatBox ("Морган Фриман: Отлично, вот твои деньги. Буду ждать тебя еще.", 255,255,255 )
end

function freeman_meh_TP () 
	showQuestWindow ( "Морган Фриман", "Добрый день, что надо?", "Я ищу гайку J2 для GECK", "freeman_meh_find_TP()", "Ничего", "", "0", "", "0", "" )
end

function freeman_meh_find_TP ()
	showQuestWindow ( "Морган Фриман", "J2? Давненько я таких не встречал. Хотя, кажется у Марти Роббинса была одна такая. Он находится в Союзе Ученых, спроси у него.", "Спасибо за информацию", "freeman_meh_said_TP()", "Теперь в Союз переться...", "freeman_meh_said_TP()", "0", "", "0", "" )
end

function freeman_meh_said_TP ()
	showQuestWindow ( "Морган Фриман", "Погоди, а кому это она нужна?", "Механику из Ривет Сити", "freeman_meh_need_TP()", "Мне", "freeman_meh_begin_TP()", "Неважно", "freeman_meh_begin_TP()", "0", "" )
end

function freeman_meh_need_TP ()
	setElementData ( localPlayer, "meh_need", 1 )
	showQuestWindow ( "Морган Фриман", "Оу, ладно, отправляйся в Союз Ученых, там точно должна быть у Марти Роббинса", "Спасибо за информацию", "freeman_meh_begin_TP()", "0", "", "0", "", "0", "" )
end

function freeman_meh_begin_TP ()
	outputChatBox ("Морган Фриман: Удачи", 255,255,255 )
	setElementData ( localPlayer, "quest_meh", 2 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	updateCompassAdditMarker ( 6, 2 )
end

function freeman_talk_TP ()
	showQuestWindow ( "Морган Фриман", "Добро пожаловать на торговый пост Караванщиков.", "Что это за место?", "freeman_place_TP()", "И тебе не хворать.", "", "0", "", "0", "" )
end

function freeman_place_TP ()
	showQuestWindow ( "Морган Фриман", "Это вход в бункер, из этого бункера мы и берем все наши лекарства и еду. Благодоря этому, в нашем продуктовом магазине можно найти множество уникальных товаров.", "Спасибо за информацию", "", "0", "", "0", "", "0", "" )
end
