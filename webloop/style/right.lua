local Right = {}

function Right.exec(data, size)
    local w, h = term.getSize()
    w = w - size.width
    data.cursorX = w
    term.setCursorPos(data.cursorX, data.cursorY)
    return data
end

return Right