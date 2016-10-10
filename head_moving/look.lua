function updateFace ()
for k, player in ipairs( getElementsByType( "player" ) ) do
local width, height = guiGetScreenSize ()
local lx, ly, lz = getWorldFromScreenPosition ( width/2, height/2, 10 )
setPedLookAt( player, lx, ly, lz )
end    
end
setTimer( updateFace, 50, 0 )