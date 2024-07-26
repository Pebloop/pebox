local Center = {}

function Center.exec(data, size)
    local w, h = term.getSize() -- if not parent, use screen size as reference

    if data.parent then
        w = data.parent.width
        h = data.parent.height

    end
    w = math.floor((w - size.width) / 2)
    data.x = w
    return data
end

return Center