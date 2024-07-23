local Text = {}

function Text.text(style, value)
    return {
        type = "text",
        style = style,
        value = value
    }
end

return Text