local npcSpawns = {
	-- items {ид,количество,вероятность,{качество}}
	{coords={211,-1833,10,270}, int = 2, dim = 2, rand = {2,2,2,2}, weapon = "Супердубина", health = 1000, model = 2, respawntime = 18000000, attS = 3, attD = 3, checkaddit = false, speed = "run", xp = 200, nearradius = 20, ondead = superMutantDied, items = { {41,1,100,{30,90}}, {10,4,20} } },
	{coords={245,-1828,10,0}, int = 2, dim = 2, strenght_stat = 40, health = 1000, model = 287, respawntime = 100000, attS = 3, attD = 3, checkaddit = false, speed = "sprintfast", xp = 10, items = { {55,3,30} } },
	{coords={236,-1831,10,260}, int = 2, dim = 2, strenght_stat = 40, health = 1000, model = 287, respawntime = 100000, attS = 3, attD = 3, checkaddit = false, speed = "sprintfast", xp = 10, items = { {55,3,30} } },
	{name = "Босс", coords={822,-1319.644,753.5,180}, int = 0, dim = 0, rand = {2,2,2,2}, weapon = "Миниган", accuracy_stat = 20, health = 10000, model = 2, respawntime = 18000000, attS = 35, attD = 35, checkaddit = false, speed = "run", xp = 5000, nearradius = 50, ondead = bunkerMutantDied, items = { {41,1,50,{30,90}}, {128,2,100}, {50,4,50} } },
	{name = "Хранитель склада", coords={807,-1315,748,90}, int = 0, dim = 0, weapon = "10-мм пистолет", accuracy_stat = 10, health = 2000, model = 2, respawntime = 18000000, attS = 7, attD = 7, checkaddit = false, speed = "run", xp = 200, nearradius = 20, items = { {41,1,10,{30,90}}, {10,4,20}, {50,6,50} } },
	{name = "Банк", coords={828,-1311,749,280}, int = 0, dim = 0, weapon = "9-мм пистолет-пулемёт", health = 1500, model = 2, respawntime = 18000000, attS = 13, attD = 13, checkaddit = false, speed = "run", xp = 200, nearradius = 20, items = { {10,2,20}, {50,3,50} } },
	{name = "Засада", coords={836,-1356,742,90}, int = 0, dim = 0, rand = {0,0,2,2}, weapon = "Супердубина", health = 600, model = 2, respawntime = 18000000, attS = 2, attD = 2, checkaddit = false, speed = "run", xp = 200, nearradius = 20, items = { {50,1,70} } },
	
	{name = "Гуль в конце", coords={851,-1417,733,90}, int = 0, dim = 0, rand = {1,1,1,1}, strenght_stat = 20, health = 100, model = 287, respawntime = 18000000, attS = 2, attD = 2, checkaddit = false, speed = "run", xp = 20, nearradius = 20, items = { {74,1,1} } },
	{name = "Гуль в конце", coords={854,-1416,733,180}, int = 0, dim = 0, rand = {1,1,1,1}, strenght_stat = 10, health = 200, model = 287, respawntime = 18000000, attS = 2, attD = 2, checkaddit = false, speed = "run", xp = 20, nearradius = 20, items = { {57,2,30}, {60,1,80} } },
	{name = "Гуль в конце", coords={844,-1418,733,0}, int = 0, dim = 0, strenght_stat = 5, health = 200, model = 287, respawntime = 18000000, attS = 2, attD = 2, checkaddit = false, speed = "run", xp = 20, nearradius = 20, items = { {53,1,70} } },
	{name = "Гуль в конце", coords={844,-1415,734,35}, int = 0, dim = 0,  strenght_stat = 5, health = 200, model = 287, respawntime = 18000000, attS = 2, attD = 2, checkaddit = false, speed = "run", xp = 20, nearradius = 20, items = { {5,2,10} } },

	{name = "Ждет", coords={783,-1338,735,0}, int = 0, dim = 0, weapon = "Супердубина", health = 150, model = 2, respawntime = 18000000, attS = 2, attD = 2, checkaddit = true, speed = "run", xp = 20, nearradius = 20, items = { {21,3,30} } },
	{name = "Ждет у еды", coords={792,-1346,734,-20}, int = 0, dim = 0, weapon = "Супердубина", health = 400, model = 2, respawntime = 18000000, attS = 2, attD = 2, checkaddit = true, speed = "run", xp = 20, nearradius = 20, items = { {13,1,40}, {4,2,35}, {2,2,35}, {22,2,20}, {10,5,20} } },
	{name = "Охраняет внизу", coords={821,-1368,734,130}, int = 0, dim = 0, weapon = "Супердубина", health = 800, model = 2, respawntime = 18000000, attS = 2, attD = 2, checkaddit = true, speed = "run", xp = 20, nearradius = 20, items = { } },
}

