local Body = {}

function Body.body(style, children)
    return {
        type = "body",
        style = style,
        children = children
    }
end

return Body