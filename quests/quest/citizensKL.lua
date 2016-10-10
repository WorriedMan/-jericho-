local localPlayer = getLocalPlayer ()

-- Сайаг

function syag_talk_KL ()
	showQuestWindow ( "Сайаг", "Что привело тебя в бар \'Золотой Гекко\'?", "Я хотел бы купить выпивки", "exports.traders:showTraderWindow(\"sayag\")", "Золотой Гекко? Странное название.", "syag_t_gekko_KL()", "Есть работенка?", "syag_t_work_KL()", "Ничего", "" )
end

function syag_t_gekko_KL ()
	showQuestWindow ( "Сайаг", "Это мое прозвище, я его получил в честь того, что частенько \"находил\" золото в чужих банковских ячейках. Да... Вот это было время... Но сейчас я уже завязал с этим и держу вот этот бар.", "Я хотел бы купить выпивки", "exports.traders:showTraderWindow(\"sayag\")", "Есть работенка?", "syag_t_work_KL()", "Ничего", "", "0", "" )
end

function syag_t_work_KL ()
	showQuestWindow ( "Сайаг", "Есть кое-что интересное. По ночам к нам сюда заходит один парень, говорят, что он ищет смелого искателя преключений для того, чтоб разобраться с одной бандой местной. Обычно он приходит около 23:00 и уходит примерно в 04:00.", "Я хотел бы купить выпивки", "exports.traders:showTraderWindow(\"sayag\")", "Золотой Гекко? Странное название.", "syag_t_gekko_KL()", "Спасибо за информацию", "", "0", "" )
end


-- Боб Райт
function right_s_KL ()
	showQuestWindow ( "Боб Райт", "Заработать не хочешь?", "Неожиданно. Что от меня требуется?", "right_s_yes_KL()", "Нет", "outputChatBox ( \"Боб Райт: Жаль, я хотел предложить неплохие деньги\", 255,255,255 )", "0", "", "0", "" )
end

function right_s_yes_KL ()
	showQuestWindow ( "Боб Райт", "Все очень просто. Отправляешся в соседнюю деревню Монтгомери, врываешся в старую пиццерию, убиваешь там всех, возвращаешся ко мне за деньгами.", "Какова награда?", "right_s_rew_KL()", "Звучит неплохо", "right_s_rew_KL()", "0", "", "0", "" )
end

function right_s_rew_KL ()
	showQuestWindow ( "Боб Райт", "В качестве награды я дам тебе 3000 крышек и подарок, потом узнаешь что в нем.", "Я берусь за это задание", "right_s_begin_KL()", "Мне это не интересно", "outputChatBox ( \"Боб Райт: Жаль, если передумаешь, то я жду тебя тут\", 255,255,255 )", "0", "", "0", "" )
end

function right_s_begin_KL ()
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_prob", 1)
	exports.pipboy:addInfoBox("Получено задание \"Небольшая проблема\"", 3 )
	updateCompassAdditMarker ( 7, 1 )
end

function right_med_KL ()
	showQuestWindow ( "Боб Райт", "Раз ты пришел, значит с бандитами в кафе покончено?", "Да, они все мертвы", "right_m_start_KL()", "Нет еще", "outputChatBox ( \"Боб Райт: Жаль, я жду тебя тут\", 255,255,255 )", "0", "", "0", "" )
end

function right_m_start_KL ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 1500 )
	showQuestWindow ( "Боб Райт", "Отлично, но, пока ты ходил, у меня появилась новая миссия для тебя. Вот часть награды.", "Мы договаривались только об одном задании", "right_m_one_KL()", "Какое?", "right_m_ok_KL()", "0", "", "0", "" )
end

function right_m_one_KL ()
	showQuestWindow ( "Боб Райт", "Ладно, я увеличу награду до 4000 тысяч, если ты выполнишь еще одно мое задание.", "Ну давай тогда, выкладывай", "right_m_ok_KL()", "Какое?", "right_m_ok_KL()", "0", "", "0", "" )
end

function right_m_ok_KL()
	showQuestWindow ( "Боб Райт", "Недавно один грузовик каравнщиков проезжал по той деревне, вез он гигантских устриц, а я их просто обожаю. Но этот грузовик разбился, а гули, насколько мне известно, совершенно случайно разнесли этих устриц по всей деревне. Значит слушай сюда, привези мне 5 устриц, тогда получишь свою полную награду.", "Хорошо", "right_med_start_KL()", "Куда мне деваться-то", "right_med_start_KL()", "0", "", "0", "" )
