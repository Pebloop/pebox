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
    local screenSize = term.getSize()


    style = "w-screen h-screen " .. style
    data = StyleManager.execute(data, style, {width=screenSize.width,height=screenSize.height})
    
    for i, child in ipairs(children) do
        local localData = Utils.deepcopy(data)
        localData.parent = 'body'
        local newData = ElementList[child.type](localData, style .. " " ..  child.style, child.value)
        data.cursorY = newData.cursorY
    end
    return data
end

return Body