local hungerTimer
local healthTakeTimer

function givePlayerEatClient ( quant )
	local tmpEat = getElementData ( localPlayer, "eat" )
	if tmpEat < 100 then
		setElementData ( localPlayer, "eat", quant+tmpEat )
		eat = quant+tmpEat
		if getElementData ( localPlayer, "antiRadWear" ) == 1 then
			quant = quant*2
		end
		eat = tmpEat+quant
		if quant+tmpEat > 70 then
			setElementData ( localPlayer, "foodTimer", 2 )
		end
		if quant+tmpEat == 80 then
			exports.pipboy:addInfoBox ( "Вы голодны, ваш переносимый вес уменьшился на 10%", 3 )
			exports.inventory:checkPlayerWeight()
		elseif quant+tmpEat == 90 then
			local rplvl = getElementData ( localPlayer, "rplvl" )
			local timeTake = 50-rplvl
			local healthTake = 1
			if not isTimer ( healthTakeTimer ) then
				if rplvl > 40 then
					timeTake = 10
				end
				if rplvl < 5 then
					healthTake = 0.1
				elseif rplvl < 10 then
					healthTake = 0.5
				end
				healthTakeTimer = setTimer ( takeHealthPlayerHunger, timeTake*1000, 1, healthTake, timeTake )
			end
			exports.pipboy:addInfoBox ( "Вы голодны, вы теряете по "..healthTake.." единице здоровья раз в "..timeTake.." секунд", 3 )
			avTimeReducing = 4000
		elseif quant+tmpEat == 100 then
			exports.pipboy:addInfoBox ( "Вы голодны и получаете на 25% урона больше", 3 )
		end
	end
end

addEvent( "givePlayerEatS", true )
addEventHandler( "givePlayerEatS", getRootElement(), givePlayerEatClient )

function takeHealthPlayerHunger ( healthTake, timeTake ) 
	healthTakeTimer = nil
	if getElementData ( localPlayer, "eat" ) > 89 then
		if getElementData ( localPlayer, "health" ) > 1 and not getElementData ( localPlayer, "norLiveDead" ) then
			setElementData ( localPlayer, "health", getElementData ( localPlayer, "health" )-healthTake )
		end
		setTimer ( takeHealthPlayerHunger, timeTake*1000, 1, healthTake, timeTake ) 
	end
end 

function takePlayerEatClient ( quant )
	local tmpEat = getElementData ( localPlayer, "eat" )
	if quant > 0 then
		if tmpEat >= 90 and tmpEat-quant < 90 then
			avTimeReducing = 2000
		end
		if tmpEat >= 80 and tmpEat-quant < 80 then
			exports.inventory:checkPlayerWeight ()
		end
		if tmpEat-quant > 0 then
			eat = tmpEat-quant
			setElementData ( localPlayer, "eat", tmpEat-quant )
			changeHungerTimer ()
		else
			setElementData ( localPlayer, "eat", 0 )
			eat = 0
		end
	else
		setElementData ( localPlayer, "eat", 0 )
		eat = 0
		changeHungerTimer ()
	end
end

addEvent( "takePlayerEatS", true )
addEventHandler( "takePlayerEatS", getRootElement(), takePlayerEatClient )

function changeHungerTimer ()
	if hungerTimer then
		if getElementData ( localPlayer, "eat" ) < 70 then
			if getElementData ( localPlayer, "foodTimer" ) == 2 then
				killTimer ( hungerTimer )
				setElementData ( localPlayer, "foodTimer", 1 )
				hungerTimer = setTimer ( hungerTimerDo, 20000, 1 ) 
			end
		end
	end
end

function hungerTimerDo ()
	local foodTimer = getElementData ( localPlayer, "foodTimer" )
	local fTime = 90000
	if foodTimer == 1 then
		fTime = 90000 
	else
		fTime = 60000 
	end
	if getElementData ( localPlayer, "vip" ) then fTime = fTime*2 end
	if getElementData(localPlayer,"perk7") then
		fTime = fTime*1.5
	end
	hungerTimer = setTimer ( hungerTimerDo, fTime, 1 ) 
	if exports.quests:isQuestWindowNotVisible() and not getElementData ( localPlayer, "norLiveKilled" ) then
		givePlayerEatClient ( 1 )
	end
end

function startHungerTimer ( timeType )
	if timeType == 1 then
		hungerTimer = setTimer ( hungerTimerDo, 30000, 1 ) 
	else
		hungerTimer = setTimer ( hungerTimerDo, 20000, 1 ) 
	end
	if getElementData ( localPlayer, "eat" ) > 89 then
		local rplvl = getElementData ( localPlayer, "rplvl" )
		local timeTake = 50-rplvl
		local healthTake = 1
		if not isTimer ( healthTakeTimer ) then
			if rplvl > 40 then
				timeTake = 10
			end
			if rplvl < 5 then
				healthTake = 0.1
			elseif rplvl < 10 then
				healthTake = 0.5
			end
			exports.pipboy:addInfoBox ( "Вы голодны, вы теряете по "..healthTake.." единице здоровья раз в "..timeTake.." секунд", 3 )
			healthTakeTimer = setTimer ( takeHealthPlayerHunger, timeTake*1000, 1, healthTake, timeTake )
		end
	end
end


addEvent( "startHungerTimerS", true )
addEventHandler( "startHungerTimerS", getRootElement(), startHungerTimer )