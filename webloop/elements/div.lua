local StyleManager = require("core.style_manager")
local Utils = require("utils")

local Div = {}

function Div.div(style, children)
    return {
        type = "div",
        style = style,
        value = children
    }
end

function Div.exec(data, style, children)
    local ElementList = require("data.elements_list")
    local ElementSize = require("data.elements_size")

    data = StyleManager.execute(data, style, {width=0,height=0})
    
    for i, child in ipairs(children) do
        local localData = Utils.deepcopy(data)
        local wrappedSize = ElementSize[child.type](localData, child.style, child.value)

        for y = 1, wrappedSize.height do
            for x = 1, wrappedSize.width do
                term.setCursorPos(data.cursorX + x - 1, data.cursorY + y - 1)
                term.setBackgroundColor(data.bgColor)
                term.write(" ")
            end
        end
        term.setBackgroundColor(colors.black)

        local newData = ElementList[child.type](localData, style .. " " ..  child.style, child.value)
        data.cursorY = newData.cursorY
    end
    return data
end

return Div