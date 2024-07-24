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
    local size = {}

    local width = #value
    if data.parent.data.width < width then
        width = data.parent.data.width
    end

    data, size = StyleManager.execute(data, style, {width=width, height=1})
    width = size.width
    term.setBackgroundColor(data.bgColor)
    term.setTextColor(data.textColor)
    term.setCursorPos(data.cursorX, data.cursorY)

    -- if width restriction
    if data.width > -1 then
        if data.width == 0 then -- no width = no text
            clean()
            return data
        end
        local val = 1 -- used to calculate text width each line
        -- if text is longer than the width restriction
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
            end
        -- if text fit in width restriction just write the text
        else
            term.write(value)
            data.cursorY = data.cursorY + 1
        end
    -- If there is no width restriction, just write text
    else 
        term.write(value)
        data.cursorY = data.cursorY + 1
    end

    -- restore original colors
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    return data
end

function Text.size(data, style, value)
    local width = 1
    local height = 1
    if data.width > -1 then
        if data.width == 0 or data.height == 0 then
            data.height = 0
            return data
        end
        local val = 1
        if #value > data.width then
            while val < #value do
                if data.height ~= -1 and height > data.height then
                    data.height = height
                    data.width = width
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
                val = val + #str + 1
                height = height + 1
            end
        end
    elseif data.width == 0 then
        data.height = 0
        return data
    else
        width = #value
    end
    data.width = math.max(data.width, width)
    data.height = math.max(data.height, height)
    return data
end

return Text