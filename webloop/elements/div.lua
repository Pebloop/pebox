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

return Div