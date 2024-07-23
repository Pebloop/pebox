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
    term.setTextColor(data.color)
    term.write(value)

    -- restore original colors
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
end

return Text