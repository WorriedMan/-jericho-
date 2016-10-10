local screenWidth,screenHeight = guiGetScreenSize()

local perkX, perkY = screenWidth/2-300, screenHeight/2-175

local choosenPerk = nil
local windowShowing = false
choosenPerkID = 1
lg = 1

perkCfg = {
	{ phrase[lg].lead_belly, "Эта способность на 100 % снижает получаемую вами дозу радиации, когда вы пьете зараженную воду или едите грибы.", 10, 1 }, -- работает
	{ phrase[lg].night_stalk, "После захода солнца (с 20:00 до 07:00) Ночное существо получает на 20% меньше урона, но на 10% больше после восхода солнца. Эта способность переводит ваши «внутренние часы» и потому действует как в помещении, так и вне его.", 2, 2 }, -- работает
	{ phrase[lg].skinner, "Может быть это и мерзко, ну и что? Выживать то как-то приходиться. Теперь вы сможете найти случайные предметы не теле убитого гуля.", 4, 3 }, -- работает
	{ phrase[lg].weap_man, "Вы одержимы огнестрельным оружием. Урон, который наносит ваше оружие, увеличивается на 10%.", 4, 4 }, -- работает
	{ phrase[lg].nerd, "Довольно уже над вами издевались! У Бешеного ботаника, когда здоровье падает до 10% или ниже, сопротивляемость урону возрастает на 50%.", 6, 5 }, -- работает
	{ phrase[lg].tresure_hunter, "У вас талант находить использованные бутылочные крышки. С этой способностью вы будете находить бутылочные крышки в самых неожиданных местах.", 6, 6 }, -- работает
	{ phrase[lg].anorexic, "Вас просто воротит от еды, из-за чего, ваш голод увеличивается в полтора раза медленнее", 8, 7 }, -- работает
	{ phrase[lg].warrior, "Вы принимали участие в операции по освобождению Анкориджа. За ваши былые заслуги все торговцы роботы и некоторые торговцы люди дают вам скидку скидку 4% на все свои товары!", 8, 8 }, -- работает
	{ phrase[lg].farsighted, "Увеличивает в два раза дальность отображения ящиков с вещами на компасе.", 10, 9 }, -- работает
	{ phrase[lg].shot_proof_1, "Уменьшает получаемый урон на 5%.", 2, 10 },  -- работает
	{ phrase[lg].skill_doctor, "Антирад восстанавливает 30% от текущего здоровья.", 10, 11 }, -- работает
	{ phrase[lg].shot_proof_2, "Уменьшает получаемый урон на 10%.\n\nНеобходим перк \"Живчик I\".", 12, 12, 10 }, --работает
	{ phrase[lg].billy_kid, phrase[lg].billy_kid_d, 12, 13, 4 }, -- работает
	{ phrase[lg].iron_fist, "Без оружия вы наносите на 100% больше урона.", 14, 14 }, -- работает
	{ phrase[lg].strong_back_1, "С этой способностью вы можете нести на 20 кг больше вещей", 14, 15 }, -- работает
	{ phrase[lg].ghoul, "Уменьшает в два раза получаемую радиацию от нахождения в зоне радиации", 16, 16 }, -- работает
	{ phrase[lg].solar, "Днем вы получаете 15% к сопротивляемости урону, а ночью 10% к получаемому урону.", 16, 17 }, -- работает
	{ phrase[lg].shot_proof_3, "Уменьшает получаемый урон на 15% \n\nНеобходим перк \"Живчик II\"", 18, 18, 12 }, -- работает
	{ phrase[lg].pro, "В случае убийства другого игрока, вы получаете 10% его опыта.", 20, 19 }, -- гат
	{ phrase[lg].fly_beast, "Полностью убирает урон от падений с высоты.", 20, 20 }, -- гат
	{ phrase[lg].one_of_us, "Вы ездили на рыбалку с Сэмом Смитом, исследовали землю со спутника вместе с Комендантом Союза Ученых, и даже пару раз переписывались с таинственным мэром Новой Деревни, для них вы - свой в доску. В случае убийства игрока, за вашу голову не назначат награду.", 20, 21 }, -- гат
	{ phrase[lg].wastelander, "Хочешь жить - умей вертеться. Ну вот вы и довертелись. Зоны радиации мало того, что восстаналивают ваше здоровье, в них вы еще и не чувствуете усталость. Но вот умереть от передозировки радиацией вы все еще можете, так что вам еще есть куда расти!", 16, 22 }, -- гат
	{ phrase[lg].ambass, "Вы являетесь \"Послом Мира\" в этих краях. Даже бандиты не смеют на вас нападать первыми. Круто? И это неважно, что \"Послом Мира\" вы назначили сами себя!", 40, 23 }, -- гат
	{ phrase[lg].strong_back_2, "С этой способностью вы можете нести на 40 кг больше вещей", 18, 24, 15 }, -- гат
	{ phrase[lg].strong_back_3, "С этой способностью вы можете нести на 60 кг больше вещей", 32, 25, 23 }, -- гат
	{ phrase[lg].pudge_1, "Увеличивает ваше здоровье на 25 единиц", 10, 26 }, -- гат
	{ phrase[lg].pudge_2, "Увеличивает ваше здоровье еще на 50 единиц", 18, 27, 26 }, -- гат
	{ phrase[lg].pudge_3, "Увеличивает ваше здоровье еще на 90 единиц", 30, 28, 27 }, -- гат
	{ "Воришка", "Если вы убиваете другого игрока, есть шанс украсть у него 20% его текущего опыта.", 6, 29 }, --
	{ "Ускоренный метаболизм", "Стимуляторы восстанавливают на 25% больше здоровья.", 8, 30 }, --
	{ "Бесшумный бег", "Способность дает вам возможность двигаться быстро бесшумно, так что для гулей теперь все равно - крадетесь вы, или бежите, они вас не заметят.", 12, 31 }, --
	{ "Смертельный удар", "При атаке оружием ближнего боя вы имеете шанс нанести врагу 500% критический урон. Вы - воплощение быстрой смерти!", 30, 32 }, --
	{ "Наблюдательность", "Наблюдательность дает вам возможность получать подробную информацию о любом существе, на которое вы целитесь. Вы определяете точное количество его очков здоровья и получаете информацию о наносимом им уроне (урон других игроков не показывается).", 2, 33 }, --
	{ "Юный прорицатель", "В детстве вы любили угадывать загаданное от 1 до 1 000 000 число, вам даже удавалось выиграть в эту игру. Ну что-ж, вы тратили свое время не зря. Теперь вдвое сокращается количество возможных вариантов при использовании отмычки на закрытом замке.", 10, 34 }, --
	--{ "Дитя радиации", "Вы и вправду дитя радиации. Чем больше степень лучевой болезни, тем быстрее восстанавливается ваше здоровье. При уровне радиации 80%/85%/90%/95% каждую секунду вы восстанавливаете 1/2/3/4 очка здоровья.", 40, 35 }, --
}

