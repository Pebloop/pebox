local HeightFull = {}

function HeightFull.exec(data, size)
    data.width = data.parent.width
    return data
end

return HeightFull