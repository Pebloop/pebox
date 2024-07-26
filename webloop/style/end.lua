local End = {}

function End.exec(data, size)
    local w = data.parent.width
    local h = data.parent.height
    data.align = "end"

    data.x = w - size.width + 1
    return data
end

return End