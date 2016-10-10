function displayLoadedRes ( res )
	for theKey,theObject in ipairs(getElementsByType ( "player" )) do
		if getElementModel ( theObject ) == 3593 or getElementModel ( theObject ) == 3594 then
			setElementFrozen ( theObject, true )
		end
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), displayLoadedRes )

setWaterColor ( 100, 200, 100 )