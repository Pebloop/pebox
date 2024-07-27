local WidthFull = {}

function WidthFull.exec(data, size)
    data.width = data.parent.width
end

return WidthFull