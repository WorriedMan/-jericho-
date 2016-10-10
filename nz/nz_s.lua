local totalZ = 0
local aliveZ = 0
local killedZ = 0
local wetZombies = 0
local chanceToTyran = 5
--local chanceToTyran = 100
local chanceToRobot = 10
local debugstate = false
local debughealth = 50


function math.percent (perc,repeatTime)
	if not repeatTime then repeatTime = 1 end
	local hits = 0
	for i = 1, repeatTime do
	local number = math.random(0,200)/2
		if number <= perc then
			hits = hits+1
		end
	end
	return hits
end

function checkIsTyran (shape)
	if math.percent ( chanceToTyran ) > 0 then
		setElementData ( shape, "tyran", true )
		setElementData ( shape, "maxHealth", math.random ( 200, 400 ) )
		setElementData ( shape, "mutantStrenght", math.random ( 5, 100 ) )
		setElementData ( shape, "mutantAccuracy", math.random ( 5, 30 ) )
	end
end

function checkIsRobot (shape, perc)
	if math.percent ( perc ) > 0 then
		setElementData ( shape, "robot", true )
		setElementData ( shape, "maxHealth", math.random ( 100, 250 ) )
		setElementData ( shape, "robotAccuracy", math.random ( 5, 15 ) )
	end
end


function createZombiesInWorld ()
	createZombiesLV ()
	createZombiesSF ()
	createZombiesCLS ()
	createZombiesLS_NORTH ()
	createZombiesLS_SOUTH ()
	createZombiesASF ()
	createZombiesCHILIDAD ()
	createZombiesBAY ()
	createZombiesEHL ()
	createZombiesNDES ()
	createZombiesSEHL ()
	createZombiesEDES ()
	createZombiesDesert()
end

addEventHandler ( "onResourceStart", getResourceRootElement (), createZombiesInWorld )

function createZombiesLV ()
	for i = 1, 600 do
	--for i = 1, 1500 do
		local x = math.random ( 862, 2786 )
		local y = math.random ( 691, 2875 )
		local far = createColCircle ( x, y, 150 )
		setElementData ( far, "zShapeFar", true, false )
		setZombieTypeRand ( far )
		setElementData ( far, "maxHealth", 150, false )
		setElementData ( far, "zDamage", 55, false )
		setElementData ( far, "zExp", 24, false )
		checkIsRobot(far, 10)
		totalZ = totalZ + 1
	end
end

function createZombiesSF ()
	for i = 1, 600 do
		local x = math.random ( -2909, -1656 )
		local y = math.random ( -846, 1427 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 120, false )
		setElementData ( far, "zDamage", 50, false )
		setElementData ( far, "zExp", 34, false )
		setZombieTypeRand ( far )
		checkIsTyran(far)
		totalZ = totalZ + 1
	end
end

function createZombiesDesert ()
	local ghouls = 150
	local perc = ghouls/100
	for i = 1, ghouls do
		local x = math.random ( -462, 745 )
		local y = math.random ( 593, 2777 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 15, false )
		setElementData ( far, "health", 150, false )
		setElementData ( far, "zDamage", 45, false )
		setElementData ( far, "zExp", 19, false )
		if i <= perc*60 then
			setElementData ( far, "zType", 1, false )
		else
			setElementData ( far, "zType", 4, false )
			setElementData ( far, "zombieRad", true, false )
		end
		checkIsRobot(far, 3)
		totalZ = totalZ + 1
	end
end

function createZombiesCLS ()
	local ghouls = 50
	local perc = ghouls/100
	for i = 1, ghouls do
		local x = math.random ( 491, 2767 )
		local y = math.random ( 150, 517 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 130, false )
		setElementData ( far, "zDamage", 60, false )
		setElementData ( far, "zExp", 39, false )
		if i <= perc*60 then
			setElementData ( far, "zType", 1, false )
		else
			setElementData ( far, "zType", 4, false )
			setElementData ( far, "zombieRad", true, false )
		end
		checkIsRobot(far, 20)
		totalZ = totalZ + 1
	end
end

