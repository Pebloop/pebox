local WidthFull = {}

function WidthFull.exec(data, size)
    data.width = data.parent.width
    return data
end

return WidthFull