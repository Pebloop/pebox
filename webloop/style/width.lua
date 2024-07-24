local Width = {}

function Width.exec(width)
    return function (data, size)
        data.width = width
        size.width = width
    return data, size
    end
end

return Width