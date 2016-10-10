function meh_gen_start_RC ()
	showQuestWindow ( "Механик", "Здравствуй. Я так посмотрю ты не местный. Не можешь мне помочь?", "А что надо?", "meh_gen_s_say_RC()", "Я сейчас занят", "", "0", "", "0", "" )
end

function meh_gen_s_say_RC ()
	showQuestWindow ( "Механик", "Сломался у нас основной генератор тепла, вернее треснула от старости одна гайка, которую я нигде не могу найти. Слышал только, что на Торговом Посту у Караванщиков была одна, но, сам понимаешь, я не могу отлучиться из деревни, все системы корабля на мне.", "Какая будет награда, если я тебе ее принесу?", "meh_gen_s_rew_RC()", "Без проблем, я смотаюсь туда", "meh_gen_s_got_RC()", "0", "", "0", "" )
end

function meh_gen_s_rew_RC ()
	showQuestWindow ( "Механик", "Будет награда, очень хорошая, ты, главное, привези ее.", "Хорошо, я сделаю это", "meh_gen_s_got_RC()", "Без проблем, я смотаюсь туда", "meh_gen_s_got_RC()", "0", "", "0", "" )
end

function meh_gen_s_got_RC ()
	showQuestWindow ( "Механик", "Отлично! Спросишь на Торговом Посту про гайку J2 для GECK. Если не знаешь, где Торговый Пост находится, то спроси об этом у бармена в баре Мегатонна в Новом Вегасе.", "Отправляюсь", "meh_gen_s_RC()", "Я знаю где это", "meh_gen_s_RC()", "0", "", "0", "" )
end

function meh_gen_s_RC ()
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_meh", 1)
	exports.pipboy:addInfoBox("Получено задание \"Выходец из убежища\"", 3 )
	updateCompassAdditMarker ( 6, 1 )
end

function meh_gen_if_RC ()
	showQuestWindow ( "Механик", "Нашел деталь J2? Мы долго не продержимся без основной системы отопления.", "Нет еще", "", "Я пока и не искал", "", "0", "", "0", "" )
end

function rob_meh_Carn_Q ()
	showQuestWindow ( "Марти Роббинс", "Я смотрю, у тебя какие-то заинтересованные глаза. Что надо?", "Я ищу гайку J2 для GECK", "rob_meh_s_Carn_Q()", "Ты ошибся", "", "0", "", "0", "" )
end

function rob_meh_s_Carn_Q ()
	showQuestWindow ( "Марти Роббинс", "А, это про тебя говорил Морган Фриман? Странно, он сказал что должен подойти придурковатый парень, а ты на придурка не больно похож.", "Ну так она у тебя есть?", "rob_meh_no_Carn_Q()", "0", "", "0", "", "0", "" )
end

function rob_meh_no_Carn_Q ()
	showQuestWindow ( "Марти Роббинс", "Боюсь тебя рассторить, но у меня ее нет. Придется тебе ехать обратно в Лас Вентурас, мне говорил один странник, что в отеле Сфинкс есть коробка с различными деталями для GECK. Отель Сфинкс ты определишь по большой фигуре сфинкса.", "Спасибо за информацию, отправляюсь", "rob_meh_begin_Carn_Q()", "Опять переться за тридевять земель", "rob_meh_begin_Carn_Q()", "0", "", "0", "" )
end

local bennyTalk = true

function benny_talk_Meh ()
	if bennyTalk then
		bennyTalk = false
		outputChatBox ( "Бенни: А ты что тут делаешь? Вырубите его!", 255, 255, 255 )
		setTimer ( bennyTalkSt2, 3000, 1 )
	end
end

function bennyTalkSt2 ()
	fadeCamera ( false, 1 )
	setTimer ( bennyTalkSt3, 3000, 1 )
end

function bennyTalkSt3 ()
	setElementPosition ( localPlayer, 2239.0498046875,1285.396484375,10.8203125 )
	setElementDimension ( localPlayer, tonumber(getElementData ( localPlayer, "playerid" )) )
	outputChatBox ( "Тебя вырубили, прямо как в старые-добрые времена", 255, 255, 255 )
	setTimer ( bennyTalkSt4, 5000, 1 )
end

function bennyTalkSt4 ()
	outputChatBox ( "Вы слышите разговор" )
	setTimer ( bennyTalkSt5, 4000, 1 )
end

function bennyTalkSt5 ()
	outputChatBox ( "Великий Хан: Ну что, Бенни, куда мы теперь со всем этим хламом?", 255, 255, 255 )
	setTimer ( bennyTalkSt6, 8000, 1 )
end

function bennyTalkSt6 ()
	outputChatBox ( "Бенни: Продадим Джонни Кэшу, я думаю Караванщики хорошо заплатят за все это барахло", 255, 255, 255 )
	setTimer ( bennyTalkSt7, 11000, 1 )
end

