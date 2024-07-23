local BgRed = {}

function BgRed.exec(data, size)
    data.bgColor = colors.red
    return data
end

return BgRed