-- Money script by Wisam

function createMoney(player)
   local x, y, z = getElementPosition(player);
   local x1, y1, x2, y2;
   x1 = (x-2)+(math.random()*4);
   y1 = (y-2)+(math.random()*4);
   x2 = (x-2)+(math.random()*4);
   y2 = (y-2)+(math.random()*4);
   local moneyAmmount = exports.inventory:getPlayerCaps(player)
   if moneyAmmount > 0 then
	   exports.inventory:removePlayerItemServer ( player, 51, moneyAmmount )
	 
	   -- We are going to create 3 pickups, zo we are just cut the ammount in half
	   moneyAmmount = math.floor(moneyAmmount/3);
	   -- Create the pickups
	   setElementData(createPickup(x1, y1, z, 3, 1212), "ammount", moneyAmmount);
	   setElementData(createPickup(x2, y1, z, 3, 1212), "ammount", moneyAmmount);
	   setElementData(createPickup(x2, y2, z, 3, 1212), "ammount", moneyAmmount);
	end
end
 
function moneyPickupHit(player)
   local money = getElementData(source, "ammount");
   if money then
		if not getElementData ( player, "norLiveKilled" ) and getElementData ( player, "inventoryAllowed" ) == 1 then
			exports.inventory:givePlayerItemServer ( player, 51, money )
			destroyElement(source);
		end
   end
end
 
addEventHandler("onPickupUse", getRootElement(), moneyPickupHit);