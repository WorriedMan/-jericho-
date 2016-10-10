--[[
    ПОКАЗЫВАЕТ НА ЭКРАНЕ УКАЗАННЫЕ СООБЩЕНИЯ С ИСЧЕЗАНИЕМ ИЛИ БЕЗ
]]

-- разрешение экрана
local screen =          {}
screen.w, screen.h =    guiGetScreenSize() -- разрешение





local default = { -- настройки сообщения по умолчанию
    text =      "",

    font =      "default-bold",
    scale =     1.0,
    color =     tocolor(255,255,255,255),
    bColor =    tocolor(0,0,0,255),
    outline =   1,
    alignX =    "left",
    alignY =    "top",

    clip =      false,
    wordBreak = false,
    postGUI =   false,

    x =         0,
    y =         0
}

local ms = { -- настройки текущего сообщения
    locked =    false, -- можно ли менять сообщения пока оно на экране
    show =      false, -- показать или нет

    text =      "",

    font =      "default-bold",
    scale =     1.0,
    color =     tocolor(255,255,255,255),
    bColor =    tocolor(0,0,0,255),
    outline =   1,

    x =         0,
    y =         0
}





local hideTimer = false -- таймер исчезания сообщения





function dxMessages_onRender ( )
    if ms.show then -- если нужно нарисовать сообщение
        -- обводка
        if ms.outline > 0 then
            dxDrawText( ms.text, ms.x + ms.outline, ms.y + ms.outline, ms.x, ms.y, ms.bColor, ms.scale, ms.font, default.alignX, default.alignY, default.clip, default.wordBreak, default.postGUI )
            dxDrawText( ms.text, ms.x - ms.outline, ms.y - ms.outline, ms.x, ms.y, ms.bColor, ms.scale, ms.font, default.alignX, default.alignY, default.clip, default.wordBreak, default.postGUI )
            dxDrawText( ms.text, ms.x + ms.outline, ms.y - ms.outline, ms.x, ms.y, ms.bColor, ms.scale, ms.font, default.alignX, default.alignY, default.clip, default.wordBreak, default.postGUI )
            dxDrawText( ms.text, ms.x - ms.outline, ms.y + ms.outline, ms.x, ms.y, ms.bColor, ms.scale, ms.font, default.alignX, default.alignY, default.clip, default.wordBreak, default.postGUI )
        end

        -- текст
        dxDrawText( ms.text, ms.x, ms.y, ms.x, ms.y, ms.color, ms.scale, ms.font, default.alignX, default.alignY, default.clip, default.wordBreak, default.postGUI )
    end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(),
    function ( )
        addEventHandler( "onClientRender", getRootElement(), dxMessages_onRender )
    end
)











--
-- покажет на экране DX сообщение с выбранными параметрами
--
function showMessage ( text, x, y, font, scale, color, backColor, outline, hideDelay, lock )

    -- если стоит запhет на изменение сообщения
    if ms.locked then return end


    -- сразу убъем таймер исчезноввения, если он был запущен для другого сообщения
    if isTimer(hideTimer) then killTimer(hideTimer) end


    -- предпроверки и корректировка входящих переменных
    if type(text) ~=      "string" then text =      default["text"]    end
    if type(x) ~=         "number" then x =         default["x"]       end
    if type(y) ~=         "number" then y =         default["y"]       end
    if type(font) ~=      "string" then font =      default["font"]    end
    if type(scale) ~=     "number" then scale =     default["scale"]   end
    if type(color) ~=     "number" then color =     default["color"]   end
    if type(backColor) ~= "number" then backColor = default["bColor"]  end
    if type(outline) ~=   "number" then outline =   default["outline"] end

    -- корректировка позиции, если указаны относительные значения
    if x > 0 and x < 1 then x = x * screen.w end
    if y > 0 and y < 1 then y = y * screen.h end


    -- обновим данные сообщения для прорисовки
    ms["show"] =    false --пока меняем данные, лучше сообщение скрыть
    ms["x"] =       x
    ms["y"] =       y
    ms["text"] =    text
    ms["font"] =    font
    ms["scale"] =   scale
    ms["color"] =   color
    ms["bColor"] =  backColor
    ms["outline"] = outline
    ms["show"] =    true -- покажем сообщение

    -- запрет менять сообщения пока оно показано на экране
    if lock then ms["locked"] = true else ms["locked"] = false end


    -- если надо запустим таймер исчезновения
    if type(hideDelay) == "number" and hideDelay > 0 then
        hideTimer = setTimer( hideMessage, hideDelay, 1 )
    end

end

--
-- уберет с экрана DX сообщение, если оно показано
--
function hideMessage ( )

    ms.show =   false
    ms.locked = false

end





--
-- запретит менять сообщения, пока оно на экране
--
function lockMessage ( )
    ms.locked = true
end

--
-- разрешит менять сообщения, пока оно на экране
--
function unlockMessage ( )
    ms.locked = false
end
