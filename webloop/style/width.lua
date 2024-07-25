local Width = {}

function Width.exec(width)
    return function (data, size)
        data.width = width
        size.width = width
    return data
    end
end

return Width