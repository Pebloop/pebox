local Pretty = {}
local Colors = require('src.data.colors')

function Pretty.print(doc, window)
    for _, token in ipairs(doc) do
        window.setTextColor(token.color)
        window.write(token.text)
        if token.text == "\n" then
            local x, y = window.getCursorPos()
            window.setCursorPos(1, y + 1)
        end
    end
    window.setTextColor(Colors.text)
end

function Pretty.printLine(doc, window, line)
    local lineIndex = 1
    local line = ""
    for i, token in ipairs(doc) do
        if token.text == "\n" then
            lineIndex = lineIndex + 1
            for j = i + 1, #doc do
                if doc[j].text == "\n" then
                    break
                end
                line = line .. doc[j].text
            end
            break
        end
    end
    window.setCursorPos(1, lineIndex)
    window.clearLine()
    window.write(line)
    
end

function Pretty.token(text, color)
    return {
        text = text,
        color = color
    }
end

function Pretty.space()
    return Pretty.token(" ", Colors.text)
end

function Pretty.newline()
    return Pretty.token("\n", Colors.text)
end

function Pretty.append(doc, obj2)
   doc[#doc + 1] = obj2
end

function Pretty.doc()
    return {}
end

return Pretty