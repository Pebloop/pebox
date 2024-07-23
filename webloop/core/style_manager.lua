local StyleList = require("data.style_list")

local StyleManager = {}

function StyleManager.execute(data, style, size) 
    -- parse modifiers by spaces
    local modifiers = {}
    for modifier in string.gmatch(style, "%S+") do
        table.insert(modifiers, modifier)
    end

    for i, modifier in ipairs(modifiers) do
        local execStyle = pcall(function() data = StyleList[modifier](data, size) end)
        if not execStyle then
            print("Style " .. modifier .. " not found")
        end
        
    end

    return data
end

return StyleManager