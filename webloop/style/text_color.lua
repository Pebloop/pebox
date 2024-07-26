local textColor = {}

function textColor.exec(color)
    return function (data, size)
        data.text_color = color
        return data
    end    
end

return textColor