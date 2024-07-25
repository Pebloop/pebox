local StyleManager = require("core.style_manager")
local Utils = require("utils")

local Body = {}

function Body.body(style)
    if type(style) == "string" then
        return function (children)
            return {
                type = "body",
                style = style,
                children = children
            }
        end
    else
        return {
            type = "body",
            style = "",
            children = style
        }
    end
end

local function computeWrappedSize(children)
    local wrappedSize = {width = 0, height = 0}
    for i, child in ipairs(children) do
        if type(child) == "string" then
            child = {type = "text", style = "", value = child}
        end
        local childSize = ElementSize[child.type](Utils.deepcopy(data), child.style, child.value)
        wrappedSize.width = math.max(wrappedSize.width, childSize.width)
        wrappedSize.height = wrappedSize.height + childSize.height
    end
    return wrappedSize
end

function Body.size(data, style, children)
    return computeWrappedSize(children)
end

function Body.exec(data, style, children)
    local ElementList = require("data.elements_list")

    data = StyleManager.execute(data, style, {width=0,height=0})

    local wrappedSize = computeWrappedSize(children)
    data.width = wrappedSize.width
    data.height = wrappedSize.height

    for i, child in ipairs(children) do

        local childData = data:child()
        childData.parent = data
        if type(child) == "string" then
            child = {type = "text", style = "", value = child}
        end
        ElementList[child.type](childData, child.style, child.value)
    end
    data.cursorY = data.cursorY + wrappedSize.height
    return data
end

return Body