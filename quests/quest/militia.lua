tasks = {
-- принос вещей:
	-- ид, мин, макс, награда, текст
	{ 7, "На складе опять произошел пожар, в результате которого было уничтожено много АнтиРада. Найдите и принесите quant АнтиРад.", 100 },
	{ 11, "У меня намечается очередное свидание с Эми Макдональд. Надо принести несколько бутылок Виски, я думаю, что quant подойдет.", 100 },
	{ 17, "Я тут вычитал в старой газете, что шпинат очень помогает в условиях повышенного радационного фона. Принеси несколько банок, давай quant", 50 },
	{ 20, "Принеси мне quant пакетиков орехов, хочется вспомнить старые времена.", 100 },
	{ 1, "Наши запасы стимуляторов стремительно тают. Принеси quant стимуляторов, чтоб мы могли продержаться до прибытия группы искателей из Лос Сантоса.", 100 },
	{ 2, "Хочется шашлыка. Принеси quant шашалыков из белки.", 50 },
}

nc_ranks = {
	"Искатель",
	"Ополченец",
	"Скаут",
	"Солдат",
	"Рейнджер",
	"Шериф",
}

nc_peds = {
	{ "рабочего, для возведения новых укреплений", 260, "он" },
	{ "одного пенсионера, ", 49, "он" },
	{ "механика, для починки механизма ворот", 50, "он" },
}

function militia_talk_start_NC ()
	if getElementData ( localPlayer, "quest_militia" ) == 0 then 
		showQuestWindow ( "Букер ДеВитт", "Я вижу новое лицо в центре ополчения. Я - глава ополчения Новой Деревни. Что вы хотите?", "Что это за место?", "militia_t_place_NC()", "Ополчение?", "militia_t_what_NC()", "А можно записаться в ополчение?", "militia_t_enjoy_NC()", "Да так, ничего", "" )
	else
		if getElementData ( localPlayer, "ncType" ) == 0 then
			showQuestWindow ( "Букер ДеВитт", "Здравствуйте, "..nc_ranks[getElementData(localPlayer, "ncRank")]..". Вы пришли за новым заданием?", "Расскажите мне об этом здании", "militia_t_place_NC()", "Расскажите мне об ополчении", "militia_t_what_NC()", "Да, мне нужно задание", "militia_get_task_NC()", "Да так, ничего", "" )
		else
			if getElementData ( localPlayer, "ncType" ) == 4 then
				showQuestWindow ( "Букер ДеВитт", "Здравствуйте, "..nc_ranks[getElementData(localPlayer, "ncRank")]..". Вы хотели доложить о выполнении задания?", "Расскажите мне об этом здании", "militia_t_place_NC()", "Расскажите мне об ополчении", "militia_t_what_NC()", "Да", "militia_q_ready_NC()", "Нет", "" )		
			elseif getElementData ( localPlayer, "ncType" ) == 1 then
				local amount = exports.inventory:getItemAmount ( getElementData ( localPlayer, "ncTarg" ) )
				if amount then
					if amount >= getElementData ( localPlayer, "ncAmount" ) then
						showQuestWindow ( "Букер ДеВитт", "Здравствуйте, "..nc_ranks[getElementData(localPlayer, "ncRank")]..". Вы хотели доложить о выполнении задания?", "Расскажите мне об этом здании", "militia_t_place_NC()", "Расскажите мне об ополчении", "militia_t_what_NC()", "Да", "militia_i_ready_NC()", "0", "" )		
					else
						showQuestWindow ( "Букер ДеВитт", "Здравствуйте, "..nc_ranks[getElementData(localPlayer, "ncRank")]..". Вы хотели доложить о выполнении задания?", "Расскажите мне об этом здании", "militia_t_place_NC()", "Расскажите мне об ополчении", "militia_t_what_NC()", "Нет", "", "0", "" )				
					end
				else
					showQuestWindow ( "Букер ДеВитт", "Здравствуйте, "..nc_ranks[getElementData(localPlayer, "ncRank")]..". Вы хотели доложить о выполнении задания?", "Расскажите мне об этом здании", "militia_t_place_NC()", "Расскажите мне об ополчении", "militia_t_what_NC()", "Нет", "", "0", "" )	
				end
			elseif getElementData ( localPlayer, "ncType" ) == 2 and getElementData ( localPlayer, "ncTarg" ) == 0 then
				showQuestWindow ( "Букер ДеВитт", "Здравствуйте, "..nc_ranks[getElementData(localPlayer, "ncRank")]..". Вы хотели доложить о выполнении задания?", "Расскажите мне об этом здании", "militia_t_place_NC()", "Расскажите мне об ополчении", "militia_t_what_NC()", "Да", "militia_z_ready_NC()", "0", "" )	
			else
				showQuestWindow ( "Букер ДеВитт", "Здравствуйте, "..nc_ranks[getElementData(localPlayer, "ncRank")]..". Вы хотели доложить о выполнении задания?", "Расскажите мне об этом здании", "militia_t_place_NC()", "Расскажите мне об ополчении", "militia_t_what_NC()", "Нет", "", "0", "" )	
			end
		end
	end
