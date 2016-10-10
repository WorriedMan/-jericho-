--[[
    ВЫБОР СКИНА
    клиент
]]

local me = getLocalPlayer() -- я





local skins = { -- таблица скинов

    -- МУЖИКИ --

    -- можно юзать в версии 1.1 и выше
    265,266,267,268,269,270,272,
    290,291,292,293,294,295,296,297,
    299,300,301,302,303,
    305,306,307,308,309,310,311,312,

    -- можно юзать в версии 1.0 и выше
    0,
	15,16,17,18,19,24,25,26,27,28,29,30,
    32,33,34,35,36,37,
    43,44,45,46,47,48,49,50,51,52,
    57,58,59,60,61,62,
    66,
    71,72,73,
    79,80,81,82,83,84,
    94,95,96,98,99,100,101,102,103,104,106,109,110,112,113,114,115,116,117,118,
    120,121,122,123,124,125,
    132,133,134,135,136,137,
    142,143,144,
    146,147,
    153,154,155,156,
    158,159,160,161,163,164,165,166,168,
    170,171,
    173,174,175,176,177,
    179,180,181,182,183,184,185,186,187,189,
    200,
    202,203,204,
	210,
    213,
    217,
    220,221,222,223,
    227,228,
    234,235,236,
    239,240,241,242,
    247,248,249,250,
    254,255,
    259,260,261,262,
    274,275,276,278,279,281,282,283,284,285,286,288,

    -- БАБЫ --

    -- можно юзать в версии 1.1 и выше
    298,
    304,

    -- можно юзать в версии 1.0 и выше
    9,10,11,12,
    31,
    38,39,40,41,
    53,54,55,
    63,64,
    69,
    75,76,77,
    85,87,88,89,90,91,92,93,
    129,130,131,
    138,139,140,141,
    145,
    148,150,151,152,
    157,
    169,
    172,
    178,
    190,191,192,193,194,195,196,197,198,199,
    201,
    205,
    207,
    211,
    214,215,216,
    218,219,
    224,
         -- 245 246
}





local maxSkinPos = #skins -- кол-во скинов
local curSkinPos = 1 -- текущий номер скина в таблице скинов

-- вернет след позицию в таблице скинов, исходя из указанной текущей позиции
local function getNextSkinPos ( curPos )
    curPos = curPos + 1
    if curPos > maxSkinPos then curPos = 1 end

    return curPos
end

-- вернет пред позицию в таблице скинов, исходя из указанной текущей позиции
local function getPrevSkinPos ( curPos )
    curPos = curPos - 1
    if curPos < 1 then curPos = maxSkinPos end

    return curPos
end





local ssms = { -- таблица с сообщениями на экране
    whileSelecting = { -- сообщение во время выбора скина
        text =      "Стрелки ВЛЕВО / ВПРАВО - листать скины, \n" ..
                    "Кнопка ENTER - применить",

        font =      "default-bold",
        scale =     1.0,
        color =     tocolor(0xFF,0x8D,0x42,255),
        bColor =    tocolor(0,0,0,200),
        outline =   1,

        x =         0.25,
        y =         0.83
    },

    afterSelecting = { -- сообщение сразу после выбора скина
        text =      "Если скин надоест, вы снова можете его поменять. \n" ..
                    "Кнопка F4 - смена скина",

        font =      "default-bold",
        scale =     1.0,
        color =     tocolor(255,255,255,200),
        bColor =    tocolor(0,0,0,200),
        outline =   1,

        x =         0.25,
        y =         0.83,

        hideDelay = 4000 -- мсек
    }
}





function setNextSkinForMe ( )
    curSkinPos = getNextSkinPos(curSkinPos)

    setElementModel( me, skins[curSkinPos] )
end

function setPrevSkinForMe ( )
    curSkinPos = getPrevSkinPos(curSkinPos)

    setElementModel( me, skins[curSkinPos] )
end





local selecting = false

function startSkinSelection ( )

    -- если уже выбирает, ничо не надо делать
    if selecting then return end
    selecting = true
	
	local x, y, z = getElementPosition(me)
	setElementData (me, "x", x )
	setElementData (me, "y", y )
	setElementData (me, "z", z )
	setElementData (me, "inter", getElementInterior ( me ))
	setElementData (me, "dim", getElementDimension ( me ))
	setElementInterior ( me, 0 )
	setElementPosition ( me, -1691.1279296875,2046.3740234375,37.14387512207 )
	setElementDimension(me, math.random(0,10000))

    -- выключим только игровое управление
    toggleAllControls( false, true, false )

    -- будем следить за нажатием этих кнопок
    bindKey( "arrow_l", "up", setPrevSkinForMe )
    bindKey( "arrow_r", "up", setNextSkinForMe )
    bindKey( "enter",   "up", stopSkinSelection )


    -- покажем инфо по управлению выбором скина
    showMessage( ssms["whileSelecting"]["text"], ssms["whileSelecting"]["x"], ssms["whileSelecting"]["y"], ssms["whileSelecting"]["font"], ssms["whileSelecting"]["scale"], ssms["whileSelecting"]["color"], ssms["whileSelecting"]["bColor"], ssms["whileSelecting"]["outline"], 0, true )

end

addEvent( "exportSkinSelectS", true )

addEventHandler( "exportSkinSelectS", getRootElement(),
    function ( )
        startSkinSelection ()
    end
)


function stopSkinSelection ( )

    -- если не выбирает, ничо не надо делать
    if not selecting then return end
    selecting = false

	setElementInterior ( me, getElementData ( me, "inter" ) )
	setElementPosition ( me, getElementData ( me, "x" ), getElementData ( me, "y" ), getElementData ( me, "z" ) )
	setElementDimension(me, getElementData ( me, "dim" ))

    -- включим все игровое управление
    toggleAllControls( true, true, false )

    -- не будем следить за нажатием этих кнопок
    unbindKey( "arrow_l", "up", setPrevSkinForMe )
    unbindKey( "arrow_r", "up", setNextSkinForMe )
    unbindKey( "enter",   "up", stopSkinSelection )


    -- покажем инфо по управлению выбором скина
    unlockMessage()
    showMessage( ssms["afterSelecting"]["text"], ssms["afterSelecting"]["x"], ssms["afterSelecting"]["y"], ssms["afterSelecting"]["font"], ssms["afterSelecting"]["scale"], ssms["afterSelecting"]["color"], ssms["afterSelecting"]["bColor"], ssms["afterSelecting"]["outline"], ssms["afterSelecting"]["hideDelay"] )


    -- отправим серву инфу о новом скине
    triggerServerEvent( "saveMySkin", me, skins[curSkinPos] )

end

