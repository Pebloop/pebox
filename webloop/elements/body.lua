local StyleManager = require("core.style_manager")
local Utils = require("utils")

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
        local localData = Utils.deepcopy(data)
        local newData = ElementList[child.type](localData, child.style, child.value)
        data.cursorY = newData.cursorY
    end
    return data
end

return Body