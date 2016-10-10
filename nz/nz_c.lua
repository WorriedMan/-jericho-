function getPositionZombieC ( x, y, shape )
	local pX, pY, pZ = getElementPosition ( localPlayer )
	z = getGroundPosition ( x, y, pZ+100 )
	if z then
		triggerServerEvent ( "spawnZombie", getLocalPlayer(), shape, x,y,z ) 
	end
end
	
addEvent( "getPositionZombie", true )
addEventHandler( "getPositionZombie", getRootElement(), getPositionZombieC )

function loadZombiesSkins(theResource)
	local txd = engineLoadTXD ( "media/Ghoul.txd" )
	engineImportTXD ( txd, 287 )
	local dff = engineLoadDFF ( "media/Ghoul.dff", 287 )
	engineReplaceModel ( dff, 287 )
	local txd = engineLoadTXD ( "media/mutant.txd" )
	engineImportTXD ( txd, 2 )
	local dff = engineLoadDFF ( "media/mutant.dff", 2 )
	engineReplaceModel ( dff, 2 )
end
addEventHandler("onClientResourceStart", getResourceRootElement (), loadZombiesSkins)

local fires = 0
local shotCheckAvailable = true

function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
    if hitElement then
		if getElementType ( hitElement ) == "ped" and getElementData( hitElement, "zombie" ) then
			if not getElementData ( hitElement, "target" ) then
				triggerServerEvent ("zombieWasAttacked", localPlayer, hitElement )
				--outputChatBox ( 'Зомби атакован, новая цель установлена' )
				return true
			end			
		end
    end
	if shotCheckAvailable then
		if weapon > 9 and weapon ~= 23 then
			shotCheckAvailable = false
			setTimer ( function () shotCheckAvailable = true end, 4000, 1 )
			local zombs = getElementsByType ( "ped", getRootElement(), true )
			local x,y,z = getElementPosition ( localPlayer )
			for i,zomb in ipairs(zombs) do 
			--outputChatBox( 'зомби' )
				if not getElementData ( zomb, "target" ) and not getElementData ( zomb, "zHeared" ) and getElementData(zomb,"class") == "zombie" then
					local zx,zy,zz = getElementPosition (zomb)
					if getDistanceBetweenPoints3D ( x,y,z, zx,zy,zz ) < 120 then
						triggerServerEvent ("zombieHeared", localPlayer, zomb )
						--outputChatBox ( 'Зомби услышал' )
					end
				end
			end
		end
	end
end

addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc )