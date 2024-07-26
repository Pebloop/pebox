local BgColor = {}

function BgColor.exec(color)
    return function (data, size)
        data.bg_color = color
    return data
    end
end

return BgColor