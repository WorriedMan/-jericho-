local screenx, screeny = guiGetScreenSize()

local groupsWindow
local groupsTabPanel
local groupsListTab

local groupsListGrid
local createGroupEdit
local createGroupBtn
local invitesListGrid
local acceptInviteBtn

local groupManageTab

local makeRankButtons -- ИД:
-- 1 - Новичок
-- 2 - Проверенный
-- 3 - Свой
-- 4 - Руководитель
-- 5 - Создатель
--
--
--
--

local inviteBtn
local kickBtn
local leaveBtn
local deleteBtn

local playersListGrid

local Window_PLS
local playerList_PLS
local Button_PLS_Y
 
 
function closeGroupsWindow()
	destroyElement ( groupsWindow )
	showCursor ( false )
	if isElement(Window_PLS) then
		destroyElement(Window_PLS)
	end
end 
 
function showGroupsWindow(list,invites,playersInGroup,secondpage,groupdeleting,rank) 
	if isElement ( groupsWindow ) then
		closeGroupsWindow()
	else
		table.sort(list,function(a,b) return a.rating > b.rating end)
		guiSetInputMode ( "no_binds_when_editing" )
		showCursor ( true )
		groupsWindow = guiCreateWindow(375, 80, 520, 550, "Система групп", false)
        guiWindowSetSizable(groupsWindow, false)
        guiSetAlpha(groupsWindow, 1.00)
		
        groupsTabPanel = guiCreateTabPanel(10, 30, 500, 510, false, groupsWindow)

        groupsListTab = guiCreateTab("Группы", groupsTabPanel)
		
        local label = guiCreateLabel(5, 5, 490, 25, "Список групп:", false, groupsListTab)
        guiLabelSetHorizontalAlign(label, "center")		
		groupsListGrid = guiCreateGridList(5, 30, 490, 180, false, groupsListTab)
		guiGridListAddColumn( groupsListGrid, "Название", 0.5 )
		guiGridListAddColumn( groupsListGrid, "Участники", 0.15 )
		guiGridListAddColumn( groupsListGrid, "Рейтинг", 0.2 )
		
		local myGang = getElementData(localPlayer,"gang") or ""
		local myRating = 0
		local myPlace = #list
		
		for i, v in ipairs ( list ) do
			local row = guiGridListAddRow ( groupsListGrid )
			guiGridListSetItemText ( groupsListGrid, row, 1, v.name, false, false )
			guiGridListSetItemText ( groupsListGrid, row, 2, v.players, false, false )
			guiGridListSetItemText ( groupsListGrid, row, 3, v.rating, false, false )
			if myGang == v.name then
				myPlace = i
				myRating = v.rating
			end
		end
        local label = guiCreateLabel(5, 220, 490, 25, "Создать группу:", false, groupsListTab)
        guiLabelSetHorizontalAlign(label, "center")		
		createGroupEdit = guiCreateEdit(5, 250, 350, 25, "", false, groupsListTab)
		
		createGroupBtn = guiCreateButton( 360, 250, 135, 25, "Создать", false, groupsListTab)
		addEventHandler("onClientGUIClick", createGroupBtn, startCreatingGroup )
        local label = guiCreateLabel(5, 285, 490, 25, "Список приглашений:", false, groupsListTab)
        guiLabelSetHorizontalAlign(label, "center")		
		invitesListGrid = guiCreateGridList(5, 315, 490, 125, false, groupsListTab)
		guiGridListAddColumn( invitesListGrid, "Название", 0.5 )
		guiGridListAddColumn( invitesListGrid, "Пригласил", 0.35 )
		if invites then
			for i, v in pairs ( invites ) do
				local row = guiGridListAddRow ( invitesListGrid )
				guiGridListSetItemText ( invitesListGrid, row, 1, i, false, false )
				guiGridListSetItemText ( invitesListGrid, row, 2, v, false, false )
			end
		end
		
		acceptInviteBtn = guiCreateButton(5, 450, 490, 25, "Принять приглашение", false, groupsListTab)
		addEventHandler ( "onClientGUIClick", acceptInviteBtn, acceptInviteClicked )
		
        groupManageTab = guiCreateTab("Ваша группа", groupsTabPanel)
		
		local gang = getPlayerGang()
		if playersInGroup and rank and gang then
			
			guiCreateLabel(227, 5, 114, 19, "Место группы: "..myPlace, false, groupManageTab)
			guiCreateLabel(227, 30, 114, 19, "Рейтинг группы: "..myRating, false, groupManageTab)
			
			playersListGrid = guiCreateGridList(5, 5, 211, 475, false, groupManageTab)
			guiGridListAddColumn( playersListGrid, "Игроки", 0.5 )
			guiGridListAddColumn( playersListGrid, "Должность", 0.35 )
			
			for i, v in ipairs (playersInGroup) do
				local row = guiGridListAddRow ( playersListGrid )
				guiGridListSetItemText ( playersListGrid, row, 1, v.nick, false, false )
				guiGridListSetItemText ( playersListGrid, row, 2, rankNames[v.rank] or "", false, false )
				guiGridListSetItemData ( playersListGrid, row, 1, v.name )
				guiGridListSetItemData ( playersListGrid, row, 2, v.rank )
				if getPlayerFromName(v.nick) then
					guiGridListSetItemColor ( playersListGrid, row, 1, 100, 255, 100 )
					guiGridListSetItemColor ( playersListGrid, row, 2, 100, 255, 100 )
				else
					guiGridListSetItemColor ( playersListGrid, row, 1, 255, 100, 100 )
					guiGridListSetItemColor ( playersListGrid, row, 2, 255, 100, 100 )
				end
			end
			
			inviteBtn = guiCreateButton(226, 105, 116, 40, "Пригласить", false, groupManageTab)
			kickBtn = guiCreateButton(226, 155, 116, 40, "Выгнать", false, groupManageTab)
			leaveBtn = guiCreateButton(374, 105, 116, 40, "Выйти", false, groupManageTab)
			if not groupdeleting then
				deleteBtn = guiCreateButton(374, 155, 116, 40, "Удалить", false, groupManageTab)
			else	
				deleteBtn = guiCreateButton(374, 155, 116, 40, "Отменить удаление", false, groupManageTab)
			end
			
			local label = guiCreateLabel(227, 208, 114, 19, "Должности:", false, groupManageTab)
			makeRankButtons = {}
			
			makeRankButtons[1] = guiCreateButton(226, 237, 116, 40, "Новичок", false, groupManageTab)    
			makeRankButtons[2] = guiCreateButton(226, 287, 116, 40, "Проверенный", false, groupManageTab)    
			makeRankButtons[3] = guiCreateButton(226, 337, 116, 40, "Свой", false, groupManageTab)    
			makeRankButtons[4] = guiCreateButton(226, 387, 116, 40, "Руководитель", false, groupManageTab)    
			makeRankButtons[5] = guiCreateButton(226, 437, 116, 40, "Создатель", false, groupManageTab)  
			if rank < 2 or groupdeleting then
				guiSetEnabled(inviteBtn,false)
			end
			if rank < 3 or groupdeleting then
				guiSetEnabled(kickBtn,false)
			end
			if rank < 4 or groupdeleting then
				for i, v in ipairs (makeRankButtons) do
					guiSetEnabled(v,false)
				end
			end
			if rank < leaderRank then
				guiSetEnabled(deleteBtn,false)
			end
			addEventHandler ( "onClientGUIClick", inviteBtn, createGatePlayersList )		
			addEventHandler ( "onClientGUIClick", kickBtn, kickSelectedPlayer )		
			addEventHandler ( "onClientGUIClick", leaveBtn, leaveMyGroup )		
			addEventHandler ( "onClientGUIClick", deleteBtn, deleteMyGroup )		
			addEventHandler ( "onClientGUIClick", makeRankButtons[1], setPlayerRankClicked )	
			addEventHandler ( "onClientGUIClick", makeRankButtons[2], setPlayerRankClicked )	
			addEventHandler ( "onClientGUIClick", makeRankButtons[3], setPlayerRankClicked )	
			addEventHandler ( "onClientGUIClick", makeRankButtons[4], setPlayerRankClicked )	
			addEventHandler ( "onClientGUIClick", makeRankButtons[5], setPlayerRankClicked )	
			
			if secondpage then
				guiSetSelectedTab ( groupsTabPanel, groupManageTab )
			end
		else
			guiSetEnabled (groupManageTab,false)
		end
	end
