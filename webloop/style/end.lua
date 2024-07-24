local End = {}

function End.exec(data, size)
    local w, h = term.getSize()
    if data.width > -1 then
        size.width = data.width
    end
    w = w - size.width
    data.cursorX = w
    return data
end

return End