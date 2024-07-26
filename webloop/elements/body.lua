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

local function computeWrappedSize(data, children)
    local ElementSize = require("data.elements_size")
    local wrappedSize = {width = 0, height = 0}
    for i, child in ipairs(children) do
        if type(child) == "string" then
            child = {type = "text", style = "", value = child}
        end
        local childSize = ElementSize[child.type](data, child.style, child.value)
        wrappedSize.width = math.max(wrappedSize.width, childSize.width)
        wrappedSize.height = wrappedSize.height + childSize.height
    end
    return wrappedSize
end

function Body.size(data, style, children)
    local childData = data:child({x = data.x, y = data.y}, data.width, data.height)
    childData.parent = data
    return computeWrappedSize(childData, children)
end

function Body.exec(data, style, children)
    local ElementList = require("data.elements_list")
    data = StyleManager.execute(data, style, {width=-1,height=-1})

    for i, child in ipairs(children) do
        if type(child) == "string" then
            children[i] = {type = "text", style = "", value = child}
        end
    end

    local childWrappedData = data:child({x = data.x, y = data.y}, data.width, data.height)
    childWrappedData.type = "div"

    local wrappedSize = computeWrappedSize(childWrappedData, children)
    if data.width == -1 then
        data.width = wrappedSize.width
    end
    if data.height == -1 then
        data.height = wrappedSize.height
    end

    term.setBackgroundColor(data.bg_color)
    for x = 1, data.width do
        for y = 1, data.height do
            term.setCursorPos(data.x + x - 1, data.y + y - 1)
            term.write(" ")
        end
    end
    term.setBackgroundColor(colors.black)

    for i, child in ipairs(children) do

        local cwd = data:child()
        cwd.type = "div"
        local childWrappedSize = computeWrappedSize(cwd, {child})

        local childData = data:child({x = data.x, y = data.y}, data.width, data.height)
        if type(child) == "string" then
            child = {type = "text", style = "", value = child}
        end
        ElementList[child.type](childData, child.style, child.value)
        data.y = data.y + childWrappedSize.height
    end
    return data
end

return Body