end

function right_med_start_KL ()
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_prob", 4)
	updateCompassAdditMarker ( 7, 4 )
	createOystersKlamat ()
end

function right_fin_KL()
	showQuestWindow ( "Боб Райт", "Я уже чую запах устриц! Давай их сюда!", "Для начала ты давай деньги", "right_fin_money_KL()", "В другой раз", "", "0", "", "0", "" )
end

function right_fin_money_KL ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 2500 )
	showQuestWindow ( "Боб Райт", "Да-да, вот твои 2500 крышек. А теперь давай мне мои устрицыыыы.", "Вот, все пять штук.", "right_finito_KL()", "Вот, но ты обещал еще и подарок", "right_f_gift_KL()", "0", "", "0", "" )
end

function right_f_gift_KL ()
	exports.inventory:givePlayerItem ( 22, 1 )
	showQuestWindow ( "Боб Райт", "Вот бутылка зараженной воды, а теперь не отвлекай меня.", "ЧТО?!", "right_finito_KL()", "0", "", "0", "", "0", "" )
end

function right_finito_KL ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_prob", 6)
	updateCompassAdditMarker ( 7, 6 )
	exports.achievments:givePoint ( 1 )
	outputChatBox ( "Боб Райт: Все, отвали от меня.", 255,255,255 )
end

-- Дантоны

function bdan_talk_KL ()
	showQuestWindow ( "Бак Дантон", "Не хочешь посмотреть на оружие Дантонов?", "Да, покажи мне ассортимент", "exports.traders:showTraderWindow(\"klamat_weap\")", "Я хочу молот как у Бака", "bdan_t_molot_KL()", "Я лучше пойду", "", "0", "" )
end

function bdan_t_molot_KL ()
	showQuestWindow ( "Бак Дантон", "Молот? Конечно, всего 3000 крышек, и он твой!", "Вот, держи", "bdan_t_give_KL()", "Покажи мне свой ассортимент", "exports.traders:showTraderWindow(25)", "Я лучше пойду", "", "0", "" )
end

function bdan_t_give_KL ()
	if exports.inventory:getPlayerCaps () >= 3000 then
		outputChatBox ( "Бак Дантон: Отлично, приятно иметь с тобой дело.", 255,255,255 )
		exports.inventory:givePlayerItemWW ( 41, 1 )
		triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 3000 )
	else
		outputChatBox ( "Бак Дантон: Когда будут деньги, тогда и приходи.", 255,255,255 )
	end
end

function cdan_talk_KL ()
	showQuestWindow ( "Чак Дантон", "Проходи в наш магазин оружия, у нас только самые редки товары, чего только стоит молот!", "А, это ты, Бак?", "outputChatBox ( \"Чак Дантон: Шуруй отсюда шутник!\", 255,255,255 )", "Пойду, ознакомлюсь", "", "0", "", "0", "" )
end
-- Кларксон 

function jer_talk_KL ()
	if getElementData ( localPlayer, "quest_prob" ) == 7 then
		showQuestWindow ( "Пол Мидлтон", "О, дак это же наш герой! Чем могу помочь?", "Как у вас тут с преступностью?", "jer_t_crime_KL()", "Есть работенка для наемника?", "jer_t_work_KL()", "Ничего", "", "0", "" )
	else
		showQuestWindow ( "Пол Мидлтон", "Здравствуйте, вы находитесь в полицейском участке города Кламат. Я Пол Мидлтон. Чем могу помочь?", "Как у вас тут с преступностью?", "jer_t_crime_KL()", "Есть работенка для наемника?", "jer_t_work_KL()", "Ничего", "", "0", "" )	
	end
end

