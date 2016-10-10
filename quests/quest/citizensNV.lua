local localPlayer = getLocalPlayer ()

-- Новый Вегас

-- Чудак

function nv_Insane_Q (x,y,z)
	local sound = playSound3D( "sounds/nv/insane.wav", x, y, z ) 
	setSoundMaxDistance( sound, 3 )
	showQuestWindow ( "Чудак", "Можете убииить меняяя, если хотитеее, нооо яяяя вам нииичего не скажууу о том, где мооои побрякууушки спрятаааны!", "Не скажешь чего?", "nv_Insane_No()", "Не больно то и хотелось", "", "Ты вообще кто?", "nv_Insane_No()", "0", "president_Main_Q()" )
end

function nv_Insane_No ()
--	outputChatBox ("Информация: Получено задание \"Чудак из Вегаса\"", 0,153,51 )
	setElementData ( localPlayer, "quest_nvinsane", 1 )	
	showQuestWindow ( "Чудак", "Чтооо то мне твое лииицо не знакооомо, навееерно ты недавнооо прибыл в эту обииитель порокааа и злааа. Эээто хорошооо, знааачит я еще моооогу спааасти твоб душуууу! Буууду ждааать тебя у бооольшого камня в пооолдень.", "Чтооо?", "nv_Insane_Start()", "Почему ты так странно говоришь?", "nv_Insane_Start()", "Где?", "nv_Insane_Start()", "0", "president_Main_Q()" )
end

function nv_Insane_Start ()
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_nvinsane", 1)
	exports.pipboy:addInfoBox("Получено задание \"Чудак из Вегаса\"", 3 )
	updateCompassAdditMarker ( 2, 1 )
	outputChatBox ("Подсказка: Отправляйтесь к большому камню.", 255,255,255 )
	outputChatBox ("Чудак: Яяя будууу ждать тебя у большого кааамня в полдееень!", 255,255,255 )
end

function nv_fin_Insane_Q ()
	showQuestWindow ( "Чудак", "Яяя будууу ждать тебя у большого кааамня в полдееень!", "Послушай, я уничтожил твою банду", "nv_f_band_Insane_Start()", "Хооорооошооо", "", "0", "", "0", "" )
end

function nv_f_band_Insane_Start ()
	showQuestWindow ( "Чудак", "Дааак тыыы всеее заааееешь. Проооошуууу, неее губиии.", "Если ты мне заплатишь", "nv_f_pay_Insane_Start()", "Нет, я все расскажу Сэму Смиту", "nv_f_pay_Insane_Start()", "0", "", "0", "" )
end

function nv_f_pay_Insane_Start ()
	exports.inventory:givePlayerItem ( 34, 1 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 500 ) 
	showQuestWindow ( "Чудак", "Воооот, держииии этоот пистолеет и 500 крышек. Этооо всеее, что уу меняя есть.", "Хорошо, можешь идти", "nv_Insane_Finish()", "Этого малооооо", "nv_f_enoght_Insane_Start()", "0", "", "0", "" )
end

function nv_f_enoght_Insane_Start ()
	exports.inventory:givePlayerItem ( 7, 3 )
	showQuestWindow ( "Чудак", "Лааадно, дееержиии эти 3 пачкиииии ааааантираааадаааа.", "Хорошо, можешь идти", "nv_Insane_Finish()", "0", "", "0", "", "0", "" )
end

function nv_Insane_Finish ()
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_nvinsane", 4)
	updateCompassAdditMarker ( 2, 4 )
	exports.achievments:givePoint ( 1 )
end

----

-- Бар Мегатонна

-- Вышибала

function talkKickerNV () -- Лас Пайсадас
	showQuestWindow ( "Вышибала", "Добро пожаловать в бар \"Мегатонна\". Лучшее и единственное место для того, чтоб напиться во всем Новом Вегасе. Только не дебоширь, я тут за порядком слежу.", "Что-то ты не похож на сильного парня.", "sillyKickerNV()", "Почему это единственный бар в Новом Вегасе?", "theoneKickerNV()", "Есть тут что интересное?", "intrKickerNV()", "*оставить без внимания*", "nolookKickerNV()" )
end

function sillyKickerNV ()
	showQuestWindow ( "Вышибала", "Очень смешно. Но на самом деле я и сам то не очень хотел тут работать, однако больше мест для работы мне найти не удалось. Хотя моих сил как раз хватает на пьянчуг всяких, чтоб выкидывать их отсюда.", "Почему это единственный бар в Новом Вегасе?", "theoneKickerNV()", "Есть тут что интересное?", "intrKickerNV()", "Ладно, пойду я", "byeKickerNV()", "0", "" )
end

