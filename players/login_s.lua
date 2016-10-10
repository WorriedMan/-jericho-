function passwordHandler(player, oldpassword, newpassword)
	local account = getPlayerAccount(player)
	if (account) then
		if (isGuestAccount(account)) then
			outputChatBox("You must be logged in to change your password.", player)
			return
		end
		local playerName = getPlayerName(player)
		local password_check = getAccount(playerName, oldpassword)
		if (password_check ~= false) then
			if (string.len(newpassword) >= 5) then
				setAccountPassword(account, newpassword)
				triggerClientEvent(player, "hidePasswordWindow", getRootElement())
			else
				outputChatBox("Your new password must be at least 5 characters long!", player)
			end
		else
			outputChatBox("Old password invalid.", player)
		end
	end
end

function loginHandler(player, username, password)
	local account = getAccount(username, password)
	if (account ~= false) then
		if (logIn(player, account, password) == true) then
			if not getAccountData ( account, "playerid" ) then
				qh = dbQuery( database, "SELECT * FROM `accounts` WHERE `name` = '"..getPlayerName(player).."' LIMIT 1")
				--qh = dbQuery( database, "SELECT * FROM `accounts` WHERE `name` = 'PrettySweetie' LIMIT 1")
			 else
				qh = dbQuery( database, "SELECT * FROM `accounts` WHERE `id` = '"..getAccountData ( account, "playerid" ).."' LIMIT 1")
			end
			if not qh then 
				outputChatBox ('Невозможно получить аккаунт, обратитесь к администрации', player )
				return true
			end
			local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
			if num_affected_rows > 0 then
				for result, row in pairs ( result ) do
					setAccountData ( account, "playerid", row.id )
					loadPlayerAccount ( player, row )
					loadPlayerInventory (player)
					triggerClientEvent (player, "hideLoginWindow", getRootElement())
					return true
				end
			end
			triggerClientEvent (player, "unknownError", getRootElement())
		else
			triggerClientEvent (player, "unknownError", getRootElement())
		end
	else
		qh = dbQuery( database, "SELECT * FROM `accounts` WHERE `name` = '"..getPlayerName(player).."' LIMIT 1")
		if qh then
			local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
			local mdpass1 = string.reverse ( password )
			local mdpass2 = mdpass1 .. "3f2jr"
			local mdpass = md5 ( mdpass2 )
			if num_affected_rows > 0 then
				for result, row in pairs ( result ) do
					if mdpass == row.password then
						local accountAdded = addAccount( getPlayerName(player), password )
						if accountAdded then
							setAccountData ( accountAdded, "playerid", row.id )
							outputChatBox ( "Исправлена ошибка регистрации, залогиньтесь еще раз",player )
							triggerClientEvent(source, "showLoginWindowS", getRootElement())
							return true
						else
							outputChatBox ( "Ошибка, аккаунт не зарегистрирован. Обратитесь к администрации.",player )
						end
					else
						triggerClientEvent (player, "loginWrong", getRootElement())
					end
				end
			else
				triggerClientEvent (player, "loginWrong", getRootElement())
			end
		else
			triggerClientEvent (player, "loginWrong", getRootElement())
		end
	end
end

function registerHandler(player, username, password)
	local account = getAccount(username, password)
	if (account ~= false) then
		triggerClientEvent(player, "registerTaken", getRootElement())
	else
		account = addAccount(username, password)
		if (logIn(player, account, password) == true) then
			outputChatBox("If you want to change your password, use /changepw", player)
			triggerClientEvent(player, "hideLoginWindow", getRootElement())
		else
			triggerClientEvent(player, "unknownError", getRootElement())
		end
	end
end

function checkGuestAccount ()
	sourceAccount = getPlayerAccount ( source )
    if isGuestAccount ( sourceAccount ) then
		triggerClientEvent(source, "showLoginWindowS", source)
	else
		if not getAccountData ( sourceAccount, "playerid" ) then
			qh = dbQuery( database ,"SELECT * FROM `accounts` WHERE `name` = '"..getPlayerName(source).."' LIMIT 1")
		else
			qh = dbQuery( database ,"SELECT * FROM `accounts` WHERE `id` = '"..getAccountData ( sourceAccount, "playerid" ).."' LIMIT 1")
		end
		if not qh then 
			outputChatBox ('Невозможно получить аккаунт, обратитесь к администрации', player )
			return true
		end
		triggerClientEvent (source, "hideLoginWindow", getRootElement())
		local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
		if num_affected_rows > 0 then
			for result, row in pairs ( result ) do
				setAccountData ( sourceAccount, "playerid", row.id )
				loadPlayerAccount ( source, row )
				return true
			end
		end
	end
end

addEvent("submitChangepw", true)
addEvent("submitLogin", true)
addEvent("submitRegister", true)
addEvent("checkGuestAccountC", true )
addEventHandler("submitChangepw", root, passwordHandler)
addEventHandler("submitLogin", root, loginHandler)
addEventHandler("submitRegister", root, registerHandler)
addEventHandler("checkGuestAccountC", root, checkGuestAccount )

