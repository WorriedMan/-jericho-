local refreshTime = 5000 -- раз в сколько милисекунд обновлять список тех, кто слышит игрока (чем меньше число, тем больше нагрузка может быть)
local radius = 30 -- радиус сферы, в которой будет слышно игрока
local playersCols = {}

for i, v in ipairs ( getElementsByType("player") ) do
	local x,y,z = getElementPosition ( v )
	playersCols[v] = createColSphere ( x,y,z, radius )
	attachElements(playersCols[v],v)
end

function createColshapeOnSpawn ()
	if not isElement ( playersCols[source] ) then
		local x,y,z = getElementPosition ( source )
		playersCols[source] = createColSphere ( x,y,z, radius )
		attachElements(playersCols[source],source)
	end
end

addEventHandler ( "onPlayerSpawn", getRootElement(), createColshapeOnSpawn )

function quitPlayerDestroySphere ( quitType )
	if playersCols[source] then
		if isElement ( playersCols[source] ) then
			destroyElement ( playersCols[source] )
		end
		playersCols[source] = nil
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayerDestroySphere )

function refreshPlayers()
	for player, sphere in pairs ( playersCols ) do
		if isElement ( player ) then
			if isElement ( sphere ) then
				local players = getElementsWithinColShape ( sphere, "player" )
				setPlayerVoiceBroadcastTo ( player, players )
			end			
		else
			if isElement ( sphere ) then
				destroyElement ( sphere )
			end
			playersCols[player] = nil
		end
	end
end

setTimer ( refreshPlayers, refreshTime, 0 )

