local Center = {}

function Center.exec(data, size)
    local w, h = term.getSize() -- if not parent, use screen size as reference

    if data.parent then
        w = data.parent.data.width
        h = data.parent.data.height
    end
    
    w = math.floor((w - size.width) / 2)
    data.cursorX = w
    return data
end

return Center