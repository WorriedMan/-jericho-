local localPlayer = getLocalPlayer ()

-- Поселок Хиггса #76

function stark_talk_HC ()
	local quest = getElementData ( localPlayer, "quest_check" )
	if quest == 0 then
		showQuestWindow ( "Баттерс Стотч", "Добро пожаловать в Роадтаун путник. Я Баттерс! Чего тебе надо от мэра этого поселения?", "Можно у тебя кое что спросить?", "stark_talk_intr_HC()", "Пока", "", "Есть работенка?", "syag_t_work_KL()", "0", "" )
	elseif quest > 0 and quest < 8 then
			showQuestWindow ( "Баттерс Стотч", "Поторопись, иначе ценная информация может пропасть.", "Можно у тебя кое что спросить?", "stark_talk_intr_HC()", "Попытаюсь", "", "0", "", "0", "" )
	elseif quest == 8 then
		exports.pipboy:addInfoBox ( "Вы отдали брелок компании \"Big MT\"", 3 )
		showQuestWindow ( "Баттерс Стотч", "Отлично сработано, дружище! От трансмитеров идет стабильный сигнал. Вот твоя награда.", "Всегда рад помочь", "stark_quest_fin_HC()", "Обожаю эту часть", "stark_quest_fin_HC()", "0", "", "0", "" )	
	elseif quest == 10 then
		local amount = exports.inventory:getItemAmount(128)
		if amount == 1 then
			showQuestWindow ( "Баттерс Стотч", "Спасибо, я думаю ты набрал много Сансет Саспариллы у них. Заходи к нам еще, может появятся новые задания. А, и руку можешь оставить себе.", "Мдэ, спасибо", "", "0", "", "0", "", "0", "" )	
			stark_finished_HC()
		elseif amount > 1 then
			showQuestWindow ( "Баттерс Стотч", "Спасибо, но мне было достаточно одной руки. Ты, должно быть, набрал у них много Сансет Саспариллы. Заходи к нам еще, может появятся новые задания. А, и все эти вонючие руки можешь оставить себе.", "Мдэ, спасибо", "", "0", "", "0", "", "0", "" )	
			stark_finished_HC()
		else
			showQuestWindow ( "Баттерс Стотч", "Привет. Надеюсь ты скоро разберешся с теми мутантами?", "Можно у тебя кое что спросить?", "stark_talk_intr_HC()", "Не парься, я уже в пути", "", "0", "", "0", "" )	
		end
	elseif quest == 9 then
		stark_continue_quest()
	else
		showQuestWindow ( "Баттерс Стотч", "Привет. Ты всегда желанный гость в нашем городе.", "Можно у тебя кое что спросить?", "stark_talk_intr_HC()", "Спасибо", "", "Есть работенка?", "", "0", "" )	
	end
end

function stark_quest_fin_HC ()
	setElementData ( localPlayer, "quest_check", 9 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 500 )
	exports.inventory:givePlayerItemWW (58,5)
	showQuestWindow ( "Баттерс Стотч", "Но не спеши расслабляться, у меня есть еще задание для тебя. Мы заключили договор с торговцем из Нового Вегаса на поставку для него всей Сансет Саспариллы, которую мы только найдем. Но вся беда в том, что первый же караван разграбили мутанты. Пожалуйста, разберись с ними. В замен можешь забрать всю Сансет Саспариллу, какую только сможешь найти у них. В качестве доказательства очистки принеси руку их главного мутанта.", "Терпеть не могу мутантов", "stark_killmuts_HC()", "Без проблем", "stark_killmuts_HC()", "0", "", "0", "" )	
	exports.players:givePlayerXPClient ( 700 )
end

function stark_continue_quest()
	showQuestWindow ( "Баттерс Стотч", "Привет, у меня есть новое задание для тебя. Мы заключили договор с торговцем из Нового Вегаса на поставку для него всей Сансет Саспариллы, которую мы только найдем. Но вся беда в том, что первый же караван разграбили мутанты. Пожалуйста, разберись с ними. В замен можешь забрать всю Сансет Саспариллу, какую только сможешь найти у них. В качестве доказательства очистки принеси руку их главного мутанта.", "Терпеть не могу мутантов", "stark_killmuts_HC()", "Без проблем", "stark_killmuts_HC()", "0", "", "0", "" )	