function createZombiesLS_NORTH ()
	local ghouls = 600
	local perc = ghouls/100
	for i = 1, ghouls do
		local x = math.random ( 154, 2825 )
		local y = math.random ( -1975, 88 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 170, false )
		setElementData ( far, "zDamage", 65, false )
		if i <= perc*60 then
			setElementData ( far, "zType", 4, false )
			setElementData ( far, "zombieRad", true, false )
		else
			setElementData ( far, "zType", 2, false )
			setElementData ( far, "zombieBoom", true, false )
		end
		checkIsRobot(far, 20)
		totalZ = totalZ + 1
	end
end

function createZombiesLS_SOUTH ()
	local ghouls = 150
	local perc = ghouls/100
	for i = 1, ghouls do
		local x = math.random ( 986, 2823 )
		local y = math.random ( -2691, -1882 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 200, false )
		setElementData ( far, "zDamage", 130, false )
		checkIsTyran (far)
		if i <= perc*20 then
			setElementData ( far, "zType", 4, false )
			setElementData ( far, "zombieRad", true, false )
		elseif i <= perc*60 then
			setElementData ( far, "zType", 2, false )
			setElementData ( far, "zombieBoom", true, false )
		else
			setElementData ( far, "zType", 3, false )
			setElementData ( far, "zombieFast", true, false )
		end
		totalZ = totalZ + 1
	end
end

function createZombiesCHILIDAD ()
	local ghouls = 300
	local perc = ghouls/100
	for i = 1, ghouls do
		local x = math.random ( -2824, -167 )
		local y = math.random ( -2815, -868 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 50, false )
		setElementData ( far, "zDamage", 500, false )
		checkIsTyran (far)
		if i <= perc*20 then
			setElementData ( far, "zType", 4, false )
			setElementData ( far, "zombieRad", true, false )
		elseif i <= perc*60 then
			setElementData ( far, "zType", 2, false )
			setElementData ( far, "zombieBoom", true, false )
		else
			setElementData ( far, "zType", 3, false )
			setElementData ( far, "zombieFast", true, false )
		end
		totalZ = totalZ + 1
	end
end

function createZombiesASF ()
	local ghouls = 150
	local perc = ghouls/100
	for i = 1, ghouls do
		local x = math.random ( -1770, -42 )
		local y = math.random ( -791, -205 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 120, false )
		setElementData ( far, "zDamage", 60, false )
		setElementData ( far, "zExp", 34, false )
		setZombieTypeRand ( far )
		checkIsRobot (far,30)
		totalZ = totalZ + 1
	end
end

function createZombiesBAY ()
	local ghouls = 150
	local perc = ghouls/100
	for i = 1, ghouls do
		local x = math.random ( -2828, -2215 )
		local y = math.random ( 2234, 2633 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 700, false )
		setElementData ( far, "zDamage", 60, false )
		if i <= perc*20 then
			setElementData ( far, "zType", 4, false )
			setElementData ( far, "zombieRad", true, false )
		elseif i <= perc*60 then
			setElementData ( far, "zType", 2, false )
			setElementData ( far, "zombieBoom", true, false )
		else
			setElementData ( far, "zType", 3, false )
			setElementData ( far, "zombieFast", true, false )
		end
		checkIsTyran (far)
		totalZ = totalZ + 1
	end
end

function createZombiesEHL ()
	for i = 1, 30 do
		local x = math.random ( -2012, -1235 )
		local y = math.random ( 2204, 2819 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 30, false )
		setElementData ( far, "zDamage", 5, false )
		setElementData ( far, "zType", 1, false )
		setElementData ( far, "zExp", 9, false )
		totalZ = totalZ + 1
	end
end

function createZombiesNDES ()
	local ghouls = 30
	local perc = ghouls/100
	for i = 1, ghouls do
		local x = math.random ( -871, -460 )
		local y = math.random ( 2300, 2880 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "maxHealth", 40, false )
		setElementData ( far, "zDamage", 10, false )
		setElementData ( far, "zExp", 9, false )
		if i <= perc*60 then
			setElementData ( far, "zType", 1, false )
		else
			setElementData ( far, "zType", 4, false )
			setElementData ( far, "zombieRad", true, false )
		end
		setElementData ( far, "zShapeFar", true, false )
		checkIsRobot(far, 5)
		totalZ = totalZ + 1
	end
end

