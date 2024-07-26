local Center = {}

function Center.exec(data, size)
    local w = data.parent.width
    local h = data.parent.height
    data.align = "middle"

    data.x = math.floor((w - size.width) / 2) + 1
    return data
end

return Center