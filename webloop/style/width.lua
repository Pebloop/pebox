local Width = {}

function Width.exec(data, size)
    data.width = size
    return data
end

return Width