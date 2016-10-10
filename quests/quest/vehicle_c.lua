function xzbt_veh_start_CL ()
	showQuestWindow ( "Xzibit", "Йоу бро, я Иксизибит, добро пожаловать в Вест Сайд. Мы тут тюнингуем тачки и продаем их.", "Вы можете улучшить мой автомобиль?", "xzbt_veh_s_talk_CL()", "Как вы тут оказались?", "xzbt_t_how_CL()", "У вас тут есть что купить, кроме машин?", "xzbt_t_sell_CL()", "Спасибо за приветствие", "" )
end

function xzbt_veh_start_nv_CL ()
	showQuestWindow ( "Xzibit", "Йоу бро, я Иксизибит, добро пожаловать в Вест Сайд. Мы тут тюнингуем тачки и продаем их.", "Будь у меня машина, вы бы ее улучшили?", "xzbt_veh_s_talk_CL()", "Как вы тут оказались?", "xzbt_t_how_CL()", "У вас тут есть что купить, кроме машин?", "xzbt_t_sell_CL()", "Спасибо за приветствие", "" )
end

function xzbt_talk_NV ()
	showQuestWindow ( "Xzibit", "Йоу бро, что хотел?", "Как вы тут оказались?", "xzbt_t_how_CL()", "У вас тут есть что купить, кроме машин?", "xzbt_t_sell_CL()", "Спасибо за приветствие", "", "0", "" )
end

function xzbt_veh_s_talk_CL ()
	showQuestWindow ( "Xzibit", "Канеш. Но только в том случае, если ты выполниш пару моих заданий.", "Выкладывай, что ты от меня хочешь.", "xzbt_veh_s_say_CL()", "Мне это не интересно", "", "0", "", "0", "" )
end


