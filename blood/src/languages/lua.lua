local Pretty = require "src/pretty"
local Colors = require "src/data/colors"

local LuaLang = {}

local tokenColors = {
    ["function"] = Colors.text2
}

function LuaLang.pretty(code, window)
    local doc = Pretty.doc()
    local buffer = ""

    for c in code:gmatch(".") do
        if c == " " then
            Pretty.append(doc, Pretty.space())
        elseif c == "\n" then
            Pretty.append(doc, Pretty.newline())
        else
            if buffer == "--" then
                Pretty.append(doc, Pretty.token(buffer, Colors.text4))
                buffer = ""
            elseif tokenColors[buffer] then
                Pretty.append(doc, Pretty.token(buffer, tokenColors[buffer]))
                buffer = ""
            end
        end
    end
    Pretty.append(doc, Pretty.token(buffer, Colors.text))
    
    Pretty.print(doc, window)
end

return LuaLang