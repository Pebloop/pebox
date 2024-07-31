local Pretty = require "src/pretty"
local Colors = require "src/data/colors"

local LuaLang = {}

local tokenColors = {
    ["function"] = Colors.text2
}

function LuaLang.pretty(code, window)
    local doc = Pretty.doc()
    local buffer = ""
    local state = "init"

    for c in code:gmatch(".") do
        if state == "init" then
            if c == " " then
                Pretty.append(doc, Pretty.token(buffer, Colors.text))
                buffer = ""
                Pretty.append(doc, Pretty.space())
            elseif c == "\n" then
                Pretty.append(doc, Pretty.newline())
            else
                buffer = buffer .. c
                if buffer == "--" then
                    state = "comment"
                elseif buffer == "\"" then
                    state = "string"
                elseif tokenColors[buffer] then
                    Pretty.append(doc, Pretty.token(buffer, tokenColors[buffer]))
                    buffer = ""
                end
            end

        elseif state == "comment" then
            if c == "\n" then
                Pretty.append(doc, Pretty.token(buffer, Colors.text4))
                buffer = ""
                state = "init"
            else
                buffer = buffer .. c
            end
        elseif state == "string" then
            if c == "\"" then
                buffer = buffer .. c
                Pretty.append(doc, Pretty.token(buffer, Colors.text3))
                Pretty.append(doc, Pretty.newline())
                buffer = ""
                state = "init"
            else
                buffer = buffer .. c
            end
        end
    end
    Pretty.append(doc, Pretty.token(buffer, Colors.text))

    Pretty.print(doc, window)
end

return LuaLang
