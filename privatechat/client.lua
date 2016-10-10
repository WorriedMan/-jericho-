g_LocalPlayer = getLocalPlayer()
g_Root = getRootElement()
g_ThisResource = getThisResource()
g_ResourceRoot = getResourceRootElement(getThisResource())

chat = {} 
newmsg = {show=false, tick=getTickCount(), showtime=5000, img=nil, lbl=nil } -- new msg table


anims = {}

function buildPlayerList()
	local x,y = guiGetScreenSize()
	local width,height = 175,350
	x = x-width
	y = (y-height)/2
	newmsg.img = guiCreateStaticImage(681.0000,134.0000, 42.0000,34.0000, "image/chat-icon.png", false) -- mail message icon
	newmsg.lbl = guiCreateLabel(553.0000,175.0000, 244.0000, 19.0000, "", false)
	guiLabelSetColor(newmsg.lbl,0, 170, 255)
		guiLabelSetHorizontalAlign(newmsg.lbl, "right", true)
	guiSetAlpha(newmsg.img, 0)
	
	
	wndPlayers = guiCreateWindow(1,256,240,343, "PM", false)
	grdPlayers = guiCreateGridList(0.0881,0.1049,0.8208,0.8568, true, wndPlayers)

		colPlayers = guiGridListAddColumn(grdPlayers, "Игроки", 0.85)

	local players = getElementsByType("player")
	for k,v in ipairs(players) do
		addPlayerToList(v)
	end
	guiSetProperty(fond,"Disabled","true")
	guiWindowSetSizable(wndPlayers, false)
	guiSetProperty(wndPlayers, "RollUpEnabled", "true")
	guiSetProperty(wndPlayers, "Dragable", "true")
	guiSetAlpha(wndPlayers, 0)
	
	
	
	anims.plfadein = Animation.create(wndPlayers, Animation.presets.guiFadeIn(1000))
	anims.plfadeout = Animation.create(wndPlayers, Animation.presets.guiFadeOut(1000))

	anims.nmfadein = Animation.create(newmsg.img, Animation.presets.guiFadeIn(1000))
	anims.nmfadeout = Animation.create(newmsg.img, Animation.presets.guiFadeOut(1000))
	
	anims.nmtextin = Animation.create(newmsg.lbl, Animation.presets.guiFadeIn(1000))
	anims.nmtextout = Animation.create(newmsg.lbl, Animation.presets.guiFadeOut(1000))
	
--[[	local x,y = guiGetPosition(newmsg.img)
	outputDebugString("guigetPostions: " ..tostring(x).." "..tostring(y))
	local scrx,scry = guiGetScreenSize()
	anims.nmslidein = Animation.create(newmsg.img, Animation.presets.guiMove(x,y))--, 1000,false, scrx,scry, false))
	anims.nmslideout = Animation.create(newmsg.img, Animation.presets.guiMove(scrx,scry))--, 1000,false, x,y, false))
]]	
	bindKey("F4", "down", togglePmGui)	
end
function addPlayerToList(ply)
	--outputDebugString("addPlayerToList:" ..getPlayerName(ply))
	local row = guiGridListAddRow(grdPlayers)
	local name = getPlayerName(ply)
	guiGridListSetItemText(grdPlayers,row,colPlayers, name, false, false)
end
function removePlayerFromList(ply)
	--outputDebugString("removePlayerFromList:" ..getPlayerName(ply))
	local name=getPlayerName(ply)
	for row=0,guiGridListGetRowCount(grdPlayers) do
		if guiGridListGetItemText(grdPlayers, row, colPlayers) == name then
			guiGridListRemoveRow(grdPlayers, row)
			outputDebugString("remove row" ..tostring(row))
		end
	end
end


function showPmGui(state)
	if state == true then
		anims.plfadein:play()
		for k,v in pairs(chat) do
			guiSetVisible(chat[k].wnd,true)
		end
		showCursor(true)
	elseif state == false then
		anims.plfadeout:play()
		for k,v in pairs(chat) do	
			guiSetVisible(chat[k].wnd,false)
		end
		showCursor(false)
		guiSetInputEnabled(false)
	end
end
function togglePmGui()
	if not anims.plfadein:isPlaying() and not anims.plfadeout:isPlaying() then
		if guiGetAlpha(wndPlayers) > .1 then showPmGui(false)
		else showPmGui(true)
		end
	end
end

function buildChatWindow(ply)
	local x,y = guiGetScreenSize()
	local width,height = 300,250
	x = x*.5
	y = y*.5
	
	chat[ply] = {}
	chat[ply].wnd = guiCreateWindow(337,277,395,252, getPlayerName(ply), false)	
	chat[ply].img = guiCreateStaticImage(0.0228,0.0754,0.9544,0.8889,true,chat[ply].wnd)
	chat[ply].memo = guiCreateMemo(0.043,0.1746,0.9089,0.623, "", true, chat[ply].wnd)
	chat[ply].edit = guiCreateEdit(0.043,0.8214,0.7089,0.1111, "", true, chat[ply].wnd)
	chat[ply].btnX = guiCreateButton(0.9215,0.0754,0.0557,0.0794, "X", true, chat[ply].wnd)
	chat[ply].btnSend = guiCreateButton(0.757,0.8135,0.2127,0.1429, "Отправить", true, chat[ply].wnd)
	guiSetProperty(chat[ply].img,"Disabled","true")
	
	guiMemoSetReadOnly(chat[ply].memo, true)
	
	guiWindowSetSizable(chat[ply].wnd, false)
	guiSetProperty(chat[ply].wnd, "RollUpEnabled", "true")
	guiSetProperty(chat[ply].wnd, "Dragable", "true")
	
	if anims.plfadein:isPlaying() then-- in process of fading in
		guiSetVisible(chat[ply].wnd, true)
	elseif anims.plfadeout:isPlaying() then -- in process of fading out
		guiSetVisible(chat[ply].wnd, false)
	else -- not in process of either
		if guiGetAlpha(wndPlayers) > .1 then
			guiSetVisible(chat[ply].wnd, true) -- is showing
		else
			guiSetVisible(chat[ply].wnd, false) -- isnt showing
		end	
	end