function createZombiesSEHL ()
	for i = 1, 30 do
		local x = math.random ( -1767, -1003 )
		local y = math.random ( 1683, 2217 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 30, false )
		setElementData ( far, "zDamage", 5, false )
		setElementData ( far, "zType", 1, false )
		setElementData ( far, "zExp", 9, false )
		totalZ = totalZ + 1
	end
end

local booms = 0
function setZombieTypeRand ( shape, normal, radiat, fast, boom )
	if shape then
		if not normal then normal = 100 end
		if not radiat then radiat = 0 end
		if not fast then fast = 0 end
		if not boom then boom = 0 end
		local kind = math.random ( 0, 100 )
		if kind < 50 then
			setElementData ( shape, "zType", 1, false )
		elseif kind > 49 and kind <= 65 then
			setElementData ( shape, "zType", 2, false )
			setElementData ( shape, "zombieBoom", true, false )
			booms = booms+1
		elseif kind > 65 and kind <= 75 then
		--elseif kind > 65 and kind <= 66 then
			setElementData ( shape, "zType", 3, false )
			setElementData ( shape, "zombieFast", true, false )
		else
			setElementData ( shape, "zType", 4, false )
			setElementData ( shape, "zombieRad", true, false )
		end
	end 
end

-- -1022, 671, -1022, 1618, -2012, 1683, -2012, 2819, -1003, 2217, -685, 1618, -685, 671
-- -1767, 1683

-- -1003, 2217

function createZombiesEDES ()
	local ghouls = 70
	local perc = ghouls/100
	for i = 1, ghouls do
		local x = math.random ( -1022, -685 )
		local y = math.random ( 671, 1618 )
		local far = createColCircle ( x, y, 100 )
		setElementData ( far, "zShapeFar", true, false )
		setElementData ( far, "maxHealth", 30, false )
		setElementData ( far, "zDamage", 10, false )
		setElementData ( far, "zExp", 14, false )
		if i <= perc*60 then
			setElementData ( far, "zType", 1, false )
		else
			setElementData ( far, "zType", 4, false )
			setElementData ( far, "zombieRad", true, false )
		end
		totalZ = totalZ + 1
	end
	--outputChatBox ( 'Всего зомби: '..totalZ )
end

function zShapeEnter ( thePlayer, matchingDimension )
	if matchingDimension then
		if getElementType ( thePlayer ) == "player" then
			if getElementData ( source, "zShapeFar" ) then
				if not getElementData ( thePlayer, "safezone.id" ) and not getElementData ( thePlayer, "inBuild" )then
					local x, y, z = getElementPosition ( source )
					if not getElementData ( source, "zSpawned" ) then
						triggerClientEvent ( thePlayer, "getPositionZombie", thePlayer, x, y, source )
					end
				end
			end
		end
	end
end
addEventHandler ( "onColShapeHit", root, zShapeEnter )

function chasedStartAttack (zomb, attS, attF)
	if isElement ( zomb ) then
		if not getElementData ( zomb, "target" ) then
			if getElementData ( zomb, "zHeared" ) then
				setElementData ( zomb, "zHeared", false ) 
			end
			setPedAnimation ( zomb )
			if exports.npc_hlc:isHLCEnabled ( zomb ) then
				exports.npc_hlc:clearNPCTasks (zomb)
			else
				exports.npc_hlc:enableHLCForNPC( zomb, "run")
			end
			if getElementData ( zomb, "tyran" ) or getElementData ( zomb, "robot" ) then
				giveWeapon ( zomb, getElementData ( zomb, "weapon" ), 1000, true )
			end
			exports.npc_hlc:addNPCTask ( zomb, {"killPed", source, getElementData ( zomb, 'attS' ), getElementData ( zomb, 'attF' )} )
			setElementData ( zomb, "target", source )
			setTimer ( checkZombieTarget, 1000, 1, zomb )
			--outputChatBox ( 'Цель установлена' )
		end
	end
end

addEvent( "chasedStartAttackC", true )
addEventHandler( "chasedStartAttackC", getRootElement(), chasedStartAttack )

