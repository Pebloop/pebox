local End = {}

function End.exec(data, size)
    local w, h = term.getSize()
    if data.width == -1 then
        w = w - size.width
    elseif data.width == 0 then
        return data
    else
        w = data.cursorX + data.width - size.width
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