local StyleManager = require("core.style_manager")
local Utils = require("utils")

local Div = {}

function Div.div(style)
    if type(style) == "string" then
        return function (props)
            return function (value)
                return {
                    type = "div",
                    style = style,
                    value = value,
                    id = props.id
                } 
            end
        end
    else
        return function (value)
            return {
                type = "div",
                style = "",
                value = value,
                id = style.id
            } 
        end
    end
end

function Div.exec(data, style, children)
end

return Div