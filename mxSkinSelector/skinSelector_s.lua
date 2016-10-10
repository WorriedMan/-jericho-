--[[
    ВЫБОР СКИНА
    сервер
]]

-- таблица с текущими скинами онлайн игроков
local skin = {}




-- это событие вызывают сами клиенты, когда нужно
addEvent( "saveMySkin", true )

addEventHandler( "saveMySkin", getRootElement(),
    function ( playerSkin )
        skin[source] = playerSkin
		takePlayerMoney ( source, 100 )
        setElementModel( source, playerSkin )
		setElementData ( source, 'useArmor', 0 )
		setElementData ( source, 'antiRadWear', 0 )
    end
)

function exportSkinSelect ( player )
	triggerClientEvent ( player, "exportSkinSelectS", getRootElement() )
end



addEventHandler( "onPlayerJoin", getRootElement(), function() skin[source] = 0 end )
addEventHandler( "onPlayerQuit", getRootElement(), function() skin[source] = nil end )
