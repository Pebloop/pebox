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

    data = StyleManager.execute(data, style, #value)
    term.write(value)
end

return Text