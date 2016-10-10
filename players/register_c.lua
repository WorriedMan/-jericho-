local registerWindow
function startRegistration ()
	showChat ( true )
	registerWindow = guiCreateWindow(0.40, 0.37, 0.20, 0.39, "Регистрация", true)
	guiWindowSetSizable(registerWindow, false)

	local loginRegister = guiCreateEdit(0.19, 0.15, 0.63, 0.09, "Логин", true, registerWindow)
	local passRegister = guiCreateEdit(0.19, 0.28, 0.63, 0.08, "Пароль", true, registerWindow)
	local repassRegister = guiCreateEdit(0.19, 0.40, 0.63, 0.08, "Повторите пароль", true, registerWindow)
	local postRegister = guiCreateEdit(0.19, 0.53, 0.64, 0.08, "Электронная почта", true, registerWindow)
	local buttRegister = guiCreateButton(0.32, 0.76, 0.40, 0.16, "Регистрация", true, registerWindow)
	guiSetProperty(buttRegister, "NormalTextColour", "FFAAAAAA")
	local rulesRegister = guiCreateCheckBox(0.04, 0.65, 0.93, 0.06, "Я знаю правила общения в интернете", false, true, registerWindow)
	guiSetEnabled ( buttRegister, false )

	guiSetVisible ( registerWindow, true )
	showCursor(true)

	
	addEventHandler ( "onClientGUIClick", passRegister, 
		function ()
			if guiGetText ( passRegister ) == "Пароль" then
	 			guiSetText ( passRegister, "" )
				guiEditSetMasked ( passRegister, true )
	 		end
		end
	, false )
	addEventHandler ( "onClientGUIClick", repassRegister, 
		function ()
			if guiGetText ( repassRegister ) == "Повторите пароль" then
	 			guiSetText ( repassRegister, "" )
				guiEditSetMasked ( repassRegister, true )
	 		end
		end
	, false )
	addEventHandler ( "onClientGUIClick", postRegister, 
		function ()
			if guiGetText ( postRegister ) == "Электронная почта" then
	 			guiSetText ( postRegister, "" )
	 		end
		end
	, false )
	addEventHandler ( "onClientGUIClick", loginRegister, 
		function ()
			if guiGetText ( icqRegister ) == "Логин" then
	 			guiSetText ( icqRegister, "" )
	 		end
		end
	, false )
	addEventHandler ( "onClientGUIClick", rulesRegister, 
		function ()
			guiSetEnabled ( buttRegister, true )
		end
	, false )
	guiSetInputMode("no_binds_when_editing")
	addEventHandler("onClientGUIChanged", loginRegister, function(element) 
		guiSetText ( loginRegister, string.gsub (guiGetText( loginRegister ), "%W", "") )
	end)
	addEventHandler("onClientGUIChanged", loginRegister, function(element) 
		guiSetText ( loginRegister, string.gsub (guiGetText( loginRegister ), "[^qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890]+", "") )
	end)
	addEventHandler("onClientGUIChanged", passRegister, function(element) 
		guiSetText ( passRegister, string.gsub (guiGetText( passRegister ), "[^qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890]+", "") )
	end)
	addEventHandler("onClientGUIChanged", repassRegister, function(element) 
		guiSetText ( repassRegister, string.gsub (guiGetText( repassRegister ), "[^qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890]+", "") )
	end)
	local regPressed = 0
	addEventHandler("onClientGUIClick", buttRegister,
		function ()	
			if guiCheckBoxGetSelected ( rulesRegister ) then
				local login = guiGetText ( loginRegister )
				local mail = guiGetText ( postRegister )
				local password = guiGetText ( passRegister )
				local repassword = guiGetText ( repassRegister )
				if password ~= "" and mail ~= "" and repassword ~= "" and password ~= "Пароль" and login ~= "login" then
					if password == repassword then
						
						
						if regPressed == 0 then
							regPressed = 1 
							setTimer ( function () regPressed = 0 end, 2000, 1 )
							triggerServerEvent ( "finRegisterPlayer", getLocalPlayer(), login, password, mail )
						end	
						
					else
						outputChatBox ("Ошибка: Ваши пароли не совпадают (первая и вторая строка) ",255,255,127 )
					end
				else
					outputChatBox ("Ошибка: Строки \"Логин\", \"пароль\", \"повторите пароль\" и \"электронная почта\" должны быть заполнены!",255,255,127 )
				end
			else
				outputChatBox ("Ошибка: Вы должны подтвердить что знаете основные правила общения в интернете ", 255,255,127 )
			end
		end
	,false)
end

function registerSuccess()
	destroyElement ( registerWindow )
	nextRulesPlayer ()  
end

addEvent ( "players:registerSuccess", true )
addEventHandler ( 'players:registerSuccess', root, registerSuccess)

function nextRulesPlayer ()  
	local rulesWindow = guiCreateWindow(442,341,545,303,"Наши правила",false)
	local memo = guiCreateMemo(16,22,517,237,"Правил у нас не много, главное - не читерить и все будет ОК. Еще запрещен багоюз, оскорбления, мат и все тому подобное.\n\nНажимая кнопку \"Дальше\", вы соглашаетесь с правилами, расположенными по адресу je-ho.ru/rules.htm",false,rulesWindow)
	guiMemoSetReadOnly(memo,true)
	local button = guiCreateButton(171,268,193,26,"Дальше",false,rulesWindow)
	guiSetVisible ( rulesWindow, true )
	addEventHandler("onClientGUIClick", button,
		function ()	
			createLearningMessages ()
			showCursor(false)
			guiSetVisible ( rulesWindow, false )
			regMusic = playSound ( ":players/sounds/end.ogg" )
			setSoundVolume(regMusic, 0.2)
		end
	,false)
