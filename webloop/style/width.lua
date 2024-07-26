local Width = {}

function Width.exec(width)
    return function (data, size)
        data.width = width
    return data
    end
end

return Width