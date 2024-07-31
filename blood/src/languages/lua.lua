local Pretty = require "src/pretty"
local Colors = require "src/data/colors"

local LuaLang = {}

local keyChar = {
    "=", "+", "-", "*", "/", "%", "^", "#"
 }

 local isNotVar = {
    " ", "\n", "(", ")", "{", "}", "[", "]", ";", ",", ":", "=", "+", "-", "*", "/", "%", "^", "#", "<", ">", "!", "&", "|", "."
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
    ["local"] = Colors.text
}

----------------- Pretty -----------------

function LuaLang.pretty(code, window, data)
    local doc = Pretty.doc()
    local buffer = ""
    local state = "init"
    local tokens = {}
    local args = {}
    local variables = {}

    local i = 1
    for c in string.gmatch(code, ".") do

        -- debug
        --local dx, dy = window.getCursorPos()
        --window.setCursorPos(20, 20)
        --window.write("         ")
        --window.setCursorPos(20, 20)
        --window.write(state)
        --window.setCursorPos(20, 21)
        --window.write("                          ")
        --window.setCursorPos(20, 21)
        --window.write(buffer)
        --window.setCursorPos(dx, dy)
        --os.pullEvent("key")



        if state == "init" then
            if c == " " then
                if tokens[#tokens] == "local" then
                    state = "variable"
                    Pretty.append(doc, Pretty.token(buffer, Colors.text))
                    buffer = ""
                    Pretty.append(doc, Pretty.space())
                else
                    Pretty.append(doc, Pretty.token(buffer, Colors.text))
                    buffer = ""
                    Pretty.append(doc, Pretty.space())
                end
            elseif c == "\n" then
                Pretty.append(doc, Pretty.token(buffer, Colors.text))
                buffer = ""
                Pretty.append(doc, Pretty.newline())
            else
                buffer = buffer .. c
                if buffer == "--" then
                    state = "comment"
                elseif c == "\"" then
                    state = "string"
                elseif c == "(" then
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

                    -- if buffer is an argument
                    for j, arg in ipairs(args) do
                        local b = string.sub(buffer, 1, string.len(buffer) - 1)
                        if arg == b then
                            for k, sc in ipairs(isNotVar) do
                                if c == sc then
                                    Pretty.append(doc, Pretty.token(b, Colors.text6))
                                    Pretty.append(doc, Pretty.token(c, Colors.text))
                                    buffer = ""
                                    break
                                end
                            end
                        end
                    end

                    -- if buffer is a variable
                    for j, var in ipairs(variables) do
                        local b = string.sub(buffer, 1, string.len(buffer) - 1)
                        if var == b then
                            for k, sc in ipairs(isNotVar) do
                                if c == sc then
                                    Pretty.append(doc, Pretty.token(b, Colors.text5))
                                    Pretty.append(doc, Pretty.token(c, Colors.text))
                                    buffer = ""
                                    break
                                end
                            end
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
        elseif state == "variable" then
            if c == "\n" then
                Pretty.append(doc, Pretty.token(buffer, Colors.text5))
                Pretty.append(doc, Pretty.newline())
                tokens[#tokens + 1] = buffer
                variables[#variables + 1] = buffer
                buffer = ""
                state = "init"
            elseif buffer .. c == "function" then
                Pretty.append(doc, Pretty.token(buffer .. c, Colors.text2))
                tokens[#tokens + 1] = buffer .. c
                buffer = ""
                state = "init"
            elseif c == " " then
                Pretty.append(doc, Pretty.token(buffer, Colors.text5))
                Pretty.append(doc, Pretty.space())
                tokens[#tokens + 1] = buffer
                variables[#variables + 1] = buffer
                buffer = ""
                state = "init"
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
    elseif state == "variable" then
        Pretty.append(doc, Pretty.token(buffer, Colors.text))
    end

    Pretty.print(doc, window)
end

----------------- Completion -----------------
function LuaLang.complete(code, x, y)
    
end


return LuaLang
