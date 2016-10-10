-- function loadPlayerPerks ( player, pTable )
	-- for i=1, #perkCfg do
		-- setElementData ( localPlayer, "perk"..i, perkCfg[i] )
	-- end
-- end

local stats = {
    [ 69 ] = 999,
    [ 70 ] = 999,
    [ 71 ] = 999,
    [ 72 ] = 999,
    [ 73 ] = 500,
    [ 74 ] = 999,
    [ 75 ] = 500,
    [ 76 ] = 999,
    [ 77 ] = 999,
    [ 78 ] = 999,
    [ 79 ] = 999,
}


function loadPlayerPerks ( player )
	loadPlayerStats ( player )
end

function triggeredLoadStats ( )
	loadPlayerStats ( source )
end

addEvent( "loadPlayerWeapStats", true )
addEventHandler( "loadPlayerWeapStats", getRootElement(), triggeredLoadStats )

function loadPlayerStats ( player )
	if getElementData ( player, "perk13" ) then
		setElementData ( player, "weapLvl", 2 )
		-- for stat,value in pairs(stats) do
			-- setPedStat(player, stat, value)
		-- end
	end
end