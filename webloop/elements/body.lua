local StyleManager = require("core.style_manager")
local Utils = require("utils")

local Body = {}

function Body.body(style)
    if type(style) == "string" then
        return function (props)
            return function (value)
                return {
                    type = "body",
                    style = style,
                    value = value,
                    id = props.id
                }
            end
        end
    else
        return function (value)
            return {
                type = "body",
                style = "",
                value = value,
                id = style.id
            } 
        end
    end
end

local function computeWrappedSize(window, data, children)
    local ElementSize = require("data.elements_size")
    local wrappedSize = {width = 0, height = 0}
    for i, child in ipairs(children) do

        local childData = data:child({x = data.x, y = data.y}, -1, -1)

        local childSize = ElementSize[child.type](window, childData, child.style, child.value)
        wrappedSize.width = math.max(wrappedSize.width, childSize.width)
        wrappedSize.height = wrappedSize.height + childSize.height
    end
    return wrappedSize
end

function Body.size(window, data, style, children)
    for i, child in ipairs(children) do
        if type(child) == "string" then
            children[i] = {type = "text", style = "", value = child}
        end
    end
    data = StyleManager.execute(data, style, {width=-1,height=-1})
    local childData = data:child({x = data.x, y = data.y}, -1, -1)
    childData.parent = data
    return computeWrappedSize(window, childData, children)
end

function Body.exec(window, data, style, children)
    data.type = "div"
    local ElementList = require("data.elements_list")

    for i, child in ipairs(children) do
        if type(child) == "string" then
            children[i] = {type = "text", style = "", value = child}
        end
    end

    data = StyleManager.execute(data, style, {width=-1,height=-1})
    local childWrappedData = data:child({x = data.x, y = data.y}, -1, -1)

    local wrappedSize = computeWrappedSize(window, childWrappedData, children)
    data.width = wrappedSize.width
    data.height = wrappedSize.height

    if data.text_align == "middle" then
        data.x = math.ceil(data.parent.width / 2 - data.width / 2) + 1
    elseif data.text_align == "end" then
        data.x = data.parent.width - data.width + 2
    end

    window.setBackgroundColor(data.bg_color)
    for x = 1, data.width do
        for y = 1, data.height do
            window.setCursorPos(data.x + x - 1, data.y + y - 1)
            window.write(" ")
        end
    end
    window.setBackgroundColor(colors.black)

    local datas = {}
    for i, child in ipairs(children) do

        local cwd = data:child()
        local childWrappedSize = computeWrappedSize(window, cwd, {child})

        local childData = data:child({x = data.x, y = data.y}, data.width, data.height)
        childData.parent = data
        childData.id = child.id
        childData.link = child.link
        datas[i] = ElementList[child.type](window, childData, child.style, child.value)
        data.y = data.y + childWrappedSize.height
    end
    return datas
end

function Body.onclick(posX, posY, data)
end

return Body