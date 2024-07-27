local StyleManager = require("core.style_manager")
local Utils = require("utils")
local Strings = require("cc.strings")

local A = {}

-- Text element
function A.text(style)
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

-- Execute text element
function A.exec(window, data, style, value)
    -- compute style
    data = StyleManager.execute(data, style, {width= #value, height=1})

    -- setup style
    window.setBackgroundColor(data.bg_color)
    window.setTextColor(data.text_color)
    window.setCursorPos(data.x, data.y)
    
    -- render text
    local parentWidth, parentHeight = window.getSize()
    if data.parent then
        parentWidth = data.parent.width
        parentHeight = data.parent.height
    end

    -- if text is bigger than parent width then cut it
    local text = Strings.wrap(value, parentWidth)
    local h = data.y
    for i, line in ipairs(text) do
        data.y = h + i - 1

        if data.text_align == "start" then
            window.setCursorPos(data.x, data.y)
        elseif data.text_align == "middle" then
            window.setCursorPos(data.x + math.floor((parentWidth - #line) / 2), data.y)
        elseif data.text_align == "end" then
            window.setCursorPos(data.x + parentWidth - #line, data.y)
        end
        window.write(line)
    end
    data.y = h + #text

    -- reset style
    window.setBackgroundColor(colors.black)
    window.setTextColor(colors.white)

    -- go one time down
    data.y = data.y + 1

    return data
end

function A.size(window, data, style, value)
    local parentWidth, _ = data:parentalSize(window)
    local formatedText = Strings.wrap(value, parentWidth)

    return {width = parentWidth, height = #formatedText}
end

return Text