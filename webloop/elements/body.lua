

local Body = {}

function Body.body(style, children)
    return {
        type = "body",
        style = style,
        children = children
    }
end

function Body.exec(style, children)
    print("exec body")
    local ElementList = require("data.elements_list")
    
    for i, child in ipairs(children) do
        ElementList[child.type](child.style, child.value)
    end
end

return Body