peds = {}

function createBosses ()
	for i,v in ipairs ( npcSpawns ) do
		local offX, offY = 0, 0
		if v.rand then
			offX, offY = math.random ( -v.rand[1], v.rand[2] ), math.random ( -v.rand[3], v.rand[4] )
		end
		
		local createdPed = exports.peds:createCustomPed({class = "boss", model = v.model, visioncheck = v.visioncheck, pos = Vector3(v.coords[1]+offX, v.coords[2]+offY, v.coords[3]), int = v.int, dim = v.dim, weapon = v.weapon, health = v.health, xp = v.xp, accuracy_stat = v.accuracy_stat or 0, strenght_stat = v.strenght_stat or 0})

		local nearsphere
		if v.nearradius then
			nearsphere = createColSphere ( v.coords[1]+offX, v.coords[2]+offY, v.coords[3], v.nearradius ) 
			attachElements ( nearsphere, createdPed )
		end
		local zSphere = createColSphere ( v.coords[1]+offX, v.coords[2]+offY, v.coords[3], 50 )
		
		attachElements ( zSphere, createdPed )
		setElementRotation ( createdPed, 0, 0, v.coords[4] )
		peds[createdPed] = { changes = 0, id = i, sphere = zSphere, additSphere = nearsphere }
		setElementData ( zSphere, "boss", createdPed, false )
		setElementData ( createdPed, "boss", true )
		setElementData ( createdPed, "checkaddit", v.checkaddit )
		
		setElementData ( createdPed, "attS", v.attS )
		setElementData ( createdPed, "attD", v.attD )
	end
end

function chasedBossStartAttack (boss)
	if isElement ( boss ) then
		if not isElement(getElementData ( boss, "target" )) and peds[boss] then
			setPedAnimation ( boss, false )
			if exports.npc_hlc:isHLCEnabled ( boss ) then
				exports.npc_hlc:clearNPCTasks (boss)
			else
				exports.npc_hlc:enableHLCForNPC( boss, npcSpawns[peds[boss].id].speed)
			end
			exports.npc_hlc:addNPCTask ( boss, {"killPed", source, npcSpawns[peds[boss].id].attS, npcSpawns[peds[boss].id].attD} )
			setElementData ( boss, "target", source )
			setTimer ( checkBossTarget, 1000, 1, boss )
		end
	end
end

addEvent( "chasedBossStartAttackC", true )
addEventHandler( "chasedBossStartAttackC", getRootElement(), chasedBossStartAttack )

function bossAttacked (boss)
	if isElement ( boss ) and getElementData(boss,"class") == "boss" then
		if not isElement(getElementData ( boss, "target" )) and peds[boss] then
			setPedAnimation ( boss, false )
			if exports.npc_hlc:isHLCEnabled ( boss ) then
				exports.npc_hlc:clearNPCTasks (boss)
			else
				exports.npc_hlc:enableHLCForNPC( boss, npcSpawns[peds[boss].id].speed)
			end
			exports.npc_hlc:addNPCTask ( boss, {"killPed", source, npcSpawns[peds[boss].id].attS, npcSpawns[peds[boss].id].attD} )
			setElementData ( boss, "target", source )
			setTimer ( checkBossTarget, 1000, 1, boss )
		end
	end
end

addEvent( "casePedDamage", true )
addEventHandler( "casePedDamage", getRootElement(), bossAttacked )

