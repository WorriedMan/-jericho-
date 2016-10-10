function createCustomPed(config)
	if config and config.pos and config.health then
		local ped = createPed ( config.model or 0, config.pos, config.rz or 0 )
		setElementData(ped,"customped",true)
		local damage = 0
		if config.weapon then
			local stats = exports.cweap_jericho:getWeaponStats(config.weapon)
			if stats then
				giveWeapon ( ped, stats.id, 1000, true )
				setPedWeaponSlot(ped,getSlotFromWeapon ( stats.id ))
				if stats.object then
					local weapon_object = createObject ( stats.object,config.pos )
					setElementCollisionsEnabled(weapon_object, false)
					exports.bone_attach:attachElementToBone(weapon_object,ped,12,stats.object_offset.x, stats.object_offset.y, stats.object_offset.z, stats.object_offset.rx, stats.object_offset.ry, stats.object_offset.rz)
					setElementData(ped,"customped:weapon_object",weapon_object)
					if config.dim then
						setElementDimension ( weapon_object, config.dim )
					end
					if config.int then
						setElementInterior ( weapon_object, config.int )
					end
				end
				damage = stats.damage
				setElementData(ped,"customped:weapon_name",config.weapon)
				if stats.id >= 0 and stats.id <= 9 then
					damage = damage+(config.strenght_stat or 0)*3
				elseif stats.id ~= 37 then
					damage = damage+(config.accuracy_stat or 0)*2
					addEventHandler ( "onPedWeaponSwitch", ped, pedWeaponSwitch )
				end
			end
		end
		if config.accuracy_stat then
			setElementData(ped,"accuracy",config.accuracy_stat)
		end
		if config.strenght_stat then
			setElementData(ped,"strenght",config.strenght_stat)
		end
		--exports.npc_hlc:enableHLCForNPC (ped, config.speed or 'run', config.accuracy or 1)
		setElementData(ped,"class",config.class or "ped")
		setElementData ( ped, "health", config.health )
		setElementData ( ped, "customped:aggresive", true )		
		setElementData ( ped, "customped:damage", damage )
		if config.visioncheck then
			setElementData ( ped, "customped:visioncheck", true )
		end
		setElementData ( ped, "maxHealth", config.maxHealth or config.health )
		if config.dim then
			setElementDimension ( ped, config.dim )
		end
		if config.int then
			setElementInterior ( ped, config.int )
		end
		if config.xp then
			setElementData ( ped, "customped:xp", config.xp )
			if config.xp_max_lvl then
				setElementData ( ped, "customped:xp_max_lvl", config.xp_max_lvl )
			end
		end
		addEventHandler("onElementDestroy", ped, pedDestroyed )
		addEventHandler("onPedWasted", ped, pedDied )
		return ped
	end
	return false
end

function pedDied()
	if getElementData(source,"customped:xp") and not getElementData(source,"customped:killedBySafezone") then
		local x,y,z = getElementPosition ( source )
		local shape = createColSphere(x,y,z,100) 
		local players = getElementsWithinColShape(shape,"player")
		exports.players:giveXPInRange ( getElementData(source,"customped:xp"), players, getElementData(source,"customped:xp_max_lvl") )
	end
end

function pedDestroyed()
	local weapon = getElementData(source,"customped:weapon_object")
	if weapon then
		destroyElement(weapon)
	end
end

function pedWeaponSwitch ( previousWeaponID, currentWeaponID )
	local stats = exports.cweap_jericho:getWeaponStats(getElementData(source,"customped:weapon_name"))
	if previousWeaponID == stats.id then
		giveWeapon ( source, stats.id, 99999, true )
	end
end

function caseZombieDamage (zomb,attacker,loss,health)
	if isElement ( zomb ) then
		if not isPedDead ( zomb ) and ( getElementData (zomb,"health") == health or attacker == client ) then
			if ( getElementData ( zomb,'health' ) or 0 ) > loss then
				setElementData ( zomb,'health', getElementData ( zomb,'health' ) - loss )
			else
				killPed ( zomb, attacker )
			end
		end
	end
end

addEvent( "casePedDamage", true )
addEventHandler( "casePedDamage", getRootElement(), caseZombieDamage )