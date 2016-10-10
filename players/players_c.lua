lg = 1

local playerLVL = 1
local radiation = 0

usefulPerks = {
	["fan"] = { 4, false },
	["botan"] = { 5, false },
	["anar"] = { 7, false },
	["live1"] = { 10, false },
	["live2"] = { 12, false },
	["steel"] = { 14, false },
	["live3"] = { 18, false },
	["finder"] = { 9, false },
	["night"] = { 2, false },
	["day"] = { 17, false },
	["lookness"] = { 33, false },
}

function loadPlayerLabels ( level, xp, radiat, virus )
	bindKey ( "Z", "down", function () showCursor( not isCursorShowing() ) end )
	if level == 0 then
		playerLVL = 1
	else
		playerLVL = level
	end
	eat = getElementData ( localPlayer, "eat" )
	if eat > 90 then avTimeReducing = 4000 end	
	radiation = getElementData ( localPlayer, "rad" )
	exports.pipboy:loadPlayerValues ()
	exports.inventory:checkPlayerWeight ()
	addEventHandler ( "onClientRender", root, updateFalloutHUD )
	setTimer ( givePointAV, 2000, 1 )
	setTimer(playerPingCheck,4000,0)
	bindKey ( ',', 'down', sitAndRelax )
	setPlayerHudComponentVisible ( "vehicle_name", false )
	setPlayerHudComponentVisible ( "area_name", false )
	local pLevel = math.floor(getElementData ( localPlayer, "rplvl" )/2) 
	for i=1, pLevel do
		if getElementData ( localPlayer, "perkSl"..i ) == 0 then
			addNewNotification ( 2, nil, nil, nil, nil, nil )
		end
	end
	local stats = getElementData ( localPlayer, 'accuracy' ) + getElementData ( localPlayer, 'breath' ) + getElementData ( localPlayer, 'strenght' )
	if getElementData ( localPlayer, "rplvl" ) > stats	then
		for i = 1, getElementData ( localPlayer, "rplvl" )-stats do
			addNewNotification ( 3, nil, nil, nil, nil, nil )
		end
	end
	local perkTable = exports.perks:getPlayerPerks ()
	if perkTable then
		for i = 1, #perkTable do
			for b = 1, #usefulPerks do
				if perkTable[i] == usefulPerks[i][1] then
					usefulPerks[i][2] = true
				end
			end
		end
	end
end

addEvent( "showLevelLabel", true )
addEventHandler( "showLevelLabel", getRootElement(), loadPlayerLabels )

local pingFails = 0
function playerPingCheck ()
	if getPlayerPing(getLocalPlayer()) > 300 then
		pingFails = pingFails +1
		if pingFails == 6 then
			triggerServerEvent("kickPlayerOnHighPing",getLocalPlayer())
			return true
		end
		outputChatBox ( "Ваш пинг больше 300! ("..pingFails.."/4)", 255, 100, 100 )
		if isTimer(pingTimer) then return end
		pingTimer = setTimer(function()
						pingFails = 0
					end,30000,1)
	end
end	

local sit = false

function sitAndRelax ()
	if sit then
		sit = false
		triggerServerEvent ( "changePlayerAnimationC", localPlayer )
	else
		sit = true
		triggerServerEvent ( "changePlayerAnimationC", localPlayer, "BEACH", "ParkSit_M_loop" )
	end
end

addEvent ( "perkGot", true )

function perkGotCheck ( id )
	for b = 1, #usefulPerks do
		if id == usefulPerks[i][1] then
			usefulPerks[i][2] = true
		end
	end
end

addEventHandler ( "perkGot", root, perkGotCheck )

local screenWidth,screenHeight = guiGetScreenSize()
local hudShowed = false

local texture = dxCreateTexture ( "inter.dds", "dxt3" )

function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end

local cTaskX, cTaskY, cTaskZ = 0, 0, 0
local cAdTaskX, cAdTaskY, cAdTaskZ = 0, 0, 0

function updateCompassArrowPos ( x, y, z)
	cTaskX, cTaskY, cTaskZ = x, y, z 
end

function updateCompassAdditArrowPos ( x, y, z )
	cAdTaskX, cAdTaskY, cAdTaskZ = x, y, z 
end

local color = tocolor ( 255, 182, 66 )

