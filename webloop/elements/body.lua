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

function Body.exec(data, style, children)
    local ElementList = require("data.elements_list")
    local width, height = term.getSize()


    style = "w-screen h-screen start " .. style
    data = StyleManager.execute(data, style, {width=width,height=height})

    for i, child in ipairs(children) do
        local localData = Utils.deepcopy(data)
        localData.parent = {
            type = 'body',
            data = Utils.deepcopy(data)
        }
        if type(child) == "string" then
            local newData = ElementList.text(localData, "", child)
            data.cursorY = newData.cursorY
        else
            local newData = ElementList[child.type](localData, child.style, child.value)
            data.cursorY = newData.cursorY
        end
    end
    return data
end

return Body