function jer_t_crime_KL ()
	if getElementData ( localPlayer, "quest_prob" ) == 6 then
		showQuestWindow ( "Пол Мидлтон", "Достаточно спокойно. Не так, конечно, как в пустыне, но жить можно. Даже набега бандитов уже недели две не было. Единственное, что ослажняет жизнь - это появление банды Великих Ханов в соседней деревеньке.", "Дак это-ж я с ними разобрался", "jer_t_reward_KL()", "Есть работенка для наемника?", "jer_t_work_KL()", "Ничего", "", "0", "" )
	elseif getElementData ( localPlayer, "quest_prob" ) == 7 then
		showQuestWindow ( "Пол Мидлтон", "Достаточно спокойно. Не так, конечно, как в пустыне, но жить можно. Даже набега бандитов уже недели две не было. Да еще и ты с бандой Великих Ханов в соседней деревне расправился, вобщем тишь и благодать.", "Да, вот такой я, герой", "outputChatBox ( \"Джереми Кларкосн: Смотри не зазвездись\", 255,255,255 )", "Есть работенка для наемника?", "jer_t_work_KL()", "0", "", "0", "" )
	else
		showQuestWindow ( "Пол Мидлтон", "Достаточно спокойно. Не так, конечно, как в пустыне, но жить можно. Даже набега бандитов уже недели две не было. Единственное, что ослажняет жизнь - это появление банды Великих Ханов в соседней деревеньке.", "Спасибо за информацию", "", "Есть работенка для наемника?", "jer_t_work_KL()", "0", "", "0", "" )
	end
end

function jer_t_reward_KL ()
	exports.players:givePlayerXPClient ( 200 )
	exports.inventory:givePlayerItem ( 46, 30 )
	setElementData ( localPlayer, "quest_prob", 7 )
	showQuestWindow ( "Пол Мидлтон", "Ты? Ничего себе. Молодец. Вот, возьми 30 патронов для дробовика в подарок.", "Да, вот такой я, герой", "outputChatBox ( \"Джереми Кларкосн: Смотри не зазвездись\", 255,255,255 )", "Есть работенка для наемника?", "jer_t_work_KL()", "0", "", "0", "" )
end

function jer_t_work_KL ()
	showQuestWindow ( "Пол Мидлтон", "Нет, ничего особенного нет, в поселении все спокойно.", "Как у вас тут с преступностью?", "jer_t_crime_KL()", "Да? Жалко", "", "0", "", "0", "" )
end

-- Мэр

function mayor_talk_KL ()
	outputChatBox ( "Мэр: Извините, я жду важную встречу", 255, 255, 255 )
	--showQuestWindow ( "Мэр", "Нет, ничего особенного нет, в поселении все спокойно.", "Как у вас тут с преступностью?", "jer_t_crime_KL()", "Да? Жалко", "", "0", "", "0", "" )
end 

-- Джерико

-- function jericho_talk_KL ()
	-- showQuestWindow ( "Jerry", "Somebody new? And still alive?", "Tell me about this settlement", "jeho_tkl_KL()", "I want to know...", "jeho_abo_KL()", "Who are you?", "jeho_self_KL()", "Bye", "" )
-- end

-- function jericho_quest_KL ()
	-- showQuestWindow ( "Jerry", "Good day, my friend", "Tell me about this city", "jeho_tkl_KL()", "I want to know...", "jeho_abo_KL()", "Who are you?", "jeho_self_KL()", "Bye", "" )
-- end

-- function jeho_tkl_KL ()
	-- showQuestWindow ( "Jerry", "Yes..", "Where are the caravaners?", "jeho_tkl_car_KL()", "Where is the hostel?", "jeho_tkl_hot_KL()", "Who are in chief here??", "jeho_tkl_chief_KL()", "Is there something special?", "jeho_tkl_spec_KL()" )
-- end

-- function jeho_tkl_car_KL()
	-- showQuestWindow ( "Jerry", "Yea, those bastards are at the end of the main street.", "Sounds like you don't like them", "jeho_tkl_car_hate_KL()", "I have another question", "jericho_quest_KL()", "Thank you for information", "", "0", "" )
-- end

function jericho_talk_KL ()
	showQuestWindow ( "Джерико", "Новенький у нас? Есть вопросы?", "Расскажи мне о Кламате", "jeho_tkl_KL()", "Я хотел бы узнать о...", "jeho_abo_KL()", "Я хочу спросить о тебе", "jeho_self_KL()", "Ничего", "" )
end

function jericho_quest_KL ()
	showQuestWindow ( "Джерико", "Говори", "Расскажи мне о Кламате", "jeho_tkl_KL()", "Я хотел бы узнать о...", "jeho_abo_KL()", "Я хочу спросить о тебе", "jeho_self_KL()", "Ничего", "" )
end

function jeho_tkl_KL ()
	showQuestWindow ( "Джерико", "Ну", "У вас в городе есть караванщики?", "jeho_tkl_car_KL()", "Где я могу снять койку?", "jeho_tkl_hot_KL()", "Кто здесь главный?", "jeho_tkl_chief_KL()", "Что-нибуть тут особенное есть?", "jeho_tkl_spec_KL()" )
