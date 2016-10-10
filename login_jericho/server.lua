function playerTryToLogin(username, password)
	if getAccount(username) then
		local account = getAccount(username,password)
		if account then
			local database = exports.players:askMysqlHandler ()
			if database then
				local qh = dbQuery( database, "SELECT * FROM `accounts` WHERE `id` = '"..getAccountData ( account, "playerid" ).."' LIMIT 1")
				if not qh then 
					showChat ( source, true )
					outputChatBox ('Невозможно получить аккаунт, обратитесь к администрации', source, 255, 0, 0 )
					return true
				else
					if getAccountPlayer(account) then
						triggerClientEvent (source, "login:accauntInUse", source)
						return
					end
					logIn(source, account, password)
					local result, num_affected_rows, errmsg = dbPoll ( qh, -1 )
					exports.players:loadLoginPlayerAccount(source,result[1])
					showChat ( source, true )
					triggerClientEvent (source, "login:hideWindow", source)
				end
			end
		else
			triggerClientEvent (source, "login:passwordWrong", source)
		end
	else
		triggerClientEvent (source, "login:loginWrong", source)
	end
end

addEvent("login:loginClicked",true)
addEventHandler("login:loginClicked",getRootElement(),playerTryToLogin)