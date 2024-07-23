local Text = {}

function Text.text(style, value)
    return {
        type = "text",
        style = style,
        value = value
    }
end

function Text.exec(style, value)
    print(value)
end

return Text