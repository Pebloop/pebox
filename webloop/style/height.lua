local Height = {}

function Height.exec(height)
    return function (data, size)
        data.height = height
        size.height = height
    return data, size
    end
end

return Height