local mTable = {}
local pointing
local pTarget
local targetType = 0
local thall
local av = 14
local hudShowed = true

function changeShowHud (commandName,show)
	if show then
		if show == "1" then
			hudShowed = false
			showChat ( false )
		else
			hudShowed = true
			showChat ( true )
		end
		return true
	else
		if hudShowed then
			hudShowed = false
			showChat ( false )
		else
			if getElementData ( localPlayer, "inventoryAllowed" ) == 1 then
				hudShowed = true
				showChat ( true )
			end
		end
	end
end    
addCommandHandler ( "showhude", changeShowHud )

function updateFalloutHUD ()
	if hudShowed then
		local x, y, z, lx, ly, lz = getCameraMatrix()
		local rz = findRotation ( x, y, lx, ly )
		local posx, posy = getElementPosition ( localPlayer )
		local mark = findRotation ( posx, posy, 2456, -1670 )
		dxDrawImageSection ( 12, screenHeight-26, 168, 32, rz*(-2.84)-84, 20, 168, 32, texture, 0, 0, 0, color )
		if getElementData ( localPlayer, "showAdditArrowC" ) then
			local posMar = findRotation ( posx, posy, cAdTaskX, cAdTaskY )
			if rz-posMar > -80 and rz-posMar < 80 then
				local start = rz-posMar
				dxDrawImageSection ( start+85, screenHeight-20, 22, 16, 776, 710, 22, 16, texture, 0, 0, 0, color )
			elseif rz-posMar < 80 then
				dxDrawImageSection ( 5, screenHeight-20, 22, 16, 776, 710, 22, 16, texture, 0, 0, 0, color )
			elseif rz-posMar > 80 then
				dxDrawImageSection ( 165, screenHeight-20, 22, 16, 776, 710, 22, 16, texture, 0, 0, 0, color )
			end
		end
		if getElementData ( localPlayer, "showArrowC" ) then
			local posMar = findRotation ( posx, posy, cTaskX, cTaskY )
			if rz-posMar > -80 and rz-posMar < 80 then
				local start = rz-posMar
				dxDrawImageSection ( start+85, screenHeight-20, 22, 16, 776, 710, 22, 16, texture, 0, 0, 0, color )
			elseif rz-posMar < 80 then
				dxDrawImageSection ( 5, screenHeight-20, 22, 16, 776, 710, 22, 16, texture, 0, 0, 0, color )
			elseif rz-posMar > 80 then
				dxDrawImageSection ( 165, screenHeight-20, 22, 16, 776, 710, 22, 16, texture, 0, 0, 0, color )
			end
		end
		for i=1, #mTable do
			local posMar = findRotation ( posx, posy, mTable[i][1], mTable[i][2] )
			if rz-posMar > -80 and rz-posMar < 80 then
				local start = rz-posMar
				dxDrawImageSection ( start+85, screenHeight-20, 27, 16, 466, 796, 27, 16, texture, 0, 0, 0, color )
			elseif rz-posMar < 80 then
				dxDrawImageSection ( 5, screenHeight-20, 27, 16, 466, 796, 27, 16, texture, 0, 0, 0, color )
			elseif rz-posMar > 80 then
				dxDrawImageSection ( 165, screenHeight-20, 27, 16, 466, 796, 27, 16, texture, 0, 0, 0, color )
			end
		end
		local health = getElementData( localPlayer,'health' )
		local numPerLevel = getElementData( localPlayer,'maxHealth' )/14
		local num = math.floor(health/numPerLevel)
		if num > 14 then
			num = 14
		end
		local x = 12
		for i = 1, num do 
			dxDrawImageSection ( x, screenHeight-55, 16, 64, 355, 836, 16, 64, texture, 0, 0, 0, color )
			x = x+10
		end
		dxDrawImageSection ( 0, screenHeight-64, 256, 64, 0, 126, 256, 64, texture, 0, 0, 0, color )
		dxDrawImageSection ( screenWidth-256, screenHeight-64, 256, 64, 190, 130, 256, 64, texture, 0, 0, 0, color )
		local weapon = getPedWeapon ( localPlayer )
		local minutes, hours = getTime ()
		if minutes < 10 then minutes = "0"..tostring(minutes) end
		if hours < 10 then hours = "0"..tostring(hours) end
		if weapon == 0 or getPedWeaponSlot ( localPlayer ) == 1 then
			 --dxDrawText ( "", screenWidth-70, screenHeight - 25, screenWidth, screenHeight, color, 1.2, "default" )
		else
			local weapon = getElementData (localPlayer,"currentWeapon")
			if weapon then
				local clip = getElementData (localPlayer,"cweap.inclip") or 0
				if getElementData (localPlayer,"cweap.reloading") then
					clip = 0
				end
				local ammo = getElementData (localPlayer,"currAmmoAmount")
				if ammo == 0 then clip = 0 end
				dxDrawText ( clip.."/"..(ammo-clip), screenWidth-70, screenHeight - 25, screenWidth, screenHeight, color, 1.2, "default" )
			end
		end
		if tonumber(radiation) > 80*playerLVL then
			dxDrawText ( "ОПАСНЫЙ УРОВЕНЬ РАДИАЦИИ", 10, screenHeight - 80, screenWidth, screenHeight, tocolor(255,0,0,255), 1.2, "tahoma" )
		end
		if eat > 90 then
			dxDrawText ( "Голод: "..eat.."%", screenWidth-178, screenHeight - 25, screenWidth, screenHeight, tocolor(240,0,0), 1.2, "default" )
		else
			dxDrawText ( "Голод: "..eat.."%", screenWidth-178, screenHeight - 25, screenWidth, screenHeight, color, 1.2, "default" )
		end
		local x = screenWidth - 155
		local numPerLevel = getElementData( localPlayer,'maxAP' )/14
		for i = 1, math.floor(av/numPerLevel) do 
			dxDrawImageSection ( x, screenHeight-60, 16, 64, 355, 836, 16, 64, texture, 0, 0, 0, color )
			x = x+10
		end
		if pointing and thall and usefulPerks.lookness then
			if isElement ( pTarget ) then
				local health = getElementData ( pTarget, 'health' ) or getElementHealth ( pTarget ) or 100
				local maxHealth = getElementData ( pTarget, 'maxHealth' ) or 100
				if health > 0 then
					dxDrawImageSection ( screenWidth/2-180, screenHeight-64, 512, 64, 0, 66, 512, 64, texture, 0, 0, 0, tocolor ( 255, 50, 50 ) )
					local x = screenWidth/2-125
					local num = 0
					if targetType == 1 then
						num = math.floor(health/40)
					elseif targetType == 2 then
						numPerMax = maxHealth/25
						num = math.floor(health/numPerMax)
					end
					if getElementType ( pTarget ) == "ped" then
						damage = getElementData ( pTarget, "zDamage" ) or getElementData( pTarget,"customped:damage" ) or 0
						dxDrawText ( "УРОН: "..damage, screenWidth/2+170, screenHeight-64, screenWidth, screenHeight, tocolor ( 255, 50, 50 ), 1.2, "sans" )
					end
					for i = 1, num do 
						dxDrawImageSection ( x, screenHeight-70, 16, 64, 355, 836, 16, 64, texture, 0, 0, 0, tocolor ( 255, 50, 50 ) )
						x = x+10
					end
				end
			end
		end
	end
