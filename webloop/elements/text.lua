local StyleManager = require("core.style_manager")

local Text = {}

function Text.text(style)
    if type(style) == "string" then
        return function (value)
            return {
                type = "text",
                style = style,
                value = value[1]
            }
        end
    else
        return {
            type = "text",
            style = "",
            value = style[1]
        }
    end
end

function Text.exec(data, style, value)
    -- compute style
    data = StyleManager.execute(data, style, {width= #value, height=1})

    -- setup style
    term.setBackgroundColor(data.bgColor)
    term.setTextColor(data.textColor)
    term.setCursorPos(data.cursorX, data.cursorY)
    
    term.write(value) -- write text

    -- reset style
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)

    -- go one time down
    data.cursorY = data.cursorY + 1

    return data
end

function Text.size(data, style, value)
    local width = 1
    local height = 1

    if data.width > -1 then

        local val = 1
        if #value > data.width then
            while val < #value do
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