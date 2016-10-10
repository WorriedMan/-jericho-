
function startAccountSystem ()
	--playersDB = dbConnect( "sqlite", ":players/Accounts/players.db" )
	--if playersDB then
		--executeSQLCreateTable("players", "name TEXT, password TEXT,money INTEGER, bmoney INTEGER" )
		--executeSQLCreateTable("players", "name TEXT, password TEXT, id INTEGER, money INTEGER, bmoney INTEGER,faction INTEGER, rank INTEGER, phone INTEGER, work INTEGER, age INTEGER, skin INTEGER, origin INTEGER, house INTEGER, icq INTEGER, email TEXT, intel INTEGER, luck INTEGER, vision INTEGER, sex INTEGER, nat TEXT, nwkey INTEGER, sckey INTEGER, nation INTEGER, virus INTEGER, av1 INTEGER, av2 INTEGER, rad INTEGER, weap1 INTEGER, weap2 INTEGER, weap3 INTEGER, weap4 INTEGER, weap5 INTEGER, weap6 INTEGER, weap7 INTEGER, weap8 INTEGER, weap9 INTEGER, weap10 INTEGER, ammo1 INTEGER, ammo2 INTEGER, ammo3 INTEGER, ammo4 INTEGER, ammo5 INTEGER, ammo6 INTEGER, ammo7 INTEGER, ammo8 INTEGER, ammo9 INTEGER, ammo10 INTEGER, bunk1 INTEGER, bunk2 INTEGER, bunk3 INTEGER, bunk4 INTEGER, bunk5 INTEGER, bunk6 INTEGER, bunk7 INTEGER, bunk8 INTEGER, bunk9 INTEGER, bunk10 INTEGER, bunk11 INTEGER, bunk12 INTEGER, bunk13 INTEGER, bunk14 INTEGER, bunk15 INTEGER, bunk16 INTEGER, bunk17 INTEGER, bunk18 INTEGER, bunk19 INTEGER, bunk20 INTEGER, totalbunks INTEGER, ach1 INTEGER, ach2 INTEGER, ach3 INTEGER, ach4 INTEGER, ach5 INTEGER, ach6 INTEGER, ach7 INTEGER, ach8 INTEGER, ach9 INTEGER, ach10 INTEGER, ach11 INTEGER, ach12 INTEGER, ach13 INTEGER, ach14 INTEGER, ach15 INTEGER, ach16 INTEGER, ach17 INTEGER, ach18 INTEGER, ach19 INTEGER, ach20 INTEGER, ach21 INTEGER, ach22 INTEGER, ach23 INTEGER, points INTEGER, quest_main INTEGER, quest_main_st INTEGER, quest_main_sex INTEGER, katy_perry INTEGER, big_bill INTEGER, stan_marsh INTEGER, tim_kuck INTEGER, vagner INTEGER, suarez INTEGER, quest_nvinsane INTEGER")
		outputServerLog( "Connected" )
	--else
		--outputServerLog( "Not" )
	--end
end


addEventHandler ( "onResourceStart",  getResourceRootElement(getThisResource()), startAccountSystem )

function registerPlayer ( password, age, nationality, icq, mail )
	if ( password ~= "" and password ~= nil ) then
	--	executeSQLInsert("players", " '"..getPlayerName(source).."', '"..password.."', '3000', '0' " )
		local xmlFileID = xmlLoadFile ( "ID.xml" )
		local idnumber = xmlFindChild ( xmlFileID, "id", 0 )
		numberid = xmlNodeGetValue ( idnumber )
		local idn = numberid + 1
		xmlNodeSetValue ( idnumber, tostring(idn) )
    	xmlSaveFile ( xmlFileID )
	    executeSQLInsert("players", " '"..getPlayerName(source).."', '"..password.."', '"..idn.."', '3000', '0', '0', '0', '0', '0', '"..age.."', '7', '0', '0', '"..icq.."', '"..mail.."', '1', '1', '1', '0', '"..nationality.."', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'"  )

		addAccount( getPlayerName(source), password )
		outputChatBox ( "Вы успешно зарегистрировались на нашем сервере!",source )
	else
		outputChatBox ( "Error creating account, correct syntax: /register <password>", source )
	end
end

addEvent( "finRegisterPlayer", true )
addEventHandler( "finRegisterPlayer", getRootElement(), registerPlayer )
