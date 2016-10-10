function robert_quest_start ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Здравствуйте, молодой человек. Не могли бы вы помочь старому ученому?", "А что вам надо?", "robert_craft_about()", "Конечно, старым надо помогать!", "robert_craft_about()", "Нет, не мог бы", "", "0", "" )
end

function robert_craft_about ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Рядом со мной стоит один из новейших станков для создания предметов - \"Мистер Рукоблуд - 1000\" от компании \"РобКо\". Моя обязанность на этой дамбе ухаживать за ним.", "Я понимаю, давайте дальше", "robert_craft_about_next()", "Я не понимаю, повторите еще раз", "robert_craft_about_repeat()", "Да-да", "robert_craft_about_next()", "0", "" )
end

function robert_craft_about_repeat ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Ну что за глупая молодежь пошла... Вот рядом со мной стоит новейщий верстальный станок \"Мистер Рукоблуд - 1000\" от компании \"РобКо\". Я слежу, чтоб он не сломался.", "Ааа, ну теперь понятно...", "robert_craft_about_next()", "Эээ... Ну... Ладно... Давайте дальше...", "robert_craft_about_next()", "0", "", "0", "" )
end

function robert_craft_about_next ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Но, вот незадача, сломались мои очки, а запасных нету. Не мог бы ты собрать на станке мне новые очки?", "Могу, но где мне взять детали для очков?", "robert_craft_about_details()", "Может в другой раз, я занят сейчас", "", "0", "", "0", "" )
end


function robert_craft_about_details ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Для начала вот, возьмите мои старые, сломанные очки.", "Что мне с ними сделать?", "robert_craft_about_what()", "А, точно, я пойду и разберу их на станке", "robert_craft_about_before()", "0", "", "0", "" )
	exports.inventory:givePlayerItemWW ( 89, 1 )
end

function robert_craft_about_before ()
	exports.players:givePlayerXPClient ( 100 )
	robert_craft_start ()
end

function robert_craft_about_what ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Подойдите к станку. Откройте его интерфейс, выберите \"Оправа очков\" и нажмите \"Сделать\". В результате чего вы получите составные детали моих очков.", "Звучит легко", "robert_craft_start()", "Пойду, попробую", "robert_craft_start()", "0", "", "0", "" )
end

function robert_craft_start ()
	exports.pipboy:addInfoBox("Получено задание \"Старым надо помогать\"", 2 )
	setElementData ( localPlayer, "quest_robert", 1)
	exports.players:givePlayerXPClient ( 50 )
	outputChatBox ( 'Роберт Мэйфлауэр: Отлично! Возвращайтесь, когда закончите.', 255, 255, 255 )
end

addEvent ( "onPlayerCraftItem", true )

function itemDisassembled ( item )
	if item == "Оправа очков" and getElementData ( localPlayer, "quest_robert" ) == 1 then
		exports.pipboy:addInfoBox("Возвращайтесь к Роберту Мэйфлауэру", 3 )
		setElementData ( localPlayer, "quest_robert", 2)
		exports.players:givePlayerXPClient ( 150 )
	elseif item == "Новые очки" and getElementData ( localPlayer, "quest_robert" ) == 5 then
		exports.pipboy:addInfoBox("Возвращайтесь к Роберту Мэйфлауэру", 3 )
		setElementData ( localPlayer, "quest_robert", 6)
		exports.players:givePlayerXPClient ( 150 )
	end
end

addEventHandler ( "onPlayerCraftItem", localPlayer, itemDisassembled )

function robert_craft_disassembld ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Вы можете разбирать таким образом большинство вещей. И, как я вижу, у вас теперь есть ободок от моих очков. Осталось раздобыть стеклышки. Их вы можете взять у Джона Початка.", "Уже бегу", "", "Ох уж этот Початок...", "", "0", "", "0", "" )
	setElementData ( localPlayer, "quest_robert", 3)
end

function john_craft_quest ()
	showQuestWindow ( "Джон Початок", "Хахаха, этот, хихихи, старикан опять, мухахаха, разбил свои очки? Мхохаха, вот, держи, награды не надо. АХАХАХАХА", "Ну спасибо", "outputChatBox ( 'Джон Початок: Удачно тебе поговорить с самим Робертом Мэйфлауэром хахахаха', 255, 255, 255 )", "Странный ты какой-то", "outputChatBox ( 'Джон Початок: Удачно тебе поговорить с самим Робертом Мэйфлауэром хахахаха', 255, 255, 255 )", "0", "", "0", "" )
	exports.inventory:givePlayerItemWW ( 91, 1 )
	setElementData ( localPlayer, "quest_robert", 4)
end

