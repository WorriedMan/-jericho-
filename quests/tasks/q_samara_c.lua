samaraBoxes={}
local test = 0

function playSamaraSound ( )
	playSound ( "sounds/horror3.wav" )
end

addEvent( "playSamaraSoundS", true )
addEventHandler( "playSamaraSoundS", getRootElement(), playSamaraSound )
