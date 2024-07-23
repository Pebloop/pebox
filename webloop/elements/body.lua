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

    data = StyleManager.execute(data, style, {width=0,height=0})
    
    for i, child in ipairs(children) do
        ElementList[child.type](data, child.style, child.value)
        data.cursorY = data.cursorY + 1
        term.setCursorPos(data.cursorX, data.cursorY)
    end
end

return Body