function robert_craft_finish_start ()
	exports.players:givePlayerXPClient ( 30 )
	showQuestWindow ( "Роберт Мэйфлауэр", "Если стеклышки уже у вас, то идите к станку. Для сбора очков, выберите рецепт \"Новые очки\" и нажмите \"Сделать\". Потом возвращайтесь ко мне вместе с очками.", "Сейчас попробую", "", "0", "", "0", "", "0", "" )
	setElementData ( localPlayer, "quest_robert", 5)
end

function robert_craft_finish_done ()
	exports.inventory:removePlayerItem ( 90, 1 )
	showQuestWindow ( "Роберт Мэйфлауэр", "Спасибо, очки я заберу. Но надо сказать вам правду.", "Я знал, что что-то здесь не так...", "robert_droid()", "Какую?", "robert_droid()", "0", "", "0", "" )
end

function robert_droid()
	showQuestWindow ( "Роберт Мэйфлауэр", "ВАС ПРИВЕТСТВУЕТ РОБОТ-ИНСТРУКТОР КОМПАНИИ \"РобКо\", СОЗДАННЫЙ ПО ОБРАЗУ АМЕРИКАНСКОГО ИЗОБРЕТАТЕЛЯ РОБЕРТА МЭЙФЛАУЭРА, СОЗДАТЕЛЯ \"СТЭЛС-БОЯ\". ВЫ ТОЛЬКО ЧТО ПРОШЛИ НАЧАЛЬНЫЙ КУРС СОЗДАНИЯ ВЕЩЕЙ, ТЕПЕРЬ 0100010010010100101010 *сообщение утеряно* ", "Мда, это было ожидаемо...", "robert_finish()", "ВОТ ЭТО ПОВОРОТ", "robert_finish()", "0", "", "0", "" )
end

function robert_finish ()
	exports.pipboy:addInfoBox("Задание \"Старым надо помогать\" завершено", 2 )
	setElementData ( localPlayer, "quest_robert", 6)
	exports.players:givePlayerXPClient ( 250 )
	exports.achievments:givePoint  ( 1 )
	exports.inventory:givePlayerItemWW ( 55, 2 )
end

function robert_learning ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Здравствуйте, вы хотели-бы что то спросить?", "Расскажите мне, как собирать вещи", "robert_learn_create()", "Расскажите мне, как разбирать вещи", "robert_learn_dis()", "Нет, просто хотел посмотреть на твою бездушную морду", "robert_learn_fin()", "0", "" )
end

function robert_learn_create ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Подойдите к любому столу \"Мистер Рукоблуд 1000\", либо воспользуйтесь портативным станком \"Мистер Рукоблуд 1000П\". Поместите необходимые для создания вещи в интерфейс станка,  после чего нажмите \"Сделать\"", "Спасибо", "robert_learn_fin()", "Расскажите мне, как разбирать вещи", "robert_learn_dis()", "0", "", "0", "" )
end

function robert_learn_dis ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Подойдите к любому столу \"Мистер Рукоблуд 1000\", либо воспользуйтесь портативным станком \"Мистер Рукоблуд 1000П\". Поместите вещь, которую хотите разобрать в интерфейс станка в нужном вам количестве. После чего нажмите \"Сделать\".", "Спасибо", "robert_learn_fin()", "Расскажите мне, как собирать вещи", "robert_learn_create()", "0", "", "0", "" )
end

function robert_learn_dis ()
	showQuestWindow ( "Роберт Мэйфлауэр", "Компания \"РобКо\" обьявляет распродажу на станки серии \"Мистер Рукоблуд\"! Скидка на версию 1000 - 2%, а скидка на портативную версию 1000П - целых 3%! Звоните по телефону 800-694-7466, 1% от каджой продажи идет правительству на борьбу с красной коммунистической заразой из Китая!", "Ты даже не знаешь что произошло с миром, железяка", "", "0", "", "0", "", "0", "" )
end

function talkMedic()
	if ( getElementData ( localPlayer, "sckey" ) or 0 ) == 0 then
		showQuestWindow ( "Медик", "У меня тут завлялся один пропуск в поселение Союза Ученых. Если хочешь, могу продать его тебе за 1000 крышек", "Беру", "acceptBuySUPass()", "Я туда сам попаду", "", "0", "", "0", "" )
	else
		outputChatBox ("Медик: Чего тебе?", 204,204,255 )
	end
end

function acceptBuySUPass()
	if exports.inventory:getPlayerCaps () >= 1000 then
		showQuestWindow ( "Медик", "Отлично. Направляйся туда, где раньше была военная база военных на горе, там еще антенна гигантская стоит.", "Спасибо", "", "0", "", "0", "", "0", "" )
		exports.pipboy:addInfoBox("Теперь вы можете посетить поселение Союз Ученых!", 4 )
		exports.inventory:givePlayerItemWW ( 8, 1 )
		setElementData(localPlayer,"sckey",1)
		triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 1000 ) 
	end
end