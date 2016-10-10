local bunks = {}
function loadBunkers ()
	for i,bunkerNum in ipairs(getElementsByType ( "bunker" )) do
		createObject ( 3852, tonumber(getElementData ( bunkerNum, "posX" )), tonumber(getElementData ( bunkerNum, "posY" )), tonumber(getElementData ( bunkerNum, "posZ" )), tonumber(getElementData ( bunkerNum, "rotX" )), tonumber(getElementData ( bunkerNum, "rotY" )), tonumber(getElementData ( bunkerNum, "rotZ" )))
		local colSphere = createColSphere ( tonumber(getElementData ( bunkerNum, "posX" )), tonumber(getElementData ( bunkerNum, "posY" )), tonumber(getElementData ( bunkerNum, "posZ" )), 5 )
		table.insert ( bunks, colSphere )
		setElementData ( colSphere, "ident", i, false )
		addEventHandler ( "onColShapeHit", colSphere, hitBunker )
	end	
end

addEventHandler ( "onResourceStart", getResourceRootElement(), loadBunkers )

function hitBunker ( hitElement )
	if getElementType ( hitElement ) == "player" then
		local bunknum = "bunk"..tostring(getElementData (source, "ident"))
		local checkBunks = 0
		for i = 1, 20 do
			if getElementData ( hitElement, "bunk"..tostring(i) ) == 1 then
				checkBunks = checkBunks+1
			end
		end
		if getElementData ( hitElement, bunknum ) == 0 then
			outputChatBox("Поздравляю! Ты нашел тайный бункер!", hitElement, 0,153,51)
			setElementData ( hitElement, "totalbunks", checkBunks+1 )
			outputChatBox ("Всего найдено: "..tostring(checkBunks+1).." бункеров", hitElement, 255,255,255 )
			setElementData ( hitElement, bunknum, 1 ) 
			exports.players:givePlayerXP ( hitElement, 200 )
			if checkBunks == 1 then
				exports.pipboy:addInfoBox("За каждый найденный бункер ты получаешь 700 крышек и 200 очков опыта!", 2, hitElement )
			end
			exports.inventory:givePlayerItemServer ( hitElement, 51, 700 )
			if checkBunks == 20 then
				exports.pipboy:addInfoBox("Поздравляю! Ты нашел последний тайный бункер! Награда: 4300 крышек", 3, hitElement )
				exports.inventory:givePlayerItemServer ( hitElement, 51, 4300 )
			end
		end
	end
end