end

function jeho_tkl_car_KL()
	showQuestWindow ( "Джерико", "Да, эти засранцы стоят в конце главной улицы.", "Почему ты их так не долюбливаешь?", "jeho_tkl_car_hate_KL()", "У меня есть еще вопрос", "jericho_quest_KL()", "Спасибо за информацию", "", "0", "" )
end

function jeho_tkl_car_hate_KL ()
	showQuestWindow ( "Джерико", "Я всех недолюбливаю, сечёшь парень?", "Ладно-ладно...", "", "У меня есть еще вопрос", "jericho_quest_KL()", "0", "", "0", "" )
end

function jeho_tkl_hot_KL ()
	showQuestWindow ( "Джерико", "Можешь переночевать у Салли Уилсон в гостиннице, она находится в одном из зданий главной улицы. Цены конечно не маленькие, но это лучшая гостинница во всем штате.", "Спасибо за информацию", "", "У меня есть еще вопрос", "jericho_quest_KL()", "0", "", "0", "" )
end

function jeho_tkl_chief_KL ()
	showQuestWindow ( "Джерико", "Мистер Берк, его ты можешь найти в здании администрации на главной улице. Но чую я, что скоро поменяется тут власть. Час, когда Джон Генри Эдем станет президентом все ближе.", "Спасибо за информацию", "", "У меня есть еще вопрос", "jericho_quest_KL()", "Кто такой Джон Генри Эдем?", "jericho_q_edem_KL()", "0", "" )
end

function jericho_q_edem_KL ()
	showQuestWindow ( "Джерико", "Да так, парень один. Знаешь, я жил в этой деревни с рождения. Еще до всех этих событий она называлась Паломино Крик. Я до этого ни разу не видел этого Эдема. А после того, как рак на горе свистнул, он внезапно появился. Ладно, не хочу я об этом говорить.", "Спасибо за информацию", "", "У меня есть еще вопрос", "jericho_quest_KL()", "А ты случаем не из Новой Деревни?", "jeho_q_nc_KL()", "0", "" )
end

function jeho_q_nc_KL ()
	showQuestWindow ( "Джерико", "Ээ, я не хочу об этом говорить. Короче, либо мы переводим разговор в другое русло, либо ты сваливаешь.", "Я предпочту свалить", "", "Давай поговорим о другом.", "jericho_quest_KL()", "0", "", "0", "" )
end

function jeho_tkl_spec_KL ()
	showQuestWindow ( "Джерико", "А что рассказывать? Город как город, у нас есть своя тюрьма, ты её наверно уже видел, она около ворот, шериф, паб, поехавший Джон Генри Эдем, который хочет стать приездентом \"Новой Америки\", и ещё много чего.", "Спасибо за информацию", "", "Давай поговорим о другом.", "jericho_quest_KL()", "0", "", "0", "" )
end

function jeho_abo_KL ()
	showQuestWindow ( "Джерико", "Ну", "Где здесь можно купить продукты?", "jeho_ab_food_KL()", "Где здесь можно преобрести медикаменты?", "jeho_ab_med_KL()", "Где я могу купить оружие?", "jeho_ab_weap_KL()", "0", "" )
end

function jeho_ab_food_KL ()
	showQuestWindow ( "Джерико", "Жратвы ты можешь прикупить у Сайага в пабе. Странный он конечно тип, всем говорит, что он ирландец, поэтому и называет свою забегаловку пабом. А вобще не советую парень, говорят она торгует человечиной, а то и гулятиной, выдавая её за консервы, да тушонку.", "Вот дерьмо, и что мне теперь жрать?", "jeho_ab_food_shit_KL()", "Я не брезгую, могу и человечины поесть", "jeho_ab_food_man_KL()", "Мне кажется, это всё чушь", "jeho_ab_food_sin_KL()", "0", "" )
end

function jeho_ab_food_shit_KL ()
	showQuestWindow ( "Джерико", "Спроси у караванщиков в конце главной улицы, у них наверняка найдётся что нибудь съедобное.", "Спасибо за информацию", "", "Давай поговорим о другом.", "jericho_quest_KL()", "0", "", "0", "" )
end

