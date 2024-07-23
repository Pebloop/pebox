local StyleManager = require("core.style_manager")

local Body = {}

function Body.body(style, children)
    return {
        type = "body",
        style = style,
        children = children
    }
end

function Body.exec(data, style, children)
    local ElementList = require("data.elements_list")

    data = StyleManager.execute(data, style)
    
    for i, child in ipairs(children) do
        ElementList[child.type](data, child.style, child.value)
    end
end

return Body