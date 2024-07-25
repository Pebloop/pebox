local End = {}

function End.exec(data, size)
    
    local w, h = term.getSize() -- if not parent, use screen size as reference

    if data.parent then
        w = data.parent.data.width
        h = data.parent.data.height
    end

    -- if no width, no content to display, so just return
    if data.width == 0 then
        return data
    else
        w = data.cursorX + w - size.width
        if w < data.cursorX then
            w = data.cursorX
        end
        if w < 1 then
            w = 1
        end
    end
    data.cursorX = w
    return data
end

return End