end

addEvent("groups:showGroupsWindow",true)
addEventHandler("groups:showGroupsWindow",getRootElement(),showGroupsWindow)

function setPlayerRankClicked ()
	if source == makeRankButtons[1] or source == makeRankButtons[2] or source == makeRankButtons[3] or source == makeRankButtons[4] or source == makeRankButtons[5] then
		local row = guiGridListGetSelectedItem ( playersListGrid )
		if row and row ~= -1 then
			local name = guiGridListGetItemData ( playersListGrid, row, 1 )
			local rank = guiGridListGetItemData ( playersListGrid, row, 2 )
			local player_rank = getPlayerRank()
			if player_rank <= rank then
				outputChatBox("Система групп: Вы не можете изменить ранг этого игрока!",255,100,100)
				return
			end
			if source == makeRankButtons[1] then
				triggerServerEvent("groups:updatePlayerRank",localPlayer,name,1)
			elseif source == makeRankButtons[2] then
				triggerServerEvent("groups:updatePlayerRank",localPlayer,name,2)
			elseif source == makeRankButtons[3] then
				triggerServerEvent("groups:updatePlayerRank",localPlayer,name,3)
			elseif source == makeRankButtons[4] then
				triggerServerEvent("groups:updatePlayerRank",localPlayer,name,4)
			elseif source == makeRankButtons[5] then
				if player_rank ~= leaderRank then 
					outputChatBox("Система групп: Вы не можете установить этот ранг!",255,100,100)
					return
				end
				triggerServerEvent("groups:updatePlayerRank",localPlayer,name,5)
			end
			closeGroupsWindow()
		end
	end
