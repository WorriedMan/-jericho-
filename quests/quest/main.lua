localPlayer = getLocalPlayer ()

function start_Main_Q ()
	showQuestWindow ( "Неизвестный", "Как хорошо, что мне удалось спасти тебя от гулей. Еще-б чуть-чуть и ты бы стал их ужином. Ты как, нормально?", "Бывало и лучше", "norm_Main_Q()", "Где я?", "where_Main_Q()", "Спасибо за спасение", "thanks_surv_Main_Q()", "Кто ты?", "whohe_Main_Q()" )
	--showChatDxText ( "Вперед!", 4.95 )
	--showChatDxText ( "Назад!", 5, 5  )
end

addCommandHandler ("tpto1", start_Main_Q)

function norm_Main_Q ()
	showQuestWindow ( "Джон Початок", "Это хорошо. А меня звать Джон Початок. Ты находишся в поселении Новая Деревня. Я нашел тебя около недавно появившийся подлодки. Ты что нибуть помнишь? ", "Неа, все как в тумане", "tuman_Main_Q()", "0", "where_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function where_Main_Q ()
	showQuestWindow ( "Джон Початок", "Ты находишся в поселении Новая Деревня. А меня звать Джон Початок. Я нашел тебя около недавно появившийся подлодки. Ты что нибуть помнишь? ", "Неа, все как в тумане", "tuman_Main_Q()", "0", "where_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function thanks_surv_Main_Q ()
	showQuestWindow ( "Джон Початок", "Всегда пожалуйста. А меня звать Джон Початок. Ты находишся в поселении Новая Деревня. Я нашел тебя около недавно появившийся подлодки. Ты что нибуть помнишь? ", "Неа, все как в тумане", "tuman_Main_Q()", "0", "where_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function whohe_Main_Q ()
	showQuestWindow ( "Джон Початок", "Я - Джон Початок. Всегда пожалуйста. Ты находишся в поселении Новая Деревня. Я нашел тебя около недавно появившийся подлодки. Ты что нибуть помнишь? ", "Неа, все как в тумане", "tuman_Main_Q()", "0", "where_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function tuman_Main_Q()
	showQuestWindow ( "Джон Початок", "Пнятненько. Знаешь, я тебе вот что скажу: не имеет значения кем ты был раньше. Теперь ты - один из горожан и подчиняешся нашим правилам. Наш главный закон: часть населения - часть деревни", "Хорошо, я запомнил. Часть населения - часть деревни. А чем тут можно занятся?", "what_do_Main_Q()", "Ладно, ладно. А чем тут можно занятся.", "what_do_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function what_do_Main_Q()
	showQuestWindow ( "Джон Початок", "Я рад, что ты усвоил наш главный закон. Можешь осмотреться в этом помещении, но если сильно не терпится, то иди сейчас направо по лестнице, затем через дверь на улицу и потом налево, прямиком к нашему мэру. Там сидит его секретарь, у него наверняка есть задание для тебя. И, чуть не забыл, сейчас ты пройдешь обучение.", "Хорошо, спасибо за информацию!", "poch_edu_start()", "Еще раз спасибо что спас меня!", "poch_edu_start()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function poch_edu_start ()
	showQuestWindow ( "Джон Початок", "Итак. На сервере есть радиация. Если она превысит максимально допустимое значение, то ты умрешь. Максимальное допустимое количество радиации увеличивается, когда увеличивается твой уровень. Тебе необходимо питаться, иначе ты умрешь от голода. Еду можно купить, если пройти прямо вглубь дамбы, чуть дальше еды продаются лекарства и можно сменить скин.", "Хорошо", "poch_edu_2_start()", "0", "fin_poch_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function poch_edu_2_start()
	showQuestWindow ( "Джон Початок", "Это еще не все. Писать в общий чат - кнопка U. PM - команда /w [ид игрока]. Инвентарь открыть - кнопка I. Если хочешь поделиться своими вещами - нажми кнопку Q. Включить курсор мыши - Z. Кстати, вступай в нашу группу vk.com/jehorpg и регайся на форуме forum.je-ho.ru", "Еще что то?", "poch_edu_3_start()", "0", "fin_poch_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function poch_edu_3_start ()
	showQuestWindow ( "Джон Початок", "Да. Открыть карту - кнопка F11. Если во время своего путешествия найдешь ящик, лежащий на земле, то подойди к нему и нажми E, возможно в нем что-то есть. Достать PipBoy - кнопка F2. На этом вроде все.", "Спасибо, теперь я пойду.", "fin_poch_Main_Q()", "0", "fin_poch_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function poch_edu_other_start ()
	local additTalkPhrase = '0'
	local additTalkDoing = ''
	if getElementData ( localPlayer, "quest_robert" ) == 3 then 
		additTalkPhrase = 'Роберт Мэйфлауэр послал меня к тебе за стеклышками'
		additTalkDoing = 'john_craft_quest()'
	end	
		--showQuestWindow ( "John Maize", "Mmkay. Well, I've got to tell you something: It is no matter who you was. Now you are one of the villagers. Our chief law: part of the crew, part of the village.", "Okay, I got it. What can I do there??", "what_do_Main_Q()", "OK OK, what can I do there?", "what_do_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )

	showQuestWindow ( "Джон Початок", "Хорошо, что я спас тебя. Хочешь еще раз прослушать обучение?", "Да", "poch_edu_start()", "Нет", "", additTalkPhrase, additTalkDoing, "0", "whohe_Main_Q()" )
end


function fin_poch_Main_Q()
	if getElementData ( localPlayer, "quest_main_st" ) == 0 then
		exports.pipboy:addInfoBox("Получено задание \"Прибытие\"", 3 )
		exports.pipboy:addInfoBox("Все свои задания вы можете посмотреть в PipBoy, кнопка F2", 4 )
		setElementData ( localPlayer, "quest_main_st", 1 )
		exports.pipboy:addInfoBox("Если не знаете куда идти, то можете спросить у одного из ополченцев.", 4 )
		exports.pipboy:addInfoBox("Прогресс сохранен",4)
		setElementData ( localPlayer, "quest_main", 1 )	
		updateCompassMarker ()
	end
end

-- Секретарь

function secr_start_Main_Q ()
	showQuestWindow ( "Секретарь", "Приветик. Ты наверно новый житель нашей деревни? Это тебя спас наш пьяница Джон Початок?", "Да, это я. Меня зовут "..getPlayerName(localPlayer).."", "name_secr_Main_Q()", "Неа, ты говоришь про кого то другого. Я тут живу уже 9 лет.", "lie_secr_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end
-- Открываем
function name_secr_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Приятно познакомиться, а меня зовут Эми Макдональнд. Еще до того, когда рак на горе свистнул, я была музыкантом. А ты кем был?", "Я.. Я.. Я не помню...", "nepomn_Main_Q()", "Я был клоуном, работал в цирке.", "tsirk_Main_Q()", "Я был военным", "warman_Main_Q()", "Я был президентом США, ты что?", "president_Main_Q()" )
end
-- Открываем

function nepomn_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Пичально конечно... Но ничего, не растравайся! Не важно кем ты был раньше, важно дургое, теперь ты часть населения - часть деревни. И у меня как раз есть задание для тебя! Найди жителя нашей деревни Алекса Мескини и возьми у него ключ, он знает какой, после чего принесешь этот ключ мне.", "Хорошо, я выполню это задание", "find_alex_Main_Q()", "0", "lie_secr_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function tsirk_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Ох как я любила ходить в цирк! Может потом покажешь мне пару фирменных клоунских приемов в постели?", "Конечно, детка. Могу хоть сейчас!", "sex_Main_Q()", "Неа, я ГЕЙ.", "gay_Main_Q()", "0", "gay_Main_Q()", "0", "president_Main_Q()" )
end

-- Открываем

function sex_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Сейчас у меня есть задание для тебя. Найди жителя нашей деревни Алекса Мескини и возьми у него ключ, он знает какой, после чего принесешь этот ключ мне.", "Хорошо, я найду его", "find_alex_Main_Q()", "Ладно, жалко только что не удалось затащить тебя в постель", "find_alex_sex_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function gay_Main_Q ()
	outputChatBox ( "Ахахаха, посоны у нас на сервере есть игрок, персонаж которого - гей!!! :D " )
	showQuestWindow ( "Эми МакДональд", "А я сразу заметила, что ты смотришь на меня, не как все. Знаешь, ты первый гей нашей деревни, я всем об этом расскажу. Но пока у меня есть задание для тебя. Найди жителя нашей деревни Алекса Мескини и возьми у него ключ, он знает какой, после чего принесешь этот ключ мне.", "Хорошо, я найду его", "find_alex_Main_Q()", "А он красивый?", "find_alex_gay_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

-- закрываем
function warman_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "А я сразу заметила какой ты сильный и мужественный. Может покажешь потом пару военных штучек в постели?", "Конечно, детка. Могу хоть сейчас!", "sex_Main_Q()", "Неа, я ГЕЙ.", "gay_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function president_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Как смешно. И не стыдно тебе упоминать в суе имя нашего великого Хулио Пеглесиаса? Ладно, у меня есть задание для тебя. Найди жителя нашей деревни Алекса Мескини и возьми у него ключ, он знает какой, после чего принесешь этот ключ мне.", "Хорошо, я найду его", "find_alex_Main_Q()", "0", "find_alex_sex_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

-- закрываем

function lie_secr_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Как смешно. Я знаю всех жителей нашей деревни и что то не примоню такого сексуального красавчика. Может покажешь мне пару трюков в постели?", "Конечно, детка. Могу хоть сейчас!", "sex_Main_Q()", "Неа, я ГЕЙ.", "gay_Main_Q()", "0", "gay_Main_Q()", "0", "president_Main_Q()" )
end

-- закрываем

function find_alex_Main_Q ()
	exports.pipboy:addInfoBox("Получено задание \"Поиски Алекса\"", 0,153,51 )
	setElementData ( localPlayer, "quest_main_st", 2 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	exports.pipboy:addInfoBox("Вы можете включить радио. Для этого нажмите на кнопку с колокольчиком в вашем пипбое и подождите пару секунд. Кнопка находится рядом с датой, в верху.", 5 )
	outputChatBox ("Эми: Удачи с поисками", 255,255,255 )
	setElementData ( localPlayer, "quest_main", 1)
	exports.players:givePlayerXPClient ( 30 )
	updateCompassMarker ()
end

function find_alex_sex_Main_Q ()
	exports.pipboy:addInfoBox("Получено задание \"Поиски Алекса\"", 0,153,51 )
	setElementData ( localPlayer, "quest_main_st", 2 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	exports.pipboy:addInfoBox("Вы можете включить радио. Для этого нажмите на кнопку с колокольчиком в вашем пипбое и подождите пару секунд. Кнопка находится рядом с датой, в верху.", 5 )
	outputChatBox ("Эми: Удачи с поисками", 255,255,255 )
	setElementData ( localPlayer, "quest_main", 1)
	exports.players:givePlayerXPClient ( 30 )
	updateCompassMarker ()
end

function find_alex_gay_Main_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	outputChatBox ("Эми: Тебе понравится", 255,255,255 )
	exports.pipboy:addInfoBox("Получено задание \"Поиски Алекса\"", 3 )
	exports.pipboy:addInfoBox("Вы можете включить радио. Для этого нажмите на кнопку с колокольчиком в вашем пипбое и подождите пару секунд. Кнопка находится рядом с датой, в верху.", 5 )
	setElementData ( localPlayer, "quest_main_st", 2 )
	setElementData ( localPlayer, "quest_main", 1)
	setElementData ( localPlayer, "quest_main_sex", 3)
	exports.players:givePlayerXPClient ( 30 )
	updateCompassMarker ()
end

-- секретарь закрыт

-- квест 1 - поиск алекса

-- разговор с жителями

-- Большой Билл

bill_snd = {
"sounds/nc/bill_1.ogg",
"sounds/nc/bill_2.ogg"
}

function big_bill_Main_Q () 
	local bill_sound = playSound3D( bill_snd[math.random( 1, 2 )], -637.73046875,2067.8916015625,60.3828125 ) 
	setSoundMaxDistance( bill_sound, 3 )
	if getElementData ( localPlayer, "quest_main_st" ) == 2 then
		if getElementData ( localPlayer, "big_bill" ) == 0 then
			showQuestWindow ( "Большой Билл", "Здравствуй, я - Большой Билл. Я работаю в машинном отделении, стараюсь, чтобы дамба всегда функционировала, даруя электричество нашей великой деревне. Часть населения - часть деревни. А ты наверное тот везунчик, которого спас Джон Початок?", "Приятно познакомиться, да, я - "..getPlayerName(localPlayer)..". Я ищу Алекса.", "bill_find_Main_Q()", "Да, это я, "..getPlayerName(localPlayer)..". Можно задать тебе вопрос? ", "bill_quest_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
			setElementData (localPlayer, "big_bill", 1 )
		else
			showQuestWindow ( "Большой Билл", "Здарова. Зачем пожаловал?", "Я ищу Алекса Мескини.", "bill_find_Main_Q()", "Можно задать тебе вопрос? ", "bill_quest_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
		end
	else
		if getElementData ( localPlayer, "big_bill" ) == 0 then
			showQuestWindow ( "Большой Билл", "Здравствуй, я - Большой Билл. Я работаю в машинном отделении, стараюсь, что бы дамба всегда функционировала, даруя электричество нашей великой деревне. Часть населения - часть деревни. А ты наверное тот везунчик, которого спас Джон Початок?", "Приятно познакомиться, да, я - "..getPlayerName(localPlayer)..". Можно задать тебе вопрос?", "bill_quest_Main_Q()", "Да, это я, "..getPlayerName(localPlayer)..". Но мне надо бежать ", "", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
			setElementData (localPlayer, "big_bill", 1 )
		else
			showQuestWindow ( "Большой Билл", "Здарова. Зачем пожаловал?", "Можно задать тебе вопрос? ", "bill_quest_Main_Q()", "Да так, просто поздароваться заходил.", "", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
		end
	end
end

function bill_find_Main_Q ()
	showQuestWindow ( "Большой Билл", "Алекса говоришь? Что то я давненько его не видел, спроси у Стэна Марша, они вроде вместе работали над каким то проектом", "Спасибо за информацию, пока!", "", "Спасибо за информацию, можно задать тебе еще вопрос? ", "bill_quest_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

-- открываем

function bill_quest_Main_Q ()
	showQuestWindow ( "Большой Билл", "Ну давай, задавай свой вопрос, только побыстрее.", "Кем ты был раньше?", "bill_before_Main_Q()", "Что произошло с миром? Я ничего не помню.", "bill_world_Main_Q()", "Как тебе секретарь мэра?", "bill_amy_Main_Q()", "Я передумал, пока!", "" )
end

-- открываем

function bill_before_Main_Q ()
	showQuestWindow ( "Большой Билл", "Я был инженером на этой самой дамбе Шермана, на которой ты сейчас стоишь, всю жизнь здесь проработал, даже когда здесь были боевые дейсвтия между НКР и Легиона Цезаря, тогда еще курьер какой то пришел со своими роботами, и всех их перебил", "Спасибо за информацию, до скорого.", "", "Что произошло с миром? Я ничего не помню.", "bill_world_Main_Q()", "Как тебе секретарь мэра?", "bill_amy_Main_Q()", "0", "" )
end

function bill_world_Main_Q ()
	showQuestWindow ( "Большой Билл", "Я не помню. Могу лишь сказать две вещи: все мы это обытие называем рак на горе свистнул и лучше не интересуйся этим вопросом. Часть населения - часть деревни.", "Кем ты был раньше?", "bill_before_Main_Q()", "Мда, интересно девки пляшут. Все равно спасибо за информацию, до скорого.", "", "Как тебе секретарь мэра?", "bill_amy_Main_Q()", "0", "" )
end

function bill_amy_Main_Q ()
	showQuestWindow ( "Большой Билл", "Тебе она тоже глянулась? Ябвдул. Хотя ходят слухи, что она лесбиянка. Надо бы спросить у Кети Перри, их частенько видят вместе.", "Кем ты был раньше?", "bill_before_Main_Q()", "Что произошло с миром? Я ничего не помню.", "bill_world_Main_Q()", "Вау, какие подробности после моего первого дня в деревне. Ладно, пока.", "", "0", "" )
	--setElementData ( localPlayer, "quest_main_sex", 4 )
end

-- закрываем

-- Большой Билл закрыт

-- Кэти Перри

function katy_perry_Main_Q ()
	if getElementData ( localPlayer, "quest_main_st" ) == 2 then
		if getElementData ( localPlayer, "katty_perry" ) == 0 then
			showQuestWindow ( "Кэти Пэрри", "Привет, я - Кэти Пэрри. Я местная поварешка, работаю в главном помещении дамбы в столовой. Эх... А ведь когда то я было певицей. А ты, я так понимаю, "..getPlayerName(localPlayer).."?", "Да, это я. Я пришел к тебе по заданию секретаря мэра. Я ищу Алекса Мескини.", "katy_find_quest_Main_Q()", "Да, это я, "..getPlayerName(localPlayer)..". Можно задать тебе вопрос? ", "katy_quest_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
			setElementData (localPlayer, "katty_perry", 1 )
		else
			showQuestWindow ( "Кэти Пэрри", "Приветики. Чем обязана визитом такого красавца?", "Я ищу Алекса Мескини.", "katy_find_Main_Q()", "Можно задать тебе вопрос? ", "katy_quest_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
		end
	else
		if getElementData ( localPlayer, "katty_perry" ) == 0 then
			showQuestWindow ( "Кэти Пэрри", "Привет, я - Кэти Пэрри. Я местная поварешка, работаю в главном помещении дамбы в столовой. Эх... А ведь когда то я было певицей. А ты, я так понимаю, "..getPlayerName(localPlayer).."?", "Приятно познакомиться, да, я - "..getPlayerName(localPlayer)..". Можно задать тебе вопрос?", "katy_quest_Main_Q()", "Приятно познакомиться, но мне уже надо бежать", "", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
			setElementData (localPlayer, "katty_perry", 1 )
		else
			showQuestWindow ( "Кэти Пэрри", "Приветики. Чем обязана визитом такого красавца?", "Можно задать тебе вопрос? ", "katy_quest_Main_Q()", "Просто так.", "", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
		end
	end
end

-- открываем
function katy_find_Main_Q ()
	showQuestWindow ( "Кэти Пэрри", "Это тот бразилец, который раньше футболистом был? Да что то как сквозь землю проволился. Наверно опять решил отправится на поиски золотого мяча", "Спасибо за информацию, пока!", "", "Спасибо за информацию, можно задать тебе еще вопрос? ", "katy_quest_Main_Q()", "Что такое золотой мяч?", "katy_golden_ball_Main_Q()", "0", "president_Main_Q()" )
end

-- открываем

function katy_quest_Main_Q ()
	showQuestWindow ( "Кэти Пэрри", "Извини, красавчик, я сегодня не в настроении.", "Жалко. Ладно, пока тогда!", "", "0", "bill_world_Main_Q()", "0", "bill_amy_Main_Q()", "0", "" )
end

-- открываем

function katy_golden_ball_Main_Q ()
	showQuestWindow ( "Кэти Пэрри", "Я сама не знаю точно, но точно помню как Алекс пытался уговорить всю деревню отправится на поиски этого золотого мяча, вроде как он дарует своему владельцу +50 к силе или ловкосте.", "Спасибо за информацию, до скорого.", "", "Интересно, надо будет тоже попытаться поискать этот мяч.", "", "И почему поиски не состоялись?", "katy_find_ball_Main_Q()", "0", "" )
end

function katy_find_ball_Main_Q ()
	showQuestWindow ( "Кэти Пэрри", "Да в самый последний момент Алекс куда то пропал и появился только через месяц, не говоря ни слова о том где был и что делал.", "Спасибо за все. Пока.", "", "0", "katy_find_ball_Main_Q", "0", "katy_find_ball_Main_Q()", "0", "" )
end

-- закрываем

-- Кэти Перри закрываем

-- Стэн Марш

function stan_marsh_Main_Q ()
	if getElementData ( localPlayer, "quest_main_st" ) == 2 then
		if getElementData ( localPlayer, "stan_marsh" ) == 0 then
			showQuestWindow ( "Неизвестный", "Чего тебе?", "Здравствуйте, я ищу Алекса Мескини", "stan_newbie_find_Main_Q()", "Меня зовут "..getPlayerName(localPlayer)..". Я тут новенький, знакомлюсь со всеми.", "stan_newbie_quest_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
			setElementData (localPlayer, "stan_marsh", 1 )
		else
			showQuestWindow ( "Стэн Марш", "Чего тебе?", "Я ищу Алекса Мескини.", "stan_find_quest_Main_Q()", "Можно задать тебе вопрос? ", "stan_quest_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
		end
	else
		if getElementData ( localPlayer, "stan_marsh" ) == 0 then
			showQuestWindow ( "Неизвестный", "Чего тебе?", "Меня зовут "..getPlayerName(localPlayer)..". Я тут новенький, знакомлюсь со всеми.", "stan_newbie_find_Main_Q()", "Ничего", "", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
			setElementData (localPlayer, "stan_marsh", 1 )
		else
			showQuestWindow ( "Стэн Марш", "Чего тебе?", "Можно задать тебе вопрос? ", "stan_quest_Main_Q()", "Ничего.", "", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
		end
	end
end

function stan_newbie_find_Main_Q ()
	showQuestWindow ( "Стэн Марш", "А, дак это же тебя недавно Джон Початок привез. Меня зовут Стэн Марш, я местный исследователь. Я надеюсь ты уже выучил наш главный закон?", "Часть населения - часть деревни", "stan_true_Main_Q()", "Не убей", "stan_flase_Main_Q()", "Не возжелай ближнего своего", "stan_flase_Main_Q()", "0", "president_Main_Q()" )
end

function stan_true_Main_Q ()
	if getElementData ( localPlayer, "quest_main_st" ) == 2 then
		showQuestWindow ( "Стэн Марш", "Правильно, быстро ты его выучил. Дак чего ты хотел?", "Можно задать тебе вопрос? ", "stan_quest_Main_Q()", "Ничего.", "", "Я ищу Алекса Мескини", "stan_find_quest_Main_Q()", "0", "president_Main_Q()" )
	else
		showQuestWindow ( "Стэн Марш", "Правильно, быстро ты его выучил. Дак чего ты хотел?", "Можно задать тебе вопрос? ", "stan_quest_Main_Q()", "Ничего.", "", "0", "stan_false_Main_Q()", "0", "president_Main_Q()" )
	end
end

function stan_flase_Main_Q ()
	if getElementData ( localPlayer, "quest_main_st" ) == 2 then
		showQuestWindow ( "Стэн Марш", "А вот и нет, наш главный закон: Часть населения - часть деревни. Запомни его, он пригодится тебе для выживания в нашем краю. Дак чего ты хотел?", "Можно задать тебе вопрос? ", "stan_quest_Main_Q()", "Ничего.", "", "Я ищу Алекса Мескини", "stan_find_quest_Main_Q()", "0", "president_Main_Q()" )
	else
		showQuestWindow ( "Стэн Марш", "А вот и нет, наш главный закон: Часть населения - часть деревни. Запомни его, он пригодится тебе для выживания в нашем краю. Дак чего ты хотел?", "Можно задать тебе вопрос? ", "stan_quest_Main_Q()", "Ничего.", "", "0", "stan_find_quest_Main_Q()", "0", "president_Main_Q()" )
	end
end

function stan_find_quest_Main_Q ()
	showQuestWindow ( "Стэн Марш", "Это тебе Эми Макдональд сказала его искать? Иди и передай ей, что он уже недели две как зажигает с цыпочками из Нового Вегаса и в наше захолустье возвращаться не хотел.", "Вот как значит. Придется значит возвращаться нисчем.", "stan_find_sad_Main_Q()", "Хорошо, передам.", "stan_find_sad_Main_Q()", "0", "stan_find_quest_Main_Q()", "0", "president_Main_Q()" )
end

function stan_find_sad_Main_Q ()
	exports.pipboy:addInfoBox("Алекса в Новой Деревне нету, возвращайтесь к секретарю мэра.", 4 )
	setElementData ( localPlayer, "quest_main", 2 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	updateCompassMarker ()
end

-- вопросы открываем
function stan_quest_Main_Q ()
	showQuestWindow ( "Стэн Марш", "Ну валяй, спрашивай.", "Что такое произошло с миром? Я ничего не помню...", "stan_world_Main_Q()", "Что такое Новый Вегас?", "stan_new_vegas_Main_Q()", "В этих краях еще есть поселения?", "stan_city_Main_Q()", "Что ты можешь мне сказать о Джоне Початке?", "stan_john_Main_Q()" )
end

function stan_world_Main_Q()
	showQuestWindow ( "Стэн Марш", "Рак на горе свистнул, вот что произошло. А вообще, не советую тебе сувать нос куда не попадя.", "У меня есть еще вопрос.", "stan_quest_Main_Q()", "Ладно, спасибо за информацию, пока.", "", "0", "stan_false_Main_Q()", "0", "president_Main_Q()"  )
end

function stan_city_Main_Q()
	showQuestWindow ( "Стэн Марш", "Из больших поселений еще есть Союз Ученых и Новый Вегас. Что бы попасть в Союз Ученых, надо поехать два раза налево из нашего поселения. А в Новый Вегас два раза направо. Но, даже если ты доберешся до них живым, тебя никто туда не пустит, надо где то добывать пропуска. Но зато тебя с распростертыми объятиями будут ждать в зонах безопасности. Одна такая есть в Эль Кебрадосе и одна в старом мотеле по пути в Новый Вегас. ", "У меня есть еще вопрос.", "stan_quest_Main_Q()", "Ладно, спасибо за информацию, пока.", "", "0", "stan_false_Main_Q()", "0", "president_Main_Q()" )
end

function stan_john_Main_Q()
	showQuestWindow ( "Стэн Марш", "Тебе очень повезло, что он спас тебя. Джон Початок тот еще пьяница, да и в те края около всплывшей недвано подлодки мало кто отваживается отправится. Гули там так и кишат.", "У меня есть еще вопрос.", "stan_quest_Main_Q()", "Ладно, спасибо за информацию, пока.", "", "0", "stan_false_Main_Q()", "0", "president_Main_Q()" )
end

function stan_new_vegas_Main_Q()
	showQuestWindow ( "Стэн Марш", "Это один из островков жизни в пустыне. Отправиться туда можно, если отсюда отправиться в Эль Кебрадос и около Эль Кебрадоса повернуть в сторону Лас Вентураса. Но не советую туда отправляться, ничего хорошего не встретишь. Помни, часть населения - часть деревни.", "У меня есть еще вопрос.", "stan_quest_Main_Q()", "Ладно, спасибо за информацию, пока.", "", "0", "stan_false_Main_Q()", "0", "president_Main_Q()" )
end
-- вопросы закрываем
	
-- Стэн Марш закрываем

-- Опять Сикиритарь

function secr_finish_first_Main_Q ()
	if getElementData ( localPlayer, "quest_main_sex" ) == 3 then
		showQuestWindow ( "Эми МакДональд", "Привет педарастик. Ну что, как там продвигаются поиски Алекса?", "Никак, Стэн Марш сказал, что Алекс вот уже две недели как зажигает с цыпочками в Новом Вегасе", "new_vegas_secr_Main_Q()", "Пока никак, я еще не нашел его", "0", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
	else
		showQuestWindow ( "Эми МакДональд", "Привет. Ну что, как там продвигаются поиски Алекса?", "Никак, Стэн Марш сказал, что Алекс вот уже две недели как зажигает с цыпочками в Новом Вегасе", "new_vegas_secr_Main_Q()", "Пока никак, я еще не нашел его", "0", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
	end
end

function new_vegas_secr_Main_Q ()
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 1)
	exports.pipboy:addInfoBox("Получено задание \"Важная информация\"", 3 )
	setElementData ( localPlayer, "quest_main_st", 3 )
	updateCompassMarker ()
	changeMissionBlip ()
	showQuestWindow ( "Эми МакДональд", "Вот оно что... Мэру это не понравится. Ладно, отправляйся в центр Эль Кебрадоса, машину предоставить тебе не могу. Там будет стоять человек в костюме шерифа, передай ему то, что тебе сказал Стэн Марш. После этого возвращайся сюда.", "Я выполню это задание, но что насчет оплаты моего труда?", "secr_oplata_vegas_Main_Q()", "Хорошо, я с удовольствие выполню еще одно задание!", "secr_oplata_false_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function secr_oplata_vegas_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Ты трудишся на благо нашей деревни. Помни правило: Часть населения - часть деревни. Так что самая лучшая оплата для тебя - это удовлетворние от выполненной работы и гордость, что ты помогаешь своему новому дому.", "Вот как, ну ладно, тогда до скорого.", "secr_oplata_false_Main_Q()", "Конечно, как я мог забыть об этом! Я рад помогать Новой Деревне!", "secr_oplata_true_Main_Q()", "0", "thanks_surv_Main_Q()", "0", "whohe_Main_Q()" )
end

function secr_oplata_true_Main_Q ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 1000 )
	outputChatBox ("Эми: Я пошутила, держи свои деньги", 255,255,255 )
	exports.pipboy:addInfoBox("Отправляйтесь в Эль Кебрадос. Ворота на выезде из деревни открываются, если рядом с ними нажать E или гудок.", 5 )
	exports.pipboy:addInfoBox("Местонахождение Эль Кебрадоса можно посмотреть в Пип Бое (F2), либо на компасе (стрелка), когда вы не в здании.", 5 )
end

function secr_oplata_false_Main_Q ()
	exports.pipboy:addInfoBox("Отправляйтесь в Эль Кебрадос. Ворота на выезде из деревни открываются, если рядом с ними нажать E или гудок.", 5 )
	exports.pipboy:addInfoBox("Местонахождение Эль Кебрадоса можно посмотреть в Пип Бое (F2), либо на компасе (стрелка), когда вы не в здании.", 5 )
end

-- заркываем сикиртиритияъ

-- Открываем Луиса Суареса
function luis_suarez_Main_Q ()
	if getElementData ( localPlayer, "quest_main_st" ) == 3 then
		if getElementData ( localPlayer, "suarez" ) == 0 then
			showQuestWindow ( "Неизвестный", "Да?", "Здравствуйте, Эми Макдональд просила передать информацию про Алекса Мескини", "suarez_newbie_info_Main_Q()", "Я - "..getPlayerName(localPlayer)..". А ты кем будешь?", "suarez_newbie_find_Main_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
			setElementData (localPlayer, "suarez", 1 )
		else
			showQuestWindow ( "Луис Суарес", "Здарова. Зачем пожаловал?", "Эми Макдональд просила передать тебе информацию про Алекса Мескини", "suarez_find_quest_Main_Q()", "Можно задать тебе вопрос? ", "suarez_quest_Main_Q()", "Да я тут просто мимо пробегал", "", "0", "president_Main_Q()" )
		end
	elseif getElementData ( localPlayer, "quest_main_st" ) == 4 and getElementData ( localPlayer, "quest_main" ) == 4 then
			showQuestWindow ( "Луис Суарес", "Здарова. Нашел там что нибуть странное?", "Нет, там все завалено", "suarez_stage_8_yes_Main_Q()", "Я еще не был там", "suarez_stage_8_no_Main_Q()", "Да я тут просто мимо пробегал", "", "0", "president_Main_Q()" )
	else
		if getElementData ( localPlayer, "suarez" ) == 0 then
			showQuestWindow ( "Луис Суарес", "Здарова. Меня Луисом Суаресом кличают. А ты, я так понимаю, "..getPlayerName(localPlayer).."?", "Ага, а ты откуда знаешь?", "suarez_name_Main_Q()", "0", "", "0", "president_Main_Q()", "0", "stan_find_quest_Main_Q()" )
			setElementData (localPlayer, "suarez", 1 )
		else
			showQuestWindow ( "Луис Суарес", "Здарова. Зачем пожаловал?", "Можно задать тебе вопрос? ", "suarez_quest_Main_Q()", "Да я тут просто мимо пробегал", "", "0", "president_Main_Q()", "0", "stan_find_quest_Main_Q()" )
		end
	end
end

-- знакомство 

function suarez_newbie_find_Main_Q ()
	if getElementData ( localPlayer, "quest_main_st" ) == 3 then
		showQuestWindow ( "Луис Суарес", "Ясно, ну а я - Луис Суареc. У меня есть для тебя совет: вон, парень в военном костюме стоит, он продает пропуска в деревню Союз Ученых. Дак чего ты хочешь?", "Эми Макдональд просила передать тебе информацию про Алекса Мескини", "suarez_find_quest_Main_Q()", "Можно задать тебе вопрос? ", "suarez_quest_Main_Q()", "Да я тут просто мимо пробегал, решил познакомиться", "", "0", "stan_false_Main_Q()" )
	else
		showQuestWindow ( "Луис Суарес", "Ясно, ну а я - Луис Суареc. У меня есть для тебя совет: вон, парень в военном костюме стоит, он продает пропуска в деревню Союз Ученых. Дак чего ты хочешь?", "Можно задать тебе вопрос? ", "suarez_quest_Main_Q()", "Да я тут просто мимо пробегал, решил познакомиться", "", "0", "stan_false_Main_Q()", "0", "president_Main_Q()" )
	end
end

-- закрываем знакомство

-- вопросы
function suarez_name_Main_Q()
	showQuestWindow( "Луис Суарес", "Да о тебе уже все в Новой Деревне говорят, вот и до сюда дошли вести, мол Джон Початок спас какого то парня.", "Можно задать тебе вопрос?", "suarez_quest_Main_Q()", "Приятно было познакомится", "", "Чем ты занимаешся тут?", "suarez_whatdo_Main_Q()", "0", "suarez_whatworld_Main_Q()" )
end
	
function suarez_quest_Main_Q ()
	showQuestWindow( "Луис Суарес", "Дерзай, у меня есть пара свободных минут.", "Почему в домах в городе горит свет? Там кто то есть?", "suarez_whyLight_Main_Q()", "Как попасть в Новый Вегас?", "suarez_howtonv_Main_Q()", "Ты знаешь что произошло с миром?", "suarez_whatworld_Main_Q()", "Чем ты занимаешся тут?", "suarez_whatdo_Main_Q()" )
end	 

function suarez_whyLight_Main_Q ()
	showQuestWindow( "Луис Суарес", "За это ты должен сказать спасибо Большому Биллу, он содержит в порядке небольшую генераторную на Дамбе, которая и питает весь штат. А из-за чего свет горит в домах, дак это длинная история, в которой я сам не сильно секу, но вроде там что то с напряжением, поэтому свет то и горит в заброшеных домах и городах. Это хоть выживших привлекает.", "Интересно, ну ладно, я побежал", "", "Как попасть в Новый Вегас?", "suarez_howtonv_Main_Q()", "Ты знаешь что произошло с миром?", "suarez_whatworld_Main_Q()", "Чем ты занимаешся тут?", "suarez_whatdo_Main_Q()" )
end

function suarez_howtonv_Main_Q ()
	showQuestWindow( "Луис Суарес", "Да едь прямо в направлении Лас Вентураса отсюда, проедешь мотель, увидешь большие работающие фонари - и едь на их свет. Только я тебе этого не говорил, ведь, эээ, часть населения - часть деревни!", "Почему в домах в городе горит свет? Там кто то есть?", "suarez_whyLight_Main_Q()", "Да я уже выучил этот ваш законишко, удачи.", "", "Ты знаешь что произошло с миром?", "suarez_whatworld_Main_Q()", "Чем ты занимаешся тут?", "suarez_whatdo_Main_Q()" )
end

function suarez_whatworld_Main_Q ()
	showQuestWindow( "Луис Суарес", "Рак на горе свистнул, вот что. Это оффициальная позиция по произошедшему правительства Новой Деревни. Но если будет время, поспрашивай людей в Новом Вегасе и Союзе Ученых про мэра Джона, доктора Д и глобальное потепление.", "Почему в домах в городе горит свет? Там кто то есть?", "suarez_whyLight_Main_Q()", "Как попасть в Новый Вегас?", "suarez_howtonv_Main_Q()", "Надо будет занятся этим.", "", "Чем ты занимаешся тут?", "suarez_whatdo_Main_Q()" )
end	

function suarez_whatdo_Main_Q ()
	showQuestWindow( "Луис Суарес", "Я слежу за всем Эль Кебрадосом, я что то вроде местного мэра, правда нас тут живых жителей всего человек пять.", "Почему в домах в городе горит свет? Там кто то есть?", "suarez_whyLight_Main_Q()", "Как попасть в Новый Вегас?", "suarez_howtonv_Main_Q()", "Ты знаешь что произошло с миром?", "suarez_whatworld_Main_Q()", "Чем ты занимаешся тут?", "suarez_whatdo_Main_Q()" )

end	
-- закрываем вопросы

-- сюжет

-- Часть 4

function suarez_find_quest_Main_Q ()
	showQuestWindow ( "Луис Суарес", "Ну и что же это за информация?", "Алекс вот уж некоторое время как обосновался в Новом Вегасе", "suarez_info_Main_Q()", "0", "", "0", "stan_false_Main_Q()", "0", "president_Main_Q()" )
end

function suarez_info_Main_Q ()
	showQuestWindow ( "Луис Суарес", "Интересно. Как бы этот поршивец чего лишнего не рассказал бандюгам из Нового Вегаса. Ладно, послушай, мне надо бы поразмыслить что с этим делать. Не мог бы ты пока выполнить одно задание?", "Говори, не сидеть же мне сложа руки", "suarez_task_start_Main_Q()", "Какое?", "suarez_task_start_Main_Q()", "0", "stan_false_Main_Q()", "0", "president_Main_Q()" )
end

function suarez_task_start_Main_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	exports.players:givePlayerXPClient ( 40 )
	setElementData ( localPlayer, "quest_main", 1)
	setElementData ( localPlayer, "quest_main_st", 4 )
	updateCompassMarker ()
	changeMissionBlip ()
	showQuestWindow ( "Луис Суарес", "Что то в районе Эль Кебрадоса слишком много гулей в последнее время, видимо с Сан Фиерро прут. А раз они оттуда идут, значит кто то расчистил завал в тунеле через гору. Отправляйся отсюда по пути в Сан Фиерро и проверь что там в туннеле.", "Хорошо, часть населения - часть деревни", "suarez_task_accept_law_Main_Q()", "Я выполню это задание, надеюсь награда будет стоящая?", "suarez_task_accept_reward_Main_Q()", "0", "stan_false_Main_Q()", "0", "president_Main_Q()" )
end

function suarez_task_accept_law_Main_Q ()
	outputChatBox ("Луис Суарес: Молодец, вот возьми этот дробовик, он тебе возможно пригодится", 255,255,255 )
	exports.pipboy:addInfoBox("Получено задание \"Пафосные Гули\"", 3 )
	exports.inventory:givePlayerItem ( 33, 1 )
	exports.inventory:givePlayerItem ( 46, 20 )
	--triggerServerEvent ( "giveClientWeapon", getLocalPlayer(), 25, 30 ) 
	st4Full_main_Q()
end

function suarez_task_accept_reward_Main_Q ()
	outputChatBox ("Луис Суарес: Достаточная, вот возьми пока этот дробовик, он тебе возможно пригодится", 255,255,255 )
	exports.pipboy:addInfoBox("Получено задание \"Пафосные Гули\"", 3 )
	exports.inventory:givePlayerItem ( 33, 1 )
	exports.inventory:givePlayerItem ( 46, 10 )
	st4Full_main_Q()
end

-- Часть 8

function suarez_stage_8_no_Main_Q ()
	showQuestWindow ( "Луис Суарес", "А чего ты тогда ждешь? Мы тут долго не выстоим, если метрвяки продолжат прибывать в таких количествах", "Можно задать тебе вопрос? ", "suarez_quest_Main_Q()", "Да, я что то об этом не подумал. Сейчас же проверю", "", "А мне все равно, будет время - проверю", "", "0", "stan_find_quest_Main_Q()" )
end

function suarez_stage_8_yes_Main_Q ()
	exports.players:givePlayerXPClient ( 50 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 1000 )
	showQuestWindow ( "Луис Суарес", "Завалено говоришь? Странно. Ладно, у меня пока больше нет ничего для тебя, но как только что нить появится - я сообщю тебе. Вот твоя награда.", "Спасибо, я тогда пойду отсюда.", "suarez_stage_8_reward_1_Main_Q()", "Маловато конечно, но сойдет.", "suarez_stage_8_reward_2_Main_Q()", "Шож так мало то?!", "suarez_stage_8_reward_3_Main_Q()", "0", "stan_find_quest_Main_Q()" )
end

function suarez_stage_8_reward_1_Main_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 1)
	setElementData ( localPlayer, "quest_main_st", 5 )
	updateCompassMarker ()
	changeMissionBlip ()
	showQuestWindow ( "Луис Суарес", "А, чуть ведь не забыл. Тебя какой то чудоковатый парень искал, просил передать что будет ждать тебя на заправке нашей, которая на выезде из города.", "Чудоковатый? Надо быть осторжнее.", "createVehicleStage9()", "Пойду проверю", "createVehicleStage9()", "0", "suarez_stage_8_reward_3_Main_Q()", "0", "stan_find_quest_Main_Q()" )
end

function suarez_stage_8_reward_2_Main_Q ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 300 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 1)
	setElementData ( localPlayer, "quest_main_st", 5 )
	updateCompassMarker ()
	changeMissionBlip ()
	showQuestWindow ( "Луис Суарес", "Ладно, держи вот еще немного. А, и чуть ведь не забыл. Тебя какой то чудоковатый парень искал, просил передать что будет ждать тебя на заправке нашей, которая на выезде из города.", "Чудоковатый? Надо быть осторжнее.", "createVehicleStage9()", "Пойду проверю", "createVehicleStage9()", "0", "suarez_stage_8_reward_3_Main_Q()", "0", "stan_find_quest_Main_Q()" )
end

function suarez_stage_8_reward_3_Main_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 1)
	exports.pipboy:addInfoBox("Получено задание \"Друзья\"", 3 )
	setElementData ( localPlayer, "quest_main_st", 5 )
	updateCompassMarker ()
	changeMissionBlip ()
	showQuestWindow ( "Луис Суарес", "Ну уж сколько есть, и на том бы сказал спасибо. А, и чуть ведь не забыл. Тебя какой то чудоковатый парень искал, просил передать что будет ждать тебя на заправке нашей, которая на выезде из города.",  "Чудоковатый? Надо быть осторжнее.", "createVehicleStage9()", "Пойду проверю", "createVehicleStage9()", "0", "suarez_stage_8_reward_3_Main_Q()", "0", "stan_find_quest_Main_Q()" )
end

function createVehicleStage9 ()
	fillMarker = createMarker ( -1320.5439453125,2698.6103515625,50.26628112793, "corona", 1, 255,255,255 )
	fillVehicle = createVehicle ( 541, -1326.2998046875,2694.994140625,49.687591552734, 0,0,312.55755615234, "VEGAS" )
	setVehicleColor ( fillVehicle, 0, 1, 0, 0 )
	setVehicleEngineState ( fillVehicle, true )
	setVehicleLightState ( fillVehicle, 3, 0 )
	setVehicleLocked ( fillVehicle, true )
end

-- закрываем сюжет

-- закрываем Суареса

-- Часть 9
function lvFillTripStartConversation ()
	if getElementData ( localPlayer, "nwkey" ) == 1 then
		showQuestWindow ( "Неизвестный", "Не надо с ним так грубо, он нам еще пригодится. Здравствуй дорогой ".. getPlayerName ( localPlayer ) ..", хотя, видимо ты не больно дорогой, раз тебя так задешего сдали. Но, позволь представиться, я - мэр Нового Вегаса, Сэм Смит. И мне надо бы тебе кое что объяснить.",  "Что я делаю в Новом Вегасе?!", "contrinueConversationStage9()", "Вы меня похитили?!", "contrinueConversationStage9()", "Что вам от меня нужно?!", "contrinueConversationStage9()", "0", "stan_find_quest_Main_Q()" )
	else
		showQuestWindow ( "Неизвестный", "Не надо с ним так грубо, он нам еще пригодится. Здравствуй дорогой ".. getPlayerName ( localPlayer ) ..", хотя, видимо ты не больно дорогой, раз тебя так задешего сдали. Но, позволь представиться, я - мэр Нового Вегаса, Сэм Смит. И мне надо бы тебе кое что объяснить.",  "Где я?!", "contrinueConversationStage9()", "Вы меня похитили?!", "contrinueConversationStage9()", "Что вам от меня нужно?!", "contrinueConversationStage9()", "0", "stan_find_quest_Main_Q()" )
	end
end

function contrinueConversationStage9 ()
	showQuestWindow ( "Мэр Сэм Смит", "Вопросы свои оставь на потом. Я вот по какому поводу попросил моих друзей тебя привезти сюда. Ты ищещь Алекса Мескини. Зря ты решил помочь этим фанатикам из Новой Деревни, потому что Алекс теперь с нами, и он ни за что не вернется туда. А ты, если будешь упорствовать в поисках... ну... ну я с тобой буду говорить в другом тоне, вернее я даже не с тобой буду говорить, а вот с этими моими друзьями, которые с большими автоматами.",  "Хорошо, я прекращу поиски Алекса", "acceptFindingsAlexStage9()", "Что я буду делать вас не касается", "unAcceptFindingsAlexStage9()", "Погоди, погоди, повтори-ка, что ты сказал?", "repeatPlsStage9()", "Для вашего же здоровья - спрячьте свои игрушечные \"автоматики\"", "repeatPlsStage9()" )
end

function repeatPlsStage9 ()
	showQuestWindow ( "Мэр Сэм Смит", "А ты смешной. Я даже решил ответить на один твой любой вопрос.",  "Что произошло с миром?", "whatWithWorldStgae9()", "0", "whyFanaticsStgae9()", "0", "repeatPlsStage9()", "0", "weaponsStage9()" )
end

function unAcceptFindingsAlexStage9 ()
	showQuestWindow ( "Мэр Сэм Смит", "Еще как касается, мы тут контролируем горааздо больше чем тебе может показаться с первого взгляда. Но не суть, я надеюсь, что ты уловил меседж. А теперь я могу ответить на один твой любой вопрос.",  "Что произошло с миром?", "whatWithWorldStgae9()", "0", "whyFanaticsStgae9()", "0", "repeatPlsStage9()", "0", "weaponsStage9()" )
end

function acceptFindingsAlexStage9 ()
	showQuestWindow ( "Мэр Сэм Смит", "Вот и молодец. Мы тут контролируем горааздо больше чем тебе может показаться с первого взгляда. А теперь я могу ответить на один твой любой вопрос.",  "Что произошло с миром?", "whatWithWorldStgae9()", "0", "whyFanaticsStgae9()", "0", "repeatPlsStage9()", "0", "weaponsStage9()" )
end

function whatWithWorldStgae9 ()
	showQuestWindow ( "Мэр Сэм Смит", "Как говорят фанатики из Новой Деревни - \"рак на горе свистнул\". Но нам известно не сильно больше чем им, после того, как в этом районе были замечены первые гули, связь с остальным миром исчезла, любые поиски в пределах досягаемости не дали результатов. Разумной жизни нет ни где, лишь найдены единичные выжившие, они оседают в одной из трех местных деревень...",  "...", "nextWorldStage9()", "0", "whyFanaticsStgae9()", "0", "repeatPlsStage9()", "0", "weaponsStage9()" )
end

function nextWorldStage9 ()
	showQuestWindow ( "Мэр Сэм Смит", "Да ты вот еще, с этой подлодки, непонятно откуда взялся. Попасть внутрь этой подлодки нам не удается, там много гулей, да и солдат остальных деревень. Кстати, в последнее время стало как то очень много гулей, хотя все подступы в наш регион заблокированны... Странно все это... Но что то я разговорился. Досвидания. Парни, пакуйте его.",  "Что?! У меня есть еще вопросы!", "packHimStage9()", "Можно в этот раз поаккуратнее?", "packHimStage9()", "0", "repeatPlsStage9()", "0", "weaponsStage9()" )
end

-- возвращение

function packHimStage9 ()
	outputChatBox ("Информация: Вас опять вырубили", 0,153,51 )
	fadeCamera ( false, 2 )
	setTimer ( finishStage9TripBegin, 4000, 1 )
	triggerServerEvent ( "mainQuest_finish_stage_9c", getLocalPlayer() ) 
end

function finishStage9TripConversation ()
	showQuestWindow ( "Водитель", "Эй, ты. Ты там не спишь?",  "А ты как думаешь?", "stage9ConversationNo()", "*изобразить храп*", "stage9ConversationHrap()", "Нет, а что?", "stage9ConversationNo()", "0", "weaponsStage9()" )
end

function stage9ConversationNo ()
	showQuestWindow ( "Водитель", "У меня есть важная информация для тебя, вернее для Эми Макдональд. Передай ей следующие слова: Пьяная черепаха не верит. Только передай в точности как я сказал. И никому кроме нее об этом ни слова!",  "Что? Что это за бред?", "stage9ConversationYouThink()", "Хорошо, я передам ей эту фразу", "stage9ConversationOkay()", "Я за спасибо не работаю", "stage9ConversationMoney()", "0", "weaponsStage9()" )
end

function stage9ConversationHrap ()
	showQuestWindow ( "Водитель", "Просыпайся, у меня важная информация!",  "А? Что? Я задремал немного...", "stage9ConversationNo()", "Я не спал, я тебя просто обманул! Ахахаха!", "stage9ConversationLie()", "*продолжать делать вид что спите*", "stage9ConversationHrap()", "0", "weaponsStage9()" )
end

function stage9ConversationLie ()
	showQuestWindow ( "Водитель", "Мне сейчас не до шутонек! У меня есть важная информация для тебя, вернее для Эми Макдональд. Передай ей следующие слова: Пьяная черепаха не верит. Только передай в точности как я сказал. И никому кроме нее об этом ни слова!",  "Что? Что это за бред?", "stage9ConversationYouThink()", "Хорошо, я передам ей эту фразу", "stage9ConversationOkay()", "Я за спасибо не работаю", "stage9ConversationMoney()", "0", "weaponsStage9()" )
end

function stage9ConversationHrap2 ()
	showQuestWindow ( "Водитель", "Аррр, просыпайся, во имя великого рассвета! Часть населения - часть деревни!",  "А? Что? Я задремал немного...", "stage9ConversationNo()", "Я не спал, я тебя просто обманул! Ахахаха!", "stage9ConversationLie()", "Во имя чего?", "stage9ConversationWhat()", "0", "weaponsStage9()" )
end

function stage9ConversationWhat ()
	showQuestWindow ( "Водитель", "Ты не знаешь??... Но это сейчас не важно! У меня есть важная информация для тебя, вернее для Эми Макдональд. Передай ей следующие слова: Пьяная черепаха не верит. Только передай в точности как я сказал. И никому кроме нее об этом ни слова!",  "Что? Что это за бред?", "stage9ConversationYouThink()", "Хорошо, я передам ей эту фразу", "stage9ConversationOkay()", "Я за спасибо не работаю", "stage9ConversationMoney()", "0", "weaponsStage9()" )
end

function stage9ConversationYouThink ()
	showQuestWindow ( "Водитель", "Это не бред, Эми должна будет все понять. Так, все, мы подъезжаем, я тебя выпущу около Эль Кебрадоса. Запомни: Пьяная черепаха не верит.",  "Да да, я запомнил.", "stage9ConversationFinish()", "0", "packHimStage9()", "0", "", "0", "weaponsStage9()" )
end

function stage9ConversationOkay ()
	showQuestWindow ( "Водитель", "Отлично, Новая Деревня в долгу перед тобой. Так, все, мы подъезжаем, я тебя выпущу около Эль Кебрадоса. Запомни: Пьяная черепаха не верит.",  "Да да, я запомнил.", "stage9ConversationFinish()", "0", "packHimStage9()", "0", "", "0", "weaponsStage9()" )
end

function stage9ConversationMoney ()
	showQuestWindow ( "Водитель", "Будут тебе деньги. Так, все, мы подъезжаем, я тебя выпущу около Эль Кебрадоса. Запомни: Пьяная черепаха не верит.",  "Да да, я запомнил.", "stage9ConversationFinish()", "0", "packHimStage9()", "0", "", "0", "weaponsStage9()" )
	exports.players:givePlayerXPClient ( 50 )
	updateCompassMarker ()
end

-- Квест 6 Пьяная черепаха

-- Секретарь
function secr_drunk_start_Main_Q ()
	if getElementData ( localPlayer, "quest_main_sex" ) == 3 then
		showQuestWindow ( "Эми МакДональд", "Привет, гей. Передал информацию Луису Суаресу?", "У меня для тебя есть срочное сообщение", "secr_long_drunk_Main_Q()", "0", "secr_yes_drunk_Main_Q()", "0", "gay_Main_Q()", "0", "president_Main_Q()" )
	else
		showQuestWindow ( "Эми МакДональд", "Приветики. Передал информацию Луису Суаресу?", "У меня для тебя есть срочное сообщение", "secr_long_drunk_Main_Q()", "0", "secr_yes_drunk_Main_Q()", "0", "gay_Main_Q()", "0", "president_Main_Q()" )
	end
end

function secr_long_drunk_Main_Q ()
	local drunkRandom = math.random ( 1, 4 )
	if getElementData ( localPlayer, "quest_main" ) == 1 then
		setElementData ( localPlayer, "quest_main", 2 )
		if drunkRandom == 1 then
			showQuestWindow ( "Эми МакДональд", "Правда? Я вся во внимании.", "Пьяная черепаха не верит", "secr_tort_drunk_Main_Q()", "0", "secr_nr_drunk_Main_Q()", "0", "gay_Main_Q()", "0", "president_Main_Q()" )
		else
			showQuestWindow ( "Эми МакДональд", "Правда? Я вся во внимании.", "Эээ.. Там что то про черепаху...", "secr_nr_drunk_Main_Q()", "0", "gay_Main_Q()", "0", "president_Main_Q()", "0", "" )
		end		
		return true
	end
	if drunkRandom == 1 then
		showQuestWindow ( "Эми МакДональд", "Ну что? Вспомнил, что хотел сказать?", "Пьяная черепаха не верит", "secr_tort_drunk_Main_Q()", "0", "secr_nr_drunk_Main_Q()", "0", "gay_Main_Q()", "0", "president_Main_Q()" )
	else
		showQuestWindow ( "Эми МакДональд", "Ну что? Вспомнил, что хотел сказать?", "Эээ.. Там что то про черепаху...", "secr_nr_drunk_Main_Q()", "0", "gay_Main_Q()", "0", "president_Main_Q()", "0", "" )
	end
end

function secr_nr_drunk_Main_Q ()
	outputChatBox ( "Эми МакДональд: Приходи, когда вспомнишь", 255, 255, 255 )
end

function secr_tort_drunk_Main_Q ()
	exports.players:givePlayerXPClient ( 50 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 500 )
	setElementData ( localPlayer, "quest_main", 3 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	showQuestWindow ( "Эми МакДональд", "Опаньки, значит все таки Суарес... Хорошо, спасибо за информацию. Вот, держи награду. У меня есть для тебя небольшое задание. Слишком много гулей в округе стало, не мог бы ты провести небольшую чистку? Скажем, убей 50 гулей, после чего приходи.", "Легко", "", "0", "gay_Main_Q()", "0", "president_Main_Q()", "0", "" )
end

function secr_zkilled_start_Main_Q()
	showQuestWindow ( "Эми МакДональд", "Ну что, выполнил мое задание? Убил 50 гулей?", "Да, 50 гулей, один к одному.", "zkilled_yes_Main_Q()", "Ну, убил примерно столько", "zkilled_yes_Main_Q()", "Нет еще", "", "0", "" )
end

function zkilled_yes_Main_Q()
	exports.players:givePlayerXPClient ( 1000 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 6000 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	showQuestWindow ( "Эми МакДональд", "Вот и отлично, но не думай, что твоя работа на благо деревни закончилась. Я приготовила для тебя очень опасное, но крайне важное задание.", "Я весь во внимании.", "hard_task_yes_Main_Q()", "Мне это не интересно.", "hard_task_no_Main_Q()", "0", "", "0", "" )
end

function hard_task_no_Main_Q()
	if getElementData ( localPlayer, "quest_main_sex" ) == 3 then
		showQuestWindow ( "Эми МакДональд", "Ах, да, я же забыла, что ты гей. Давай так, за выполнение этого задания, я познакомлю тебя с таким красавчиком, что ты дар речи потеряешь.", "Я весь во внимании.", "hard_task_yes_Main_Q()", "Мне это тоже не интересно.", "hard_task_also_no_Main_Q()", "0", "", "0", "" )
	else
		showQuestWindow ( "Эми МакДональд", "Красавчик, послушай, давай так, в случае выполнения этого задания, мы с тобой встретимся у меня в доме и кое-что \"обсудим\".", "С этого и надо было начинать, что требуется от меня?", "hard_task_yes_Main_Q()", "Это меня тоже не интересует.", "hard_task_gay_Main_Q()", "0", "", "0", "" )
	end
end

function hard_task_also_no_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Мда, последнее, что я могу предложить тебе - это 20000 крышек Это большая часть сбережений нашей деревни, но задание неотложное, его вряд-ли сможет выполнить кто-нибуть другой. А вообще, знаешь ли, очень плохо, что мы тебя приютили, а ты готов работать только за деньги.", "Таков мир, детка. Что требуется от меня?", "hard_task_yes_Main_Q()", "Да я пошутил. Что требуется от меня в этом задании?", "hard_task_yes_Main_Q()", "0", "", "0", "" )
end

function hard_task_gay_Main_Q ()
	setElementData ( localPlayer, "quest_main", 3 )
	showQuestWindow ( "Эми МакДональд", "Чтоо? Значит ты всеж-таки гей, я догадывалась об этом. Тогда давай за выполнение этого задания, я познакомлю тебя с таким красавчиком, что ты дар речи потеряешь.", "Я весь во внимании.", "hard_task_yes_Main_Q()", "Ладно, я выполню задание твое просто так, только не считай меня геем.", "hard_task_yes_Main_Q()", "Не, не мое это.", "hard_task_also_no_Main_Q()", "0", "" )
end

function hard_task_yes_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Луис Суарес оказался предателем, он работает на Новый Вегас. Эти бандиты перешли все границы. Только, вроде бы, наши отношения с ними начали налаживаться, мы даже разрешили им открыть отделение своего банка в деревне, как они подкладывают нам такую свинью. Единственный выход из данной ситуации - уничтожить Новый Вегас.", "Мне послышалось? Ты сказала - уничтожить Новый Вегас? Но как?", "hard_how_Main_Q()", "Давно пора наказать этих мафиози. Но как ты собралась это сделать?", "hard_how_Main_Q()", "Мне не кажется, что уничтожить поселение - это хорошая идея.", "hard_ungood_Main_Q()", "0", "" )
end

function hard_ungood_Main_Q()
	showQuestWindow ( "Эми МакДональд", "Тебе только так кажется, они не заслуживают ничего другого.", "Возможно ты права, но как ты решила уничтожить Новый Вегас?", "hard_how_Main_Q()", "Но ведь там-же живут невинные люди.", "hard_people_Main_Q()", "0", "hard_ungood_Main_Q()", "0", "" )
end

function hard_people_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Знаешь, в нашем краю невинных людей нету, всем нам, в конце концов, в аду гореть, просто кому-то раньше, а кому-то чуть попозднее.", "Возможно ты права, но как ты решила уничтожить Новый Вегас?", "hard_how_Main_Q()", "Часть населения - часть деревни. Я выполню задание. Говори как.", "hard_how_Main_Q()", "Эээ... Ну ладно... Но как уничтожить Новый Вегас?", "hard_how_Main_Q()", "0", "" )
end

function hard_how_Main_Q ()
	showQuestWindow ( "Эми МакДональд", "Очень даже просто. У солдат из Союза Ученых есть доступ к военному спутнику, который может бомбардировать поверхность земли. Отправляйся в Союз Ученых, там, в жилых помещениях, тебя будет ждать наш тайный агент - Моряк Попай. Он введет тебя в курс дела.", "Я берусь за это задание.", "hard_accept_Main_Q()", "0", "hard_how_Main_Q()", "0", "hard_how_Main_Q()", "0", "" )
end

function hard_accept_Main_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 1 )
	setElementData ( localPlayer, "quest_main_st", 7 )
	outputChatBox ("Эми Макдональд: Удачи!", 255, 255, 255 )
	updateCompassMarker ()
	changeMissionBlip()
end

function popeye_start_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Ешь шпинат.", "Часть населения - часть деревни.", "pop_start_first_Main_Q()", "*проигнорировать*", "", "0", "hard_how_Main_Q()", "0", "" )
end

function pop_start_first_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Иди.", "Что?", "pop_go_first_Main_Q()", "Куда?", "pop_go_first_Main_Q()", "0", "hard_how_Main_Q()", "0", "" )
end

function pop_go_first_Main_Q ()
	showQuestWindow ( "Моряк Попай", "К гражданскому коменданту, он в лабораториях.", "Зачем?", "pop_tell_first_Main_Q()", "0", "pop_tell_first_Main_Q()", "0", "hard_how_Main_Q()", "0", "" )
end

function pop_tell_first_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Скажи ему.", "Что?", "pop_agent_first_Main_Q()", "Что ему сказать?", "pop_agent_first_Main_Q()", "0", "hard_how_Main_Q()", "0", "" )
end

function pop_agent_first_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Что ты из центрального отделения.", "Чего? Откуда??", "pop_where_first_Main_Q()", "А дальше что?", "pop_ok_first_Main_Q()", "0", "hard_how_Main_Q()", "0", "" )
end

function pop_where_first_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Не перебевай.", "Хорошо.", "pop_ok_first_Main_Q()", "0", "pop_agent_first_Main_Q()", "0", "hard_how_Main_Q()", "0", "" )
end

function pop_ok_first_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Выполни то, что он скажет.", "Ага.", "pop_yes_first_Main_Q()", "0", "pop_agent_first_Main_Q()", "0", "hard_how_Main_Q()", "0", "" )
end

function pop_yes_first_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Только потом возвращайся ко мне.", "Все, сделаю.", "pop_finish_first_Main_Q()", "0", "pop_agent_first_Main_Q()", "0", "hard_how_Main_Q()", "0", "" )
end

function pop_finish_first_Main_Q()
	exports.players:givePlayerXPClient ( 100 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 2 )
	setElementData ( localPlayer, "quest_main_st", 7 )
	updateCompassMarker ()
	outputChatBox ("Моряк Попай (кричит): Ешь шпинат, проходимец!", 255, 255, 255 )
end


function comrade_start_Main_Q ()
	showQuestWindow ( "Гражданский Комендант", "Хеллоу гражданин, что вам надо?", "Я прибыл из центрального отделения.", "comrade_central_Main_Q()", "Я хотел бы спросить кое-что", "comrade_quest_SU()", "Ничего", "", "0", "" )
end

function comrade_central_Main_Q ()
	showQuestWindow ( "Гражданский Комендант", "Сразу бы так и сказали. Не будем медлить, нам необходимо попасть в порт Сан Фиерро как можно быстрее, но, как вы могли заметить, пока ехали сюда из центрального отделения, весь Сан Фиерро просто напросто кишит гулями. Поэтому было решено расчистить мост, ведущий из Бай Сайда в Сан Фиееро.", "С помощью чего?", "comrade_what_Main_Q()", "0", "comrade_quest_SU()", "0", "", "0", "" )
end

function comrade_what_Main_Q ()
	showQuestWindow ( "Гражданский Комендант", "С помощью одного из наших боевых спутников, что летают на орбите. К несчастью, связь со спутником прервана, чтобы ее восстановить, требуются две вещи: коды доступа и оборудование, которое восстановит соединение. Оборудование находится на складе в Лас Вентурасе, а коды доступа в церкви, тоже в Лас Вентурасе, только не спрашивайте, почему они там. У меня на этом все. Выходите из лабораторий, на площади вас будет ждать наш польский механик - Катерина Минет, она расскажет вам подробности.", "Вас понял, отправляюсь.", "comrade_ready_Main_Q()", "Так точно!", "comrade_ready_Main_Q()", "Минет? Хе-хе-хе", "comrade_ready_Main_Q()", "Вас понял!", "comrade_ready_Main_Q()" )
end

function comrade_ready_Main_Q ()
	exports.players:givePlayerXPClient ( 50 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 1 )
	setElementData ( localPlayer, "quest_main_st", 8 )
	updateCompassMarker ()
	exports.pipboy:addInfoBox("Получено задание \"Ремонт спутников\"", 3 )
	outputChatBox ("Гражданский Комендант: Идите.", 255, 255, 255 )
end

function minet_start_Main_Q ()
	showQuestWindow ( "Катерина Минет", "Доброй ночи, я так понимаю, что это вы должны нам помочь с восстановлением связи со спутником.", "Хорошая у вас фамилия, от бога дана.", "minet_family_Main_Q()", "Да, это я.", "minet_ready_Main_Q()", "Я не знаю о чем вы говорите.", "", "0", "" )
end

function minet_family_Main_Q()
	showQuestWindow ( "Катерина Минет", "Не время для шутонек. Слушайте сюда. Отправляйтесь на склад в Лас Вентурасе, я отмечу на вашей карте какой. На складе будет стоять один единственный грузовик, вот его и подберите и привезите ко мне, сюда.", "Все понял.", "minet_step1_Main_Q()", "0", "comrade_quest_SU()", "0", "", "0", "" )
end

function minet_ready_Main_Q()
	showQuestWindow ( "Катерина Минет", "Слушайте сюда. Отправляйтесь на склад в Лас Вентурасе, я отмечу на вашей карте какой. На складе будет стоять один единственный грузовик, вот его и подберите и привезите ко мне, сюда.", "Все понял.", "minet_step1_Main_Q()", "0", "comrade_quest_SU()", "0", "", "0", "" )
end


function minet_step1_Main_Q()
	exports.players:givePlayerXPClient ( 50 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 2 )
	setElementData ( localPlayer, "quest_main_st", 8 )
	exports.players:updateCompassArrowPos ( 1047.12109375,2383.77734375,10.8203125 )
	setElementData ( localPlayer, "showArrowC", true )
	outputChatBox ("Катерина Минет: И помните, мне не зря дана такая фамилия.", 255, 255, 255 )
	create8stageFirstMarker ()
	setElementData ( localPlayer, "mission", 1 )
	setElementData ( localPlayer, "onmission", true )
	changeMissionBlip ()
end

function minet_restart_q8s1 ()
	create8stageFirstMarker ()
	setElementData ( localPlayer, "mission", 1 )
	setElementData ( localPlayer, "onmission", true )
	outputChatBox ("Вы начали миссию заново.", 255,255,255 )
	exports.players:updateCompassArrowPos ( 1047.12109375,2383.77734375,10.8203125 )
	setElementData ( localPlayer, "showArrowC", true )
	changeMissionBlip ()
end

function minet_start2_Main_Q ()
	showQuestWindow ( "Катерина Минет", "А вы молодец, удачно справились с первой частью задания. Теперь необходимо отправиться в церковь Лас Вентураса. Там вы кое-что, что необходимо доставить сюда.", "Без проблем.", "minet_step2_Main_Q()", "А что это?", "minet_whatis_Main_Q()", "0", "", "0", "" )
end

function minet_whatis_Main_Q ()
	outputChatBox ("Катерина Минет: Увидите, пускай это будет сюрпризом.", 255, 255, 255 )
	minet_step2_Main_Q()
end

function minet_step2_Main_Q()
	exports.players:givePlayerXPClient ( 50 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 4 )
	setElementData ( localPlayer, "quest_main_st", 8 )
	create8stageSecondMarker ()
	setElementData ( localPlayer, "mission", 2 )
	setElementData ( localPlayer, "onmission", true )
	exports.players:updateCompassArrowPos ( 1530.6728515625,751.0517578125,11.0234375 )
	setElementData ( localPlayer, "showArrowC", true )
	changeMissionBlip ()
end

function minet_restart_q8s2 ()
	create8stageSecondMarker ()
	setElementData ( localPlayer, "mission", 2 )
	setElementData ( localPlayer, "onmission", true )
	outputChatBox ("Вы начали миссию заново.", 255,255,255 )
	exports.players:updateCompassArrowPos ( 1530.6728515625,751.0517578125,11.0234375 )
	setElementData ( localPlayer, "showArrowC", true )
	changeMissionBlip ()
end

function minet_finish_Main_Q ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 1000 )
	exports.players:givePlayerXPClient ( 50 )
	showQuestWindow ( "Катерина Минет", "Вы хорошо справились. Вот ваша награда.", "Маловато будет. Может еще прибавите?", "minet_fin2_Main_Q()", "Отлично. Что мне теперь делать?", "minet_next_Main_Q()", "0", "", "0", "" )
end

function minet_fin2_Main_Q ()
	showQuestWindow ( "Катерина Минет", "Размеры вашей премии указаны в вашем контракте.", "Надо было лучше читать контракт. У вас есть еще поручения, Минет?", "minet_next_Main_Q()", "0", "", "0", "", "0", "" )
end

function minet_next_Main_Q ()
	showQuestWindow ( "Катерина Минет", "Нам надо настроить связь со спутником, но это уже будет без вас. Сейчас вы умрете.", "Что?!", "minet_trick_Main_Q()", "Как бы не так.", "minet_trick_Main_Q()", "Скорее вы умрете.", "minet_trick_Main_Q()", "0", "" )
end

function minet_trick_Main_Q ()
	showQuestWindow ( "Катерина Минет", "Да я пошутила. Но настройка спутника действительно обойдется без вас. Но вы нам еще понадобитесь, да и не забывайте, что ваш контракт, который вы заключили в центральном отделении, действует еще год. А пока идите к гражданскому коменданту. Он вам даст следующее задание.", "Ну и шуточки у тебя.", "minet_last_Main_Q()", "Хорошо.", "minet_last_Main_Q()", "0", "minet_trick_Main_Q()", "0", "" )
end

function minet_last_Main_Q()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 6 )
	setElementData ( localPlayer, "quest_main_st", 8 )
	updateCompassMarker ()
	--outputChatBox ("Получено задание \"Индиана Джонс\"", 0,153,51 )
end

function comrade_indiana_Main_Q ()
	showQuestWindow ( "Гражданский Комендант", "Насколько я знаю, вы успешно справились с заданием Катерины и получили за это премию. Что-ж мы будем настраивать связь со спутником. Но у меня есть для вас следующее поручение.", "И что-же это за задание такое?", "comrade_indiana_c_Main_Q()", "Конечно, говорите.", "comrade_indiana_c_Main_Q()", "0", "", "0", "" )
end

function comrade_indiana_c_Main_Q ()
	showQuestWindow ( "Гражданский Комендант", "Вот вам GPS устройство. Мы будем следить за вашими перемещениями. Ваша задача найти как минимум 10 бункеров, что разбросаны по всей пустыне, после возвращайтесь сюда.", "Выполню", "comrade_indiana_s_Main_Q()", "А зачем это?", "comrade_indiana_swhy_Main_Q()", "0", "", "0", "" )
end

function comrade_indiana_swhy_Main_Q ()
	comrade_indiana_s_Main_Q ()
	outputChatBox ("Гражданский Комендант: Приказы не обсуждаются.", 255,255,255 )
end

function comrade_indiana_s_Main_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 1 )
	setElementData ( localPlayer, "quest_main_st", 9 )
	updateCompassMarker ()
	exports.pipboy:addInfoBox("Получено задание \"Индиана Джонс\"", 3 )
end

function comrade_destroy_b_Main_Q ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 2000 )
	showQuestWindow ( "Гражданский Комендант", "Мы следили за вашими перемещениями и теперь знаем, где находится большинство бункеров. Отлично сработано! Я выписал вам премию.", "Рад служить Союзу Ученых", "comrade_destroy_c_Main_Q()", "Да-да, что там дальше?", "comrade_destroy_c_Main_Q()", "0", "", "0", "" )
end

function comrade_destroy_c_Main_Q ()
	exports.players:givePlayerXPClient ( 500 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	exports.pipboy:addInfoBox("Получено задание \"Вижу землю!\"", 3 )
	setElementData ( localPlayer, "quest_main", 1 )
	setElementData ( localPlayer, "quest_main_st", 10 )
	updateCompassMarker ()
	showQuestWindow ( "Гражданский Комендант", "Связь со спутником успешно установлена, теперь мы можем бомбрадировать любой участок штата. Миссия по зачистке моста будет возложена на вас. Приходите, как будете готовы размазать пару сотен сгнивших голов с помощью современных технологий.", "Хорошо.", "", "С радостью.", "", "0", "", "0", "" )
end

function comrade_sat_quest_Main_Q ()
	showQuestWindow ( "Гражданский Комендант", "Готовы к выполнению этой важной задачи?", "Конечно! Давайте начинать!", "comrade_sat_start_Main_Q()", "Еще нет...", "", "0", "", "0", "" )
end

function comrade_sat_start_Main_Q ()
	fadeCamera ( false, 2 )
	outputChatBox ("Гражданский Комендант: Подойдите сюда и подключайтесь к трансляции.", 255,255,255 )
	setTimer ( function ()
					fadeCamera ( true, 2 )
					setCameraMatrix ( -2682.5236, 1322.7069, 85.4296, -2682.5236, 1342.7069, 55.4296 ) 
					setElementDimension ( getLocalPlayer(), getElementData ( localPlayer, "playerid" ) )
					toggleAllControls ( false )
					setCameraGoggleEffect ( "thermalvision" )
					setElementData ( localPlayer, "onmission", true )
					setElementData ( localPlayer, "onsatmission", true )
				end, 4000, 1 )
	setTimer ( function ()
					showQuestWindow ( "Гражданский Комендант", "Как картинка?", "Как в жизни.", "comrade_sat_g_quality_Main_Q()", "Неплохо, но небольшие помехи есть.", "comrade_sat_quality_Main_Q()", "0", "", "0", "" )
				end, 6000, 1 )
end

function comrade_sat_quality_Main_Q ()
	showQuestWindow ( "Гражданский Комендант", "Правда? Ну вам больно хорошая и не нужна, вы ведь не лица их будете рассматривать. Сейчас камера спутника начнет движение вдоль моста, вам необходимо лишь отмечать места, где необходимо произвести взрыв. И да, там осталась моя пластинка с музыкой, она автоматически запустится. Все понятно?", "Да!", "comrade_sat_go_Main_Q()", "0", "comrade_sat_quality_Main_Q()", "0", "", "0", "" )
	exports.players:givePlayerXPClient ( 100 )
end

function comrade_sat_g_quality_Main_Q ()
	showQuestWindow ( "Гражданский Комендант", "Это хорошо. Сейчас камера спутника начнет движение вдоль моста, вам необходимо лишь отмечать места, где необходимо произвести взрыв. И да, там осталась моя пластинка с музыкой, она автоматически запустится. Все понятно?", "Да!", "comrade_sat_go_Main_Q()", "0", "comrade_sat_quality_Main_Q()", "0", "", "0", "" )
end

function comrade_sat_go_Main_Q ()
	showCursor ( true )
	beginCountdownSat ()
end

function comrade_sat_finish_Main_Q (kills, perc)
	setElementDimension ( getLocalPlayer(), 0 )
	setElementPosition ( localPlayer, 279.6075,1855.3359,8.765 )
	fadeCamera ( false, 2 )
	setTimer ( function ()
					fadeCamera ( true, 2 )
					showCursor ( false )
					setElementData ( localPlayer, "onmission", false )
					setElementData ( localPlayer, "onsatmission", false )
					setCameraGoggleEffect ( "normal" )
					toggleAllControls ( true )
					setCameraTarget ( localPlayer )
					setElementPosition ( localPlayer, 279.6075,1855.3359,8.765 )
					showQuestWindow ( "Гражданский Комендант", "Неплохо-неплохо, хотя яб лучше справился, но здоровьице уже не то, что раньше. Давайте посмотрим на ваши данные. Итак, вы убили "..tostring(kills).." гулей, неплохой результат, по нашим подсчетам, это около "..tostring(perc).." процентов.", "Я старался.", "comrade_sat_well_Main_Q()", "Пфф, это я еще не старался.", "comrade_sat_bad_Main_Q()", "0", "", "0", "" )
				end, 4000, 1 )
end

function comrade_sat_well_Main_Q ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 1500 )
	showQuestWindow ( "Гражданский Комендант", "Это хорошо, что вы старались, я выпишу вам дополнительную премию. На этом пока все. Кстати, пока вы там были заняты, вас искал некий Моряк Попай, не знаю кто это и что он хотел, но помните, что пока вы на службе, вас ни кто не должен отвлекать.", "Попай... А я про него и забыл.", "comrade_sat_last_Main_Q()", "Чуть было не забыл про него.", "comrade_sat_last_Main_Q()", "Не знаю кто это.", "comrade_sat_last_Main_Q()", "0", "" )
end
function comrade_sat_bad_Main_Q ()
	showQuestWindow ( "Гражданский Комендант", "Что? За это наложу на вас штраф, вы останетесь без месячной зарплаты. Все, идите, у меня заданий больше нету. Кстати, пока вы там были заняты, вас искал некий Моряк Попай, не знаю кто это и что он хотел, но помните, что пока вы на службе, вас ни кто не должен отвлекать, за это я вас лишу зарплаты и за следующий месяц.", "Попай... А я про него и забыл.", "comrade_sat_last_Main_Q()", "Чуть было не забыл про него.", "comrade_sat_last_Main_Q()", "Не знаю кто это.", "comrade_sat_last_Main_Q()", "Ох уже этот Попай.", "comrade_sat_last_Main_Q()" )
end

function comrade_sat_last_Main_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	exports.pipboy:addInfoBox("Получено задание \"Опаньки\"", 3 )
	setElementData ( localPlayer, "quest_main", 1 )
	setElementData ( localPlayer, "quest_main_st", 11 )
	updateCompassMarker ()
	exports.players:givePlayerXPClient ( 500 )
end

function pop_uf_start_Main_Q()
	showQuestWindow ( "Моряк Попай", "Вот и ты. Получил доступ к спутнику?", "Погоди, почему ты в тот раз так странно со мной говорил?", "pop_uf_strange_Main_Q()", "Да, мы можем подключится к спутнику и уничтожить Новый Вегас.", "pop_uf_ready_Main_Q()", "0", "", "0", "" )
end

function pop_uf_strange_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Ты не понял? Это нужно всего лишь было для конспирации. Я не знал как ты выглядишь, поэтому говорил эти слова всем. Все это дело понял только ты, значит ты и был нужным мне человеком. Ну дак что, спутник в наших руках?", "Да, мы можем подключится к спутнику и уничтожить Новый Вегас.", "pop_uf_ready_Main_Q()", "0", "", "0", "", "0", "" )
end

function pop_uf_ready_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Отлично, но я должен тебе сказать кое-что. На самом деле я не двойной агент, я тройной. Я работаю на Новый Вегас.", "НЕОЖИДАННЫЙ ПОВОРОТ", "pop_uf_change_Main_Q()", "А я сразу это понял.", "pop_uf_under_Main_Q()", "Дак ты предатель!!!", "pop_uf_supostat_Main_Q()", "0", "" )
end

function pop_uf_change_Main_Q ()
	showQuestWindow ( "Моряк Попай", "ДА. У меня есть к тебе деловое предложение от Мэра Смита.", "Это от того говнюка, что похитил меня?", "pop_uf_shit_Main_Q()", "Слушаю.", "pop_uf_list_Main_Q()", "0", "", "0", "" )
end

function pop_uf_under_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Ну-ну, конечно. И как же?", "Ты не похож на этих психов из Новой Деревни", "pop_uf_under_psycho_Main_Q()", "Что-то есть в тебе такое особенное.", "pop_uf_under_spec_Main_Q()", "Рожа мне твоя знакома, видел тебя в Новом Вегасе", "pop_uf_under_seen_Main_Q()", "Эээ.. Ну... По голосу... И.. Это... Глаза у тебя как-то бегали...", "pop_uf_under_body_Main_Q()" )
end

function pop_uf_under_psycho_Main_Q ()
	exports.players:givePlayerXPClient ( 100 )
	showQuestWindow ( "Моряк Попай", "Ахаха, ну, это да, что есть, то есть. Но сейчас у меня есть к тебе деловое предложение от Мэра Смита.", "Это от того говнюка, что похитил меня?", "pop_uf_shit_Main_Q()", "Слушаю.", "pop_uf_list_Main_Q()", "0", "", "0", "" )
end

function pop_uf_under_spec_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Да ладно врать то, нихрена ты не понял. А я то уж испугался, что теряю сноровку. Но не суть, у меня есть к тебе деловое предложение от Мэра Смита.", "Это от того говнюка, что похитил меня?", "pop_uf_shit_Main_Q()", "Слушаю.", "pop_uf_list_Main_Q()", "0", "", "0", "" )
end

function pop_uf_under_seen_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Да ладно врать то, я в Вегасе уже месяца два не бывал, нихрена ты меня заранее не разгадал. А я то уж испугался, что теряю хватку. Но не суть, у меня есть к тебе деловое предложение от Мэра Смита.", "Это от того говнюка, что похитил меня?", "pop_uf_shit_Main_Q()", "Слушаю.", "pop_uf_list_Main_Q()", "0", "", "0", "" )
end

function pop_uf_under_body_Main_Q ()
	exports.players:givePlayerXPClient ( 200 )
	showQuestWindow ( "Моряк Попай", "Видать теряю сноровку... Но не суть, у меня есть к тебе деловое предложение от Мэра Смита.", "Это от того говнюка, что похитил меня?", "pop_uf_shit_Main_Q()", "Слушаю.", "pop_uf_list_Main_Q()", "0", "", "0", "" )
end

function pop_uf_supostat_Main_Q ()
	exports.players:givePlayerXPClient ( 200 )
	showQuestWindow ( "Моряк Попай", "Тише ты, а то нас обоих вояки загребут. Послушай, мы же оба понимаем, что тебе нахрен эта сраная Новая Деревня не нужна. А у Мэра Смита есть для тебя достойное деловое предложение.", "Это тот говнюк, что похитил меня?", "pop_uf_shit_Main_Q()", "Слушаю.", "pop_uf_list_Main_Q()", "0", "", "0", "" )
end

function pop_uf_shit_Main_Q()
	showQuestWindow ( "Моряк Попай", "Щенок, знал бы ты, что значит быть похищенным нашей мафией, ты бы сразу понял, что тот инцидент - это всего-лишь была дружеская поездка.", "Хорошо, я тебя слушаю.", "pop_uf_list_Main_Q()", "Не к добру это, но, ладно, я тебя слушаю.", "pop_uf_list_Main_Q()", "0", "", "0", "" )
end

function pop_uf_list_Main_Q ()
	showQuestWindow ( "Моряк Попай", "Отправляйся в Новый Вегас, там иди в штаб-квартиру мафии и поговори с Мэром Смитом, он тебе все обьяснит.", "Уже отправляюсь.", "pop_uf_go_Main_Q()", "0", "pop_uf_list_Main_Q()", "0", "", "0", "" )
end

function pop_uf_go_Main_Q ()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_main", 2 )
	setElementData ( localPlayer, "quest_main_st", 11 )
	updateCompassMarker ()
	changeMissionBlip()
end

function mayor_start_Main_Q ()
	showQuestWindow ( "Сэм Смит", "Доброй ночи, хотя, у нас ведь тут всегда ночь, и она всегда не добрая.", "Где-то я это слышал. Не напомнишь, где и когда?", "mayor_start_forg_Main_Q()", "Что ты хотел, Сэм?", "mayor_start_t_Main_Q()", "0", "", "0", "" )
end

function mayor_start_forg_Main_Q ()
	showQuestWindow ( "Сэм Смит", "Да ладно тебе, мы же тебя вернули в целости и сохранности.", "Что там у тебя за предложение ко мне?", "mayor_start_t_Main_Q()", "0", "pop_uf_list_Main_Q()", "0", "", "0", "" )
end

function mayor_start_t_Main_Q ()
	showQuestWindow ( "Сэм Смит", "Как ты наверное знаешь, этот пьяница Початок нашел тебя около подлодки. Мы, как не старались, не смогли попасть в нее, там стоит сканер отпечатков пальцев. А ты видимо плавал на этой подводной лодке и тебя она должна пропустить. Вот, кстати, к вопросу о доверии. Мы могли бы просто отрезать у тебя пальцы и воспользоваться ими, но нет, мы предлагаем тебе это сделать это самостоятельно, да и еще деньжат доплатим, 2000 крышек думаю будет достаточно.", "Странно это все, но я согласен.", "mayor_start_task_Main_Q()", "Я давно хотел узнать почему я здесь оказался.", "mayor_start_task_Main_Q()", "0", "", "0", "" )
end

function mayor_start_task_Main_Q ()
	showQuestWindow ( "Сэм Смит", "После того, как проникнешь на подлодку, отключи там систему защиты и возвращайся. Задание - легче легкого, даже незнаю, почему я тебе пообещал целых 2000 крышек за него.", "Все, я отправляюсь.", "mayor_start_begin_Main_Q()", "0", "mayor_start_task_Main_Q()", "0", "", "0", "" )
end

function mayor_start_begin_Main_Q()
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	exports.pipboy:addInfoBox("Получено задание \"Новые преключения!\"", 3 )
	setElementData ( localPlayer, "quest_main", 1 )
	setElementData ( localPlayer, "quest_main_st", 12 )
	updateCompassMarker ()
	exports.players:givePlayerXPClient ( 500 )
	changeMissionBlip()
end

function doc_submarine_talk()
	showQuestWindow ( "Доктор 0", "ВЕЛИКОЛЕПНО! Я не ожидал, что программа \"Протектотрон-23\" сможет справиться со всеми тестами.", "Эй, ты хто и что тут делаешь??", "doc_whowhat_talk()", "О чем ты?!", "doc_whowhat_talk()", "0", "", "0", "" )
end

function doc_whowhat_talk()
	showQuestWindow ( "Доктор 0", "Как-же эволюционировал искусственный интелект! Позволь представиться, я - Доктор 0, твой создатель. А ты - тестовый образец программы \"Протектотрон\" за номером 23. Мы с тобой в данный момент находимся в исскуственно смоделированном мире, который в свою очередь находится на старой советской подводной базе в сибире.", "У тебя все в порядке с головой??", "doc_head_talk()", "Да быть этого не может!", "doc_nhead_talk()", "0", "", "0", "" )
end

function doc_head_talk ()
	showQuestWindow ( "Доктор 0", "У меня с ней все в полном порядке, раз я смог создать такого идеального робота! Первые 22 робота не могли закончить тестовые испытания, перегружаясь в разнные моменты. А ты - практически идеален. Мы можем выпускать тебя в серию. Все, парни, выключайте его...", "ЧТО?!", "doc_turnoff_talk()", "Я не дамся вам!", "doc_turnoff_talk()", "0", "", "0", "" )
end

function doc_nhead_talk ()
	showQuestWindow ( "Доктор 0", "Я тоже не могу в это поверить, но мне все же удалось создать такого идеального робота! Первые 22 робота не могли закончить тестовые испытания, перегружаясь в разнные моменты. А ты - практически идеален. Мы можем выпускать тебя в серию. Все, парни, выключайте его...", "ЧТО?!", "doc_turnoff_talk()", "Я не дамся вам!", "doc_turnoff_talk()", "0", "", "0", "" )
end

function doc_turnoff_talk()
	local music = playSound ( "sounds/again.ogg" )
	setSoundVolume(music, 0.2)
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	exports.achievments:givePoint ( 5 )
	setElementData ( localPlayer, "quest_main", 2 )
	setElementData ( localPlayer, "quest_main_st", 12 )
	exports.players:givePlayerXPClient ( 500 )
	setPedAnimation ( localPlayer, "RYDER", "RYD_Die_PT2", -1, false, false, false, false )
	fadeCamera ( false, 3 ) 
	setTimer ( function ()
					setElementPosition ( localPlayer, -755.8837890625, 2043.834960937, 60 )
					setElementDimension ( localPlayer, 0 )
					fadeCamera ( true, 2 )
					setPedAnimation ( localPlayer )
				end, 94000, 1 )
	setTimer ( function () 
					setElementPosition ( localPlayer, -755.8837890625, 2043.834960937, 60 )
					setElementDimension ( localPlayer, math.random ( 1, 1000 ) )
					beginFinishPart1()
				end, 5000, 1 )
end

finMsg = {
	{ "Вот ты и закончил основной сюжет, надеюсь тебе было весело.", 255, 255, 255, 5 },
	{ "Создатель - PrettySweetie aka Андрей Муравенко.", 255, 255, 255, 5 },
	{ "Помошнички - Angel01 и DrigaDriga.", 255, 255, 255, 4 },
	{ "Отдельное спасибо - BenLaden.", 255, 255, 255, 3 },
	{ "Но это, конечно же, не все.", 255, 255, 255, 4 },
	{ "Закончена тобой только первая часть сюжета.", 255, 255, 255, 4 },
	{ "Примерно через месяц будет готово продолжение.", 255, 255, 255, 5 },
	{ "Подробнее - на сайте je-ho.ru и группе vk.com/jehorpg", 255, 255, 255, 8 },
	{ "Послушай, кажется Доктор 0 что-то говорит.", 255, 255, 255, 4 },
	{ "Доктор 0: Что? Вы уверены?", 255, 255, 255, 4 },
	{ "Доктор 0: Значит придется задержаться и провести еще тесты.", 255, 255, 255, 6 },
	{ "Доктор 0: Возвращаем его, пускай пока продолжает текущую серию тестов.", 255, 255, 255, 8 },
	{ "Доктор 0: Мы должны успеть за месяц подготовить новую серию тестов.", 255, 255, 255, 8 },
	{ "Доктор 0: Назревает война, мы должны как можно быстрее подготовить протектотронов.", 255, 255, 255, 8 },
	{ "Доктор 0: Выпустите его в Новой Деревне и сотрите ему память про все то, что я говорил", 255, 255, 255, 8 },
	{ "Хитер Доктор 0, не так ли?", 255, 255, 255, 4 },
	{ "Жди продолжения сюжета!", 255, 255, 255, 3 },
}

function beginFinishPart1 ()
	local offsetTime = 1
	for i = 1, #finMsg do
		setTimer ( function ()
						exports.textLib:showMessageDX ( finMsg[i][1], finMsg[i][5], finMsg[i][2], finMsg[i][3], finMsg[i][4] )
				   end, offsetTime*1000, 1 )
		offsetTime = offsetTime + finMsg[i][5]
	end

end


--

function startMainPart2 ()
	showQuestWindow ( "Сэм Смит", "Ты отлично справился! Теперь у нас есть доступ к подлодке. Я уже отправил туда несколько исследователей, они обещали скоро вернутся. Вот твоя награда.", "Отлично, есть еще задания?", "msam_ntask_Main_Q()", "Странно, я ничего не помню", "msam_nrem_Main_Q()", "0", "", "0", "" )
end

function msam_nrem_Main_Q()
	exports.players:givePlayerXPClient ( 100 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 2000 )
	showQuestWindow ( "Сэм Смит", "Бывает. Ты главное знай - работа выполнена так отлично, что я решил дать тебе еще одну работенку.", "Ну, выкладывай", "msam_ntask_s_Main_Q()", "0", "", "0", "", "0", "" )
end

function msam_ntask_Main_Q()
	exports.players:givePlayerXPClient ( 100 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 2000 )
	showQuestWindow ( "Сэм Смит", "Конечно есть, ты ведь отлично выполнил свою первую миссию.", "Ну, выкладывай", "msam_ntask_s_Main_Q()", "0", "", "0", "", "0", "" )
end

function msam_ntask_s_Main_Q()
	showQuestWindow ( "Сэм Смит", "Ты бывал когда нибуть в поселении Кламат?", "Да", "msam_s_kl_y_Main_Q()", "Нет", "msam_s_kl_y_Main_Q()", "0", "", "0", "" )
end

function msam_s_kl_y_Main_Q()
	showQuestWindow ( "Сэм Смит", "Отлично, значит ты знаешь про Джона Генри Эдема, того парня, что хочет стать там мэром и захватить весь штат. Я хочу, чтоб ты совершил на него покушение.", "Как он собирается захватить весь штат?", "msam_s_kl_how_con_Main_Q()", "0", "msam_s_kl_nk_Main_Q()", "0", "", "0", "" )
end

function msam_s_kl_n_Main_Q()
	showQuestWindow ( "Сэм Смит", "Посмотришь у себя в PipBoy где он находится. Там есть парень, которого зовут Джон Генри Эдем. Он хочет стать мэром Кламата и захватить весь штат. Я хочу, чтоб ты совершил на него покушение.", "Как он собирается захватывать весь штат?", "msam_s_kl_how_con_Main_Q()", "0", "", "0", "", "0", "" )
end

function msam_s_kl_how_con_Main_Q()
	showQuestWindow ( "Сэм Смит", "Лучше я об этом умолчу. Главное знай, что не поздоровится в связи захватом власти Эдемом всем, в том числе и тебе", "Как он собирается захватывать весь штат?", "msam_s_kl_how_con_Main_Q()", "0", "", "0", "", "0", "" )
end

function msam_s_kl_how_Main_Q()
	--showQuestWindow ( "Сэм Смит", "Посмотришь у себя в PipBoy где он находится. Там есть парень, которого зовут Джон Генри Эдем. Он хочет стать мэром Кламата и захватить весь штат. Я хочу, чтоб ты совершил на него покушение.", "Без проблем, только как?", "msam_s_kl_how_Main_Q()", "Я не убиваю людей", "msam_s_kl_nk_Main_Q()", "0", "", "0", "" )
end


function finish()

end