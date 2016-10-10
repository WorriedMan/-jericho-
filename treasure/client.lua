local last_x, last_y, last_z

function findTreasure()
	if getElementData ( localPlayer, "perk6") then
		local x,y,z = getElementPosition(localPlayer)
		if not last_x or getDistanceBetweenPoints3D ( x,y,z, last_x,last_y,last_z ) > 10 then
			local caps = 0
			for i = 1, 20 do
				if math.random(1,100) <= 40 then
					caps = caps+1
				end
			end
			if caps > 0 then
				exports.inventory:givePlayerItemWW ( 51, caps, true )
				exports.pipboy:addInfoBox("Вы нашли бутылочные крышки! ("..tostring(caps)..")",2)
			end
		end
		last_x, last_y, last_z = x,y,z
	end
	setTimer(findTreasure,math.random(300000,900000),1)
end

setTimer(findTreasure,math.random(300000,900000),1)