local Pretty = require "src/pretty"
local Colors = require "src/data/colors"

local LuaLang = {}

local keyChar = {
    " ", "(", ")", ",", "{", "}", "[", "]", "=", "+", "-", "*", "/", "%", "^", "#", "<", ">", ";", ":", ".", "'", "\"", "\n"
 }

local tokenColors = {
    ["function"] = Colors.text2,
    ["if"] = Colors.text2,
    ["then"] = Colors.text2,
    ["else"] = Colors.text2,
    ["elseif"] = Colors.text2,
    ["end"] = Colors.text2,
    ["for"] = Colors.text2,
    ["do"] = Colors.text2,
    ["while"] = Colors.text2,
    ["repeat"] = Colors.text2,
    ["until"] = Colors.text2,
    ["return"] = Colors.text2,
    ["break"] = Colors.text2,
    ["in"] = Colors.text2,
    ["and"] = Colors.text2,
    ["or"] = Colors.text2,
    ["not"] = Colors.text2,
    ["true"] = Colors.text2,
    ["false"] = Colors.text2,
    ["nil"] = Colors.text2,
}

function LuaLang.pretty(code, window)
    local doc = Pretty.doc()
    local buffer = ""
    local state = "init"
    local tokens = {}
    local args = {}
    local variables = {}

    local i = 1
    for c in string.gmatch(code, ".") do
        if state == "init" then
            if c == " " then
                Pretty.append(doc, Pretty.token(buffer, Colors.text))
                buffer = ""
                Pretty.append(doc, Pretty.space())
            elseif c == "\n" then
                Pretty.append(doc, Pretty.token(buffer, Colors.text))
                buffer = ""
                Pretty.append(doc, Pretty.newline())
            else
                buffer = buffer .. c
                if buffer == "--" then
                    state = "comment"
                elseif buffer == "\"" then
                    state = "string"
                elseif buffer == "(" then
                    if tokens[#tokens] == "function" then
                        Pretty.append(doc, Pretty.token(buffer, Colors.text))
                        args = {}
                        buffer = ""
                        state = "function-args"
                    else
                        Pretty.append(doc, Pretty.token(buffer, Colors.text))
                        buffer = ""
                    end
                elseif tokenColors[buffer] then
                    Pretty.append(doc, Pretty.token(buffer, tokenColors[buffer]))
                    tokens[#tokens + 1] = buffer
                    buffer = ""
                -- if buffer is a function argument
                else
                    for j, sc in ipairs(keyChar) do
                        if c == sc then
                            local b = string.sub(buffer, 1, string.len(buffer) - 1)
                            Pretty.append(doc, Pretty.token(b, Colors.text))
                            Pretty.append(doc, Pretty.token(c, Colors.text2))
                            buffer = ""
                            break
                        end
                    end

                    for j, arg in ipairs(args) do
                        if arg == buffer then
                            Pretty.append(doc, Pretty.token(buffer, Colors.text6))
                            buffer = ""
                            break
                        end
                    end
                end
            end

        elseif state == "comment" then
            if c == "\n" then
                Pretty.append(doc, Pretty.token(buffer, Colors.text4))
                Pretty.append(doc, Pretty.newline())
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
        elseif state == "function-args" then
            if c == ")" then
                Pretty.append(doc, Pretty.token(buffer, Colors.text6))
                Pretty.append(doc, Pretty.token(c, Colors.text))
                args[#args + 1] = buffer
                tokens[#tokens + 1] = args
                buffer = ""
                state = "init"
            elseif c == "," then
                Pretty.append(doc, Pretty.token(buffer, Colors.text6))
                Pretty.append(doc, Pretty.token(c, Colors.text))
                args[#args + 1] = buffer
                buffer = ""
            else
                buffer = buffer .. c
            end
        end

        i = i + 1
    end

    if state == "init" then
        Pretty.append(doc, Pretty.token(buffer, Colors.text))
    elseif state == "comment" then
        Pretty.append(doc, Pretty.token(buffer, Colors.text4))
    elseif state == "string" then
        Pretty.append(doc, Pretty.token(buffer, Colors.text3))
    elseif state == "function-args" then
        Pretty.append(doc, Pretty.token(buffer, Colors.text6))
    end

    Pretty.print(doc, window)
end

return LuaLang