function bennyTalkSt7 ()
	outputChatBox ( "Спустя два часа, вы приходите в себя", 255, 255, 255 )
	setTimer ( bennyTalkStFin, 4000, 1 )
end

function bennyTalkStFin ()
	fadeCamera ( true, 2 )
	setElementInterior ( localPlayer, 0 )
	setElementDimension ( localPlayer, 0 )
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_meh", 4)
	updateCompassAdditMarker ( 6, 4 )
end

function cash_meh_Carn_Q ()
	showQuestWindow ( "Джонни Кэш", "Привет, я Джонни Кэш.", "Я слышал, что у тебя есть деталь J2 для GECK", "cash_meh_yes_Carn_Q()", "...", "", "0", "", "0", "" )
end

function cash_meh_yes_Carn_Q ()
	showQuestWindow ( "Джонни Кэш", "Да, есть у меня одна такая деталь. Насколько я вижу по тебе, она тебе нужна. Так что я тебе ее не продам.", "ЧТО?", "cash_meh_clean_Carn_Q()", "Это как-же так?", "cash_meh_clean_Carn_Q()", "0", "", "0", "" )
end

function cash_meh_clean_Carn_Q ()
	showQuestWindow ( "Джонни Кэш", "Я тебе ее отдам просто так. Но только в том случае, если ты принесешь мне чистую зубную щетку.", "И где же мне ее взять?", "cash_meh_where_Carn_Q()", "0", "", "0", "", "0", "" )
end

function cash_meh_where_Carn_Q ()
	showQuestWindow ( "Джонни Кэш", "В туннеле, говорят, который между Союзом Ученых и Форт Карсоном есть абсолютно чистая зубная щетка в гигиеничном пакетике. Принесешь ее - будет тебе деталь J2 для GECK.", "Ну... Хорошо...", "cash_meh_begin_Carn_Q()", "Что за странный мир...", "cash_meh_begin_Carn_Q()", "0", "", "0", "" )
end

function cash_meh_begin_Carn_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_meh", 5)
	updateCompassAdditMarker ( 6, 5 )
	shet_cash = createPickup ( -212.80834960938,1091.1323242188,-10.340960502625, 3, 1279 )
end

function cash_shet_Carn_Q ()
	showQuestWindow ( "Джонни Кэш", "Ну что, нашел для меня щетку? А то у меня скоро свидание с Эми Макдональд.", "Да, вот она", "cash_shet_yes_Carn_Q()", "Нет еще", "cash_shet_no_Carn_Q()", "0", "", "0", "" )
end

function cash_shet_yes_Carn_Q ()
	exports.players:givePlayerXPClient ( 40 )
	showQuestWindow ( "Джонни Кэш", "Отлично, вот твоя деталь J2. Я ее все равно у этого лоха Бенни купил за 10 крышек.", "Спасибо", "cash_shet_fin_Carn_Q()", "Сразу-б так", "cash_shet_fin_Carn_Q()", "0", "", "0", "" )
end

function cash_shet_no_Carn_Q ()
	outputChatBox ("Джонни Кэш: Ладно, но поторопись", 255, 255, 255 )
end

function cash_shet_fin_Carn_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_meh", 7)
	updateCompassAdditMarker ( 6, 7 )
end

function meh_finish_RC ()
	showQuestWindow ( "Механик", "Чего тебе?", "Я нашел деталь J2 для GECK", "meh_f_found_RC()", "Ничего", "", "0", "", "0", "" )
end

function meh_f_found_RC ()
	showQuestWindow ( "Механик", "Опаньки...", "Что?", "meh_f_what_RC()", "0", "", "0", "", "0", "" )
end

function meh_f_what_RC ()
	if getElementData ( localPlayer, "meh_need" ) == 0 then
		showQuestWindow ( "Механик", "Понимаешь... Оказывается, крышка от \"Квантовой Ядер Колы\" сделана по чертежам гайки J2 для GECK, поэтому я использовал ее и твоя гайка мне нужна.", "ЧТО?!", "meh_f_free_RC()", "Да не может быть", "meh_f_free_RC()", "0", "", "0", "" )
	else
		showQuestWindow ( "Механик", "Мне Морган Фриман уже продал такую деталь, так что твоя гайка мне не нужна.", "ЧТО?!", "meh_f_free_RC()", "Да не может быть", "meh_f_free_RC()", "0", "", "0", "" )
	end
end

function meh_f_free_RC ()
	outputChatBox ( "Механик: Все, иди отсюда, а то подам на тебя жалобу в ополчение", 255, 255, 255 )
	setTimer ( meh_f_fin_RC, 3000, 1 )
end

function meh_f_fin_RC ()
	exports.players:givePlayerXPClient ( 400 )
	outputChatBox ("Квест завершен, впредь мы с тобою будем умнее", 0,153,51 )
	exports.achievments:givePoint ( 1 )
	setElementData ( localPlayer, "quest_meh", 8)
	updateCompassAdditMarker ( 6, 8 )
end