end

function stark_killmuts_HC ()
	setElementData ( localPlayer, "quest_check", 10 )
	showQuestWindow ( "Баттерс Стотч", "Я знал что на тебя можно положиться. Говорят, что их логово находиться где то рядом с той большой надписью VINEWOOD. Я думаю тебе стоит поискать там.", "Выдвигаюсь", "", "0", "", "0", "", "0", "" )	
end

function stark_finished_HC ()
	setElementData ( localPlayer, "quest_check", 11 )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 500 )
	exports.players:givePlayerXPClient ( 2000 )
	exports.pipboy:addInfoBox ( "Задание \"Перезагрузка\" завершено.", 3 )
end

function stark_talk_intr_HC ()
	showQuestWindow ( "Баттерс Стотч", "Валяй", "Расскажи про ваш город", "stark_talk_cname_HC()", "Опасно тут у вас", "stark_talk_bands_HC()", "Я передумал", "", "0", "" )
end

function stark_talk_cname_HC ()
	showQuestWindow ( "Баттерс Стотч", "Как ты заметил, мы находимся на окраине Лос Сантоса, а вернее на автомагистрали. Если надо купить припасы, то подойди к торговому роботу Роберт Мэйфлауэр. Больше ты тут вряд ли что то найдешь. Наше поселение используется как перевалочный пункт в пути на север.", "Спасибо за информацию", "", "У меня есть еще вопрос.", "stark_talk_intr_HC()", "0", "", "0", "" )
end

function stark_talk_bands_HC ()
	showQuestWindow ( "Баттерс Стотч", "А то. Это тебе не пустыня, где три поселения поделили сферы влияния и контролируют их. Лос Сантос - ни кем не занятая территория, она так и манит к себе всякий сброд. А этот сброд использует наше поселение как перевалочный пункт на пути к Кламату, откуда уже рукой подать до пустыни, где они все награбленное сбывают торговцам.", "Спасибо за информацию", "", "У меня есть еще вопрос.", "stark_talk_intr_HC()", "0", "", "0", "" )
end

-- function stark_talk_bands_HC ()
	-- showQuestWindow ( "Баттерс Стотч", "А то. Это тебе не пустыня, где три поселения поделили сферы влияния и контролируют их. Лос Сантос - ни кем не занятая территория, она так и манит к себе всякий сброд. А этот сброд использует наше поселение как перевалочный пункт на пути к Кламату, откуда уже рукой подать до пустыни, где они все награбленное сбывают торговцам.", "Спасибо за информацию", "", "У меня есть еще вопрос.", "stark_talk_intr_HC()", "0", "", "0", "" )
-- end


function syag_t_work_KL ()
	if getElementData ( localPlayer, "quest_check" ) == 0 then
		showQuestWindow ( "Баттерс Стотч", "Кое-что есть. Надо поездить по городу и перезапустить трансмиттеры.", "Что за трансмитиеры?", "syag_t_work_transm_KL()", "Без проблем!", "syag_t_work_start_KL()", "0", "", "0", "" )
	else
		outputChatBox ( "Баттерс Стотч: Больше ничего нет", 255,255,255 )
	end
end


function syag_t_work_transm_KL ()
	showQuestWindow ( "Баттерс Стотч", "Передающие устройства. Они собирают информацию, и через старые кабели передают ее в Союз Ученых. Взамен мы получаем поставки Антирада и Стимуляторов. Какая это информация - я точно не знаю, что-то вроде о загрязнении окружающей среды химикатами. Вобщем не суть важна. Главное - это перезапускать их, когда они, бывает, перегреваются.", "И как их перезапустить?", "syag_t_work_reload_KL()", "Без проблем!", "syag_t_work_start_KL()", "0", "", "0", "" )
end

