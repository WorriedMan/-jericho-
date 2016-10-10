perksStatsWindowShowing = false

local perksList = {1,2,3,4,5,6,7,8,9,10}
local selectedPerk
local selectedPerkInfo
local pipWindow

local function listClicked ( list, listTable, selectedRow )
	local perk_info = exports.pipos:pipListGetItemData(list,selectedRow,"perk_info")
	if perk_info then
		selectedPerkInfo = perk_info[1]..": "..perk_info[2]
		selectedPerk = perk_info[4]
	end
end

function createPerksWindow()
	perksStatsWindowShowing = true
	selectedPerk = nil
	selectedPerkInfo = nil
	pipWindow = exports.pipos:createPipWindow ( {x = xPip+250, y = yPip+60, width = 360, height = 200, name = "perksListWindow", not_render = true } )
	exports.pipos:createPipList ( {x=10,y=10,width = 340,height = 180,name = "perksList",parent="perksListWindow", line_size = 30, color = tocolor ( 255, 182, 66 )} )
	--for i, v in ipairs ( perksList ) do
	for i = 1, 20 do
		local perk = getElementData(localPlayer,"perkSl"..i)
		if perk and perk ~= 0 then
			local perk_info = exports.perks:getPerkInfo(perk)
			local count = exports.pipos:pipListAddItem({parent="perksList",label=perk_info[1]})
			exports.pipos:pipListSetItemData("perksList",count,"perk_info",perk_info)
		end
	end
	if not getElementData ( localPlayer, "speedShow" ) then
		--createPipButton ( "turn_muuav", xPip+300, yPip+100, 195, 30, "Активировать модуль УУиВ", 1.2, 255, 182, 66, "default" )
	end
	addEventHandler ( "pipos:listClicked", getRootElement(), listClicked )
end

function hidePerksWindow ()
	if perksStatsWindowShowing then
		--outputChatBox(tostring(pipWindow:destroyMe()))
		exports.pipos:destroyPipWindow("perksListWindow")
		pipWindow = nil
		perksStatsWindowShowing = false
		removeEventHandler ( "pipos:listClicked", getRootElement(), listClicked )
	end
end	

function renderPerksWindow ()
	dxDrawText ( 'Список выбранных перков', xPip+300, yPip+40, screenWidth, screenHeight, tocolor ( 255, 182, 66 ), 1, myFont )
	if selectedPerk then
		--dxDrawText ( selectedPerkInfo, xPip+260, yPip+260, xPip+600, yPip+460, tocolor ( 255, 182, 66 ), 1, "default-bold", "center", "top", true, true )
		dxDrawText ( selectedPerkInfo, xPip+260, yPip+260, xPip+460, yPip+460, tocolor ( 255, 182, 66 ), 1, "default-bold", "center", "top", true, true )
		dxDrawImage ( xPip+470, yPip+260, 128, 107, ":perks/boy/"..selectedPerk..".png", 0, 0, 0 )
	else
		dxDrawText ( "Подсказка: Перк можно выбрать каждый четный уровень до 40 уровня (включительно).\n\n\nДля выбора перка нажмите F1.\nПомните, что за всю игру вы сможете выбрать не больше 20 перков!", xPip+260, yPip+260, xPip+610, yPip+460, tocolor ( 255, 255, 220 ), 1, "default-bold", "center", "top", true, true )
	end
end

function statsButtonClicked (button)
	if button.name == 'turn_muuav' then
		setElementData ( localPlayer, "speedShow", true)
		destroyPipButtonByName ('turn_muuav')
	end
end

addEvent ( "pipButtonClicked", true )
addEventHandler ( 'pipButtonClicked', root, statsButtonClicked)

addEvent ( "pipos:listClicked", false )