function jeho_ab_food_man_KL ()
	showQuestWindow ( "Джерико", "Ну, если подумать, то ты прав. Времена такие, что есть - выбирать не приходится.", "Спасибо за информацию", "", "Давай поговорим о другом.", "jericho_quest_KL()", "0", "", "0", "" )
end

function jeho_ab_food_sin_KL ()
	showQuestWindow ( "Джерико", "Иди и проверь, ха-ха-ха.", "Спасибо за информацию", "", "Давай поговорим о другом.", "jericho_quest_KL()", "0", "", "0", "" )
end 

function jeho_ab_med_KL ()
	showQuestWindow ( "Джерико", "У Дока Митчела на внутренней улице города, но цены он явно задирает, так что лучше обратись к Караванщикам, они возят достаточно дешевые медикаменты из Союза Ученых и с Торгового Поста.", "Спасибо за информацию", "", "У меня есть еще вопрос", "jericho_quest_KL()", "0", "", "0", "" )
end

function jeho_ab_weap_KL ()
	showQuestWindow ( "Джерико", "Лавка Чака и Бака Дантонов находится на внутренней улице, рядом со сценой. Цены в последнее время хорошие, уж не знаю где они оружие берут. Да еще и супер-кувалду продают. Но вот только запомни одну вещь - не перепутай их, они блезнецы.", "Спасибо за информацию", "", "У меня есть еще вопрос", "jericho_quest_KL()", "0", "", "0", "" )
end

function jeho_self_KL ()
	showQuestWindow ( "Джерико", "Да что я могу о себесказать. Всю жизнь провел тут, в Паломино Крик. Потом началась вся эта кутерьма с гулями и радиацией. Мне пришлось бежать из родных краев на север, в Лас Вентурас. Когда ситуация более-менее нормализовалась, я приехал сюда вместе с караваном. Сейчас подрабатываю всяким мелким трудом.", "Спасибо за информацию", "", "У меня есть еще вопрос", "jericho_quest_KL()", "0", "", "0", "" )
end

-- Салли Уилсон

function sally_talk_KL ()
	if getElementData ( localPlayer, "nat" ) == 7 then
		outputChatBox ( "Салли Уилсон: Спасибо за аренду комнаты в моей гостиннице, вот ваш чек", 255, 255, 255 )
	else
		showQuestWindow ( "Салли Уилсон", "Здравствуйте. Вы находитесь в гостиннице города Кламат. Я предоставляю аренду комнаты за 80 крышек за ночь. Сервис у нас отменный: есть душ, туалет, у всех отдельные комнаты с кроватью, стулом и столом.", "Пожалуй, я арендую", "sally_t_rent_KL()", "Спасибо, не надо", "outputChatBox ( \"Салли Уилсон: Заходите в другой раз тогда, у нас есть свободные комнаты\", 255,255,255) ", "0", "", "0", "" )
	end
end

function sally_t_rent_KL ()
	outputChatBox ( "Салли Уилсон: Отлично, ваша комната вторая слева.", 255,255,255 )
	exports.pipboy:addInfoBox ( "Теперь вы будете появлятся в Гостиннице Кламата за 80 крышек.", 3 )
	setElementData ( localPlayer, "nat", 7 )
end

-- Виски Боб

function whis_tell_KL ()
	if getElementData ( localPlayer, "quest_whiskey" ) == 0 then
		if exports.inventory:getPlayerCaps () > 100 then
			showQuestWindow ( "Виски-Боб", "Здорова. Не угостишь выпивкой старого вояку Виски-Боба?", "Без проблем (100 КР.)", "whis_drink_KL()", "Сам себе выпивку покупай", "", "0", "", "0", "" )
		else
			showQuestWindow ( "Виски-Боб", "Здорова. Не угостишь выпивкой старого вояку Виски-Боба?", "У меня нет денег", "", "Сам себе выпивку покупай", "", "0", "", "0", "" )
		end
	elseif getElementData ( localPlayer, "quest_whiskey" ) == 3 then
		showQuestWindow ( "Виски-Боб", "Ну что, как там наше небольшое дельце?", "Там не было никакого аппарата, только записка", "whis_ready_letter_KL()", "Я все сделал как ты просил", "whis_ready_lie_KL()", "0", "", "0", "" )
	elseif getElementData ( localPlayer, "quest_whiskey" ) == 5 then
		showQuestWindow ( "Виски-Боб", "Я недавно встретил людей Вилли, они сказали, что вернули самогонный аппарат. Спасибо тебе, дружище!", "Да без проблем. Где моя награда?", "whis_fin_reward_KL()", "Да без проблем, мне и награду за это не надо", "whis_fin_no_reward_KL()", "0", "", "0", "" )
	end
