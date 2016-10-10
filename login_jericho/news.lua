function loadNewsTable()
	executeSQLQuery("CREATE TABLE IF NOT EXISTS `newsList` (`news` TEXT,`added` INTEGER)")
	
	--executeSQLQuery("INSERT INTO `newsList` (`news`,`added`) values(?,?)","20.06.2015\nВышло обновление 22!",getRealTime().timestamp)
end

addEventHandler ( "onResourceStart", getResourceRootElement(), loadNewsTable )

function askNews()
	triggerClientEvent ( source, "login:sendNews", source, executeSQLQuery( "SELECT * FROM `newsList` ORDER BY `added` DESC LIMIT 3" ) )
end

addEvent("login:askNews",true)
addEventHandler("login:askNews",getRootElement(),askNews)

function addNews(text)
	local currentNews = executeSQLQuery( "SELECT * FROM `newsList` ORDER BY `added` DESC" )
	if #currentNews >= 3 then
		executeSQLQuery ( "DELETE FROM `newsList` WHERE `added`= ?", currentNews[3].added )
	end
	executeSQLQuery ( "INSERT INTO `newsList` (`news`, `added`) values(?,?)", text, getRealTime().timestamp )
end