function checkBossTarget ( boss )
	if isElement ( boss ) then
		if not isPedDead ( boss ) then
			local target = getElementData ( boss, "target" )
			if isElement ( target ) and not getElementData ( target, "norLiveKilled" ) then
				if getElementType ( target ) == "player" then
					local pX, pY, pZ = getElementPosition ( target )
					local zX, zY, zZ = getElementPosition ( boss )
					setTimer ( checkBossTarget, 1000, 1, boss )
					if (getDistanceBetweenPoints3D(pX, pY, pZ, zX, zY, zZ) > 100 ) then
						exports.npc_hlc:clearNPCTasks (boss)
						setElementData ( boss, "target", false )
					end
				end
			else
				local zSphere = peds[boss].sphere
				if isElement ( zSphere ) then
					local zTargets = getElementsWithinColShape ( zSphere, "player" )
					local x,y,z = 9999, 9999, 9999
					local nearest = nil
					local zX, zY, zZ = getElementPosition ( boss )
					if zTargets then
						for theKey,thePlayer in ipairs(zTargets) do
							local pX, pY, pZ = getElementPosition ( thePlayer )
							if getDistanceBetweenPoints3D(pX, pY, pZ, zX, zY, zZ) < getDistanceBetweenPoints3D(x, y, z, zX, zY, zZ) and not getElementData ( localPlayer, "safezone.id" ) and not getElementData ( thePlayer, "norLiveKilled" ) then
								x,y,z = pX, pY, pZ
								nearest = thePlayer
							end
						end
					end
					if nearest then
						setElementData ( boss, "target", nearest )
						setTimer ( checkBossTarget, 1000, 1, boss )
						exports.npc_hlc:clearNPCTasks (boss)
						exports.npc_hlc:addNPCTask ( boss, {"killPed", nearest, npcSpawns[peds[boss].id].attS, npcSpawns[peds[boss].id].attD} )
					else
						setElementPosition ( boss, npcSpawns[peds[boss].id].coords[1], npcSpawns[peds[boss].id].coords[2], npcSpawns[peds[boss].id].coords[3] )
						setElementRotation ( boss, 0, 0, npcSpawns[peds[boss].id].coords[4] )
						exports.npc_hlc:disableHLCForNPC (boss)
					end
				else
					respawnBoss ( boss )
				end
			end
		end
	end
end

function respawnBoss ( boss )
	if peds[boss] then
		if isElement(boss) then
			exports.npc_hlc:disableHLCForNPC (zomb)
			destroyElement(boss)
		end	
		if isElement(peds[boss].sphere) then
			destroyElement(peds[boss].sphere)
		end	
		if isElement ( peds[boss].loot ) then
			destroyElement ( peds[boss].loot )
		end
		local v = npcSpawns[peds[boss].id]
		local i = peds[boss].id
		peds[boss] = nil
		local offX, offY = 0, 0
		if v.rand then
			offX, offY = math.random ( -v.rand[1], v.rand[2] ), math.random ( -v.rand[3], v.rand[4] )
		end
		local createdPed = exports.peds:createCustomPed({class = "boss", model = v.model, visioncheck = v.visioncheck, pos = Vector3(v.coords[1]+offX, v.coords[2]+offY, v.coords[3]), int = v.int, dim = v.dim, weapon = v.weapon, health = v.health, xp = v.xp, accuracy_stat = v.accuracy_stat or 0, strenght_stat = v.strenght_stat or 0})
		
		local nearsphere
		if v.nearradius then
			nearsphere = createColSphere ( v.coords[1]+offX, v.coords[2]+offY, v.coords[3], v.nearradius ) 
			attachElements ( nearsphere, createdPed )
		end		
		
		setElementRotation ( createdPed, 0, 0, v.coords[4] )
		peds[createdPed] = { changes = 0, id = i, sphere = zSphere, additSphere = nearsphere }

		setElementData ( createdPed, "boss", true )
		setElementData ( createdPed, "checkaddit", v.checkaddit )
	
		setElementData ( createdPed, "attS", v.attS )
		setElementData ( createdPed, "attD", v.attD )
	end
end

function bossDied(totalammo, theKiller)
	if getElementData ( source, "boss" ) and peds[source] then
		local pedset = npcSpawns[peds[source].id]
		if pedset then
			local x,y,z = getElementPosition ( source )
			if pedset.ondead then
				pedset.ondead(source)
			end
			setTimer ( respawnBoss, pedset.respawntime, 1, source )
			--exports.players:giveXPInRange ( xp, playersinzone, pedset.xp )
			peds[source].loot = exports.loot:createCustomLoot (x,y,z,pedset.dim,pedset.int,pedset.items,true)
			if theKiller then
				exports.groups_jericho:givePlayerGroupRating(theKiller,50)
			end
		end
	end
end
addEventHandler("onPedWasted", root, bossDied)

function getPlayersNearBoss ( ped )
	if peds[ped] then
		if isElement ( peds[ped].additSphere ) then
			return getElementsWithinColShape ( peds[ped].additSphere, "player" )
		end
	end
end	

createBosses()