end

function whis_fin_no_reward_KL ()
	exports.inventory:givePlayerItemWW (13,1)
	outputChatBox ( "Виски-Боб: Правда?! Уважаю. Но возьми эту бутылку. От заведения.", 255,255,255 )
	setElementData ( localPlayer, "quest_whiskey", 6 )
	exports.achievments:givePoint ( 1 )
	exports.players:givePlayerXPClient ( 1000 )
	exports.pipboy:addInfoBox ( "Задание \"Левый бизнес\" завершено.", 3 )
end


function whis_fin_reward_KL ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 5000 )
	setElementData ( localPlayer, "quest_whiskey", 6 )
	exports.achievments:givePoint ( 1 )
	exports.players:givePlayerXPClient ( 300 )
	exports.pipboy:addInfoBox ( "Задание \"Левый бизнес\" завершено.", 3 )
	outputChatBox ( "Виски-Боб: Заходи когда будешь в Кламате, выпьем вместе.", 255,255,255 )
end

function whis_ready_lie_KL ()
	if math.random ( 1, 2 ) == 1 then
		showQuestWindow ( "Виски-Боб", "Спасибо, дружище, вот твоя награда.", "Там не было никакого аппарата, только записка", "whis_ready_letter_KL()", "Без проблем, дружище.", "whis_ready_lie_fin_KL()", "0", "", "0", "" )
	else
		showQuestWindow ( "Виски-Боб", "Слушай, я врунов за километр чую. Что-то ты темнишь.", "Там не было никакого аппарата, только записка", "whis_ready_letter_KL()", "Я? Вру? Другу? Никогда!", "whis_ready_lie_no_KL()", "0", "", "0", "" )
	end
end

function whis_ready_lie_no_KL ()
	if math.random ( 1, 2 ) == 1 then
		showQuestWindow ( "Виски-Боб", "Извиги тогда. Спасибо, дружище, вот твоя награда.", "Там не было никакого аппарата, только записка", "whis_ready_letter_KL()", "Без проблем, дружище.", "whis_ready_lie_fin_KL()", "0", "", "0", "" )
	else
		outputChatBox ( "Виски-Боб: Так, все, иди отсюда. Я сам разберусь.", 255,255,255 )
		setElementData ( localPlayer, "quest_whiskey", 6 )
		exports.pipboy:addInfoBox ( "Задание \"Левый бизнес\" завершено.", 3 )
	end
end

function whis_ready_lie_fin_KL ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 5000 )
	exports.inventory:givePlayerItemWW (13,2)
	setElementData ( localPlayer, "quest_whiskey", 6 )
	exports.achievments:givePoint ( 1 )
	exports.pipboy:addInfoBox ( "Задание \"Левый бизнес\" завершено.", 3 )
	exports.players:givePlayerXPClient ( 1000 )
end

function whis_ready_letter_KL()
	showQuestWindow ( "Виски-Боб", "Ох уж этот Вилли...", "Что ему от тебя надо?", "whis_ready_letter_need_KL()", "0", "", "0", "", "0", "" )
	exports.inventory:removePlayerItem ( 121, 1 )
end


function whis_ready_letter_need_KL()
	showQuestWindow ( "Виски-Боб", "Когда я был в Роадтауне последний раз, я прихватил у него один непонятный предмет. Я так и не понял что с ним делать. Иди и обменяй его на мой аппарат. За это я заплачу тебе 5000 крышек.", "Уже отправляюсь", "whis_ready_go_KL()", "0", "", "0", "", "0", "" )
	exports.inventory:removePlayerItem ( 121, 1 )
end

function whis_ready_go_KL ()
	setElementData ( localPlayer, "quest_whiskey", 4 )
	exports.inventory:givePlayerItemWW (122,1)
	exports.players:givePlayerXPClient ( 200 )
	exports.pipboy:addInfoBox ( "Отправляйтесь в Роадтаун.", 3 )
end

