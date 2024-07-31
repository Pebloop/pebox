local Pretty = require "src/pretty"
local Colors = require "src/data/colors"

local LuaLang = {}

function LuaLang.pretty(code, window)
    local doc = Pretty.doc()

    for c in code:gmatch(".") do
        if c == " " then
            Pretty.append(doc, Pretty.space())
        elseif c == "\n" then
            Pretty.append(doc, Pretty.newline())
        else
            Pretty.append(doc, Pretty.token(c, Colors.text))
        end
    end

    
    Pretty.print(doc, window)
end

return LuaLang