function spawnTyran ( shape, x,y,z, source ) 
	if isElement ( shape ) and isElement ( source ) then
		local weapon = "Супердубина"
		if math.random ( 0, 10 ) < 5 then
			weapon = "Штурмовая винтовка"
		end
		local zomb = exports.peds:createCustomPed({class = "mutant", model = 2, pos = Vector3(x,y,z+1), visioncheck = true, rz = math.random(0,360), weapon = weapon, health = getElementData ( shape, "maxHealth" ), xp = 220, xp_max_lvl = getElementData ( shape, "zExp" ), accuracy_stat = getElementData ( shape, "mutantAccuracy" ), strenght_stat = getElementData ( shape, "mutantStrenght" )})
		if weapon == "Супердубина" then
			setElementData ( zomb, "attS", 3, false )
			setElementData ( zomb, "attF", 3, false )
		else
			setElementData ( zomb, "attS", 30, false )
			setElementData ( zomb, "attF", 20, false )
		end
		setElementData ( shape, "zombie", zomb )
		local zSphere = createColSphere ( x, y, z, 150 ) 
		attachElements ( zSphere, zomb )
		setElementData ( zomb, "zombieShape", zSphere, false )
		setElementData ( zSphere, "zombieShape", true, false )
		setElementData ( zomb, "spawnShape", shape, false )
		addEventHandler("onPedWasted", zomb, zombieDied)
		if debugstate then
			setElementData ( zomb, "maxHealth", debughealth )
			setElementData ( zomb, "health", debughealth )
		end
		exports.npc_hlc:enableHLCForNPC( zomb, "run")
		setElementData ( shape, "zSpawned", true )
		wentZombieToWalk ( zomb )
	end
end

function spawnRobot ( shape, x,y,z, source ) 
	if isElement ( shape ) and isElement ( source ) then
		local zomb = exports.peds:createCustomPed({class = "robot", model = 232, pos = Vector3(x,y,z+1), visioncheck = true, rz = math.random(0,360), weapon = "9-мм пистолет-пулемёт", health = getElementData ( shape, "maxHealth" ), xp = 100, xp_max_lvl = getElementData ( shape, "zExp" ), accuracy_stat = getElementData ( shape, "robotAccuracy" )})
		setElementData ( shape, "zombie", zomb )
		
		
		local zSphere = createColSphere ( x, y, z, 150 ) 
		attachElements ( zSphere, zomb )
			setElementData ( zomb, "strenght", 0 )
		setElementData ( zomb, "zombieShape", zSphere, false )
		setElementData ( zSphere, "zombieShape", true, false )
		setElementData ( zomb, "spawnShape", shape, false )
		setElementData ( zomb, "zExp", getElementData ( shape, "zExp" ), false )
		addEventHandler("onPedWasted", zomb, zombieDied)
		if debugstate then
			setElementData ( zomb, "maxHealth", debughealth )
			setElementData ( zomb, "health", debughealth )
		end
		setElementData ( zomb, "attS", 40, false )
		setElementData ( zomb, "attF", 30, false )
		exports.npc_hlc:enableHLCForNPC( zomb, "walk")
		setElementData ( shape, "zSpawned", true, false )
		wentZombieToWalk ( zomb )
	end
end

