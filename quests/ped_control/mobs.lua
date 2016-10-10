mobsCFG = { -- x y z тип
	{ 348.3798828125,1040.5068359375,2305.3103027344, 2 },
	{ 356.703125,1039.9697265625,2305.3103027344, 2 },
	{ 349.7353515625,1056.931640625,2305.3103027344, 2 },
	{ 349.1484375,1063.5615234375,2305.3103027344, 2 },
	{ 344.1005859375,1063.28515625,2305.3103027344, 2 },
	{ 335.9638671875,1063.298828125,2305.3103027344, 2 },
	{ 330.876953125,1032.0693359375,2305.3103027344, 2 },
	{ 323.85174560547,1071.55859375,2309.2966308594, 2 },
	{ 319.34783935547,1061.677734375,2309.2966308594, 2 },
	{ 334.0439453125,1044.984375,2305.3103027344, 2 },
	{ 327.4736328125,1058.181640625,2307.866210937, 2 },
	{ 1291.9609375,-1011.1259765625,6645.7319335938, 1 },
	{ 1290.828125,-1013.27734375,6645.7319335938, 1 },
	{ 1303.5771484375,-981.8603515625,6645.7319335938, 1 },
	{ 1296.673828125,-1010.025390625,6645.7319335938, 1 }, --WhgvhEPy
}

-- типки: 1 - обычный - 2 с броней

mobs = {}

function loadServerMobs ()	
	for i = 1, #mobsCFG do		
		local createdPed = exports.zombies:createZombie( mobsCFG[i][1], mobsCFG[i][2], mobsCFG[i][3] )
		if mobsCFG[i][4] == 2 then
			setPedArmor ( createdPed, 100 )
		end
		setElementData ( createdPed, "mob", true )
		setElementData ( createdPed, "mob-x", mobsCFG[i][1])
		setElementData ( createdPed, "mob-y", mobsCFG[i][2])
		setElementData ( createdPed, "mob-z", mobsCFG[i][3])
	end							
end

--addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), function () setTimer ( loadServerMobs, 1000, 1 ) end )

function mobWasted ( attacker, weapon, bodypart )
			if getElementData ( source, "mob" ) then
				local x = getElementData ( source, "mob-x")
				local y = getElementData ( source, "mob-y")
				local z = getElementData ( source, "mob-z")
				setTimer ( respawnMob, 300000, 1, x,y,z )
			end
end

function respawnMob ( x,y,z )
	local createdPed = exports.zombies:createZombie ( x,y,z )
	if createdPed then
		setPedArmor ( createdPed, 100 )
		setElementData ( createdPed, "mob", true )
		setElementData ( createdPed, "mob-x", x)
		setElementData ( createdPed, "mob-y", y)
		setElementData ( createdPed, "mob-z", z)
	else
		outputDebugString ( "error with mob respawn 56 line" )
	end
end

addEvent("onZombieWasted",true)
addEventHandler( "onZombieWasted", getRootElement(), mobWasted)