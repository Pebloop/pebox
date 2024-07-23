local BgColor = {}

function BgColor.exec(color)
    return function (data, size)
        data.bgColor = color
    return data
    end
end

return BgColor