end

function targetingActivated ( target )
	if ( target ) then
		if getElementType ( target ) == "ped" then
			pointing = true
			pTarget = target
			--if getElementType ( target ) == 'vehicle' then
			--	targetType = 1
			--else
			if getElementType ( target ) == 'ped' or getElementType ( target ) == 'player' then
				if not getElementData ( target, 'npc-ped' ) then
					targetType = 2
				end
			end
		end
	else
		targetType = 0
		pTarget = nil
		pointing = false
	end
end
addEventHandler ( "onClientPlayerTarget", getRootElement(), targetingActivated )

function outputAimState (key, keyState)
	if keyState == "down" then
		thall = true
	else
		thall = false
	end
end

bindKey ( "aim_weapon", "both", outputAimState )

avTimeReducing = 2000

function givePointAV ()
	setTimer ( givePointAV, avTimeReducing, 1 )
	if av<getElementData ( localPlayer, 'maxAP' ) then
		if ( getPedMoveState ( localPlayer ) ~= 'sprint' and getPedMoveState ( localPlayer ) ~= 'jump' ) or isPedInVehicle ( localPlayer ) then
			av = av+1
			if av == 1 then
				toggleControl ( 'sprint', true )
				toggleControl ( 'jump', true )
			end
			local aBlock, aName = getPedAnimation ( localPlayer )
			if aName == "ParkSit_M_loop" and av<getElementData ( localPlayer, 'maxAP' ) then
				av = av+1
			end
			if getElementData ( localPlayer, "vip" ) then
				av = av+1
			end
		end
	end
