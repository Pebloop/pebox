local BgBlack = {}

function BgBlack.exec(data, size)
    data.bgColor = colors.black
    return data
end

return BgBlack