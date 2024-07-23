local BgGray = {}

function BgGray.exec(data, size)
    data.bgColor = colors.gray
    return data
end

return BgGray