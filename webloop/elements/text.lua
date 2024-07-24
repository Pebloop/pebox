local StyleManager = require("core.style_manager")

local Text = {}

function Text.text(style, value)
    return {
        type = "text",
        style = style,
        value = value
    }
end

function Text.exec(data, style, value)

    data = StyleManager.execute(data, style, {width=#value, height=1})
    term.setBackgroundColor(data.bgColor)
    term.setTextColor(data.textColor)
    term.setCursorPos(data.cursorX, data.cursorY)

    if data.width > -1 then
        if data.width == 0 then
            return
        end
        while #value < data.width do
            value = value .. " "
            term.write(value)
            term.setCursorPos(data.cursorX, data.cursorY + 1)
        end
    end

    -- restore original colors
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
end

return Text