function xzbt_veh_s_say_CL ()
	showQuestWindow ( "Xzibit", "Ну, начнем с простого. У нас в поселении сломалась последняя лопата. Привези мне 3 лопаты, я тебя хорошенько вознагражу .", "И все? Звучит проще простого.", "xzbt_veh_s_read_CL()", "Я справлюсь с этим.", "xzbt_veh_s_read_CL()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function xzbt_veh_s_read_CL ()
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_vehicle", 1)
	exports.pipboy:addInfoBox("Получено задание \"Тачка на прокачку\"", 3 )
end

function xzbt_veh_1st_CL ()
	showQuestWindow ( "Xzibit", "Принес лопаты? Мы уже не можем, еще чуть-чуть и случится в нашем поселении коллапс.", "Я надеюсь, что до этого не дойдет", "", "Как вы тут оказались?", "xzbt_t_how_CL()", "У вас тут есть что купить, кроме машин?", "xzbt_t_sell_CL()", "Так вам и надо... Ой, скоро привезу", "" )
end

function xzbt_veh_vodka_CL ()
	local shovelID = exports.inventory:getItemAmount (28) or 0
	if shovelID >= 3 then
		showQuestWindow ( "Xzibit", "Отлично, я уже вижу эти новенькие лопаты. Перед тем, как я разрешу тебе у нас тюнинговаться, я хочу тебе попросить еще об одной вещи.", "Выкладывай, я с радостью", "xzbt_veh_v_start_CL()", "Что-ж вы все так говорите", "xzbt_veh_v_start_CL()", "Как-нибуть в другой раз", "", "0", "" )
	else
		showQuestWindow ( "Xzibit", "Принес лопаты? Мы уже не можем, еще чуть-чуть и случится в нашем поселении коллапс.", "Я надеюсь, что до этого не дойдет", "", "Как вы тут оказались?", "xzbt_t_how_CL()", "У вас тут есть что купить, кроме машин?", "xzbt_t_sell_CL()", "Так вам и надо... Ой, скоро привезу", "" )
	end
end

function xzbt_veh_v_start_CL ()
	exports.inventory:removePlayerItem ( 28, 3 )
	if getElementData ( localPlayer, "quest_main_st" ) > 6 then
		showQuestWindow ( "Xzibit", "Вобщем у меня смертельная болезнь, шпинатонедостаточность.", "Что?", "xzbt_veh_v_what_CL()", "Э?", "xzbt_veh_v_what_CL()", "Так это тебе к Попаю надо, он в Союзе Ученых", "xzbt_veh_v_popeye_CL()", "Что-то я о такой ни разу не слышал", "xzbt_veh_v_what_CL()" )
	else
		showQuestWindow ( "Xzibit", "Вобщем у меня смертельная болезнь, шпинатонедостаточность.", "Что?", "xzbt_veh_v_what_CL()", "Э?", "xzbt_veh_v_what_CL()", "Что-то я о такой ни разу не слышал", "xzbt_veh_v_what_CL()", "0", "" )
	end
end

function xzbt_veh_v_popeye_CL ()
	showQuestWindow ( "Xzibit", "Мне дорога в Союз заказана. Слушай, для меня жизнено необходимо сьедать каждую неделю по баночке шпината. Наши запасы шпината иссякли на этой неделе. Принеси мне 20 банок шпината, и я разрешу тебе пользоваться нашей автомастерской и продавать тут свои автомобили", "Ну ладно, коли уж такое дело, будет тебе шпинат", "xzbt_veh_v_begin_CL()", "Ну... Это... Ладно...", "xzbt_veh_v_begin_CL()", "0", "xzbt_veh_v_what_CL()", "0", "" )
end

function xzbt_veh_v_what_CL ()
	showQuestWindow ( "Xzibit", "Это долго обьяснять, самое главное - мне нужно сьедать каждую неделю по баночке шпината. Наши запасы шпината иссякли на этой неделе. Принеси мне 20 банок шпината, и я разрешу тебе пользоваться нашей автомастерской и продавать тут свои автомобили.", "Ну ладно, коли уж такое дело, будет тебе шпинат", "xzbt_veh_v_begin_CL()", "Ну... Это... Ладно...", "xzbt_veh_v_begin_CL()", "0", "xzbt_veh_v_what_CL()", "0", "" )
end

function xzbt_veh_v_begin_CL ()
	exports.players:givePlayerXPClient ( 40 )
	exports.pipboy:addInfoBox("Прогресс сохранен",4)
	setElementData ( localPlayer, "quest_vehicle", 3)
end

function xzbt_veh_v_yes_CL ()
	showQuestWindow ( "Xzibit", "Как я погляжу, у тебя есть немного шпината, давай сюда.", "Держи", "xzbt_veh_v_give_CL()", "Нет, этот мне нужен самому", "", "0", "xzbt_veh_v_what_CL()", "0", "" )
end

function xzbt_veh_v_give_CL ()
	local gived = getElementData ( localPlayer, "xzbt_s" )
	local spinachQuant = exports.inventory:getItemAmount (17) or 0
	local need = 20 - gived -- 11
	if need > spinachQuant then
		exports.inventory:removePlayerItem ( 17, spinachQuant )
		setElementData ( localPlayer, "xzbt_s", gived+spinachQuant)
		outputChatBox ("Xzibit: спасибо бро, осталось принести всего "..tostring(need-spinachQuant).." банок шпината", 255,255,255 )
	elseif need == spinachQuant then
		exports.inventory:removePlayerItem ( 17, spinachQuant )
		triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 2000 )
		exports.achievments:givePoint ( 1 )
		showQuestWindow ( "Xzibit", "Спасибо бро, я не знаю, что делал бы без тебя. Можешь тюнинговать свою тачку в нашей автомастерской, и еще, давай я встрою тебе экран в Антирад костюм, чтоб ты мог смотреть кинцо, пока вокруг сущий ад.", "Рад стараться", "xzbt_veh_finish_CL()", "А что-бы я делал то, без этих денег", "xzbt_veh_finish_CL()", "0", "", "0", "" )
	else
		exports.inventory:removePlayerItem ( 17, need )
		triggerServerEvent ( "giveClientMoney", getLocalPlayer(), 2000 )
		exports.achievments:givePoint ( 1 )
		showQuestWindow ( "Xzibit", "Спасибо бро, я не знаю, что делал бы без тебя. Можешь тюнинговать свою тачку в нашей автомастерской, и еще, давай я встрою тебе экран в Антирад костюм, чтоб ты мог смотреть кинцо, пока вокруг сущий ад.", "Рад стараться", "xzbt_veh_finish_CL()", "А что-бы я делал то, без этих денег", "xzbt_veh_finish_CL()", "0", "", "0", "" )
	end
end

function xzbt_veh_finish_CL ()
	setElementData ( localPlayer, "quest_vehicle", 4)
	exports.pipboy:addInfoBox("Теперь вы можете улучшать свои автомобили в этой деревне." )
end

function xzbt_veh_v_no_CL ()
	showQuestWindow ( "Xzibit", "Шпината нет?", "Нет пока", "", "Как вы тут оказались?", "xzbt_t_how_CL()", "У вас тут есть что купить, кроме машин?", "xzbt_t_sell_CL()", "0", "" )
end

function xzbt_t_how_CL ()
	showQuestWindow ( "Xzibit", "Я со своей бандой долго скитался, пока не нашел это место, которое оказалось идеальным для нового поселения.", "У вас тут есть что купить, кроме машин?", "xzbt_t_sell_CL()", "Я пошел", "", "0", "", "0", "" )
end

function xzbt_t_sell_CL ()
	showQuestWindow ( "Xzibit", "Свои запасы мы не продаем, но можешь посмотреть, что есть у Караванщиков, которые находятся около въезда в поселение.", "Как вы тут оказались?", "xzbt_t_how_CL()", "Пойду спрошу у них", "", "0", "", "0", "" )
end