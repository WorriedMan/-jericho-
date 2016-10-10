function savePos(thePlayer,command,comment)
    local x, y, z = getElementPosition(thePlayer)
    local xr,yr,zr = getElementRotation ( thePlayer )
    hFile = fileOpen("pos.txt", false)
    if hFile then
        local temp
        while not fileIsEOF(hFile) do
        temp = fileRead(hFile, 500)
    end
        fileWrite(hFile,x .. ',' .. y .. ',' .. z .. ',' .. xr .. ',' .. yr .. ',' .. zr .. ',' .. comment .. '\n')
    else
        hFile = fileCreate("pos.txt")
        fileWrite(hFile,x .. ',' .. y .. ',' .. z .. ',' .. xr .. ',' .. yr .. ',' .. zr .. ',' .. comment .. '\n')
    end
    outputChatBox("Saved!", thePlayer)
    fileClose(hFile)
end
addCommandHandler ("pos", savePos)