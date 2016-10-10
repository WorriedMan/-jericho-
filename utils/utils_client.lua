function isPlayerInBuilding()
	local x,y,z = getElementPosition ( localPlayer )
	local hit,hitX,hitY,hitZ,hitElement,normalX,normalY,normalZ,material = processLineOfSight(x,y,z,x,y,z+10,true,false,false,true,false,false,false,false,nil)
	if hit then return true end
	return false
end

local fps=99
local frames,lastsec=0,0
function checkUtils()
    local frameticks=getTickCount()
    frames=frames+1
    if frameticks-1000>lastsec then
        local prog=(frameticks-lastsec)
        lastsec=frameticks
        fps=frames/(prog/1000)
        frames=fps*((prog-1000)/1000)
    end
end

addEventHandler ( "onClientRender", root, checkUtils)
	
function getPlayerFPS()
	return math.floor(fps)
end