end

function givePlayerAV ( amount )
	av = av+amount
	if av > (getElementData ( localPlayer, 'maxAP' ) or 1) then
		av = getElementData ( localPlayer, 'maxAP' )
	end
end

local jumpcheck = true
local sprintTimer
local sprintcheck
local checkValue

function checkPlayerSprint ()
	if not isPedInVehicle ( localPlayer ) then
		if getPedMoveState ( localPlayer ) == "sprint" then
			if getElementData ( localPlayer, 'inRadZone' ) and getElementData ( localPlayer, 'perk22' ) and getElementData ( localPlayer, "antiRadWear" ) > 0 then
				return true
			end
			if not getElementData ( localPlayer, "norLiveKilled" ) and not getElementData ( localPlayer, "fungus" ) then
				if av > 1 then 
					if checkValue then
						av = av-1 
						checkValue = false
					else
						checkValue = true
					end
				else
					setControlState ( 'sprint',false )
					toggleControl ( 'sprint', false )
					toggleControl ( 'jump', false )
					av = 0 
				end
			end
		end
	end
end
setTimer ( checkPlayerSprint, 1500, 0 )

function playerJumped ()
	if not isPedInVehicle ( localPlayer ) then
		if isControlEnabled ( 'jump' ) then
			if jumpcheck then
				setTimer ( function () jumpcheck = true end, 1000, 1 )
				jumpcheck = false
				if getElementData ( localPlayer, 'inRadZone' ) and getElementData ( localPlayer, 'perk22' ) and getElementData ( localPlayer, "antiRadWear" ) > 0 then
					return true
				end
				if not getElementData ( localPlayer, "norLiveKilled" ) and not getElementData ( localPlayer, "fungus" ) then
					if av > 1 then 
						av = av-1 
					else
						toggleControl ( 'sprint', false )
						toggleControl ( 'jump', false )
						av = 0 
					end
				end
			end
		end
	end
end

bindKey ( "jump", "down", playerJumped )

function checkLootShapeHit( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) then
		 if getElementData ( source, "lootVeryFar" ) then
			if getElementData ( theElement, "perk9" ) then
				local id = getElementData ( source, "ident" )
				if exports.loot:getLootState ( id ) then
					local x,y,z = getElementPosition ( source )
					table.insert ( mTable, { x,y, 1, id } )
				end
			end
		 end
		 if getElementData ( source, "lootFar" ) then
			if not getElementData ( theElement, "perk9" ) then
				local id = getElementData ( source, "ident" )
				if exports.loot:getLootState ( id ) then
					local x,y,z = getElementPosition ( source )
					table.insert ( mTable, { x,y, 1, id } )
				end
			end
		 end
		 if getElementData ( source, "loot" ) then
			for i=1, #mTable do
				if mTable[i] then
					if mTable[i][3] then
						if mTable[i][3] == 1 then
							if getElementData ( source, "ident" ) == mTable[i][4] then
								table.remove ( mTable, i )
							end
						end
					end
				end
			end
		 end
    end
end
addEventHandler("onClientColShapeHit",getRootElement(),checkLootShapeHit)

function checkLootShapeLeave( theElement, matchingDimension )
    if ( theElement == getLocalPlayer() ) then
		 if getElementData ( source, "lootFar" ) then
			for i=1, #mTable do
				if mTable[i] then
					if mTable[i][3] then
						if mTable[i][3] == 1 then
							if getElementData ( source, "ident" ) == mTable[i][4] then
								table.remove ( mTable, i )
							end
						end
					end
				end
			end
		 end
    end
end
addEventHandler("onClientColShapeLeave",getRootElement(),checkLootShapeLeave)

function changeClientLabelLevel (lvl)
	playerLVL = lvl
	if lvl%2 == 0 then
		addNewNotification ( 2, nil, nil, nil, nil, nil )
	end
end

addEvent( "changeLabelLevel", true )
addEventHandler( "changeLabelLevel", getRootElement(), changeClientLabelLevel )