function syag_t_work_reload_KL ()
	showQuestWindow ( "Баттерс Стотч", "У них настроен автоматический автозапуск при подходе человека со специальным брелоком, который я дам тебе. Главное перезапустить их все в правильном порядке. Я закачаю тебе в Пипбой карту, которая поможет разобраться с порядком включения трансмитеров. Все, отправляйся. Как только перезапустишь их все, я дам тебе награду. О ней поговорим по твоему прибытию.", "Уже бегу", "syag_t_work_start_KL()", "Без проблем!", "syag_t_work_start_KL()", "0", "", "0", "" )
end

function syag_t_work_start_KL ()
	updateCompassAdditMarker (11,1)
	outputChatBox ( "Баттрес Стотч: Буду ждать тебя", 255,255,255 )
	exports.pipboy:addInfoBox ( "Получено задание \"Перезагрузка\"", 3 )
	setElementData ( localPlayer, "quest_check", 1 )
	exports.pipboy:addInfoBox ( "Получен брелок компании \"Big MT\"", 3 )
	checkingTransmitter = createColSphere (lsmarkers[1].x,lsmarkers[1].y, lsmarkers[1].z, 4 )
	checkingTransmitterIcon = exports.pipboy:addMapIcon ( lsmarkers[1].x,lsmarkers[1].y, lsmarkers[1].z, 3, 'Трансмиттер' ) or 0 
	addEventHandler("onClientColShapeHit",checkingTransmitter,loadNextTransmitter)
end

--addCommandHandler ( "trt", syag_t_work_start_KL )

function loadNextTransmitter (hitElement)
	if hitElement == localPlayer then
		local id = getElementData ( localPlayer, "quest_check" )+1
		setElementData ( localPlayer, "quest_check", id )
		exports.players:givePlayerXPClient ( lsmarkers[id-1].xp )
		exports.pipboy:deleteMapIcon ( checkingTransmitterIcon )
		destroyElement ( checkingTransmitter )
		playSound ( "sounds/obj_radiotoweractivate.wav" )
		updateCompassAdditMarker (12,id)
		if id <= #lsmarkers then
			checkingTransmitter = createColSphere (lsmarkers[id].x,lsmarkers[id].y, lsmarkers[id].z, 4 )
			exports.pipboy:addInfoBox ( 'Вы запустили трансмитер #'..id, 2 )
			checkingTransmitterIcon = exports.pipboy:addMapIcon ( lsmarkers[id].x,lsmarkers[id].y, lsmarkers[id].z, 3, 'Трансмитер' ) or 0
			addEventHandler("onClientColShapeHit",checkingTransmitter,loadNextTransmitter)		
		else
			exports.pipboy:addInfoBox ( 'Все трансмиттеры запущены. Возвращаемся в Роадтаун.', 2 )
		end
	end
end

-- Вэнди Стотч
function talkWendyHC ()
	showQuestWindow ( "Вэнди Стотч", "Очередной путешественник в нашем городе? Добро пожаловать!", "Доброго дня", "", "Можно спросить у вас кое что?", "wendy_talk_HC()", "0", "", "0", "" )
end

function wendy_talk_HC ()
	showQuestWindow ( "Вэнди Стотч", "Конечно, дорогуша.", "Кто ты?", "wendy_talk_who_HC()", "Ты местная?", "wendy_talk_from_HC()", "Чем тут у вас можно заняться?", "wendy_talk_work_HC()", "Я передумал", "" )
end

function wendy_talk_who_HC ()
	showQuestWindow ( "Вэнди Стотч", "Я жена мэра Роадтауна Баттерса Стотча, Вэнди Стотч. Я тут ничем почти и не занимаюсь, только целыми днями общаюсь с путешественниками, которые используют наше поселение как перевалочный пункт. Правда сегодня что-то только ты один у нас тут, да Вилли со своей бандой.", "У меня есть еще вопрос", "wendy_talk_HC()", "Спасибо, красавица", "outputChatBox ( \"Вэнди Стотч: Обращайся ко мне в любое время\", 255,255,255 )", "0", "", "0", "" )
end

