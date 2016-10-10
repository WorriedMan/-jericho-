createObject ( 702,-592,2321,35 )
createObject ( 702,-592,2322,35 )
createObject ( 702,-593,2321,35 )
createObject ( 702,-592.5,2321.5,35 )
createObject ( 702,-592.5,2321.5,36 )
function samara_quest_start ()
	showQuestWindow ( "Самара", "Семь дней...", "Что?", "samara_quest_s_die()", "Что будет через семь дней?", "samara_quest_s_die()", "А, я тебя знаю", "samara_quest_s_die()", "Нет, этого не может быть!", "samara_quest_s_die()" )
end

function samara_quest_s_die ()
	showQuestWindow ( "Самара", "Через семь дней ты умрешь...", "ЭТОГО НЕ МОЖЕТ БЫТЬ!!!", "samara_quest_s_fin()", "Ты меня чтоль убьешь?", "samara_quest_s_fin()", "Я настолько крутой, что мне похер", "samara_quest_s_fin()", "О чем ты воообще?", "samara_quest_s_fin()" )
end

function samara_quest_s_fin ()
	setElementData ( localPlayer, "quest_ring", 2 )
	updateCompassAdditMarker ( 8, 2 )
	exports.inventory:givePlayerItem ( 107, 1 )
	--setTimer ( triggerServerEvent, 3000, 1, "destroySamaraBoxesС", localPlayer )
	setTimer ( destroySamaraBoxes, 3000, 1 )
end


function strange_s_ring ()
	showQuestWindow ( "Странник", "По глазам твоим вижу, что ты недавно с ней встречался.", "С кем?", "strange_s_days_ring()", "УРА! Я УЖ ДУМАЛ МНЕ КОНЕЦ", "strange_s_days_ring()", "Моя твоя не понимать", "strange_s_days_ring()", "О чем ты?", "strange_s_days_ring()" )
end

function strange_s_days_ring ()
	showQuestWindow ( "Странник", "Там, в центральном магазине Союза Ученых. Я хочу тебе помочь. И я знаю как остановить ее...", "И как же?", "strange_s_how_ring()", "ГОВОРИ ТОГДА, НЕ ТЯНИ", "strange_s_how_ring()", "0", "", "0", "" )
end

function strange_s_how_ring ()
	showQuestWindow ( "Странник", "Когда она была еще человеком, у нее была аллергия на шпинат.", "Откуда ты это знаешь?", "strange_s_where_ring()", "0", "", "0", "", "0", "" )
end

function strange_s_where_ring ()
	showQuestWindow ( "Странник", "Скажем так, я любил синематограф и жил у маяка на острове Маеско", "Как ее остановить?", "strange_asass_where_ring()", "0", "", "0", "", "0", "" )
end

function strange_asass_where_ring ()
	showQuestWindow ( "Странник", "Совсем недавно я узнал о том, что, из за радиации, на дне залива у дамбы вырос Мегашпинат. Он содержит в шесть раз больше прилива сил, чем обычный шпинат.", "Попае одобряе", "strang_pop_ring()", "Мы подсунем его ей?", "strange_sphinat_ring()", "0", "", "0", "" )
end

function strang_pop_ring ()
	showQuestWindow ( "Странник", "Ты что, с ума сошел?? Ни в коем случае не говори Моряку Попаю. Если он съест его, я думаю, последствия будут ужасными для нас всех.", "Ок, мы подсунем этот шпинат той страшиле?", "strange_sphinat_ring()", "0", "", "0", "", "0", "" )
end

function strange_sphinat_ring ()
	outputChatBox ("Информация: Прогресс сохранен", 0,153,51 )
	setElementData ( localPlayer, "quest_ring", 4)
	updateCompassAdditMarker ( 8, 4 )
	samaraShpinColShape = createColSphere ( -592.5,2321.5,36, 2 )
	superShpinIcon = exports.pipboy:addMapIcon ( -592.5,2321.5,36, 3, 'Шпинат' ) or 0 
	addEventHandler("onClientColShapeHit",samaraShpinColShape,
			function () 
				exports.pipboy:addInfoBox ( 'Вы собрали Супершпинат, теперь отправляйтесь в Союз Ученых на встречу.', 2 )
				outputChatBox ("Информация: Прогресс сохранен", 0,153,51 )
				destroyElement ( samaraShpinColShape )
				setElementData ( localPlayer, 'quest_ring', 5 )
				exports.players:givePlayerXPClient ( 100 )
				pdateCompassAdditMarker ( 8, 5 )
				exports.pipboy:deleteMapIcon ( superShpinIcon )
			end)
	showQuestWindow ( "Странник", "Да, ты прав. Я поставлю на твоем пипбое примерное место, где растет Супершпинат. Как соберешь шпинат, отправляйся обратно в Союз Ученых, и сразись с ней.", "Хорошо, чтоб я без тебя делал", "strange_go_ring()", "0", "", "0", "", "0", "" )
end

function strange_go_ring ()
	exports.inventory:givePlayerItemWW ( 109, 10 )
	showQuestWindow ( "Странник", "И еще кое-что. Вот, возьми эти накопители воздуха, они тебе пригодятся, для дыхания под водой.", "Спасибо", "", "Да я и так умею дышать под водой", "", "0", "", "0", "" )
end

function samara_quest_s_finale ()
	showQuestWindow ( "Самара", "Пришло время умирать...", "Ага, тебе! (Дать Супершпинат)", "samara_letsdie_ring()", "У МЕНЯ ДЛЯ ТЕБЯ СЮРПРИЗИК (Дать Супершпинат)", "samara_letsdie_ring()", "0", "", "0", "" )
end

function samara_letsdie_ring ()
	showQuestWindow ( "Самара", "Неееееееет...", "Hasta la vista, baby!", "samara_boom_ring()", "А ТЫ ДУМАЛА Я ТУТ С ТОБОЙ В ИГРУШКИ ИГРАЮ", "samara_boom_ring()", "0", "", "0", "" )
end

function samara_boom_ring ()
	exports.inventory:givePlayerItemWW ( 27, 1 )
	exports.inventory:givePlayerItemWW ( 16, 2 )
	exports.inventory:givePlayerItemWW ( 20, 1 )
	exports.inventory:givePlayerItemWW ( 21, 20 )
	createExplosion ( -244.91934204102,1487.1560058594,68.90625, 1, true, -1.5, false )
	outputChatBox ("Завершено задание \"Неделя\"", 0,153,51 )
	setElementData ( localPlayer, "quest_ring", 6 )
	exports.achievments:givePoint ( 1 )
	setTimer ( destroySamaraBoxes, 1500, 1 )
end