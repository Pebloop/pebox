local StyleManager = require("core.style_manager")
local Utils = require("utils")
local Strings = require("cc.strings")

local Text = {}

-- Text element
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

-- Execute text element
function Text.exec(data, style, value)
    -- compute style
    data = StyleManager.execute(data, style, {width= #value, height=1})

    -- setup style
    term.setBackgroundColor(data.bg_color)
    term.setTextColor(data.text_color)
    term.setCursorPos(data.x, data.y)
    
    -- render text
    local parentWidth, parentHeight = term.getSize()
    if data.parent then
        parentWidth = data.parent.width
        parentHeight = data.parent.height
    end

    -- if text is bigger than parent width then cut it
    local text = Strings.wrap(value, parentWidth)
    local h = data.y
    for i, line in ipairs(text) do
        data.y = h + i - 1
        term.setCursorPos(data.x, data.y)
        term.write(line)
    end
    data.y = h + #text

    -- reset style
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)

    -- go one time down
    data.y = data.y + 1

    return data
end

function Text.size(data, style, value)
    local parentWidth, parentHeight = data:parentalSize()
    print("parentWidth : " .. parentWidth)
    print("parentHeight : " .. parentHeight)
    os.pullEvent("key")
    
    if #value < parentWidth then
        return {width = #value, height = 1}
    else
        local formatedText = Strings.wrap(value, parentWidth)

        return {width = parentWidth, height = #formatedText}
    end
end

return Text