function spawnZombieS ( shape, x, y, z )
	if not getElementData ( shape, "zSpawned" ) then
		if getElementData ( shape, "tyran" ) then
			spawnTyran ( shape, x,y,z, source ) -- Спавн Супермутантов
		elseif getElementData ( shape, "robot" ) then
			spawnRobot ( shape, x,y,z, source ) -- Спавн Роботов
		else
			local zomb = exports.peds:createCustomPed({class = "zombie", model = 287, pos = Vector3(x,y,z+1), visioncheck = true, rz = math.random(0,360), health = getElementData ( shape, "maxHealth" ), xp = 20, xp_max_lvl = getElementData ( shape, "zExp" ), strenght_stat = getElementData ( shape, "zombieStrenght" )})
			setElementData ( shape, "zombie", zomb )
			local zSphere = createColSphere ( x, y, z, 150 ) 
			attachElements ( zSphere, zomb )
			setElementData ( zomb, "zombieShape", zSphere, false )
			setElementData ( zSphere, "zombieShape", true, false )
			setElementData ( zomb, "spawnShape", shape, false )
			setElementData ( zomb, "zDamage", getElementData ( shape, "zDamage" ) )
			setElementData ( zomb, "zExp", getElementData ( shape, "zExp" ), false)
			setElementData ( zomb, "attS", 3, false )
			setElementData ( zomb, "attF", 3, false )
			setElementData ( zomb, "strenght", 0 )
			setElementData ( zomb, "accuracy", 0 )
			
			addEventHandler("onPedWasted", zomb, zombieDied)
			exports.npc_hlc:enableHLCForNPC( zomb, "run")
			if getElementData ( shape, "zombieFast" ) then 
				exports.npc_hlc:setNPCWalkSpeed (zomb, "sprintfast") 
				setElementData ( zomb, "zombieFast", true )
				setElementData ( zomb, "zDamage", getElementData ( shape, "zDamage" )*2.5 )
				setElementData ( zomb, "maxHealth", 600 )
				setElementData ( zomb, "health", 600 )
				setElementModel ( zomb, 237 )
				setElementData ( zomb, "customped:xp", 300 )
			end
			if getElementData ( shape, "zombieRad" ) then 
				local radzone = createColSphere (x,y,z,3 )
				setElementData ( radzone, "radZone", true )
				setElementData ( radzone, "level", math.random(1,4) )
				attachElements ( radzone, zomb )
				setElementData ( zomb, "zombieRad", true )
				setElementData ( zomb, "zRadZone", radzone )
				local mark = createMarker ( x, y, z+1.5, "corona", 0.5 )
				attachElements ( mark, zomb )	
			end
			setElementData ( shape, "zSpawned", true, false )
			aliveZ = aliveZ + 1
			wentZombieToWalk ( zomb )
		end
	end
end

addEvent( "spawnZombie", true )
addEventHandler( "spawnZombie", getRootElement(), spawnZombieS )

function checkZombiesStats ( playerSource )
	outputChatBox ( 'Всего зомби: '..totalZ, playerSource )
	outputChatBox ( 'Живых: '..aliveZ, playerSource )
	outputChatBox ( 'Убито: '..killedZ, playerSource )
	outputChatBox ( 'В воде: '..wetZombies, playerSource )
end

addCommandHandler ( "zstats", checkZombiesStats )

function createTempMob(kind,coords)

end

function wentZombieToWalk ( zomb )
	if isElement ( zomb ) then
		if not isPedDead ( zomb ) then
			if checkPlayersInView ( zomb ) then
				if not getElementData ( zomb, "target" ) then
					local rdmangle = math.random( 1, 359 )
					setPedRotation( zomb, rdmangle )
					if getElementData ( zomb, "calss" ) == "mutant" then
						setPedAnimation ( zomb, "FAT", "FatWalk", -1, true, true, true)
					else
						setPedAnimation ( zomb, "PED", "WALK_fatold", -1, true, true, true)
					end
				end
				setTimer ( wentZombieToWalk, 7000, 1, zomb )
			else
				if getElementData ( zomb, "zRadZone" ) then destroyElement ( getElementData ( zomb, "zRadZone" ) ) end
				exports.npc_hlc:clearNPCTasks (zomb)
				exports.npc_hlc:disableHLCForNPC (zomb)
				if isElement ( getElementData ( zomb, "zombieShape" ) ) then destroyElement ( getElementData ( zomb, "zombieShape" ) ) end
				setElementData ( getElementData ( zomb, "spawnShape" ), "zSpawned", false, false )
				local attaches = getAttachedElements ( zomb )
				if attaches then
					for ElementKey, ElementValue in ipairs ( attaches ) do
						if isElement ( ElementValue ) then
							if not getElementData ( ElementValue, "zRadZone" ) then
								destroyElement ( ElementValue )
							end
						end
					end
				end
				destroyElement ( zomb )
			end
		end
	end
end

function checkPlayersInView ( zomb ) 
	local shapeFar = getElementData ( zomb, "zombieShape" )
	if isElement(shapeFar) then
		if #getElementsWithinColShape ( shapeFar, 'player' ) == 0 then
			return false 
		else return true end
	end
end

