function her_quest_start ()
	showQuestWindow ( "Герберт Дешвуд", "Привет, путник! Как живётся на пустошах?", "Пока ещё живу, это уже хорошо", "her_norm()", "Отвали старикан", "", "0", "", "0", "" )
end

function her_norm ()
	showQuestWindow ( "Герберт Дешвуд", "Не хочешь помочь мне с поисками моего друга, гуля Аргаила? В долгу не останусь.", "Без проблем, но с чего начать?", "her_no_prob()", "Сам ищи", "", "0", "", "0", "" )
end

function her_no_prob ()
	showQuestWindow ( "Герберт Дешвуд", "Джонни Кэш сказал мне, что видел его на территории военной базы. Я уже стар, и не могу передвигаться по пустыне как делал это 20 лет назад, поэтому прошу тебя, помоги.", "Но как мне отличить его?", "her_like()", "Окей, отправляюсь", "her_quest_beg()", "0", "", "0", "" )
end

function her_like ()
	showQuestWindow ( "Герберт Дешвуд", "Очень просто - он, надеюсь, не будет пытаться тебе убить.", "Я попытаюсь сделать всё, что в моих силах. ", "her_quest_beg()", "Окей, отправляюсь", "her_quest_beg()", "0", "", "0", "" )
end

function her_quest_beg ()
	exports.pipboy:addInfoBox("Получено задание \"Поиски друга\"", 2 )
	setElementData ( localPlayer, 'quest_her', 1 )
	outputChatBox ( "Герберт Дешвуд: Надеюсь, все у вас получится!", 255, 255, 255 )
	argailColShape = createColSphere ( 212.80859375,1855.51953125,13.016319274902, 3 )
			--setElementData ( argailColShape, 'action', true )
			--setElementData ( argailColShape, 'type', 6 )
			addEventHandler("onClientColShapeHit",argailColShape,
			function () 
				exports.pipboy:addInfoBox ( 'На мертвом гуле вы находите письмо', 2 )
				exports.inventory:givePlayerItemWW ( 108, 1 )
				destroyElement ( argailColShape )
			end)
end

function her_found ()
	showQuestWindow ( "Герберт Дешвуд", "Ну и где же он?! Я что то не вижу его рядом с тобой.", "Дедуля, дружок твой сдох", "her_sad()", "Ну... Я нашел его мертвым...", "her_sad()", "0", "", "0", "" )
end

function her_sad ()
	showQuestWindow ( "Герберт Дешвуд", "Ах... Я ожидал подобных вестей от тебя, но, в глубине, надеялся на лучшее... Что-ж, спасибо и на том. Вот, держи этот антирад костюм, мне он все равно уже не понадобится...", "Спасибо", "her_finish()", "Пфф", "her_finish()", "0", "", "0", "" )
end

function her_finish ()
	exports.inventory:givePlayerItemWW ( 14, 1 )
	exports.pipboy:addInfoBox("Задание \"Поиски друга\" завершено", 2 )
	setElementData ( localPlayer, 'quest_her', 3 )
end