function theoneKickerNV ()
	showQuestWindow ( "Вышибала", "Знаешь ли, не так-то легко стало доставать спиртные напитки, когда мир полетел к чертям. Ну а владелец \"Мегатонны\", вроде как, знает несколько складов в пригородах Лас Вентурса, где выпивки выше крыши.", "Что-то ты не похож на сильного парня.", "sillyKickerNV()", "Ладно, пойду я", "byeKickerNV()", "Есть тут что интересное?", "intrKickerNV()", "0", "nolookKickerNV()" )
end

function intrKickerNV ()
	showQuestWindow ( "Вышибала", "Спрашивай у бармена, мне нечего тебе сказать по этому поводу.", "Что-то ты не похож на сильного парня.", "sillyKickerNV()", "Почему это единственный бар в Новом Вегасе?", "theoneKickerNV()", "Ладно, пойду я", "byeKickerNV()", "0", "nolookKickerNV()" )
end

function byeKickerNV()
	return true
end

function nolookKickerNV()
	outputChatBox ("Вышибала: Тебя я выкину отсюда первым.", 255,255,255 )
end

----

function barman_talk_NV() -- Лас Пайсадас
	if getElementData ( localPlayer, "quest_nvinsane" ) == 1 then
		showQuestWindow ( "Бармен", "Добро пожаловать в бар \"Мегатонна\", странник. Будешь что нибуть пить?", "Да, я с радостью.", "exports.traders:showTraderWindow(\"megatonna\")", "Я тут одного чудака повстречал", "insane_BarmanNV()", "Да нет, спасибо", "byeKickerNV()", "0", "" )
	else
		showQuestWindow ( "Бармен", "Добро пожаловать в бар \"Мегатонна\", странник. Будешь что нибуть пить?", "Да, я с радостью.", "exports.traders:showTraderWindow(\"megatonna\")", "Чем тут можно заняться?", "todoBarmanNV()", "Почему город называется Новый Вегас?", "whynvBarmanNV()", "Да нет, спасибо", "byeKickerNV()" )
	end
end

function insane_BarmanNV ()
	showQuestWindow ( "Бармен", "Аа, очередной агнец на заклание пришел...", "Что ты сказал?!", "insane_agnec_BarmanNV()", "0", "insane_BarmanNV()", "0", "byeKickerNV()", "0", "" )
end

function insane_agnec_BarmanNV ()
	showQuestWindow ( "Бармен", "Что?!", "\"Очередной агнец на заклание пришел\"", "insane_true_BarmanNV()", "0", "insane_BarmanNV()", "0", "byeKickerNV()", "0", "" )
end

function insane_true_BarmanNV ()
	showQuestWindow ( "Бармен", "Я что, это в слух чтоль сказал???!!! Мамма мия, похоже у меня проблемы.", "Ну-ка, выкладывай все на чистоту", "insane_tr_BarmanNV()", "Да-да, у тебя проблемы", "insane_tr_BarmanNV()", "0", "byeKickerNV()", "0", "" )
end

function insane_tr_BarmanNV ()
	showQuestWindow ( "Бармен", "Ладно, мне проблемы не нужны, слушай сюда. На самом деле у этого парня нет никаких побрякушек, он просто-напросто обманщик, заманивает с моей помощью людей в засаду, а там их убивает.", "Вот это поворот, пойду-ка я сним разберусь", "insane_go_BarmanNV()", "Ха, отличная схема", "insane_go_BarmanNV()", "0", "byeKickerNV()", "0", "" )
end

function insane_go_BarmanNV ()
	showQuestWindow ( "Бармен", "Но похоже, что Сэм Смит все разнюхал, мне надо замести следы. Давай так - я говорю тебе, где их база, а ты наведываешся туда, убиваешь их всех, и говоришь Чудаку, что все кончено.", "С радостью", "insane_got_BarmanNV()", "Конечно", "insane_got_BarmanNV()", "0", "byeKickerNV()", "0", "" )
end

