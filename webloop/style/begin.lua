local Begin = {}

function Begin.exec(data, size)
    data.cursorX = 1
    term.setCursorPos(data.cursorX, data.cursorY)
    return data
end

return Begin