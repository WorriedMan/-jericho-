local localPlayer = getLocalPlayer ()

-- Новый Вегас

-- Гражданский Комендант

function comrade_talk_SU ()
	showQuestWindow ( "Гражданский Комендант", "Добрый день гражданин, что вам надо?", "Я бы хотел задать пару вопросов.", "comrade_quest_SU()", "Да ничего, я мимо проходил", "", "0", "", "0", "" )
end

function comrade_quest_SU ()
	showQuestWindow ( "Гражданский Комендант", "И что же вас интересует?", "Как вы относитесь к другим деревням?", "comrade_villages_SU()", "Вам тут помощь не нужна?", "comrade_help_SU()", "Чем вы тут занимаетесь?", "comrade_doing_SU()", "Я передумал", "" )
end

function comrade_villages_SU ()
	showQuestWindow ( "Гражданский Комендант", "Руководство предпочитает не распространяться на эту тему, но я могу сказать вам, гражданин, что, как только будет найдено средство избавления от зомби, мы вернем эти деревни под свой контроль. Не будет никакого ополчения и мафии, только законное, избранное правительство.", "У меня есть еще вопрос", "comrade_quest_SU()", "Спасибо за информацию, пойду я", "", "0", "", "0", "" )
end

function comrade_help_SU ()
	showQuestWindow ( "Гражданский Комендант", "Гражданин, сохраняйте спокойствие, мы со всем справимся сами.", "У меня есть еще вопрос", "comrade_quest_SU()", "Спасибо за информацию, пойду я", "", "0", "", "0", "" )
end

function comrade_doing_SU ()
	showQuestWindow ( "Гражданский Комендант", "Мы занимаемся поисками антидота к вирусу, из-за которого все это дело случилось. Не беспокойтесь, гражданин, противоядие будет найдено нами в скором времени.", "У меня есть еще вопрос", "comrade_quest_SU()", "Спасибо за информацию, пойду я", "", "0", "", "0", "" )
end

function talkBandit()
	if getElementData ( localPlayer, "nwkey" ) == 0 then
		showQuestWindow ( "Бандит", "У меня тут завалялся один пропуск в поселение Новый Вегас. Если хочешь, могу продать его тебе за 2000 крышек", "Беру", "acceptBuyNVPass()", "Я туда сам попаду", "", "0", "", "0", "" )
	else
		outputChatBox ("Бандит: Чего тебе?", 204,204,255 )
	end
end

function acceptBuyNVPass()
	if exports.inventory:getPlayerCaps () >= 2000 then
		showQuestWindow ( "Бандит", "Вот, держи свой пропуск, но запомни: хоть кому скажешь обо мне - убью.", "Без б.", "", "0", "", "0", "", "0", "" )
		exports.pipboy:addInfoBox("Теперь вы можете посетить поселение Новый Вегас!", 4 )
		setElementData ( getLocalPlayer(), "nwkey", 1 )
		exports.inventory:givePlayerItemWW ( 9, 1 )
		triggerServerEvent ( "takeClientMoney", getLocalPlayer(), 2000 ) 
	end
end

function talkLizWatfard()
	if getElementData ( localPlayer, "quest_ring" ) == 0 then
		showQuestWindow ( "Лиз Вотфорд", "Нет! Нет! Нет! Нет! Нет! Нет! Нет! Нет! Нет!", "Эй, детка, успокойся. Что случилось?", "liz_watfard_whatHappened()", "Странная какая-то", "", "0", "", "0", "" )
	else
		outputChatBox ("Лиз Вотфорд: Нет! Нет! Нет! Нет! Нет!", 204,204,255 )
	end
end

function liz_watfard_whatHappened()
	showQuestWindow ( "Лиз Вотфорд", "Нет! Нет! Нет! Нет! Нет! Погодите, может вы сможете мне помочь! Умоляю вас, зайдите в то темное помещение дальше по улице, может так вы меня спасете!", "Ради такой крошки как ты, все что угодно", "", "Ага, обдурить меня решила? Там наверняка твои дружки будут ждать меня с битами!", "", "0", "", "0", "" )
	if getElementData(localPlayer,"quest_ring") == 0 then
		exports.pipboy:addInfoBox("Получено задание \"Неделя\"", 2 )
		setElementData ( localPlayer, 'quest_ring', 1 )
	end
end