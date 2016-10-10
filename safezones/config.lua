safeZones = {
	{name = "здание", coords = {0,0, 1,1}, color = {0, 0, 0, 0}, noZombie = true, noFight = true, noSafes = true },
	{name = "Новая Деревня", coords = {-935,1938, 400, 200}, color = {0, 255, 0, 30}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "Новый Вегас", coords = {-343, 2580, 230, 240}, color = {0, 0, 255, 30}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "Союз Ученых", coords = {-407, 1247, 280, 450}, color = {250,0,0,30}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "Эль Кебрадос", coords = {-1540, 2565, 35, 70}, color = {0,255,0,30}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "Мотель", coords = {-795, 2743, 50, 30}, color = {0,0,255,30}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "заправка", coords = {-1326.2998046875,2694.994140625, 10, 10}, color = {}, showName = false, noZombie = true, noFight = true },
	{name = "bos", coords = {1253.15,1567.4, 100, 120}, color = {105,116,83, 255}, noZombie = true},
	{name = "Вест Сайд", coords = {-2200.4013671875,-280.072265625, 100, 230}, color = {212,211,178,30}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "Ривет Сити", coords = {-3039.5087890625,309.75, 200, 275}, color = {105,116,83, 30}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "Кламат", coords = {2304,-17, 100, 120}, color = {105,116,83, 30}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "Роадтаун", coords = {2121,-1587, 100, 85}, color = {0,0,0, 255}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "naem", coords = {-1992.302734375,623.205078125, 130, 150}, color = {240,50,180, 30}, noZombie = true },
	{name = "Торговый Пост", coords = {1010.7412109375,1210.642578125, 130, 165}, color = {100,190,200,30}, showName = true, noZombie = true, noFight = true, noSafes = true },
	{name = "andrey", coords = {53.642,1679.76, 130, 105}, color = {190,100,130,30}, noZombie = true },
	{name = "andrey", coords = {-1698,1186, 100, 100}, color = {105,116,83, 0}, noZombie = true },
}

function getPlayerZoneConfig(player)
	local id = getElementData (player, "safezone.id" )
	if id and safeZones[id] then
		return safeZones[id]
	end
	return {}
end


function getZoneConfig(id)
	return safeZones[id] or false
end

function checkPlayerSafezone(player)
	local x,y = getElementPosition ( player )
	for i, v in ipairs ( safeZones ) do
		if v.coords and x > v.coords[1] and x < v.coords[1] + v.coords[3] and y > v.coords[2] and y < v.coords[2]+v.coords[4] then
			setElementData ( player, "safezone.id", i )
			return true
		end
	end
	setElementData ( player, "safezone.id", nil )
	return false
end