function insane_got_BarmanNV ()
	exports.players:givePlayerXPClient ( 100 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_nvinsane", 2)
	updateCompassAdditMarker ( 2, 2 )
	outputChatBox ("Бармен: Отправляйся в ангар старого аэропорта. Их там будет два человека.", 255, 255, 255 )
end


function todoBarmanNV () 
	showQuestWindow ( "Бармен", "Я бы посоветовал тебе отправиться на арену зомби, там можно поднять неплохие деньги, если ты умеешь стрелять. И еще поговори вон с тем мужиком в черном, у него возможно есть что тебе предложить, в плане работы.", "Я бы выпить хотел", "exports.traders:showTraderWindow(\"megatonna\")", "Спасибо за информацию", "byeKickerNV()", "Почему город называется Новый Вегас?", "whynvBarmanNV()", "0", "byeKickerNV()" )
end

function whynvBarmanNV () 
	showQuestWindow ( "Бармен", "Знаешь, я всю свою жизнь прожил в этом городе, только раньше он назывался Лас Пайсадас, старое название ты все еще можешь увидеть на указателях. После того, как случилась вся эта хренотень с зомби, в город пришел Джонс со своими бандитами. Они восстановили тут порядок, возвели стены вокруг города, и, в честь этого события, город стал называться Джонстаун. Но мэр Джонс через некоторое время скончался, а к власти пришел Сэм Смит. Сэмми, в старом мире, был в банде, заправляющей одним из казино на стрипе. Ну и он решил превратить этот город в Новый Вегас. Но, как ты можешь заметить, у него это не очень хорошо получается.", "Я бы выпить хотел", "exports.traders:showTraderWindow(\"megatonna\")", "Чем тут можно заняться?", "todoBarmanNV()", "Спасибо за информацию", "byeKickerNV()", "0", "byeKickerNV()" )
end

function barman_find_start_NV ()
	showQuestWindow ( "Бармен", "Добро пожаловать в бар \"Мегатонна\", странник. Не хочешь подзаработать крышек?", "Да, я с радостью.", "barman_find_tell_NV()", "Я бы выпить хотел", "exports.traders:showTraderWindow(\"megatonna\")", "Почему город называется Новый Вегас?", "whynvBarmanNV()", "Да нет, спасибо", "byeKickerNV()" )
end

function barman_find_tell_NV ()
	showQuestWindow ( "Бармен", "Недавно до меня доползли слухи о том, что, мол, Караванщики создали небольшое поселение, в котором продают жутко дешевые товары. Я, чтоб проверить эти слухи, послал одного из местных пьяниц, Бобби Чарльтона на поиски этого поселения. Но он пропал. Может поищешь его? Говорят, что поселение находится где-то в пригороде Лас Вентураса. Награда обеспечена.", "Сложно конечно будет, но я попробую найти.", "barman_find_get_NV()", "Где-то я уже слышал об этом поселении.", "barman_find_get_NV()", "0", "whynvBarmanNV()", "0", "byeKickerNV()" )
end

function barman_find_get_NV ()
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_findtp", 1)
	exports.pipboy:addInfoBox("Получено задание \"Торговый Пост\"", 3 )
	updateCompassAdditMarker ( 3, 1 )
end

function barman_find_finish_NV ()
	showQuestWindow ( "Бармен", "Как поиски продвигаются?", "Я нашел поселение и его самого", "barman_find_fin2_NV()", "Пока никак", "", "0", "whynvBarmanNV()", "0", "byeKickerNV()" )
end

function barman_find_fin2_NV ()
	showQuestWindow ( "Бармен", "Дак он живой?! Ладно, дальше я сам с ним разберусь. В награду я дам тебе 10 Монет Сьерра Мадре.", "...", "barman_find_finita_NV()", "0", "", "0", "whynvBarmanNV()", "0", "byeKickerNV()" )
end

function barman_find_finita_NV ()
	exports.inventory:givePlayerItem ( 21, 10 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_findtp", 4)
	updateCompassAdditMarker ( 3, 4 )
	exports.achievments:givePoint ( 1 )
end

function talkArenaBoss()
	showQuestWindow ( "Распорядитель арены", "Добро пожаловать на арену гулей. Я вижу ты крутой парень, не хочешь испытать себя?", "Хочу", "arena_boss_want()", "Что это за место?", "arena_boss_whatis()", "Я хочу получить свой приз", "arena_boss_reward()", "Нет, спасибо", "" )
end

local wait

function arena_boss_want ()
	if wait then return true end
	wait = true
	setTimer ( function () wait = nil end, 2000, 1 )
	triggerServerEvent ("zombie_arena:wantToStartArena",localPlayer)
end	

function arena_boss_whatis()
	showQuestWindow ( "Распорядитель арены", "На этой арене странники со всего штата испытывают свои силы в борьбе с гулями в тесном пространстве. Некоторые оказываются удачливы, и выигрывают призы. Участие в выживании на арене бесплатное.", "Отлично, я хочу принять участие", "arena_boss_want()", "Это не опасно?", "arena_boss_danger()", "Нет уж", "", "0", "" )
end

function arena_boss_danger()
	showQuestWindow ( "Распорядитель арены", "Сам то подумай, если бы она была на 100 процентов безопасна, ходил бы кто нибуть на нее смотреть? Но если гули накостыляют тебе так, что ты потеряешь сознание, мы тебя быстренько оттуда вытащим.", "Отлично, я хочу принять участие", "arena_boss_want()", "Нет уж", "", "0", "", "0", "" )
end

function arena_boss_reward()
	triggerServerEvent ("zombie_arena:checkPlayerReward",localPlayer)
end