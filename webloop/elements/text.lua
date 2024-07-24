local StyleManager = require("core.style_manager")

local Text = {}

function Text.text(style, value)
    return {
        type = "text",
        style = style,
        value = value
    }
end

local function clean()
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
end

function Text.exec(data, style, value)
    local newY = data.cursorY

    data = StyleManager.execute(data, style, {width=#value, height=1})
    term.setBackgroundColor(data.bgColor)
    term.setTextColor(data.textColor)
    term.setCursorPos(data.cursorX, data.cursorY)

    if data.width > -1 then
        if data.width == 0 then
            clean()
            return data
        end
        local val = 1
        if #value > data.width then
            local height = 1
            if data.height == 0 then
                clean()
                return data
            end
            while val < #value do
                if data.height ~= -1 and height > data.height then
                    clean()
                    return data
                end
                local str = string.sub(value, val, val + data.width)
                -- if str cut in the middle of a word then cut it to the last space
                if str[#str] ~= " " and value[val + data.width + 1] ~= " " then
                    local lastSpace = string.find(str, " [^ ]*$")
                    if lastSpace then
                        str = string.sub(str, 1, lastSpace - 1)
                    end
                end
                -- trim spaces
                str = string.match(str, "^%s*(.-)%s*$")
                term.write(str)
                val = val + #str + 1
                data.cursorY = data.cursorY + 1
                term.setCursorPos(data.cursorX, data.cursorY)
                height = height + 1
                newY = height
            end
        else
            term.write(value)
            data.cursorY = data.cursorY + 1
        end
    else 
        term.write(value)
        data.cursorY = data.cursorY + 1
    end

    -- restore original colors
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    return data
end

return Text