local pretty = require "cc.pretty"
local Colors = require "src/data/colors"

local LuaLang = {}

local function colorToken(token)
    local tokenColors = {
        ["function"] = Colors.text2,
        ["return"] = Colors.text2,
        ["do"] = Colors.text2,
        ["in"] = Colors.text2,
        ["for"] = Colors.text2,
        ["while"] = Colors.text2,
        ["repeat"] = Colors.text2,
        ["until"] = Colors.text2,
        ["if"] = Colors.text2,
        ["then"] = Colors.text2,
        ["else"] = Colors.text2,
        ["elseif"] = Colors.text2,
        ["end"] = Colors.text2,
        ["local"] = Colors.text2,
        ["nil"] = Colors.text3,
        ["true"] = Colors.text3,
        ["false"] = Colors.text3,
        ["and"] = Colors.text3,
        ["or"] = Colors.text3,
        ["not"] = Colors.text3,
        ["break"] = Colors.text3,
        ["goto"] = Colors.text3,
        ["continue"] = Colors.text3,
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
        window.setCursorPos(1, window.getCursorY() + 1)
    end
    
end

return LuaLang