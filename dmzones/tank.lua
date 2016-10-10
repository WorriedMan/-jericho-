GUIEditor_Image = {}

function showFightCursor ()
-- Created: 05/03/2011 20:46
  local w, h = guiGetScreenSize ()
GUIEditor_Image[1] = guiCreateStaticImage( 705,280,39,42,":guieditor/images/pricel.png",false)





guiSetVisible (GUIEditor_Image[1], true)


--- --- --- --- ---
end

addCommandHandler ("showfight", showFightCursor)

--function startTankFight ()
---- Created: 05/03/2011 20:46
--
--GUIEditor_Image[1] = guiCreateStaticImage(0.4542,0.4322,0.0715,0.1289,":guieditor/images/pricel.png",true)
--
--guiSetVisible (GUIEditor_Image[1], true)
--
--
----- --- --- --- ---
--end
--
--addCommandHandler ("fight", startTankFight)

function explosion ()
  local w, h = guiGetScreenSize ()
  local x, y, z = getWorldFromScreenPosition ( w/2, h/2, 10 )
  createExplosion ( x, y, z, 11 )
end
bindKey ( "i", "down", explosion )