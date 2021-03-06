function start ()

end

-- Новая Деревня

nc_sold = {
"sounds/nc/nc_sold_1.wav",
"sounds/nc/nc_sold_2.wav",
"sounds/nc/nc_sold_3.wav"
}

function meet_nc_Soldiers_Q (x,y,z)
	local nc_sold_sound = playSound3D( nc_sold[math.random( 1, 3 )], x, y, z ) 
	setSoundMaxDistance( nc_sold_sound, 3 )
	showQuestWindow ( "Ополченец", "Чего тебе?", "Я хочу спросить, что и где здесь находится", "pos_nc_Soldiers_Q()", "Что ты охраняешь?", "pos_nc_"..tostring(sold_pos).."_Soldiers_Q()", "Ничего, извини что побеспокоил", "0", "0", "president_Main_Q()" )
end

function pos_nc_1_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Ополченец", "Я охраняю наш местный магазин оружия, заходи, там очень хорошие цены, а оружие почти без радиации", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_nc_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_nc_2_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Ополченец", "Я охраняю нашу мэрию. Можешь зайти туда если хочешь, я думаю секретарь мэра с радостью поговорит с тобой", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_nc_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_nc_3_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Ополченец", "Я охраняю наш центр ополчения. Тебе там делать нечего, так что проваливай остюда", "Да мне накласть на твое мнение, аривидерчи", "", "Ладно, ладно, я не хочу нарушать закон", "", "Я хочу спросить что и где здесь находится", "pos_nc_Soldiers_Q()", "0", "president_Main_Q()" )
end

