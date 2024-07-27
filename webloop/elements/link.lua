local StyleManager = require("core.style_manager")
local Utils = require("utils")
local Strings = require("cc.strings")

local Link = {}

-- Text element
function Link.link(style)
    if type(style) == "string" then
        return function (link)
            return function (value)
                return {
                    type = "link",
                    style = style,
                    value = value[1],
                    link = link
                } 
            end
        end
    else
        return function (value)
            return {
                type = "link",
                style = "",
                value = value[1]
            } 
        end
    end
end

-- Execute text element

function Link.onClick(posX, posY, data)
    print("link")
end

return Link