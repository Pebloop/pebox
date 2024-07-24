local StyleList = require("data.style_list")

local StyleManager = {}

function StyleManager.execute(data, style, size) 
    -- parse modifiers by spaces
    local modifiers = {}
    for modifier in string.gmatch(style, "%S+") do
        table.insert(modifiers, modifier)
    end

    for i, modifier in ipairs(modifiers) do
        if data.width > -1 then
            size.width = data.width
        end
        if data.height > -1 then
            size.height = data.height
        end
        local execStyle, response = pcall(function() data = StyleList[modifier](data, size) end)
        if not execStyle then
            print("Style " .. modifier .. " not found")
        end
        
    end

    return data
end

return StyleManager