function sortItemsInLoot ()
	table.sort (perkCfg, sortFunction)
end

function sortFunction (a,b)
	local lev1, lev2 = a[3], b[3]
	return lev1<lev2
end

sortItemsInLoot ()

function createPerkChoose ()
	if windowShowing == false then
		windowShowing = true
		perkWindow = guiCreateWindow(perkX, perkY, 600, 349, "", false)
		guiWindowSetSizable(perkWindow, false)
		guiSetAlpha(perkWindow, 1.00)
		choosenPerkID = nil
		choosenPerk = nil
		perkGrid = guiCreateGridList(14, 30, 170, 307, false, perkWindow)
		guiGridListAddColumn(perkGrid, phrase[lg].perk_name, 0.7)
		guiGridListAddColumn(perkGrid, phrase[lg].lvl, 0.1)
		for i, v in ipairs (perkCfg) do
			if not getElementData ( localPlayer, "perk"..v[4] ) then
				local createdRow = guiGridListAddRow(perkGrid)
				guiGridListSetItemText(perkGrid, createdRow, 1, v[1], false, false)
				guiGridListSetItemText(perkGrid, createdRow, 2, v[3], false, false)
				guiGridListSetItemData ( perkGrid, createdRow, 1,  i )
				if v[3] > getElementData ( localPlayer, "rplvl" ) then
					guiGridListSetItemColor ( perkGrid, createdRow, 1, 128, 128, 128 )
					guiGridListSetItemColor ( perkGrid, createdRow, 2, 128, 128, 128 )
				end
			end
		end
		addEventHandler("onClientGUIClick", perkGrid, actionOnPerk,false)
		showCursor ( true )
		perkLabel = guiCreateLabel(196, 221, 386, 113, "", false, perkWindow)
		guiLabelSetHorizontalAlign(perkLabel, "left", true)
		guiSetFont(perkGrid, "default-bold-small")
	end