end

function militia_i_ready_NC ()
	exports.inventory:removePlayerItem ( getElementData ( localPlayer, "ncTarg" ), getElementData ( localPlayer, "ncAmount" ) )
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), tasks[getElementData ( localPlayer, "ncAddit" )][3]+getElementData ( localPlayer, "ncRank" ) )
	showQuestWindow ( "Букер ДеВитт", "Отлично, вот ваша награда. Приходите завтра за новым заданием.", "Рад стараться на благо нашей деревни!", "militia_finish_NC()", "Да-да", "militia_finish_NC()", "0", "", "0", "" )		
end

function militia_z_ready_NC ()
	local power = 1
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), getElementData ( localPlayer, "ncAmount" )+getElementData ( localPlayer, "ncRank" ) ) 
	showQuestWindow ( "Букер ДеВитт", "Отлично, вот ваша награда. Приходите завтра за новым заданием.", "Рад стараться на благо нашей деревни!", "militia_finish_NC()", "Да-да", "militia_finish_NC()", "0", "", "0", "" )		
end

function militia_q_ready_NC ()
	triggerServerEvent ( "giveClientMoney", getLocalPlayer(), getElementData ( localPlayer, "ncAmount" )+getElementData ( localPlayer, "ncRank" ) ) 
	local ped_type = getElementData ( localPlayer, 'ncTarg' )
	showQuestWindow ( "Букер ДеВитт", "Мне уже сообщили, что "..nc_peds[ped_type][3].." в пункте назначения. Приходите завтра за новым заданием.", "Рад стараться на благо нашей деревни!", "militia_finish_NC()", "Да-да", "militia_finish_NC()", "0", "", "0", "" )	
end

function militia_finish_NC ()
	local time = getRealTime()
	setElementData ( localPlayer, "ncType", 0 )
	setElementData ( localPlayer, "ncLastTask", time.timestamp )
	setElementData ( localPlayer, "ncTasksDone", getElementData ( localPlayer, "ncTasksDone" )+1 )
	if getElementData ( localPlayer, "ncTasksDone" ) == getElementData(localPlayer, "ncRank")*3 and getElementData(localPlayer, "ncRank") < 6 then
		setElementData(localPlayer, "ncRank", getElementData(localPlayer, "ncRank")+1 )
		showQuestWindow ( "Букер ДеВитт","Кстати, вы дослужились до нового звания. Теперь вы - "..nc_ranks[getElementData(localPlayer, "ncRank")]..". В награду я вам выдаю 1000 крышек и 1 Сувенирную Монету РобКО. Теперь вы будете получать более сложные задания!", "Ура!", "", "Часть населения-часть деревни", "", "0", "", "0", "" )		
		if getElementData(localPlayer, "ncRank") == 6 then
			exports.inventory:givePlayerItemWW ( 88, 1 )
		end
		exports.achievments:givePoint ( 1 )
		triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 1000 )
	end
end

