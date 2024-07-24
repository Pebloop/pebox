local StyleManager = require("core.style_manager")
local Utils = require("utils")

local Div = {}

function Div.div(style, children)
    return {
        type = "div",
        style = style,
        children = children
    }
end

function Div.exec(data, style, children)
    local ElementList = require("data.elements_list")

    data = StyleManager.execute(data, style, {width=0,height=0})
    
    for i, child in ipairs(children) do
        local localData = Utils.deepcopy(data)
        local newData = ElementList[child.type](localData, style .. " " ..  child.style, child.value)
        data.cursorY = newData.cursorY
    end
    return data
end

return Div