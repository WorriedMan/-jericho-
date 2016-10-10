local items = {
	{name = "Броня Рейнджера",id=98,quant=1}, -- 1
	{name = "Силовая броня",id=99,quant=1}, -- 2
	{name = "Нитки и иголка (x10)",id=73,quant=10}, -- 3
	{name = "Ткани (x10)",id=72,quant=10}, -- 4
	{name = "Броня солдата",id=96,quant=1}, -- 5 
	{name = "9-мм пистолет",id=129,quant=1}, -- 6
	{name = "9-мм пистолет+",id=132,quant=1}, -- 7
	{name = "Мария",id=133,quant=1}, -- 8
	{name = "12,7-мм пистолет",id=138,quant=1}, -- 9
	{name = "Охотничий револьвер",id=144,quant=1}, -- 10
	{name = "10-мм пистолет",id=34,quant=1}, -- 11
	{name = "Револьвер Магнум кал. 357",id=140,quant=1}, -- 12
	{name = "10-мм пистолет-пулемёт",id=35,quant=1}, -- 13
	{name = "10-мм пистолет+",id=148,quant=1}, -- 14
	{name = "Бластер Чужих",id=143,quant=1}, -- 15
	{name = "Винтовка Гаусса",id=136,quant=1}, -- 16
}

local itemsPacks = {
--	{ид, шанс (сумма шансов должна быть равна 100)}
	{{6,15},{7,9},{8,7},{9,15},{10,10},{11,10},{12,10},{13,9},{14,7},{15,3},{16,5}},
	{{1,20},{2,15},{3,20},{4,15},{5,30}},
}

local packToID = {151, 158}

function selectRandomItem(pack)
	if exports.inventory:getItemAmountServer(client,packToID[pack]) > 0 then
		local itemsOrder = {}
		local itemsQuant = #itemsPacks[pack]
		for i = 1, 21 do
			local percent = math.random ( 1, 100 )
			local total = 0
			for c = 1, itemsQuant do
				total = total+itemsPacks[pack][c][2]
				if percent <= total then
					itemsOrder[i] = itemsPacks[pack][c][1]
					break
				end
			end
		end
		triggerClientEvent(client,"case:recieveCaseOpening",client,itemsOrder)
		setTimer( function(player) if isElement(player) then exports.inventory:givePlayerItemServerWW(player,items[itemsOrder[19]].id,items[itemsOrder[19]].quant,100,true) end end, 11000, 1, client )
	end
end
addEvent( 'case:selectRandomItem', true )
addEventHandler( 'case:selectRandomItem', getRootElement(), selectRandomItem )