-- function pos_nc_4_Soldiers_Q ()
	-- sold_pos = 0
	-- showQuestWindow ( "Ополченец", "Я ничего не охраняю, так что вали отсюда пока кости целы, я не в настроении", "Все все, я уже ухожу", "", "Что то стряслось?", "problem_nc_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
-- end

function problem_nc_Soldiers_Q ()
	sold_pos = 0
	outputChatBox ("Ополченец: Стряслось, но тебя это не касается", 255,255,255 )
end

 function pos_nc_5_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Ополченец", "Это центральное здание нашей деревни, там ты можешь поесть, поспать, купить одежду и лекартсва. А какая там красавица в ресторане то работает!", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_nc_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

 function pos_nc_4_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Ополченец", "Под моим контролем находится въезд в деревню. Это самое худшее место для службы. Постоянно с утеса прямо сюда падают зомби, потом приходится отдирать их от асфальта.", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_nc_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_nc_Soldiers_Q ()
	showQuestWindow ( "Ополченец", "Буду говорить тебе относительно въезда в деревню. Первыми идут стоянка автомобилей и центр ополчения. Пройдя дальше, по правую сторону ты увидишь мэрию, а чуть дальше, по левую, магазин оружия. В конце деревни находятся церковь и центральное здание.", "Спасибо за информацию", "", "0", "", "0", "president_Main_Q()", "0", "" )
end

-- закрытие Новой Деревни

-- открытие Союза Ученых

function meet_su_Soldiers_Q ()
	showQuestWindow ( "Солдат", "Проходи мимо, я на дежурстве.", "Я хочу спросить что и где здесь находится", "pos_su_Soldiers_Q()", "Что ты охраняешь?", "pos_su_"..tostring(sold_pos).."_Soldiers_Q()", "Уже ухожу", "", "0", "president_Main_Q()" )
end

 function pos_su_1_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Солдат", "Центр выдачи населению лекарств. Это, возможно, самое востребованное здание в округе. Кстати, советую тут закупиться лекарствами, здесь самые дешевые цены.", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_su_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_su_2_Soldiers_Q ()
	sold_pos = 0
	outputChatBox ("Солдат: По всем вопросам обращайся к капитану Членсу.", 255,255,255 )
	--showQuestWindow ( "Солдат", "Въезд на территорию военного объекта Союз Ученых. ", "Вольно", "", "Я хочу спросить что и где здесь находится", "pos_su_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_su_3_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Солдат", "Нашу местную тюрьму. Правда в последнее время сюда попадает все меньше и меньше народу. Все из за этого Отца Фифана, он ведет религиозную пропаганду среди местных беженцев, что, между прочим очень не нравится руководству базы.", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_su_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

 function pos_su_4_Soldiers_Q ()
	sold_pos = 0
	outputChatBox ("Солдат: Проход разрешен только персоналу базы.", 255,255,255 )
	--showQuestWindow ( "Солдат", "Въезд на территорию военного объекта Союз Ученых. ", "Вольно", "", "Я хочу спросить что и где здесь находится", "pos_su_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_su_5_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Солдат", "Контролирую ситуацию в жилых помещениях беженцев. Можешь здесь поесть и отдохнуть. Но помни, что все помещение находится под примотром камер наблюдения, не вздумай дебоширить.", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_su_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_su_6_Soldiers_Q ()
	sold_pos = 0
	outputChatBox ("Солдат: По всем вопросам обращайся к капитану Членсу.", 255,255,255 )
end
-- Открытие Новый Вегас

nv_sold = {
"sounds/nv/nv_sold_1.wav",
"sounds/nv/nv_sold_2.wav",
"sounds/nv/nv_sold_3.wav"
}

function meet_nv_Soldiers_Q (x,y,z)
	local nv_sold_sound = playSound3D( nv_sold[math.random( 1, 3 )], x, y, z ) 
	setSoundMaxDistance( nv_sold_sound, 3 )
	showQuestWindow ( "Бандит", "Чего тебе? У меня не так много времени, что бы тратить его на всяких голодранцев.", "Я хочу спросить что и где здесь находится", "pos_nv_Soldiers_Q()", "Что ты охраняешь?", "pos_nv_"..tostring(sold_pos).."_Soldiers_Q()", "Ничего, извини что побеспокоил", "0", "0", "president_Main_Q()" )
end

function pos_nv_1_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Бандит", "Я охраняю оружейный магазин. Кстати, заходи, здесь только самое лучшее оружие со всего Сан Андреаса. Ходят, слухи, будто бы владелец этого магазина договорился с одним все еще работающим заводом оружия, который находится недалеко от Лас Вентураса.", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_nv_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_nv_2_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Бандит", "Я охраняю вход в бар Мегатонна, заходи, освежись свежим пивком или водкой, у Фила большой набор напитков.", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_nv_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_nv_5_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Бандит", "Да вот, распорядили меня на охрану пункта продажи лекарств. Эх... Как же я скучаю по былым временам, когда мы под командованием Джонса отбивали эту территорию от гулей...", "Кто такой Джонс?", "john_nv_3_Soldiers_Q()", "Я хочу спросить что и где здесь находится", "pos_nv_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function john_nv_3_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Бандит", "Ты что, не знаешь кто это? Он был первым мэром Нового Вегаса. Джонс командовал отрядом военных, в котором состоял я, этот отряд и отбил небольшой участок земли от гулей, который сейчас все называют Новым Вегасом. Но потом пришли все эти бандиты, власть поменялась, чтобы выжить нам пришлось согласится на их условия, а Джонс исчез. О нем и по сей день ничего не слышно.", "Интересная, история. Ну ладно, мне уже пора бежать.", "", "0", "problem_nc_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_nv_4_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Бандит", "Как видишь, мне приходится наблюдать и за ареной гулей и за рынком автомобилей. Кстати, если хочешь подзаработать деньжат - обратись к распорядителю арены, что сидит вон во входе на арену, левее от меня. Думаю, он даст тебе шанс показать себя на арене.", "Хм... Деньжата это конечно хорошо, я обязательно подумаю об этом.", "", "Нет уж, я не хочу рисковать своей жизнью.", "", "Я хочу спросить что и где здесь находится", "pos_nv_Soldiers_Q()", "0", "president_Main_Q()" )
end

function pos_nv_3_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Бандит", "Это мэрия Нового Вегаса, а заодно и база нашей Мафии, так что тебе там делать нечего, проваливай.", "Мафия говоришь? Пожалуй да, уйду ка я отсюда.", "", "У меня есть дело к мэру, так что не жужи мне тут.", "", "Я хочу спросить что и где здесь находится", "pos_nv_Soldiers_Q()", "0", "president_Main_Q()" )
end

function pos_nv_6_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Бандит", "А больше тебе ничего не сказать?", "Извини, не хотел тебя беспокоить.", "", "Да как ты говоришь с новым мэром?!", "chat_nv_6_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function chat_nv_6_Soldiers_Q ()
	outputChatBox ("Бандит: Ага, как же, топай восвоясие, шутник.", 255,255,255 )
end

function pos_nv_7_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Бандит", "Я охраняю самый дорогой дом Нового Вегаса от всякого сброда, что шатается сюда из трейлерного парка.", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_nv_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function pos_nv_8_Soldiers_Q ()
	sold_pos = 0
	showQuestWindow ( "Бандит", "Здесь живет элита Нового Вегаса, так что, если у тебя тут нету дома, то проваливай.", "Спасибо за информацию, пока", "", "Я хочу спросить что и где здесь находится", "pos_nv_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function meh_nv_Soldiers_Q ()
	--local sound = playSound3D( "sounds/nv/door_closed.wav", x, y, z ) 
--	setSoundMaxDistance( sound, 3 )
	sold_pos = 0
	showQuestWindow ( "Бандит", "Вход в дом Механика запрещен указом мэра, вали отсюда.", "Но мне нужно попасть внутрь!", "meh_no_nv_Soldiers_Q()", "Я хочу спросить, что и где здесь находится", "pos_no_nv_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function meh_no_nv_Soldiers_Q ()
	outputChatBox ("Бандит: Мне все равно, указ есть указ.", 255,255,255 )
end

function pos_no_nv_Soldiers_Q ()
	outputChatBox ("Бандит: Я тебе не справочная служба, у меня важное задание.", 255,255,255 )
end

function pos_nv_Soldiers_Q ()
	showQuestWindow ( "Бандит", "Прямо напротив мэрии находятся: элитный жилой район, авторынок, продуктовый магазин и бар Мегатонна. На следующей улице находятся арена, пункт продажи лекарств, оружейка и дом механика Гэта. Дальше идет жилой район.", "Спасибо за информацию", "", "0", "pos_nc_"..tostring(sold_pos).."_Soldiers_Q()", "0", "warman_Main_Q()", "0", "president_Main_Q()" )
end

function bank_nc_nv_Soldiers_Q ()
	showQuestWindow ( "Бандит", "Чего тебе?", "Зачем ты тут стоишь?", "bank_nc_why_Soldiers_Q()", "Хороший у тебя автомат", "rifle_bank_nc_Soldiers_Q()", "Ничего", "", "0", "president_Main_Q()" )
end

function bank_nc_why_Soldiers_Q ()
	showQuestWindow ( "Бандит", "Я охраняю местное отделение Банка Нового Вегаса. Ужасная работа, но зато платят так, что через пару месяцев я смогу купить дом в элитном районе Нового Вегаса.", "Так ты не местный?", "bank_nc_out_Soldiers_Q()", "И сколько же тебе платят?", "bank_nc_cash_Soldiers_Q()", "Хороший у тебя автомат", "rifle_bank_nc_Soldiers_Q()", "Спасибо за информацию", "" )
end

function bank_nc_out_Soldiers_Q ()
	showQuestWindow ( "Бандит", "Нет конечно, я сам то с Лас Вентураса, но спустя некоторое время после нашествия этих мертвяков я перебрался в Новый Вегас, там как раз еще всем заправлял мэр Джонс. Долго там себе не мог найти работу, я ведь в нормальной жизни был менеджером в магазине. Но вот недавно они открыли это отделение банка и я решил отправиться охраником.", "И как тебе тут живется?", "bank_nc_live_Soldiers_Q()", "И сколько же тебе платят?", "bank_nc_cash_Soldiers_Q()", "Хороший у тебя автомат", "rifle_bank_nc_Soldiers_Q()", "Спасибо за информацию", "" )
end

function bank_nc_live_Soldiers_Q ()
	showQuestWindow ( "Бандит", "Не сказать что сладко. Все жители Новой Деревни и Эль Кебрадоса давным давно спятили. Я вообще не понимаю, зачем тут делать отделение банка. Но платят - и ладно, переживу как нибуть.", "Почему ты сделал такой вывод?", "bank_nc_insane_Soldiers_Q()", "И сколько же тебе платят?", "bank_nc_cash_Soldiers_Q()", "Хороший у тебя автомат", "rifle_bank_nc_Soldiers_Q()", "0", "" )
end


function bank_nc_insane_Soldiers_Q ()
	showQuestWindow ( "Бандит", "Я не думаю что это уместно обсуждать ТУТ. Захочешь - сам все поймешь, это быстро бросается в глаза. Мой тебе совет - не задерживайся тут, при первой же возможности попытайся свалить в Новый Вегас или, на крайний случай, в Союз Ученых.", "Спасибо за информацию, последую твоему совету", "", "И сколько же тебе платят?", "bank_nc_cash_Soldiers_Q()", "Хороший у тебя автомат", "rifle_bank_nc_Soldiers_Q()", "Мне кажется, что с местными все впорядке", "bank_nc_alright_Soldiers_Q()" )
end

function bank_nc_alright_Soldiers_Q()
	outputChatBox ("Бандит: Ага, конечно, а я будущий мэр Нового Вегаса.", 255,255,255 )
end

function bank_nc_cash_Soldiers_Q ()
	showQuestWindow ( "Бандит", "Достаточно много, но ты даже не думай позариться на мои деньги.", "Так ты не местный?", "bank_nc_out_Soldiers_Q()", "Да я и не думал, извини", "", "Хороший у тебя автомат", "rifle_bank_nc_Soldiers_Q()", "0", "" )
end

function rifle_bank_nc_Soldiers_Q()
	showQuestWindow ( "Бандит", "Ага, недавно мне его начальство привезло.", "Зачем ты тут стоишь?", "bank_nc_why_Soldiers_Q()", "Спасибо за информацию", "", "0", "rifle_bank_nc_Soldiers_Q()", "0", "" )
end

-- Закрытие Новый Вегас
function finish()

end

