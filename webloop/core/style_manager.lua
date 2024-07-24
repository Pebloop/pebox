local StyleList = require("data.style_list")

local StyleManager = {}

function StyleManager.execute(data, style, size) 
    -- parse modifiers by spaces
    local modifiers = {}
    local newSize = {}
    for modifier in string.gmatch(style, "%S+") do
        table.insert(modifiers, modifier)
    end

    for i, modifier in ipairs(modifiers) do
        local execStyle, response = pcall(function() data, newSize = StyleList[modifier](data, size) end)
        if not execStyle then
            print("Error with " .. modifier .. " modifier")
            print(response)
        else
            if newSize then
                size.width = newSize.width
                size.height = newSize.height
            end
        end
        
    end

    return data, size
end

return StyleManager