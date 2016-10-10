local changeLabelTimer 

function loadLoginWindow (_,nomusic)
	if not getElementData ( localPlayer, "loged" ) then
		addEventHandler ( "onClientRender", root, renderPipWindowses )
		fadeCamera(true)
		showCursor ( true )
		setPlayerHudComponentVisible ( "radar", false )
		showChat ( false )
		setCameraFly()
		if not nomusic then
			backgroundSound = playSound("background.mp3")
		end
		local screenWidth,screenHeight = guiGetScreenSize()
		createPipWindow({name="loginWindow",x=screenWidth/2-350,y=screenHeight/2-200,width=700,height=400,alpha=180})
		createPipButton ( {name="loginButton",x=20, y=300, width = 200, height = 30, parent = "loginWindow",itext="Войти",alignX="center",showBack = true} )
		createPipButton ( {name="registerButton",x=20, y=350, width = 200, height = 30, parent = "loginWindow",itext="Регистрация",alignX="center",showBack = true} )
		createPipButton ( {name="newsLabel",x=350, y=30, width = 230, height = 50, parent = "loginWindow",itext="Новости сервера",alignX="center",alignY = "center",fontSize=1.0} )
		createPipButton ( {name="news1",x=250, y=110, width = 420, height = 70, parent = "loginWindow",itext="-",alignX="center" ,fontSize=1} )
		createPipButton ( {name="news2",x=250, y=195, width = 420, height = 70, parent = "loginWindow",itext="-",alignX="center" ,fontSize=1} )
		createPipButton ( {name="news3",x=250, y=280, width = 420, height = 70, parent = "loginWindow",itext="-",alignX="center" ,fontSize=1} )
		createPipEdit ( {name="passwordEdit",x=20, y=100, width = 200, height = 30, parent = "loginWindow",itext="Ваш пароль",masked=true,resetInitial = true,max=19} )
		createPipEdit ( {name="loginEdit",x=20, y=50, width = 200, height = 30, parent = "loginWindow",itext=getPlayerName ( localPlayer ),max=19} )
		triggerServerEvent ("login:askNews",localPlayer)
	end
end

addEventHandler("onClientResourceStart", resourceRoot, loadLoginWindow )

function buttonClicked(button)
	if button.name == "loginButton" then
		triggerServerEvent ("login:loginClicked",localPlayer,pipWindowses["loginWindow"].child["loginEdit"].text,pipWindowses["loginWindow"].child["passwordEdit"].text)
	elseif button.name == "registerButton" then
		exports.players:startRegistration()
		hideWindow(true)
	end
end

addEvent ( "pipButtonClicked", true )
addEventHandler ( 'pipButtonClicked', root, buttonClicked)

function loginWrong()
	if not changeLabelTimer or not isTimer ( changeLabelTimer ) then
		playSound ( "passbad.wav" )
		pipWindowses["loginWindow"].child["loginButton"].text = "Логин неправильный"
		changeLabelTimer = setTimer ( function () pipWindowses["loginWindow"].child["loginButton"].text = "Войти" end, 2000, 1 )
	end
end

addEvent ( "login:loginWrong", true )
addEventHandler ( 'login:loginWrong', root, loginWrong)

function passwordWrong()
	if not changeLabelTimer or not isTimer ( changeLabelTimer ) then
		playSound ( "passbad.wav" )
		pipWindowses["loginWindow"].child["loginButton"].text = "Пароль неправильный"
		changeLabelTimer = setTimer ( function () pipWindowses["loginWindow"].child["loginButton"].text = "Войти" end, 2000, 1 )
	end
end

addEvent ( "login:passwordWrong", true )
addEventHandler ( 'login:passwordWrong', root, passwordWrong)

function sendNews (news)
	for i, v in ipairs ( news ) do
		pipWindowses["loginWindow"].child["news"..i].text = v.news
	end
end

addEvent("login:sendNews",true)
addEventHandler("login:sendNews",getRootElement(),sendNews)

function hideWindow (notcamera)
	pipWindowses["loginWindow"]:destroyMe()
	removeEventHandler ( "onClientRender", root, renderPipWindowses )
	showCursor(false) 
	stopSound ( backgroundSound )
	removeEventHandler ( "onClientRender", root, flyCamera )
	if not notcamera then
		setCameraTarget(localPlayer)
	end
end

addEvent("login:hideWindow",true)
addEventHandler("login:hideWindow",getRootElement(),hideWindow)