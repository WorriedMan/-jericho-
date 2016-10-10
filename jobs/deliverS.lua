tripPostVehicle = nil
tripPostAvailable = false
tripPostPlayer = nil

places = {}

places = { 
	{ "Эль Кебрадос", -1562.078125,2690.0478515625,55.382129669189,0.51910400390625 },
	{ "Закусочная на трассе", -1927.82421875,2375.0517578125,49.119113922119,60.785522460938}, 
	{ "Карьер", 615.4375,883.3359375,-43.334037780762,0.00274658203125}, 
	{ "Арена Зомби", -205.685546875,2729.3974609375,62.312351226807,0.88168334960938},
	{ "Старый Аэропорт", 407.109375,2537.3974609375,16.171430587769,0.88168334960938},
	{ "Поместье Охотника", -689.697265625,951.314453125,11.793927192688,60.785522460938},
	{ "Союз Ученых", -365.7314453125,1582.5771484375,75.923980712891,0.88168334960938}
}

trips = {}

trips = {
{ 3, 5, 6, 7 },
{ 3, 4, 5, 7 },
{ 1, 2, 4, 7 },
{ 2, 3, 6, 7 },
{ 1, 2, 3, 6 },
{ 1, 3, 4, 5 },
{ 1, 2, 3, 4 }
}

tripVehicles = {}
tripVehicles = { 530, 423, 485, 588 }

function startTripPost ( source )
	if tripPostAvailable == true then
		local playersTable = getElementsByType ( "player" )
		if #playersTable > 3 then
			local place1 = math.random ( 1, 7 )
			local trip = math.random ( 1, 4 )
			local ride1 = string.gsub ( "от / до +", "/", places[place1][1] )
			local ride2 = string.gsub ( ride1, "+", places[trips[place1][trip]][1] )
			local vehicle = math.random ( 1, 4 )
			outputChatBox ( "Игрок "..getPlayerName ( source ).." отправился по маршруту "..ride2, getRootElement(), 153,51,204  ) 
			outputChatBox ( "Подсказка: Убивший его игрок получит 7000$", getRootElement(), 255,255,255 )
			outputChatBox ( "Ваш маршрут: "..ride2, source, 204,102,0 ) 
			outputChatBox ( "Подсказка: С вас взяли 7000$, если вы успешно доедите до конца маршрута не умерев - получите 14000$", getRootElement(), 255,255,255 )
			takePlayerMoney ( source, 7000 )
			tripPostVehicle = createVehicle ( tripVehicles[vehicle], places[place1][2], places[place1][3], places[place1][4], 0, 0, places[place1][5], "TARGET" )
			addVehicleUpgrade ( tripPostVehicle, 1010 )
			warpPedIntoVehicle ( source, tripPostVehicle )
			toggleControl ( source, "enter_exit", false )
			triggerClientEvent ( source, "createTripMarker", source, places[trips[place1][trip]][2], places[trips[place1][trip]][3], places[trips[place1][trip]][4] )
			tripPostAvailable = false
			tripPostPlayer = source
			addEventHandler ( "onPlayerWasted", source, tripPostPlayerWasted )
		--	addEventHandler ( "onVehicleExplode", tripPostVehicle, tripPostPlayerWasted )
			addEventHandler ( "onPlayerQuit", source, tripPostPlayerQuit )
		else
			outputChatBox ("Поездка разрешена только тогда, когда на сервере есть как минимум 4 игрока.", source, 0,153,51 )
		end
	else
		if tripPostPlayer then 
			outputChatBox ("Информация: В данный момент поездку совершает игрок "..getPlayerName ( tripPostPlayer ).."", source, 0,153,51 )
		else
			local remaining, executesRemaining, totalExecutes = getTimerDetails(tripPostTimer)
			outputChatBox ("Информация: В данный момент совершить поездку нельзя, осталось подождать "..tostring(remaining/1000).." секунд", source, 0,153,51 )
		end
	end
end

addCommandHandler ("ko", startTripPost)

function finishTripPostS ( )
	toggleControl ( source, "enter_exit", true )
	outputChatBox ("Информация: Игрок "..getPlayerName ( source ).." успешно завершил поездку и получил 14000$", getRootElement(), 0,153,51 )
	outputChatBox ("Информация: Вы успешно завершили "..getPlayerName ( source ).." поездку и получили 14000$", source, 0,153,51 )
	outputChatBox ("Подсказка: Следующую поездку можно будет совершить через 15 минут", getRootElement(), 255,255,255 )
	givePlayerMoney ( source, 14000 )
	tripPostPlayer = nil
	tripPostTimer = setTimer ( function () tripPostAvailable = true end, 1800000, 1 )
	removeEventHandler ( "onPlayerWasted", source, tripPostPlayerWasted )
	--removeEventHandler ( "onVehicleExplode", tripPostVehicle, tripPostPlayerWasted )
	removeEventHandler ( "onPlayerQuit", source, tripPostPlayerQuit )
	triggerClientEvent ( source, "destroyTripMarker", source )
	destroyElement ( tripPostVehicle )
end

addEvent( "finishTripPost", true )
addEventHandler( "finishTripPost", getRootElement(), finishTripPostS )

function tripPostPlayerWasted ( ammo, attacker, weapon, bodypart )
	if attacker then
		outputChatBox ("Игрок "..getPlayerName ( attacker ).." убил "..getPlayerName ( source ).." и получил за это 7000$", getRootElement(), 153,51,204  ) 
		givePlayerMoney ( attacker, 7000 )
	else
		outputChatBox ("Игрок "..getPlayerName ( source ).." умер, никто не получает 7000$ за его убийство", getRootElement(), 153,51,204  ) 
	end
	outputChatBox ("Информация: Вы не смогли проехать по маршруту не умерев и не получаете 15000$, ваши 7000$ вам никто не вернет", source, 0,153,51 )
	outputChatBox ("Подсказка: Следующую поездку можно будет совершить через 15 минут", getRootElement(), 255,255,255 )
	tripPostTimer = setTimer ( function () tripPostAvailable = true end, 900000, 1 )
	removeEventHandler ( "onPlayerWasted", source, tripPostPlayerWasted )
	removeEventHandler ( "onPlayerQuit", source, tripPostPlayerQuit )
	triggerClientEvent ( source, "destroyTripMarker", source )
	toggleControl ( source, "enter_exit", true )
	if tripPostVehicle then
		destroyElement ( tripPostVehicle )
	end
	tripPostPlayer = nil
end

function tripPostPlayerQuit ( quitType )
	outputChatBox ("Игрок "..getPlayerName ( source ).." вышел из игры, никто не получает 7000$ за его убийство", getRootElement(), 153,51,204 ) 
	outputChatBox ("Подсказка: Следующую поездку можно будет совершить через 15 минут", getRootElement(), 255,255,255 )
	tripPostTimer = setTimer ( function () tripPostAvailable = true end, 900000, 1 )
	tripPostPlayer = nil
	triggerClientEvent ( source, "destroyTripMarker", source )
end