end

function createGatePlayersList (button)
	if source ~= inviteBtn then return end
	if not isElement(Window_PLS) then 
		guiSetEnabled (groupsWindow,false)
		Window_PLS = guiCreateWindow(screenx/2-155,screeny/2-220,310,360,"Выбор игрока",false)
		guiSetVisible(Window_PLS, true)
		guiSetProperty(Window_PLS, "AlwaysOnTop", "true")
		guiWindowSetSizable(Window_PLS, false)
		Button_PLS_Y = guiCreateButton(17,299,129,36,"Выбор",false,Window_PLS)
		local Button_PLS_N = guiCreateButton(161,299,129,36,"Отмена",false,Window_PLS)
		playerList_PLS = guiCreateGridList ( 21, 20, 268, 265, false, Window_PLS )
		local column = guiGridListAddColumn( playerList_PLS, "Игроки", 0.85 )
		if ( column ) then
			for id, player in ipairs(getElementsByType("player")) do
				if player ~= localPlayer then
					local row = guiGridListAddRow ( playerList_PLS )
					guiGridListSetItemText ( playerList_PLS, row, column, getPlayerName ( player ), false, false )
				end
			end
		end
		addEventHandler ( "onClientGUIClick", Button_PLS_Y, givePlayerAcceptToGate )
		addEventHandler ( "onClientGUIClick", Button_PLS_N, function () destroyElement(Window_PLS) guiSetEnabled (groupsWindow,true) end )
	end
end

local usedToClick = false

function givePlayerAcceptToGate ()
	if source ~= Button_PLS_Y then return true end
	if usedToClick then return true end
	usedToClick = true
	setTimer ( function () usedToClick = false end, 3000, 1 )
	local row = guiGridListGetSelectedItem ( playerList_PLS )
	if row and row ~= -1 then
		local name = guiGridListGetItemText ( playerList_PLS, row, 1 )
		closeGroupsWindow()
		triggerServerEvent("groups:sendPlayerInvite",localPlayer,name)
	end
end

function kickSelectedPlayer ()
	if source ~= kickBtn then return true end
	local row = guiGridListGetSelectedItem ( playersListGrid )
	if row and row ~= -1 then
		local name = guiGridListGetItemData ( playersListGrid, row, 1 )
		local rank = guiGridListGetItemData ( playersListGrid, row, 2 )
		local player_rank = getPlayerRank()
		if player_rank <= rank then
			outputChatBox("Система групп: Вы не можете выгнать этого игрока!",255,100,100)
			return
		end
		closeGroupsWindow()
		triggerServerEvent("groups:kickSelectedPlayer",localPlayer,name)
	end
end

function leaveMyGroup ()
	if source ~= leaveBtn then return true end
	triggerServerEvent("groups:leaveMyGroup",localPlayer)
	closeGroupsWindow()
end

function deleteMyGroup ()
	if source ~= deleteBtn then return true end
	triggerServerEvent("groups:deleteMyGroup",localPlayer)
	closeGroupsWindow()
end

function startCreatingGroup()
	if source ~= createGroupBtn then return end
	local groupName = guiGetText(createGroupEdit)
	if groupName and groupName ~= "" and not string.find(groupName,"'") and not string.find(groupName,'"') then
		prepareToOpenGroupsWindow()	
		triggerServerEvent("groups:createNewGroup",localPlayer,groupName)
	else
		outputChatBox("Система групп: Вы не ввели название группы",255,100,100)
	end
end

function acceptInviteClicked()
	if source ~= acceptInviteBtn then return end
	local row1 = guiGridListGetSelectedItem ( invitesListGrid )
	if row1 and row1 > -1 then
		local text = guiGridListGetItemText ( invitesListGrid, row1, 1 )
		closeGroupsWindow()
		triggerServerEvent("groups:inviteToGroupAccepted",localPlayer,text)
	end
end

function prepareToOpenGroupsWindow(key)
	if isElement ( groupsWindow ) then
		closeGroupsWindow()
	else
		triggerServerEvent ("groups:askGroupsList", localPlayer, string.lower(key) == "f2")
	end
end

bindKey("f3","down",prepareToOpenGroupsWindow)
bindKey("f4","down",prepareToOpenGroupsWindow)

--GPS
playerBlibs = {}
amouunt = 0
function updateGPS ()
	amouunt = 0
	local gangname = getElementData(getLocalPlayer(),"gang")
	for i, blip in ipairs(playerBlibs) do
		if isElement(blip) then
			destroyElement(blip)
		end
	end
	if not gangname then return end	
	playerBlibs = {}	
	for i, player in ipairs(getElementsByType("player")) do
		local pl_gang = getElementData(player,"gang") 
		if pl_gang and gangname == pl_gang and player ~= localPlayer then
			amouunt = amouunt+1
			playerBlibs[amouunt] = createBlipAttachedTo(player,0,2,22,255,22)
			setBlipVisibleDistance(playerBlibs[amouunt],1000)
		end
	end
end
setTimer(updateGPS,10000,0)