function givePlayerRadClient ( quant )
	if not getElementData ( localPlayer, "norLiveKilled" ) and getElementData ( localPlayer, "antiRadWear" ) == 0 and not getElementData ( localPlayer, "inBuild" ) then
		setElementData ( localPlayer, "rad", quant+radiation )
		radiation = quant+radiation
		exports.pipboy:updateRadLabel(radiation)
		if quant+radiation > 100*playerLVL then
			exports.pipboy:addInfoBox("Передозировка радиацией", 2 )
			setElementData ( localPlayer, 'health',0 )
			setTimer ( takePlayerRadClient, 2000, 1, 0 )
		end
	end
end

addEvent( "givePlayerRadS", true )
addEventHandler( "givePlayerRadS", getRootElement(), givePlayerRadClient )

function takePlayerRadClient ( quant )
	if quant > 0 then
		if radiation-quant > 0 then
			setElementData ( localPlayer, "rad", radiation-quant )
			radiation = radiation-quant
		else
			setElementData ( localPlayer, "rad", 0 )
			radiation = 0
			exports.pipboy:updateRadLabel(radiation)
		end
	else
		setElementData ( localPlayer, "rad", 0 )
		radiation = 0
	end
	exports.pipboy:updateRadLabel(radiation)
end

addEvent( "takePlayerRadS", true )
addEventHandler( "takePlayerRadS", getRootElement(), takePlayerRadClient )

function givePlayerXPClient ( quant )
    triggerServerEvent ( "givePlayerXPC", getLocalPlayer(), quant ) 
end

function showDXLevelUpText ()
    dxDrawText("LEVEL UP!",2.0,184.0,510.0,240.0,tocolor(255,0,0,255),3.0,"bankgothic","left","center",true,false,false)
end

function playLVLUpSoundC ()
	playSound("sounds/lvlup.mp3")
	addEventHandler("onClientRender",root,showDXLevelUpText)
	setTimer (function() removeEventHandler("onClientRender",root,showDXLevelUpText) end, 3500, 1 )
end

addEvent( "playLVLUpSound", true )
addEventHandler( "playLVLUpSound", getRootElement(), playLVLUpSoundC )

function givePlayerNewHealth ( amount )
	local health = getElementData ( localPlayer, 'health' )
	local maxHealth = getElementData ( localPlayer, 'maxHealth' )
	if health + amount >= maxHealth then
		setElementData ( localPlayer, 'health', maxHealth )
		return true
	else
		setElementData ( localPlayer, 'health', health+amount )
		return true
	end
end

local helpLabel
local selectStats
local strenghtHelpButton
local breathHelpButton
local accuracyHelpButton

function createStatsUpPanel ()
	if not isElement ( selectStats ) then
		showCursor ( true )
		local statX, statY = screenWidth/2-150,screenHeight/2-100
		selectStats = guiCreateWindow ( statX, statY, 300, 200, phrase[lg].choose_stat, false )
		guiSetAlpha ( selectStats, 255 )
		local strenghtButton = guiCreateButton(10, 30, 200, 30, phrase[lg].strenght, false, selectStats)
		strenghtHelpButton = guiCreateButton(240, 30, 30, 30, "?", false, selectStats)
		guiSetFont ( strenghtHelpButton, 'default-bold-small' )
		local breathButton = guiCreateButton(10, 80, 200, 30, phrase[lg].stam, false, selectStats)
		breathHelpButton = guiCreateButton(240, 80, 30, 30, "?", false, selectStats)
		guiSetFont ( breathHelpButton, 'default-bold-small' )
		local accuracyButton = guiCreateButton(10, 130, 200, 30, phrase[lg].prec, false, selectStats)
		accuracyHelpButton = guiCreateButton(240, 130, 30, 30, "?", false, selectStats)
		guiSetFont ( accuracyHelpButton, 'default-bold-small' )
		addEventHandler( "onClientGUIClick", strenghtButton, function () statsChoosen ( 1 ); destroyElement ( source ) end )
		addEventHandler( "onClientGUIClick", breathButton, function () statsChoosen ( 2 ); destroyElement ( source ) end )
		addEventHandler( "onClientGUIClick", accuracyButton, function () statsChoosen ( 3 ); destroyElement ( source ) end )
	end
end