end

lrnMsg = {
	{ "Добро пожаловать в Jericho: Fallout Online!", 255, 150, 0, 2 },
	{ "Здесь ты можешь делать все, что душе угодно!", 255, 255, 255, 3 },
	{ "Хочешь - стань исследователем, хочешь - убивай гулей, хочешь - стань бандитом!", 255, 255, 255, 4 },
	{ "У нас есть много занятий для тебя", 255, 255, 255, 2 },
	{ "Но сначала узнай немного информации о сервере.", 255, 255, 255, 4 },
	{ "За убийство одного гуля ты получаешь определенную сумму денег (которая увеличивается, когда у тебя увеличивается уровень).", 255, 255, 255, 6 },
	{ "Учти два правила выживания:", 255, 255, 255, 3 },
	{ "1. Не позволяй гулям тебя атаковать, иначе скоро умрешь от радиации", 255, 255, 255, 5 },
	{ "2. Не ешь и не бери что попало, иначе скоро умрешь от радиации", 255, 255, 255, 5 },
	{ "В игре имеется множество населенных пунктов, например", 255, 255, 255, 3 },
	{ "Новая Деревня, Союз Ученых, Новый Вегас, Ривет Сити", 255, 255, 255, 4 },
	{ "Но с самого начала ты имеешь доступ только в одну деревню, доступ к остальным надо заслужить", 255, 255, 255, 6 },
	{ "Новая Деревня - почти-что обычная деревня, со своим мэром, ополчением, но и со своими тараканами в голове жителей.", 255, 255, 255, 8 },
	{ "Союз Ученых - оплот старого правительства и их армии.", 255, 255, 255, 8 },
	{ "Для обычных людей здесь есть только общие бараки, да несколько точек торговли.", 255, 255, 255, 7 },
	{ "Новый Вегас - самая богатая деревня всей пустыни, здесь балом правит мафия.", 255, 255, 255, 8 },
	{ "Но, порой, эта мафия даже лучше управляет своей деревней, чем свихнувшиеся доктора Союза Ученых и фанатики из Новой Деревни.", 255, 255, 255, 8 },
	{ "По остальным поселениям узнаешь сам.", 255, 255, 255, 4 },
	{ "Это все, что я хотел тебе рассказать. Если возникнут еще вопросы, то можешь спросить ответы у хелперов, или в группе vk.com/jehorpg", 255, 255, 255, 15 },
	{ "Начнешь ты свое путешествие в Новой Деревне, с небольшой суммой денег в кармане", 255, 255, 255, 8 },
	{ "Так что отправляйся покорять жестокий мир Фаллаута! Удачи тебе!", 255, 255, 255, 8 }
}

cameraTms = {
	{ -36.3876953125,2350.3193359375,35.302555084229, -196.49609375,2591.4482421875,62.859375, 15},
	{ -36.3876953125,2350.3193359375,35.302555084229, -196.49609375,2591.4482421875,62.859375, 6 },
	{ -275.5712890625,2632.99609375,70.645660400391, -223.7783203125,2760.853515625,62.6875, 13 },
	{ -480.8408203125,1964.8408203125,84.682006835938, -547.3818359375,2005.501953125,60.3828125, 12 },
	{ -759.6572265625,2058.0634765625,70.3828125, -677.263671875,2057.51171875,60.1875, 8 },
	{ -334.4130859375,1524.8818359375,85.356956481934, -286.609375,1496.7255859375,75.980895996094, 15 }, -- союз ученых
	{ -223.7783203125,2760.853515625,75.6875, -275.5712890625,2632.99609375,62.645660400391, 22 }, -- новый вегас
	{ -223.7783203125,2760.853515625,75.6875, -275.5712890625,2632.99609375,62.645660400391, 30 }
	
}

function createLearningMessages ()
	setElementData ( localPlayer, "cameraFly", false)
	local offsetTime = 1
	for i = 1, #lrnMsg do
		setTimer ( function ()
						exports.textLib:showMessageDX ( lrnMsg[i][1], lrnMsg[i][5], lrnMsg[i][2], lrnMsg[i][3], lrnMsg[i][4] )
				   end, offsetTime*1000, 1 )
		offsetTime = offsetTime + lrnMsg[i][5]
	end
	offsetTime = 1
	for i = 1, #cameraTms do 
		if i == #cameraTms then
			setTimer ( function ()
						exports.login_jericho:loadLoginWindow (nil,true)
						outputChatBox ("Введите свои логин и пароль, после чего нажмите кнопку \"Войти\"", 255,255,255 )
						--setFarClipDistance(60)
					end, offsetTime*1000, 1 )
			break
		end
		setTimer ( function ()
						setCameraMatrix ( cameraTms[i][1], cameraTms[i][2], cameraTms[i][3], cameraTms[i][4], cameraTms[i][5], cameraTms[i][6] )
					end, offsetTime*1000, 1 )
		offsetTime = offsetTime + cameraTms[i][7]
	end
end

function nextFinishReg ()
	createLearningMessages ()
	showCursor(false)
	setFarClipDistance(150)
end