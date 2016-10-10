local localPlayer = getLocalPlayer ()
local screenX,screenY = guiGetScreenSize()

function calculatePedSightC ( myped )
	local px, py, pz = getElementPosition( myped )
	local x, y, z = getPositionInfrontOfElement(myped, 0.5)
    if ( isLineOfSightClear( px, py, pz, x, y, z, true, true, true, true, false, false, false, myped ) == true ) then
		--outputChatBox ( "Открыто" )
		triggerServerEvent ( "pedSightCalculated", getLocalPlayer(), 1, myped ) 
	else
	--	outputChatBox ( "Закрыто" )
		triggerServerEvent ( "pedSightCalculated", getLocalPlayer(), 0, myped ) 
    end
end
addEvent( "calculatePedSight", true )
addEventHandler( "calculatePedSight", getRootElement(), calculatePedSightC )


function getPositionInfrontOfElement(element, meters)
    if not element or not isElement(element) then
        return false
    end
    if not meters then
        meters = 3
    end
    local posX, posY, posZ = getElementPosition(element)
    local _, _, rotation = getElementRotation(element)
    posX = posX - math.sin(math.rad(rotation)) * meters
    posY = posY + math.cos(math.rad(rotation)) * meters
    return posX, posY, posZ
end

buttLabelShowed = 0

actions = {
	"разговора",
	"покупки",
	"входа",
	"выхода", 
	"открытия",
	"поиска",
	"сбора грибов",
	"создания вещей"
}

function showActLabel  ( id )
	if buttLabel and buttImage then
		if buttLabelShowed == 0 then
			guiSetVisible ( buttLabel, true )
			guiSetVisible ( buttImage, true )
			guiSetText ( buttLabel, "нажмите для "..actions[id] )
			buttLabelShowed = 1
		end
	else
		buttLabel = guiCreateLabel(screenX/2, 28, screenX/2, 30, "нажмите для "..actions[id], false)
		guiSetFont(buttLabel, "default-bold-small")
		
		buttImage = guiCreateStaticImage(screenX/2-64, 10, 70, 56, ":quests/images/butt.png", false)
		buttLabelShowed = 1
	end
end

function unShowActLabel ( )
	if buttLabel and buttImage then
		if buttLabelShowed == 1 then
			guiSetVisible ( buttLabel, false )
			guiSetVisible ( buttImage, false )
			buttLabelShowed = 0
		end
	end
end

addEvent( "unShowActLabelS", true )
addEventHandler( "unShowActLabelS", getRootElement(), unShowActLabel )

function actColShapeHit ( hitElement, matchingDimension)
	if hitElement == localPlayer then
		if matchingDimension then 
			if getElementData ( source, "action" ) then
				if getElementData ( source, "type" ) == 1 then
					setElementData ( localPlayer, "cshpNPC_p", getElementData ( source, "place" ) )
					setElementData ( localPlayer, "cshpNPC_l", getElementData ( source, "live" ) )
					setElementData ( localPlayer, "cshpNPC_id", getElementData ( source, "id" ) )
				end
				if getElementData(source,"zloot") and not getElementData(localPlayer,"perk3") then
					return
				end
				showActLabel ( getElementData ( source, "type" ) )
			end
		end
	end
end

 addEventHandler ( "onClientColShapeHit", getRootElement(), actColShapeHit )
 
 function actColShapeLeave( theElement, matchingDimension )
    if theElement == localPlayer then
		if getElementData ( source, "action" ) then
			if getElementData ( source, "type" ) == 1 then
				setElementData ( localPlayer, "cshpNPC_p", nil )
				setElementData ( localPlayer, "cshpNPC_l", nil )
				setElementData ( localPlayer, "cshpNPC_id", nil )
			end
			unShowActLabel ()
		end
    end
end
addEventHandler("onClientColShapeLeave",getRootElement(),actColShapeLeave)

addEventHandler( "onClientElementStreamIn", getRootElement( ),
    function ( )
        if getElementType( source ) == "ped" then
            if getElementData ( source, "npc-ped" ) then
			--	if getElementData ( localPlayer, "online" ) == 0 then
					triggerServerEvent ( "giveStreamedPedWeaponC", source ) 
					if getElementData ( source, "pedAnimBlock" ) then
						setPedAnimation ( source, getElementData ( source, "pedAnimBlock" ), getElementData ( source, "pedAnimName" ), -1, getElementData ( source, "pedAnimRepeat"), false, false, true )
					end
			--	end
			end
        end
    end
);

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
    	txd = engineLoadTXD ( "skin/popeye.txd" )
		engineImportTXD ( txd, 1 )
		dff = engineLoadDFF ( "skin/popeye.dff", 1 )
		engineReplaceModel ( dff, 1 )
		txd = engineLoadTXD ( "skin/swat.txd" )
		engineImportTXD ( txd, 7 )
		dff = engineLoadDFF ( "skin/swat.dff", 7 )
		engineReplaceModel ( dff, 7 )
		txd = engineLoadTXD ( "skin/samara.txd" )
		engineImportTXD ( txd, 14 )
		dff = engineLoadDFF ( "skin/samara.dff", 14 )
		engineReplaceModel ( dff, 14 )
		txd = engineLoadTXD ( "skin/chuck.txd" )
		engineImportTXD ( txd, 251 )
		dff = engineLoadDFF ( "skin/chuck.dff", 251 )
		engineReplaceModel ( dff, 251 )
		
				txd = engineLoadTXD ( "skin/Frank_Metrix.txd" )
		engineImportTXD ( txd, 263 )
		dff = engineLoadDFF ( "skin/Frank_Metrix.dff", 263 )
		engineReplaceModel ( dff, 263 )
		
				txd = engineLoadTXD ( "skin/Kestrel.txd" )
		engineImportTXD ( txd, 243 )
		dff = engineLoadDFF ( "skin/Kestrel.dff", 243 )
		engineReplaceModel ( dff, 243 )
		
		txd = engineLoadTXD ( "skin/vgwwelcome.txd" )
		engineImportTXD ( txd, 7415 )
		dff = engineLoadDFF ( "skin/vgswlcmsign1.dff", 7415 )
		engineReplaceModel ( dff, 7415 )
		
		txd = engineLoadTXD ( "skin/wmyammo.txd" )
		engineImportTXD ( txd, 280 )
		dff = engineLoadDFF ( "skin/wmyammo.dff", 280 )
		engineReplaceModel ( dff, 280 )
		
	end
)

deathExplodeAvail = true

--addEventHandler("onClientVehicleCollision", root,
--    function(collider,force, bodyPart, x, y, z, nx, ny, nz)
--         if ( source == getPedOccupiedVehicle(localPlayer) ) then
--			if isElement ( collider ) then
--				if getElementType ( collider ) == 'ped' then
--					if getElementModel ( collider ) == 237 or getElementData ( collider, 'zombieRad' ) then
--						if deathExplodeAvail then
--							deathExplodeAvail = false
--							setTimer ( function () deathExplodeAvail = true end, 5000, 1 )
--							triggerServerEvent ( 'explodeVehicleDeath', collider )
--						end
--					end
--				end
--			end
 --        end
  --  end
--)