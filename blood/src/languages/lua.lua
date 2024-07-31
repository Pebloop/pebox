local pretty = require "cc.pretty"
local Colors = require "src/data/colors"

local LuaLang = {}

local function colorToken(token)
    local tokenColors = {
        ["function"] = Colors.text2
    }

    return tokenColors[token] or Colors.text
end

function LuaLang.pretty(code, window)

    for line in string.gmatch(code, "[^\n]+") do
        for token in string.gmatch(line, "%S+") do
            window.setTextColor(colorToken(token))
            window.write(token)
            window.write(" ")
        end
        window.write("\n")
    end
    
end

return LuaLang