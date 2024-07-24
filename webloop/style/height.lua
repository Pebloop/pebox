local Height = {}

function Height.exec(data, size)
    data.height = size
    return data
end

return Height