function checkZombieTarget ( zomb )
	if isElement ( zomb ) then
		if not isPedDead ( zomb ) then
			local target = getElementData ( zomb, "target" )
			if isElement ( target ) and not exports.safezones:getPlayerZoneConfig(target).noZombie and not getElementData ( target, "norLiveKilled" ) then
				if getElementType ( target ) == "player" then
					local pX, pY, pZ = getElementPosition ( target )
					local zX, zY, zZ = getElementPosition ( zomb )
					setTimer ( checkZombieTarget, 1000, 1, zomb )
					if (getDistanceBetweenPoints3D(pX, pY, pZ, zX, zY, zZ) > 120 ) then
						exports.npc_hlc:clearNPCTasks (zomb)
						setElementData ( zomb, "target", false )
					end
				end
			end
		end
	end
end

function zombieKilledPlayer (task)
	if task[1] == "walkToPos" then
		if getElementData ( source, "zHeared" ) then
			setElementData ( source, "zHeared", false )
		end
	end
	if getElementData ( source, "target" ) then
		setElementData ( source, "target", false )
	end
end

addEventHandler ( "npc_hlc:onNPCTaskDone", getResourceRootElement(), zombieKilledPlayer )

addEvent( "headboom", true )
function Zheadhit ( ped,attacker, weapon, bodypart)
	if (getElementData (ped, "zombie") == true) then
		if not isPedDead ( ped ) then
			killPed ( ped, attacker, weapon, bodypart )
			setPedHeadless  ( ped, true )
		end
	end
end
addEventHandler( "headboom", getRootElement(), Zheadhit )

function destroyZombieRadZone (radzone)
	if isElement ( radzone ) then
		destroyElement ( radzone )
	end
end

function createDeadZombShape ( ped, who )
	if isElement ( ped ) then
		local x,y,z = getElementPosition ( ped )
		local createdShape = createColSphere ( x, y,z, 2 )
		setElementData ( createdShape, "deadBandit", true )
		setElementData ( createdShape, "action", true )
		setElementData ( createdShape, "type", 6 )
		exports.loot:putItemsInCustomLoot ( createdShape, math.random ( 3, 5 ), who )
		setElementData ( ped, 'deadBanditShape', createdShape )
		setElementData ( ped, 'deadBanditPed', true )
	end
end

function zombieDied(totalammo, theKiller)
	if getElementData ( source, "zRadZone" ) then 
		if isElement ( getElementData ( source, "zRadZone" ) ) then
			local playerInRad = getElementsWithinColShape ( getElementData ( source, "zRadZone" ), "player" )
			for theKey,thePlayer in ipairs(playerInRad) do 
				triggerEvent ( "onColShapeLeave", getElementData ( source, "zRadZone" ), thePlayer, true )
			end
			setTimer ( destroyZombieRadZone, 3600000, 1, getElementData ( source, "zRadZone" ) ) 
		end				
	end
	local spawnShape = getElementData ( source, "spawnShape" )
	local attaches = getAttachedElements ( source )
	if attaches then
		for ElementKey, ElementValue in ipairs ( attaches ) do
			if not getElementData ( ElementValue, "zRadZone" ) then
				destroyElement ( ElementValue )
			end
		end
	end
	setTimer ( setElementData, 300000, 1, spawnShape, "zSpawned", false, false )
	if getElementData(source,"customped:killedBySafezone") then return end
	local x,y,z = getElementPosition ( source )
	if getElementData ( source, "class" ) == "mutant" then
		createDeadZombShape ( source, 1 )
		setTimer (	function ( source )
			if isElement ( source ) then
				if isElement ( getElementData ( source, "deadBanditShape" ) ) then
					destroyElement ( getElementData ( source, "deadBanditShape" ) )
				end
				destroyElement ( source )
			end
		end, 300000, 1, source )
	elseif getElementData ( source, "class" ) == "robot" then
		createDeadZombShape ( source, 2 )
		setTimer (	function ( source )
			if isElement ( source ) then
				if isElement ( getElementData ( source, "deadBanditShape" ) ) then
					destroyElement ( getElementData ( source, "deadBanditShape" ) )
				end
				destroyElement ( source )
			end
		end, 300000, 1, source )
	else
		setTimer (	function ( source )
			if isElement ( source ) then
				destroyElement ( source )
			end
		end, 10000, 1, source )
		local zombieLoot = createColSphere ( x, y, z, 2 )
		setElementData ( zombieLoot, "level", 0 )
		setElementData ( zombieLoot, "loot", true )
		setElementData ( zombieLoot, "useLevel", getElementData ( source, "zExp" ) )
		setElementData ( zombieLoot, "zloot", true )
		setElementData ( zombieLoot, "action", true )
		setElementData ( zombieLoot, "type", 6 )
		setElementData ( zombieLoot, "ident", 0 )
		setTimer ( function ()
			if isElement(zombieLoot) then
				destroyElement ( zombieLoot )
			end
		end,60000, 1 )
	end
	if theKiller then
		if getElementType ( theKiller ) == 'player' then
			local level = getElementData ( source, "zExp" )
			if level then
				if getElementData ( theKiller, "rplvl" ) <= level then
					giveZombieKillerReward ( theKiller, source )
				end
			else
				giveZombieKillerReward ( theKiller, source )
			end
		end
	end