end
function destroyChatWindow(ply)
	if chat[ply] and isElement(chat[ply].wnd) then
		destroyElement(chat[ply].wnd)
		chat[ply] = nil	
	end
end

function sendChatMessage(ply)
	--outputDebugString("sendChatMessage: " .. tostring(ply))
	if chat[ply] and isElement(chat[ply].wnd) then
		local newText = guiGetText(chat[ply].edit)
		if newText and string.len(newText) > 0 then
			local oldText = guiGetText(chat[ply].memo)
			if not oldText then oldText = "" end
			oldText = oldText .. getPlayerName(g_LocalPlayer) .. ": " .. newText .. "\n"
			guiSetText(chat[ply].memo, oldText)
			guiSetText(chat[ply].edit, "")
			guiMemoSetCaretIndex(chat[ply].memo, string.len(oldText))

			triggerServerEvent("onGUIPrivateMessage", g_LocalPlayer, ply,newText) 
		end	
	end
end
function recieveChatMessage(ply, msg)
	--outputDebugString("recieveChatMessage: " .. msg)
	if not chat[ply] then
		buildChatWindow(ply)
	end
	
	newmsg.show = true
	newmsg.tick = getTickCount()
	
	---guiSetText(newmsg.lbl, getPlayerName(ply) .. ": " .. msg .. "\n")
guiSetText(newmsg.lbl, " Сообщение от " .. getPlayerName(ply) .. "\n")
	outputChatBox("** ПОЛУЧЕНО ЛИЧНОЕ СООБЩЕНИЕ **",255,255,255,true)
                local sound = playSound("msg.mp3",false)
                setSoundVolume(sound, 0.5)


	anims.nmfadein:play()
	anims.nmtextin:play()
	--anims.nmslidein:play()

	local oldText = guiGetText(chat[ply].memo)
	if not oldText then oldText = "" end
	oldText = oldText .. getPlayerName(ply) .. ": " .. msg .. "\n"
	guiSetText(chat[ply].memo, oldText)
	guiMemoSetCaretIndex(chat[ply].memo, string.len(oldText))
end

event_resource_start = function(res)
	buildPlayerList()
end

event_resource_stop = function(res)
	unbindKey("F3", "down", togglePmGui)	
	showPmGui(false)
end

event_player_join = function()
	--outputDebugString("onClientPlayerJoin")
	addPlayerToList(source)
end

event_player_quit = function()
	--outputDebugString("onClientPlayerQuit")
	removePlayerFromList(source)
	destroyChatWindow(source)
end

event_gui_click = function(button, state, absx, absy)
	if button == "left" and state == "up" then
		if getElementType(source) == "gui-button" then
			local parent = getElementParent(source)
			if parent ~= false then
				local ply = getPlayerFromName(guiGetText(parent))
				if ply then
					if source == chat[ply].btnX then
						destroyChatWindow(ply)
						guiSetInputEnabled(false)
					elseif source == chat[ply].btnSend then
						sendChatMessage(ply)
						guiSetInputEnabled(false)
					end
				end
			end
		elseif getElementType(source) == "gui-edit" then
			local parent = getElementParent(source)
			if parent ~= false then
				local ply = getPlayerFromName(guiGetText(parent))
				if source == chat[ply].edit then
					guiSetInputEnabled(true)
				end
			end
		else
			guiSetInputEnabled(false)
		end
	end
end

event_gui_doubleclick = function(button, state, absx, absy)
	if button == "left" and state == "up" then
		if source == grdPlayers then
			local row, col = guiGridListGetSelectedItem(grdPlayers)
			--outputDebugString("double clicked row: "..tostring(row))
			if row == -1 or col == -1 then return end				
			local name = guiGridListGetItemText(grdPlayers, row, col)
			local ply = getPlayerFromName(name)
			if not chat[ply] then
				buildChatWindow(ply)
			end
			guiBringToFront(chat[ply].wnd)			
		end
	end
end

event_gui_accepted = function(element)
	local parent = getElementParent(source)
	if parent ~= false then
		local ply = getPlayerFromName(guiGetText(parent))
		if ply then
			if element == chat[ply].edit then
				sendChatMessage(ply)
			end
		end
	end
end

event_render = function()
	if newmsg.show == true then
		if getTickCount() > newmsg.tick + newmsg.showtime then
			anims.nmfadeout:play()
			anims.nmtextout:play()
			newmsg.show = false
		end
	end
end

addEvent("onPrivateChatSent", true)
addEventHandler("onPrivateChatSent", g_Root, recieveChatMessage)

addEventHandler("onClientResourceStart", g_ResourceRoot, event_resource_start)
addEventHandler("onClientResourceStop", g_ResourceRoot, event_resource_stop)
addEventHandler("onClientGUIDoubleClick", g_ResourceRoot, event_gui_doubleclick)
addEventHandler("onClientGUIClick", g_ResourceRoot, event_gui_click)
addEventHandler("onClientGUIAccepted", g_ResourceRoot, event_gui_accepted)

addEventHandler("onClientPlayerJoin", g_Root, event_player_join)
addEventHandler("onClientPlayerQuit", g_Root, event_player_quit)
addEventHandler("onClientRender", g_Root, event_render)