local Height = {}

function Height.exec(height)
    return function (data, size)
        data.height = height
    return data
    end
end

return Height