end

function giveZombieKillerReward ( player, zomb )
	if not getElementData ( zomb, "arenaZombie" ) then
		exports.inventory:givePlayerItemServer ( player, 51, 7 )
		local x,y,z = getElementPosition ( zomb )
		if getElementModel ( zomb ) == 237 then
			exports.inventory:givePlayerItemServer ( player, 51, 70 )
			return true
		elseif getElementModel ( zomb ) == 232 then
			exports.inventory:givePlayerItemServer ( player, 51, 40 )
			return true
		elseif getElementModel ( zomb ) == 2 then
			exports.inventory:givePlayerItemServer ( player, 51, 100 )
			return true
		end
		if getElementData ( zomb, "tyran" ) then
			exports.groups_jericho:givePlayerGroupRating(player,10)
		elseif getElementData ( zomb, "robot" ) then
			exports.groups_jericho:givePlayerGroupRating(player,5)
		else
			exports.groups_jericho:givePlayerGroupRating(player,1)
		end
		if getElementData ( zomb, "zombieFast" ) then exports.inventory:givePlayerItemServer ( player, 110, math.random ( 1, 5 ) ) end
		if getElementData ( zomb, "zombieBoom" ) then exports.inventory:givePlayerItemServer ( player, 110, math.random ( 1, 3 ) ) end
		if getElementData ( player, "ncType" ) == 2 then
			if getElementData ( player, "ncTarg" ) > 1 then
				setElementData ( player, "ncTarg", getElementData ( player, "ncTarg" )-1 )
				exports.pipboy:addInfoBox ( "Осталось убить гулей: "..tostring(getElementData ( player, "ncTarg" )), 3, player )
			elseif getElementData ( player, "ncTarg" ) == 1 then
				exports.pipboy:addInfoBox ( "Гули убиты, возвращайтесь к Букеру ДеВитту", 3, player )
				setElementData ( player, "ncTarg", 0 )
			end
		end
		setElementData ( player, "Zombie kills", (getElementData ( player, "Zombie kills" ) or 0)+1  )
	end
end

function zombieWasAttackedS ( zomb )
	if isElement ( zomb ) then
		if not isPedDead ( zomb ) then
			setPedAnimation ( zomb )
			exports.npc_hlc:clearNPCTasks (zomb)
			exports.npc_hlc:addNPCTask ( zomb, {"killPed", source, getElementData ( zomb, "attS" ), getElementData ( zomb, "attF" )} )
			setElementData ( zomb, "target", source )
			setTimer ( checkZombieTarget, 1000, 1, zomb )
		end
	end
end

addEvent( "zombieWasAttacked", true )
addEventHandler( "zombieWasAttacked", getRootElement(), zombieWasAttackedS )

function zombieHearedS ( zomb )
	if isElement ( zomb ) then
		if not isPedDead ( zomb ) then
			if not getElementData ( zomb, "target" ) and not getElementData ( source, "zHeared" ) then
				setPedAnimation ( zomb )
				exports.npc_hlc:clearNPCTasks (zomb)
				setElementData ( zomb, "zHeared", source )
				local x,y,z = getElementPosition ( source )
				exports.npc_hlc:addNPCTask ( zomb, {"walkToPos", x, y, z, 2})
			end
		end
	end
end

addEvent( "zombieHeared", true )
addEventHandler( "zombieHeared", getRootElement(), zombieHearedS )