function wendy_talk_from_HC ()
	showQuestWindow ( "Вэнди Стотч", "Нееет. Я родилась в городке Саус Парк в Колорадо. Потом переехала сюда со своим мужем Баттерсом и другом семьи Стэном Маршем. После катастрофы мы поначалу нашли прибежеще в Новой Деревне. Но моему мужу почему то взбрела в голову идея основать свое поселение. Куда мне было деваться? Мы отправились в Кламат, а потом в Лос Сантос.", "У меня есть еще вопрос", "wendy_talk_HC()", "Спасибо, красавица", "outputChatBox ( \"Вэнди Стотч: Обращайся ко мне в любое время\", 255,255,255 )", "0", "", "0", "" )
end

function wendy_talk_work_HC ()
	showQuestWindow ( "Вэнди Стотч", "Странный ты какой-то. Обычно к нам все приезжают с твердой целью поживиться всяким хламом в Лос Сантосе, поэтому путников мы работой не затрудняем. Хотя Баттэрс говорил что-то про информационные станции, которые надо проверить. Поговори с ним по этому вопросу.", "У меня есть еще вопрос", "wendy_talk_HC()", "Спасибо, красавица", "outputChatBox ( \"Вэнди Стотч: Обращайся ко мне в любое время\", 255,255,255 )", "0", "", "0", "" )
end

-- Вилли
function willy_s_HC ()
	if getElementData ( localPlayer, "quest_whiskey" ) == 4 then
		showQuestWindow ( "Вилли", "Чего тебе?", "Меня сюда направил Виски-Боб", "willy_sended_whiskey_KL()", "Ничего", "outputChatBox ( \"Вилли: Вот и проваливай отсюда, я жду одного калеку\", 255,255,255 )", "0", "", "0", "" )
	else
		outputChatBox ( "Вилли: Не мешай.", 255,255,255 )
		--showQuestWindow ( "Вилли", "Чего тебе?", "Неожиданно. Что от меня требуется?", "right_s_yes_KL()", "Нет", "outputChatBox ( \"Боб Райт: Жаль, я хотел предложить неплохие деньги\", 255,255,255 )", "0", "", "0", "" )
	end
end

function willy_sended_whiskey_KL ()
	showQuestWindow ( "Вилли", "Он у тебя?! Непонятный предмет у тебя?!!?!?", "Я готов обменять его на самогонный аппарат.", "willy_sended_change_KL()", "Сколько крышек я получу за него?", "willy_sended_money_KL()", "0", "", "0", "" )
end

function willy_sended_money_KL ()
	showQuestWindow ( "Вилли", "Давай его сюда, а то бошку тебе откручу своими руками!", "Ок ок, не горячись. Давай обмен.", "willy_sended_change_KL()", "0", "", "0", "", "0", "" )
end


function willy_sended_change_KL ()
	showQuestWindow ( "Вилли", "Ладно, я скажу своим людям, чтоб они вернули самогонный аппарат и заправили его дровами. Гони сюда непонятный предмет!!", "Вот он", "willy_sended_change_fin_KL()", "0", "", "0", "", "0", "" )
end

function willy_sended_change_fin_KL ()
	setElementData ( localPlayer, "quest_whiskey", 5 )
	exports.inventory:removePlayerItem ( 122, 1 )
	exports.players:givePlayerXPClient ( 200 )
	willy_fin_KL()
end

function willy_fin_KL ()
	outputChatBox ( "Вилли: Можешь идти к Бобу и доложить ему о выполнении задания.", 255,255,255 )
end

-- Роберт Мэйфлауэр

function talkRobertHC()
	showQuestWindow ( "Роберт Мэйфлауэр", "ВАС ПРИВЕТСТВУЕТ РОБОТ-ПРОДАВЕЦ КОМПАНИИ \"РобКо\", СОЗДАННЫЙ ПО ОБРАЗУ АМЕРИКАНСКОГО ИЗОБРЕТАТЕЛЯ РОБЕРТА МЭЙФЛАУЭРА, СОЗДАТЕЛЯ \"СТЭЛС-БОЯ\". ПОСМОТРИТЕ НА АССОРТИМЕНТ ТОВАРОВ, КОТОРЫЕ Я ВАМ МОГУ ПРЕДЛОЖИТЬ", "А я-то думаю: гдеж тебя видел", "exports.traders:showTraderWindow(\"robert_roadtown\")", "*промолчать*", "", "0", "", "0", "" )
end