function whis_drink_KL ()
	exports.inventory:givePlayerItemWW (11,1)
	--setPedAnimation ( npcPeds["wbob"], "VENDING", "VEND_Drink2_P", -1, false, false, false, true )
	showQuestWindow ( "Виски-Боб", "Вот это я понимаю Ч-Е-Л-О-В-Е-К! Можно даже сказать К-Р-У-Т-О-Й П-А-Р-Е-Н-Ь. С-П-А-С-И-Б-О тебе.", "У меня к тебе есть пара В-О-П-Р-О-С-О-В.", "whis_quest_KL()", "Да я тоже люблю бухнуть", "outputChatBox ( \"Виски-Боб: Приходи тада еще.\", 255,255,255)", "0", "", "0", "" )
end

function whis_quest_KL ()
	local work = "0"
	if getElementData ( localPlayer, "quest_whiskey" ) == 0 then
		work = "Может есть какая работенка?"
	end
	showQuestWindow ( "Виски-Боб", "Валяй. Кто заказывает выпивку, тот и задает вопросы.", "Я тут недавно был в Новом Вегасе...", "whis_vegas_KL()", "За кого ты будешь голосовать?", "whis_vote_KL()", "Спасибо, но мне уже пора.","", work, "whis_work_KL()" )
end

function whis_vegas_KL ()
	local work = "0"
	if getElementData ( localPlayer, "quest_whiskey" ) == 0 then
		work = "Может есть какая работенка?"
	end
	showQuestWindow ( "Виски-Боб", "Даже не говори мне про этот город. Ты нигде не найдешь такого скопища порока и лжи. Поэтому я надеюсь, что Генри станет нашим новым мэром и наведет там порядок.", "За кого ты будешь голосовать?", "whis_vote_KL()", "Спасибо, но мне уже пора.","", work, "whis_work_KL()", "0", "" )
end

function whis_vote_KL ()
	local work = "0"
	if getElementData ( localPlayer, "quest_whiskey" ) == 0 then
		work = "Может есть какая работенка?"
	end
	showQuestWindow ( "Виски-Боб", "Конечно за Генри! Он обещает горы золотые нам, как же я могу за него не проголосовать??!", "Я тут недавно был в Новом Вегасе...", "whis_vegas_KL()", "Спасибо, но мне уже пора.", "", work, "whis_work_KL()", "0", "" )
end

function whis_work_KL ()
	showQuestWindow ( "Виски-Боб", "Есть кое-что...", "Ну давай же, не томи", "whis_work_2_KL()", "Тормоз, мне уже надо уходить.","", "0", "", "0", "" )
end

function whis_work_2_KL ()
	showQuestWindow ( "Виски-Боб", "Видишь ли, у меня небольшой левый бизнес, а я сейчас не могу уделить ему внимание. Недалеко от города у меня есть самогонный аппарат, и туда сейчас пора снова подкинуть дров. Допустим я дам тебе 500 крышек и две бутыли самогона если ты это сделаешь.", "Хорошо, я сделаю это", "whis_work_start_KL()", "А как я найду его?", "whis_work_howtofind_KL()","0", "","0","" )
end


function whis_work_howtofind_KL ()
	showQuestWindow ( "Виски-Боб", "Я поставлю тебе отметку на PipBoy", "Хорошо, я сделаю это", "whis_work_start_KL()", "Я не буду этого делать", "","0", "", "0", "" )
end

function whis_work_start_KL ()
	exports.inventory:givePlayerItemWW (120,1)
	outputChatBox ( "Виски-Боб: Вот тебе дрова. Как только заправишь, приходи ко мне за наградой.", 255,255,255 )
	exports.pipboy:addInfoBox ( "Получено задание \"Левый бизнес\"", 3 )
	setElementData ( localPlayer, "quest_whiskey", 1 )
	samogonApparat = createColSphere (2161,-104, 2, 7 )
	updateCompassAdditMarker (10,1)
			samogonIcon = exports.pipboy:addMapIcon ( 2161,-104, 2, 3, 'Самогон' ) or 0 
			addEventHandler("onClientColShapeHit",samogonApparat,
			function () 
				exports.pipboy:addInfoBox ( 'Аппарата нет, но вы находите записку', 2 )
				exports.inventory:givePlayerItemWW ( 121, 1 )
				outputChatBox ("Информация: Прогресс сохранен", 0,153,51 )
				destroyElement ( samogonApparat )
				exports.players:givePlayerXPClient ( 100 )
				setElementData ( localPlayer, 'quest_ring', 3 )
				exports.pipboy:deleteMapIcon ( samogonIcon )
			end)
end