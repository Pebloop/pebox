local StyleManager = require("core.style_manager")
local Utils = require("utils")
local Strings = require("cc.strings")

local Link = {}

-- Text element
function Link.link(style)
    if type(style) == "string" then
        return function (args)
            return function (value)
                return {
                    type = "link",
                    style = style,
                    value = value[1],
                    link = args[1] or args.link or "",
                    id = args.id or ""
                } 
            end
        end
    else
        return function (value)
            return {
                type = "link",
                style = "",
                value = value[1],
                link = style[1] or style.link or "",
                    id = style.id or ""
            } 
        end
    end
end

-- Execute text element

function Link.onClick(window, data, events)
    return {
        url = data.link
    }
end

return Link