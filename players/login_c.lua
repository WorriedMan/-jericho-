local localPlayer = getLocalPlayer()
local playerName = getPlayerName(localPlayer)

function createPasswordWindow()
	windowChangepw = guiCreateWindow(0.3859,0.349,0.2219,0.1628,"Изменить пароль",true)
	guiSetSize(windowChangepw, 165, 21)
	guiSetAlpha(windowChangepw,0.80000001192093)
	editOldpw = guiCreateEdit(110,29,165,21,"",false,windowChangepw)
	guiSetAlpha(editOldpw,1)
	guiEditSetMasked(editOldpw,true)
	labelOldpw = guiCreateLabel(10,29,90,21,"Старый пароль:",false,windowChangepw)
	guiSetAlpha(labelOldpw,1)
	guiLabelSetColor(labelOldpw,255,255,255)
	guiLabelSetVerticalAlign(labelOldpw,"center")
	guiLabelSetHorizontalAlign(labelOldpw,"left",false)
	editNewpw = guiCreateEdit(110,60,165,21,"",false,windowChangepw)
	guiSetAlpha(editNewpw,1)
	guiEditSetMasked(editNewpw,true)
	guiEditSetMaxLength(editNewpw,50)
	labelNewpw = guiCreateLabel(10,60,90,21,"Новый пароль:",false,windowChangepw)
	guiSetAlpha(labelNewpw,1)
	guiLabelSetColor(labelNewpw,255,255,255)
	guiLabelSetVerticalAlign(labelNewpw,"center")
	guiLabelSetHorizontalAlign(labelNewpw,"left",false)
	buttonChangepw = guiCreateButton(10,91,265,23,"Изменить пароль",false,windowChangepw)
	guiSetAlpha(buttonChangepw,1)
	
	guiSetVisible(windowChangepw, false)
	
	addEventHandler("onClientGUIClick", buttonChangepw, clientSubmitChangepw, false)
end

function createLoginWindow()
	windowLogin = guiCreateWindow(0.3945,0.3646,0.2109,0.2018,"Авторизация",true)
	guiSetSize(windowLogin, 270, 155, false)
	guiSetAlpha(windowLogin,1)
	labelUsername = guiCreateLabel(10,52,59,24,"Логин:",false,windowLogin)
	guiSetAlpha(labelUsername,1)
	guiLabelSetColor(labelUsername,255,255,255)
	guiLabelSetVerticalAlign(labelUsername,"center")
	guiLabelSetHorizontalAlign(labelUsername,"left",false)
	labelPassword = guiCreateLabel(10,86,59,24,"Пароль:",false,windowLogin)
	guiSetAlpha(labelPassword,1)
	guiLabelSetColor(labelPassword,255,255,255)
	guiLabelSetVerticalAlign(labelPassword,"center")
	guiLabelSetHorizontalAlign(labelPassword,"left",false)
	labelInfo = guiCreateLabel(10,26,250,17,"Войдите или зарегистрируйтесь.",false,windowLogin)
	guiSetAlpha(labelInfo,1)
	guiLabelSetColor(labelInfo,255,255,255)
	guiLabelSetVerticalAlign(labelInfo,"top")
	guiLabelSetHorizontalAlign(labelInfo,"center",false)
	guiSetFont(labelInfo,"default-bold-small")
	editUsername = guiCreateEdit(79,52,181,25,playerName,false,windowLogin)
	guiSetAlpha(editUsername,1)
	guiEditSetMaxLength(editUsername, 50)
	editPassword = guiCreateEdit(79,86,181,25,"",false,windowLogin)
	guiSetAlpha(editPassword,1)
	guiEditSetMasked(editPassword, true)
	guiEditSetMaxLength(editPassword, 50)
	buttonLogin = guiCreateButton(10,121,120,21,"Вход",false,windowLogin)
	guiSetAlpha(buttonLogin,1)
	buttonRegister = guiCreateButton(143,121,117,21,"Регистрация",false,windowLogin)
	guiSetAlpha(buttonRegister,1)
	
	guiSetVisible(windowLogin, false)
	
	addEventHandler("onClientGUIClick", buttonLogin, clientSubmitLogin, false)
	addEventHandler("onClientGUIClick", buttonRegister, function ()
															guiSetVisible ( windowLogin, false )
															startRegistration ()
														end, false)
end

function resourceStart()
	triggerServerEvent ( "checkGuestAccountC", localPlayer )
	setTimer ( checkInventoryLoaded, 3000, 1 )
end

function checkInventoryLoaded () 
	if not getResourceFromName ( "inventory" ) then
		outputChatBox ( 'ОШИБКА ПРИ ЗАГРУЗКЕ. ПЕРЕЗАЙДИТЕ НА СЕРВЕР.', 255, 0, 0 )
	end
end

function showLoginWindow ()
	if not getElementData ( localPlayer, "online" ) then
		createLoginWindow()
		if (windowLogin ~= nil) then
			guiSetVisible(windowLogin, true)
		else
			outputChatBox("Ошибка.")
		end
		showCursor(true)
		guiSetInputEnabled(true)
	end
end

function changePw()
	createPasswordWindow()
	guiSetVisible(windowChangepw, true)
	showCursor(true)
	guiSetInputEnabled(true)
end

function clientSubmitLogin(button, state)
	if button == "left" and state == "up" then
		local username = guiGetText(editUsername)
		local password = guiGetText(editPassword)
		if username and password then
			triggerServerEvent("submitLogin", getRootElement(), localPlayer, username, password)
		else
			guiSetText(labelInfo, "Введите логин и пароль.")
		end
	end
end

function clientSubmitChangepw(button, state)
	if button == "left" and state == "up" then
		local oldpassword = guiGetText(editOldpw)
		local newpassword = guiGetText(editNewpw)
		if oldpassword and newpassword then
			triggerServerEvent("submitChangepw", getRootElement(), localPlayer, oldpassword, newpassword)
		else
			outputChatBox("Введите старый и новый пароль.")
		end
	end
end

function hideLoginWindow()
	guiSetInputEnabled(false)
	guiSetVisible(windowLogin, false)
	showCursor(false)
end

function hidePasswordWindow()
	guiSetInputEnabled(false)
	guiSetVisible(windowChangepw, false)
	showCursor(false)
end

function unknownError()
	guiSetText(labelInfo, "Неизвестная ошибка.")
end

function loginWrong()
	guiSetText(labelInfo, "Неправильный пароль или логин.")
end


addEvent("hidePasswordWindow", true)
addEvent("hideLoginWindow", true)
addEvent("unknownError", true)
addEvent("loginWrong", true)
addEvent("showLoginWindowS", true )
addEventHandler("hidePasswordWindow", getRootElement(), hidePasswordWindow)
addEventHandler("hideLoginWindow", getRootElement(), hideLoginWindow)
addEventHandler("unknownError", getRootElement(), unknownError)
addEventHandler("loginWrong", getRootElement(), loginWrong)
addEventHandler("showLoginWindowS", getRootElement(), showLoginWindow )
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), resourceStart)

addCommandHandler("changepw", changePw)

showPlayerHudComponent ( "ammo", false )
showPlayerHudComponent ( "health", false )
showPlayerHudComponent ( "money", false )
showPlayerHudComponent ( "weapon", false )
showPlayerHudComponent ( "radar", false )
showPlayerHudComponent ( "clock", false )