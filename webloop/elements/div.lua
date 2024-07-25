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
    local ElementList = require("data.elements_list")
    local ElementSize = require("data.elements_size")

    local divData = Utils.deepcopy(data)
    divData.width = 0
    divData.height = 0
    divData.parent = {
        type = 'div',
        data = Utils.deepcopy(data)
    }

    divData = StyleManager.execute(divData, style, {width=0,height=0})

    for i, child in ipairs(children) do

        -- if child is a string, convert it to a text element
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
            data = Utils.deepcopy(dataCopy)
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