function statsChoosen ( stat )
	destroyElement ( selectStats )
	showCursor ( false )
	if stat == 1 then
		setElementData ( localPlayer, 'strenght', getElementData ( localPlayer, 'strenght' ) + 1 )
		calculatePlayerHP ()
		calculatePlayerDamage ()
	elseif stat == 2 then
		setElementData ( localPlayer, 'breath', getElementData ( localPlayer, 'breath' ) + 1 )
		calculatePlayerAP ()
		exports.inventory:checkPlayerWeight ()
	elseif stat == 3 then
		setElementData ( localPlayer, 'accuracy', getElementData ( localPlayer, 'accuracy' ) + 1 )
		calculatePlayerDamage ()
	end
end	
	
addEventHandler( "onClientMouseEnter", getRootElement(), 
    function(aX, aY)
		if source == strenghtHelpButton then
			if not helpLabel then
				helpLabel = guiCreateLabel ( aX, aY, 250, 80, phrase[lg].strenght_d..getElementData ( localPlayer, 'strenght' ), false )
				guiSetFont ( helpLabel, 'default-bold-small' )
			end
		elseif source == breathHelpButton then
			if not helpLabel then
				helpLabel = guiCreateLabel ( aX, aY, 250, 80, 'Увеличивает ОД на 5 единиц,\nпереносимый вес на 5 кг;\nТекущее значение: '..getElementData ( localPlayer, 'breath' ), false )
				guiSetFont ( helpLabel, 'default-bold-small' )
			end
		elseif source == accuracyHelpButton then
			if not helpLabel then
				helpLabel = guiCreateLabel ( aX, aY, 250, 80, 'Увеличивает урон стрелкового оружия на\n2 единицы;\nТекущее значение: '..getElementData ( localPlayer, 'accuracy' ), false )
				guiSetFont ( helpLabel, 'default-bold-small' )
			end
		end
    end
)

addEventHandler("onClientMouseLeave", getRootElement(), function(aX, aY)
	if source == strenghtHelpButton or source == breathHelpButton or source == accuracyHelpButton then
		if isElement ( helpLabel ) then 
			destroyElement ( helpLabel )
			helpLabel = nil
		end
	end
end)

function calculatePlayerDamage ()
	setElementData ( localPlayer, 'shootWeaponDamage', getElementData ( localPlayer, 'accuracy' ) )
end

function calculatePlayerAP (firstrun)
	setElementData ( localPlayer, 'maxAP', 14+getElementData ( localPlayer, 'breath' )+getElementData ( localPlayer, 'tempbreath' ) )
	if firstrun then
		av = 14+getElementData ( localPlayer, 'breath' )
	end
end

addEvent( "calculatePlayerAPS", true )
addEventHandler( "calculatePlayerAPS", getRootElement(), calculatePlayerAP )

function calculatePlayerHP ()
	local additHealth = 0
	if getElementData ( localPlayer, 'perk26' ) then
		additHealth = 60
	end	
	if getElementData ( localPlayer, 'perk27' ) then
		additHealth = additHealth+120
	end	
	if getElementData ( localPlayer, 'perk28' ) then
		additHealth = additHealth+240
	end	
	setElementData ( localPlayer, 'maxHealth', 95+getElementData ( localPlayer, 'rplvl' )*5+getElementData ( localPlayer, 'strenght' )*10+getElementData ( localPlayer, 'tempstrenght' )*10+additHealth )
end

addEvent( "calculatePlayerHP", true )
addEventHandler( "calculatePlayerHP", getRootElement(), calculatePlayerHP )

local showFPS = false

function checkInfo ()
	local timestamp = getElementData(root,"timestamp")
	local rtime = getRealTime(timestamp)
	if showFPS then
		dxDrawText ( "FPS: " .. tostring(exports.utils:getPlayerFPS()).."| PING: " .. tostring(getPlayerPing(getLocalPlayer())) .. " | TIMESTAMP: "..timestamp.." | ВРЕМЯ: "..rtime.hour..":"..rtime.minute, 0, 0, screenWidth,screenHeight, tocolor(255,255,255), 1, "default", "right" )
	end    
end

function InfoOn ()
	if not showFPS then
		showFPS = true
		addEventHandler ( "onClientRender", root, checkInfo)
	else
		showFPS = false
		removeEventHandler ( "onClientRender", root, checkInfo)
	end
end
addCommandHandler ( "stats", InfoOn)


