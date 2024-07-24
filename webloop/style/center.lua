local Center = {}

function Center.exec(data, size)
    local w, h = term.getSize()
    w = math.floor((w - size.width) / 2)
    data.cursorX = w
    return data
end

return Center