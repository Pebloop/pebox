local StyleManager = require("core.style_manager")
local Utils = require("utils")

local Div = {}

function Div.div(style)
    if type(style) == "string" then
        return function (children)
            return {
                type = "div",
                style = style,
                value = children
            }
        end
    else
        return {
            type = "div",
            style = "",
            value = style
        }
    end
end

function Div.exec(data, style, children)
    local size = {}
    local ElementList = require("data.elements_list")
    local ElementSize = require("data.elements_size")

    data, size = StyleManager.execute(data, style, {width=0,height=0})
    data.width = size.width
    data.height = size.height

    for i, child in ipairs(children) do

        if type(child) == "string" then
            child = {type = "text", style = "", value = child}
        end

        local wrappedSize = ElementSize[child.type](Utils.deepcopy(data), child.style, child.value)

        for y = 1, wrappedSize.height - 1 do
            for x = 1, wrappedSize.width do
                term.setCursorPos(data.cursorX + x, data.cursorY + y - 1)
                term.setBackgroundColor(data.bgColor)
                term.write(" ")
            end
        end
        term.setBackgroundColor(colors.black)

        local dataCopy = Utils.deepcopy(data)
        dataCopy.width = wrappedSize.width
        dataCopy.height = wrappedSize.height
        dataCopy.parent = {
            type = 'div',
            data = Utils.deepcopy(data)
        }
        local newData = ElementList[child.type](dataCopy, child.style, child.value)
        data.cursorY = newData.cursorY
    end
    return data
end

function Div.size(data, style, value)
    local ElementList = require("data.elements_list")
    local ElementSize = require("data.elements_size")

    local size = {width=0, height=0}
    for i, child in ipairs(value) do
        local localData = Utils.deepcopy(data)
        local wrappedSize = ElementSize[child.type](localData, style .. " " ..  child.style, child.value)
        size.width = math.max(size.width, wrappedSize.width)
        size.height = size.height + wrappedSize.height
    end
    return size
end

return Div