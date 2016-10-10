local discounts = {
	["Подарок новому жителю"] = {size = 10,},
	["Ветеран"] = {size = 4,},

}

function calculateDiscount(trader,item)
	local discount = 0
	for i, v in pairs(discounts) do
		if v.check(trader,item) then
			discount = discount+v.size
		end
	end
	return discount
end

function getAllDiscounts(trader,item)
	local sendDiscount = {}
	for i, v in pairs(discounts) do
		if v.check(trader,item) then
			sendDiscount[i] = v
		end
	end
	return sendDiscount
end

discounts["Подарок новому жителю"].check = function(trader,item)
	if trader == "nc_food" then
		if getElementData ( localPlayer, "quest_main" ) < 2 and getElementData ( localPlayer, "quest_main_st" ) < 7 then
			return true
		end
	end
	return false
end

discounts["Ветеран"].check = function(trader,item)
	if traders[trader].veteran and getElementData(localPlayer,"perk8") then
		return true
	end
	return false
end