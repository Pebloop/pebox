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

    data = StyleManager.execute(data, style)
    term.write(value)
    data.cursorY = data.cursorY + 1
    term.setCursorPos(data.cursorX, data.cursorY)
end

return Text