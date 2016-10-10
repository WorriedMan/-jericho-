function showSatMenuStart ( satDim )
	setCameraMatrix ( -2682.5236, 1322.7069, 85.4296, -2682.5236, 1342.7069, 55.4296 ) 
	
	setElementDimension ( getLocalPlayer(), getElementData ( localPlayer, "playerid" ) )
	setElementPosition ( getLocalPlayer(), -328.212, 1527.84, 76.3569 )
   	toggleAllControls ( false )
end
local backgroundMusic

function beginCountdownSat ()
	zomb = {}
	zombiDied = 0
	zombiDiedPr = 0
	zombiTotalPr = 1
	setCameraMatrix ( -2682.5236, 1322.7069, 85.4296, -2682.5236, 1342.7069, 55.4296 ) 
	outputChatBox ("Подсказка: кликая на землю, ты вызываешь взрыв, который поможет уничтожить гулей!", 255,204,255 )
	startInitZombies ()
	exports.pipboy:turnOffRadio()
	backgroundMusic = playSound("jingle.mp3")
	setSoundVolume(backgroundMusic, 0.1)
	setTimer(function() if isElement(backgroundMusic) then setSoundVolume(backgroundMusic, getSoundVolume(backgroundMusic)+0.1) end end, 200, 7)
	showCursor ( true )
	expTime = 0

	addEventHandler("onClientPedWasted", getRootElement(), onWasted)
	addEventHandler ( "onClientClick", getRootElement(), addLabelOnClick )
	killedLabel = guiCreateLabel(0.0781,0.4194,0.1469,0.0528,"killed: 0",true)
	guiSetFont(killedLabel,"sa-header")
	guiSetVisible ( killedLabel, true )
end

local zomb = {}
local zombiDied = 0
local zombiDiedPr = 0
local zombiTotalPr = 1

function initSat ()
	--setCameraMatrix ( -2682.5236, 1322.7069, 85.4296, -2682.5236, 1342.7069, 55.4296 ) 
	showCursor ( true )
	expTime = 0

	addEventHandler("onClientPedWasted", getRootElement(), onWasted)
	addEventHandler ( "onClientClick", getRootElement(), addLabelOnClick )

end


function onWasted(killer, weapon, bodypart)
	if ( getElementData ( source, "shZ" )  == 1 ) then
			zombiDied = zombiDied + 1
			guiSetText ( killedLabel, "killed: " .. tostring(zombiDied) )
			--guiSetText ( killedLabel, "percent: " .. tostring(zombiDied) )
	end
end
 
-- add the event handler


function moveCameraSat ()
	local timesEx = 1
	x, y, z = getElementPosition ( getLocalPlayer () )
	--setCameraMatrix ( x, y, z+50, x, y+20, z ) 
	setTimer ( function () 
		local xO, yO, zO, lx, ly, lz = getCameraMatrix()
		local zLast = zO+10
		setCameraMatrix ( xO, yO+0.2, zO, lx,ly+0.2,lz, 0 ) 
		--setCameraMatrix ( xO, yO+0.05, z+50, lx,ly+0.1,z, 0 ) 
	end, 50, 2000 )
	setTimer ( function () 
		local xO, yO, zO, lx, ly, lz = getCameraMatrix()
		local zLast = zO+10
		setCameraMatrix ( xO, yO+0.2, zO, lx,ly+0.2,lz, 0 ) 
		--setCameraMatrix ( xO, yO+0.05, z+50, lx,ly+0.1,z, 0 ) 
		--timesEx = timesEx + 1
		--outputChatBox ( timesEx )
	end, 50, 2000 )
	setTimer ( checkCameraPosition, 5000, 1 )
end

function checkCameraPosition ()
	local xO, yO, zO, lx, ly, lz = getCameraMatrix()
	if ly > 2130 then
		calculateKilledZombies ()
	else
		setTimer ( checkCameraPosition, 5000, 1 )
	end
end

function calculateKilledZombies ()
	zombiDiedPr = math.floor(zombiDied/zombiTotalPr)
	--guiSerVisible ( percLabel, false )
	guiSetVisible ( killedLabel, false )
	removeEventHandler ( "onClientClick", getRootElement(), addLabelOnClick )
	setTimer ( comrade_sat_finish_Main_Q, 2000, 1, zombiDied, zombiDiedPr )
	setTimer(function() if isElement(backgroundMusic) then setSoundVolume(backgroundMusic, getSoundVolume(backgroundMusic)-0.1) end end, 200, 9)
	setTimer(function() if isElement(backgroundMusic) then stopSound(backgroundMusic) destroyElement(backgroundMusic) end end, 2000, 1 )
	deleteBridgeZombies ()
	--triggerServerEvent ( "askLeadersTableC", getLocalPlayer(), 1, zombiDied, zombiDiedPr ) 
end


expType = 3

function addLabelOnClick ( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
	if expTime == 0 then
		expTime = 1
		setTimer ( function () createExplosion ( worldX, worldY, worldZ, expType ) end, 500, 1 )
		setTimer ( function () expTime = 0 end, 1500, 1 )
	end
end

local totalZomb = 0

function startInitZombies ()
	initZombies(-2681.2114, 1524.8448, 61, 30)
	initZombies(-2681.5593, 1581.4780, 64, 30)
	initZombies(-2681.5270, 1664.9421, 68, 30)
	initZombies(-2681.5148, 1749.6209, 69, 30)
	initZombies(-2681.4143, 1828.3640, 68, 30)
	initZombies(-2681.3010, 1891.7553, 67, 30)
	initZombies(-2681.4030, 1960.0626, 64, 30)
	initZombies(-2681.4711, 2016.2666, 60, 30)
	initZombies(-2681.3076, 2091.2497, 56, 30)
	zombiTotalPr = math.floor(totalZomb/100)
	outputChatBox ("Информация: Всего зомби на мосту - " .. tostring(totalZomb), 0,153,51 )
	moveCameraSat ()
end

 
function deleteBridgeZombies ()
	for i, ped in ipairs (zomb) do
		destroyElement ( ped )
	end
end
 
function initZombies(baseX, baseY, baseZ, count)
	local playerDim = getElementDimension ( getLocalPlayer() )
    for i = 1, count do
        local tempX, tempY = baseX+math.random(-20,20), baseY+math.random(-20,20)
        local zcoord = getGroundPosition (tempX, tempY, baseZ)
        local ped = createPed(287, tempX, tempY, zcoord+1.5, math.random(0,360))
        if ped then
			setPedAnimation ( ped, "PED", "WALK_fatold", -1, true, true, true)
            setElementHealth(ped, 10)
			setElementDimension ( ped, playerDim )
            if not isElementInWater (ped) then
				setElementData ( ped, "shZ", 1 )
                totalZomb = totalZomb+1
            --    outputChatBox(totalZomb)
                zomb[totalZomb] = ped
            else
                destroyElement(ped)
            end
        end 
    end
end
