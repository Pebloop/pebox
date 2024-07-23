local textColor = {}

function textColor.exec(color)
    return function (data, size)
        data.textColor = color
        return data
    end    
end

return textColor