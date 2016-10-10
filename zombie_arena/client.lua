local screenWidth,screenHeight = guiGetScreenSize()
local arenaWindow
local fightInfo

function showMenu(leader,player_kills,alltimeLeaders,last_week,player_alltime)  
	if not isElement ( arenaWindow ) then
		fightInfo = {}
		showCursor ( true )   
   
		arenaWindow = guiCreateWindow(screenWidth/2-252, screenHeight/2-230, 504, 490, "Арена выживания", false)
        guiWindowSetSizable(arenaWindow, false)

        guiCreateLabel(14, 47, 476, 183, "Правила:\n1. Убивайте гулей и получайте $20 за каждого\n2. Участие в арене бесплатное\n3. Участники используют собственное оружие \n4. Каждый, убивший на арене 50 гулей, получает в подарок револьвер\n\"Секвойя рейнджера\n5. Чемпион недели (набравший наибольшее количество убийств) получает\n'Набор чемпиона'\n5. Чемпион может забрать свой набор здесь же всю следующую неделю\n\nЧто входит в набор чемпиона:\n100 патронов кал. 45-70, 5 стимуляторов", false, arenaWindow)
        local welcome = guiCreateLabel(14, 22, 476, 20, "Добро пожаловать на арену гулей Нового Вегаса!", false, arenaWindow)
        guiSetFont(welcome, "default-bold-small")
        guiLabelSetHorizontalAlign(welcome, "center", false)
        guiLabelSetVerticalAlign(welcome, "center")
		local champion = guiCreateLabel(14, 230, 476, 20, "Чемпион прошедшей недели: "..last_week[1].." ("..last_week[2]..").", false, arenaWindow)
        guiSetFont(champion, "default-bold-small")
        guiLabelSetHorizontalAlign(champion, "center", false)
        guiLabelSetVerticalAlign(champion, "center")
		local this_week_champion = guiCreateLabel(14, 245, 476, 40, "Лидер текущей недели: "..leader[1].." ("..leader[2].."). \nУ вас: "..player_kills.." убийств за неделю и "..player_alltime.." за все время.", false, arenaWindow)
        guiSetFont(this_week_champion, "default-bold-small")
        guiLabelSetHorizontalAlign(this_week_champion, "center", false)
        guiLabelSetVerticalAlign(this_week_champion, "center")    
        local leaders = guiCreateLabel(14, 280, 476, 20, "Лучшие за всю историю:", false, arenaWindow)		
        guiSetFont(leaders, "default-bold-small")
        guiLabelSetHorizontalAlign(leaders, "center", false)
        guiLabelSetVerticalAlign(leaders, "center")
        local leadersGrid = guiCreateGridList(13, 310, 477, 129, false, arenaWindow)
		
		guiGridListAddColumn( leadersGrid, "Имя", 0.5 )
		guiGridListAddColumn( leadersGrid, "Убйиств гулей", 0.3 )
		for i, v in ipairs (alltimeLeaders) do
			local row = guiGridListAddRow ( leadersGrid )
			guiGridListSetItemText ( leadersGrid, row, 1, v.name, false, false )
			guiGridListSetItemText ( leadersGrid, row, 2, v.kills, false, true )
		end
		fightInfo = {week_kills = player_kills,leader = leader[2],fight_kills = 0,round = 1}
        local startButton = guiCreateButton(14, 449, 225, 31, "Принять участие", false, arenaWindow)
        local closeButton = guiCreateButton(265, 449, 225, 31, "Закрыть", false, arenaWindow)    
		addEventHandler ( "onClientGUIClick", startButton, startArenaFightClicked )
		addEventHandler ( "onClientGUIClick", closeButton, function () showCursor ( false ) destroyElement ( arenaWindow ) end )
	end
end

addEvent("zombie_arena:showMenu",true)
addEventHandler("zombie_arena:showMenu",getRootElement(),showMenu)

function startArenaFightClicked ()
	showCursor ( false )
	destroyElement ( arenaWindow )
	outputChatBox("Распорядитель арены: Извини, арена пока на ремонте.")
	--triggerServerEvent ("zombie_arena:startClicked",localPlayer)
end

function startArenaFight ()
	addEventHandler("onClientRender", root, drawFightInfo)
end

addEvent("zombie_arena:startArenaFight",true)
addEventHandler("zombie_arena:startArenaFight",getRootElement(),startArenaFight)

function finishFight ()
	removeEventHandler("onClientRender", root, drawFightInfo)
end

addEvent("zombie_arena:finishFight",true)
addEventHandler("zombie_arena:finishFight",getRootElement(),finishFight)

function updateArenaFightInfo (round)
	fightInfo.round = round
end

addEvent("zombie_arena:updateArenaFightInfo",true)
addEventHandler("zombie_arena:updateArenaFightInfo",getRootElement(),updateArenaFightInfo)

function drawFightInfo()
	if fightInfo.week_kills > fightInfo.leader then
		dxDrawText ("Волна: "..fightInfo.round.."\nУбито гулей за бой: "..fightInfo.fight_kills.."\nУбито гулей за неделю: "..fightInfo.week_kills.."\nВы лидер недели!",10,screenHeight/2)
	else
		dxDrawText ("Волна: "..fightInfo.round.."\nУбито гулей за бой: "..fightInfo.fight_kills.."\nУбито гулей за неделю: "..fightInfo.week_kills.."\nРекорд недели: "..fightInfo.leader,10,screenHeight/2)
	end
end

function onArenaZombieWasted(killer)
    if getElementData ( source, "arenaZombie" ) and killer and killer == localPlayer and getElementData (localPlayer,"onArena") then
		fightInfo.fight_kills = fightInfo.fight_kills+1
		fightInfo.week_kills = fightInfo.week_kills+1
	end
end

addEventHandler("onClientPedWasted", getRootElement(), onArenaZombieWasted)