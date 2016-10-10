tyransCFG = { -- x y z rot дальность угол обзора
	{ -179.3359375,1135.3349609375,19.7421875,88.218811035156, 35, 30 },
	{ -206.2705078125,1145.3955078125,19.7421875,268.45227050781, 35, 30 },
	{ -17.767578125,1175.7421875,19.563381195068,345.66537475586, 35, 30 },
	{ -175.869140625,1111.5205078125,19.7421875,120.84320068359, 35, 30 },
	{ -252.9228515625,1077.119140625,20.2421875,295.88555908203, 35, 30 },
	{ -260.4384765625,1150.2822265625,20.145700454712,44.404663085938, 35, 30 },
	{ -149.7412109375,1173.14453125,19.749988555908,10.154266357422, 35, 30 },
	{ -141.31640625,1173.3671875,19.749988555908,351.32891845703, 35, 30 },
	{ -252.935546875,1029.0390625,19.7421875,212.24536132813, 35, 30 },
	{ -139.376953125,983.1162109375,19.660360336304,253.60952758789, 35, 30 },
	{ -34.51953125,1141.7802734375,19.7421875,292.172119140633, 35, 30 },
	{ 22.7900390625,1177.5615234375,19.369792938232,193.78256225586, 35, 30 },
	{ 2938.7119140625,-1777.3037109375,1191.0656738281,182.10940551758, 35, 30 },
	{ 208.9697265625,-1831.3671875,10.262861251831,236.44860839844, 35, 30 },
}

tyrans = {}
tyransShapes = {}

function loadServerTyrans ()	
	for i = 1, #tyransCFG do		
		local createdPed = createPed ( 2,tyransCFG[i][1],tyransCFG[i][2],tyransCFG[i][3],tyransCFG[i][4] )
		local createdSphere = createColSphere ( tyransCFG[i][1],tyransCFG[i][2],tyransCFG[i][3], 40 )
		attachElements ( createdSphere, createdPed )
		setElementData ( createdSphere, "tyran", true )
		setPedArmor ( createdPed, 100 )
		setElementData ( createdPed, "tyran", true )
		setElementData ( createdPed, "tyr-x", tyransCFG[i][1])
		setElementData ( createdPed, "tyr-y", tyransCFG[i][2])
		setElementData ( createdPed, "tyr-z", tyransCFG[i][3])
		setElementData ( createdPed, "tyr-a", tyransCFG[i][4])
	end							
end

--addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), function () setTimer ( loadServerTyrans, 2000, 1 ) end )

function tyranWasted ( attacker, weapon, bodypart )
	if attacker then
		if getElementType ( attacker ) == "player" then 
			if getElementData ( source, "tyran" ) then
				exports.players:givePlayerXP ( attacker, 100 )
				--if weapon then
					local x = getElementData ( source, "tyr-x")
					local y = getElementData ( source, "tyr-y")
					local z = getElementData ( source, "tyr-z")
					local a = getElementData ( source, "tyr-a")
					setTimer ( respawnTyran, 900000, 1, x,y,z,a )
					if weapon ~= 34 and weapon ~= 16 then
						exports.inventory:givePlayerItemServer ( attacker, 51, 1000 )
					end
				--end
			end
		end
	end
end

function respawnTyran ( x,y,z,a )
	local createdPed = createPed ( 2, x,y,z,a )
	setPedArmor ( createdPed, 100 )
	setElementData ( createdPed, "tyran", true )
	setElementData ( createdPed, "tyr-x", x)
	setElementData ( createdPed, "tyr-y", y)
	setElementData ( createdPed, "tyr-z", z)
	setElementData ( createdPed, "tyr-a", a)
	
end

addEvent("onBotWasted",true)
addEventHandler( "onBotWasted", getRootElement(), tyranWasted)



function zShapeEnter ( thePlayer, matchingDimension )
	if matchingDimension then
		if getElementType ( thePlayer ) == "player" then
			if getElementData ( source, "tyran" ) then
				if not getElementData ( thePlayer, "norLiveKilled" ) and not getElementData ( localPlayer, "safezone.id" ) then
					local tyran = getElementAttachedTo ( source )
					if tyran then
						if not getElementData ( tyran, "tyranTarget" ) then
							triggerClientEvent ( thePlayer, "playerChasedTyran", thePlayer, tyran, source )
						end
					end
				end
			end
		end
	end
end
addEventHandler ( "onColShapeHit", root, zShapeEnter )