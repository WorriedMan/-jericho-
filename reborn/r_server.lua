function startRebornChallenge ( source )
	local x, y, z = getElementPosition ( source )
	local model = getElementModel ( source )
	local antiRadWear = getElementData ( source, "antiRadWear" )
	local interior = getElementInterior ( source )
	local dimension = getElementDimension ( source )
	if antiRadWear == 1 then
		model = getElementData ( source, "modelid" )
		setElementData ( source, "antiRadWear" )
	end
	setTimer ( spawnPlayer, 2500, 1, source, x, y, z, math.random ( 0, 360 ), model, interior, dimension )
	setTimer ( setElementAlpha, 2500, 1, source, 70 )
	--exports.loot:dropPlayerItems ( source )
	setElementData ( source, "norLiveKilled", true )
	setElementData ( source, "zombieProof", true )
	setElementData ( source, "inventoryAllowed", 0 )
	toggleControl ( source, "fire", false )
	toggleControl ( source, "jump", false )
	setElementData ( source, "died", 1 )
	toggleControl ( source, "enter_exit", false )
	toggleControl ( source, "aim_weapon", false )
	setTimer ( triggerClientEvent, 2500, 1, source, "startRebornEffects", source )
	local level = getElementData ( source, "rplvl" )*3
	setElementData ( source, "soulParts", level )
	exports.pipboy:addInfoBox("Ваша душа распалась. Соберите "..tostring(level).." ее частей для восстановления. Либо подождите 40 секунд.",6,source)
	setPedGravity ( source, 0.005 )
end

function resumeRebornChallenge ( source )
	setElementData ( source, "norLiveKilled", true )
	setElementData ( source, "zombieProof", true )
	setElementData ( source, "inventoryAllowed", 0 )
	local x, y, z = getElementData ( source, "x" ),getElementData ( source, "y" ),getElementData ( source, "z" )
	setElementPosition ( source, x, y, z+5 )
	setElementDimension ( source, 0 )
	setElementInterior ( source, 0 )
	local model = getElementModel ( source )
	--spawnPlayer ( source, x, y, z+3, math.random ( 0, 360 ), model )
	toggleControl ( source, "fire", false )
	--toggleControl ( source, "jump", false )
	setElementData ( source, "died", 1 )
	toggleControl ( source, "enter_exit", false )
	toggleControl ( source, "aim_weapon", false )
	triggerClientEvent ( source, "startRebornEffects", source )
	setElementAlpha ( source, 70 )
	local level = getElementData ( source, "rplvl" )*2
	setElementData ( source, "soulParts", level )
	exports.pipboy:addInfoBox("Ваша душа распалась. Соберите "..tostring(level).." ее частей для восстановления. Либо подождите 40 секунд.",6,source)
	setPedGravity ( source, 0.005 )
end

local spawns = {
	{ -570.0771484375,2011.7421875,60.233222961426 },
	{ 251.294921875,1843.6591796875,8.7734375 },
	{ -242.7666015625,2711.953125,62.6875 },
	{ -3007.109375,397.8818359375,9.5062503814697 },
	{ 2318.88671875,8.412109375,26.484375 },
}

function rebornPlayer ( source, collected )
	if getElementData ( source, "norLiveKilled" ) then
		local x,y,z = getElementPosition ( source )
		local nearest = 9999
		local nearesID = 1
		if getPedOccupiedVehicle ( source ) then
			removePedFromVehicle ( source )
		end
		--if not collected then
			for i = 1, #spawns do
				local dist = getDistanceBetweenPoints3D ( x,y,z, spawns[i][1], spawns[i][2], spawns[i][3] )
				if dist < nearest then
					nearest = dist
					nearesID = i
				end
			end
			setElementPosition ( source, spawns[nearesID][1], spawns[nearesID][2], spawns[nearesID][3] )
		-- else
			-- setElementPosition ( source, x,y,z )
		-- end
		setTimer ( triggerClientEvent, 1000, 1, source, "stopRebornEffects", source, getWeather() )
		setTimer ( setElementAlpha, 1000, 1, source, 255 )
		setElementData ( source, "inventoryAllowed", 1 )
		setElementData ( source, "norLiveKilled", false )
		setElementData ( source, "zombieProof", false )
		setElementData ( source, "health", getElementData ( source, 'maxHealth' ) )
		if not getElementData ( source, "overWeight" ) then
			toggleControl ( source, "jump", true )
		end
		setElementData ( source, "died", 0 )
		toggleControl ( source, "fire", true )
		--toggleControl ( source, "jump", true )
		toggleControl ( source, "enter_exit", true )
		toggleControl ( source, "aim_weapon", true )
		setPedGravity ( source, 0.008 )
	end
end

function soulsCollectedS (collected)
    rebornPlayer ( source, collected )
end
addEvent( "soulsCollected", true )
addEventHandler( "soulsCollected", getRootElement(), soulsCollectedS )