end

function actionOnPerk ()
	local selectedThings = guiGridListGetSelectedItems ( perkGrid )
	if selectedThings[1] then
		--local perkID = selectedThings[1].row+1
		local perkID = guiGridListGetItemData ( perkGrid, tonumber(selectedThings[1]["row"]), 1 )
		if perkID then
			if perkCfg[perkID][3] <= getElementData ( localPlayer, "rplvl" ) then
				if choosePerkButt == nil then
					choosePerkButt = guiCreateButton(330, 320, 115, 25, phrase[lg].chose, false, perkWindow)
					addEventHandler("onClientGUIClick", choosePerkButt, givePlayerPerk,false)
				end
				guiSetText ( perkLabel, perkCfg[perkID][2] )
				choosenPerk, choosenPerkID = perkCfg[perkID][4], perkID
				if perkImage then destroyElement ( perkImage ) end
				perkImage = guiCreateStaticImage(281, 38, 193, 150, "boy/"..perkCfg[perkID][4]..".png", false, perkWindow)
			end
		else
			outputChatBox ("Ошибка! Как можно скорее сообщите администратору код: B1aaaa", 255,255,127 )
		end
	end
end

function givePlayerPerk ( )
	if choosenPerk then
		if perkCfg[choosenPerkID][5] then
			if not getElementData ( localPlayer, "perk"..perkCfg[choosenPerkID][5] ) then
				outputChatBox ("Вы не можете взять этот перк", 255,255,127 )
				return true
			end
		end
		perkNum = getFreePerkSlot ()
		setElementData ( localPlayer, "perk"..choosenPerk, true )
		setElementData ( localPlayer, "perkSl"..perkNum, choosenPerk )
		showCursor ( false )
		destroyElement ( choosePerkButt )
		destroyElement ( perkImage )
		choosePerkButt = nil
		destroyElement ( perkWindow )
		windowShowing = false
		exports.pipboy:addInfoBox ( 'Выбран перк  \"'..perkCfg[choosenPerkID][1]..'\"')
		triggerEvent ( "perkGot", localPlayer, choosenPerk )
		if choosenPerk == 13 then
			triggerServerEvent ( "loadPlayerWeapStats", localPlayer )
		end
	end
end

function getFreePerkSlot ()
	for i = 1, 20 do
		if getElementData ( localPlayer, "perkSl"..i ) == 0 and i <= getElementData ( localPlayer, "rplvl" )/2 then
			return i
		end
	end
end

function getPlayerPerks ()
	local pTable = {}
	for i = 1, 20 do
		if getElementData ( localPlayer, "perkSl"..i ) > 0 then
			table.insert ( pTable, getElementData ( localPlayer, "perkSl"..i ) )
		end
	end
	if pTable[1] ~= nil then 
		return pTable 
	else 
		return false 
	end
end

function getPerkInfo(perkid)
	for i, v in ipairs (perkCfg) do
		if v[4] == perkid then
			return v
		end
	end
end

--addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()),createPerkChoose)
-- function giveMePerk(cmd,perkid)
	-- local perkid = tonumber(perkid)
	-- for i, v in ipairs (perkCfg) do
		-- if v[4] == perkid then
			-- local choosenPerk = v[4]
			-- setElementData ( localPlayer, "perk"..perkid, true )
			-- setElementData ( localPlayer, "perkSl"..getFreePerkSlot (), choosenPerk )
			-- exports.pipboy:addInfoBox ( 'Выбран перк  \"'..v[1]..'\"')
			-- triggerEvent ( "perkGot", localPlayer, choosenPerk )
			-- if choosenPerk == 13 then
				-- triggerServerEvent ( "loadPlayerWeapStats", localPlayer )
			-- end
			-- break
		-- end
	-- end
-- end

-- addCommandHandler("perk",giveMePerk)

-- addCommandHandler("perkc",createPerkChoose)

-- function resetMyPerks(cmd,perkid)
	-- for i = 1, 20 do
		-- setElementData(localPlayer,"perkSl"..i,0)
	-- end
	-- for i, v in ipairs(perkCfg) do
		-- setElementData ( localPlayer, "perk"..i, false )
	-- end
-- end

-- addCommandHandler("resetp",resetMyPerks)

function givePlayerPerkChoose ()
	exports.players:addNewNotification ( 2, nil, nil, nil, nil, nil )
end