function militia_get_task_NC ()
	local time = getRealTime()
	local timeToNew = 172800
	if getElementData ( localPlayer, "vip" ) then timeToNew = 86400 end
	if getElementData ( localPlayer, "ncLastTask" )+timeToNew < time.timestamp then
		local taskType = 3
		if getElementData ( localPlayer, "ncRank" ) < 3 then
			taskType = math.random ( 1, 2 )
			
		else
			taskType = math.random ( 1, 3 )
		end
		if taskType == 1 then
			local thingNum = math.random ( 1, #tasks )
			local maxThings = math.random ( 1, 2 ) + getElementData ( localPlayer, "ncRank" )*math.random (1,2)
			local finString = string.gsub(tasks[thingNum][2], "quant", tostring(maxThings) )
			local difficult = "простое"
			if maxThings > 3 and maxThings < 6 then
				difficult = "не простое"
			elseif maxThings > 5 then
				difficult = "прямо скажем, сложное"
			end
			setElementData ( localPlayer, "ncType", 1 )
			setElementData ( localPlayer, "ncTarg", tasks[thingNum][1] )
			setElementData ( localPlayer, "ncAmount", maxThings )
			setElementData ( localPlayer, "ncAddit", thingNum )
			showQuestWindow ( "Букер ДеВитт", "Ваше задание сегодня "..difficult..". "..finString, "Ладно, я берусь за него", "militia_accept_NC()", "Рад служить нашей деревне!", "militia_accept_NC()", "0", "", "0", "" )		
		elseif taskType == 2 then
			local zombNum = math.random ( getElementData ( localPlayer, "ncRank" )+2, 5+3*getElementData ( localPlayer, "ncRank" ) )
			local money = zombNum*(40+getElementData ( localPlayer, "ncRank" ))
			local name = "гуля"
			setElementData ( localPlayer, "ncType", 2 )
			setElementData ( localPlayer, "ncTarg", zombNum )
			setElementData ( localPlayer, "ncAmount", money )
			if zombNum > 4 and zombNum < 20 then
				name = "гулей"
			end
			showQuestWindow ( "Букер ДеВитт", "Вы получите сегодня важное задание. Дикие гули продолжают прибывать в наш район из Сан Фиеерро. Уничтожте "..tostring ( zombNum ).." "..name..". За это задание вам будет выплачена награда в размере "..tostring(money).." крышек", "Ладно, я берусь за него", "militia_accept_NC()", "Рад служить нашей деревне!", "militia_accept_NC()", "0", "", "0", "" )		
			
		elseif taskType == 3 then
			local ped_type = math.random ( 1, #nc_peds )
			local rank = getElementData ( localPlayer, "ncRank" )
			local base = 1000
			if rank == 5 then base = 2000 elseif rank == 6 then base = 3000 end
			local money = math.random ( base, base+1000 )
			setElementData ( localPlayer, "ncType", 3 )
			setElementData ( localPlayer, "ncTarg", ped_type )
			setElementData ( localPlayer, "ncAmount", money )
			showQuestWindow ( "Букер ДеВитт", "Необходимо сопроводить в Эль Кебрадос "..nc_peds[ped_type][1]..". Дело важное, "..nc_peds[ped_type][3].." будет следовать за тобой. Если "..nc_peds[ped_type][3].." от тебя отстанет, либо ты зайдешь куда-либо, то "..nc_peds[ped_type][3].." вернется сюда. И еще, "..nc_peds[ped_type][3].." не умеет стрелять. Все, "..nc_peds[ped_type][3].." будет ждать тебя снаружи. Если "..nc_peds[ped_type][3].." вернется сюда, то подойди ко мне, я его позову. В награду получишь "..tostring(money).." крышек.", "Ладно, я берусь за него", "militia_accept_NC(3)", "Рад служить нашей деревне!", "militia_accept_NC(3)", "0", "", "0", "" )			
		end
	else
		showQuestWindow ( "Букер ДеВитт", "Ну извини тогда, новых заданий пока нет.", "Плохо, я приду попозже", "outputChatBox(\"Букер ДеВитт: Буду вас ждать\", 255, 255, 255)", "Отлично, я как раз хотел передохнуть", "outputChatBox(\"Букер ДеВитт: Буду вас ждать\", 255, 255, 255)", "0", "", "0", "" )			
	end
end

function militia_t_what_NC ( num )
	exports.pipboy:addInfoBox ( "Задание обновлено", 3 )
	exports.players:givePlayerXPClient ( 50 )
	if num then
		if num == 3 then
			exports.pipboy:addInfoBox ( "Житель ожидает вас снаружи", 3 )
		end
	end
end

function militia_accept_NC ( num )
	exports.pipboy:addInfoBox ( "Задание обновлено", 3 )
	if num then
		if num == 3 then
			exports.pipboy:addInfoBox ( "Житель ожидает вас снаружи", 3 )
		end
	end
end

function militia_t_place_NC ()
	if getElementData ( localPlayer, "quest_militia" ) == 0 then 
		showQuestWindow ( "Букер ДеВитт", "Вы находитесь в Центре Ополчения Новой Деревни, в этом же помещении находится наша тюрьма.", "Что-то тут не слишком людно", "militia_t_p_nop_NC()", "Расскажите мне про ополчение", "militia_t_what_NC()", "А можно записаться в ополчение?", "militia_t_enjoy_NC()", "Спасибо за информацию", "" )
	else
		showQuestWindow ( "Букер ДеВитт", "Вы находитесь в Центре Ополчения Новой Деревни, в этом же помещении находится наша тюрьма.", "Что-то тут не слишком людно", "militia_t_p_nop_NC()", "Расскажите мне про ополчение", "militia_t_what_NC()", "Спасибо за информацию", "", "0", "" )	
	end
end

function militia_t_p_nop_NC ()
	if getElementData ( localPlayer, "quest_militia" ) == 0 then 
		showQuestWindow ( "Букер ДеВитт", "А вы наблюдательны. Действительно, тюрьма пустует, поэтому я отправил всех ополченцев по делам, тем-более, что в последнее время гули довольно сильно активизировались.", "Расскажите мне про ополчение", "militia_t_what_NC()", "А можно записаться в ополчение?", "militia_t_enjoy_NC()", "Спасибо за информацию", "", "0", "" )	
	else
		showQuestWindow ( "Букер ДеВитт", "А вы наблюдательны. Действительно, тюрьма пустует, поэтому я отправил всех ополченцев по делам, тем-более, что в последнее время гули довольно сильно активизировались.", "Расскажите мне про ополчение", "militia_t_what_NC()", "Спасибо за информацию", "", "0", "", "0", "" )		
	end
end

function militia_t_what_NC ()
	if getElementData ( localPlayer, "quest_militia" ) == 0 then 
		showQuestWindow ( "Букер ДеВитт", "Наше ополчение - это оплот спокойствия в Новой Деревне. Наша работенка, прямо скажем, не простая. Постоянные набеги гулей и бандитов... Да еще и отношения с Новым Вегасом испортились, так что иногда приходится вступать в бои с солдатами из Вегаса...", "Расскажите мне про это место", "militia_t_place_NC()",  "А можно к вам записаться?", "militia_t_enjoy_NC()", "Спасибо за информацию", "", "0", "" )
	else
		showQuestWindow ( "Букер ДеВитт", "Наше ополчение - это оплот спокойствия в Новой Деревне. Наша работенка, прямо скажем, не простая. Постоянные набеги гулей и бандитов... Да еще и отношения с Новым Вегасом испортились, так что иногда приходится вступать в бои с солдатами из Вегаса...", "Расскажите мне про это место", "militia_t_place_NC()",  "Спасибо за информацию", "", "0", "", "0", "" )
	end
end

function militia_t_enjoy_NC ()
	setElementData ( localPlayer, "quest_militia", 1 )
	showQuestWindow ( "Букер ДеВитт", "Отлично. Пиходите ко мне, когда будет свободное время, я выдам вам задание.", "Расскажите мне про это место", "militia_t_place_NC()",  "Спасибо!", "", "0", "", "0", "" )
end

-- function removeMilPedFromVeh ( )
	-- if isElement ( source ) then
		-- if isElementSyncer ( source ) then
			-- state = setPedControlState ( source, "enter_exit", true )
			-- outputChatBox ( tostring(state) )
		-- end
	-- end
-- end

-- addEvent( "removeMilPedFromVehS", true )
-- addEventHandler( "removeMilPedFromVehS", getRootElement(), removeMilPedFromVeh )