local pretty = require "cc.pretty"

local LuaLang = {}

function LuaLang.pretty(code)
    local doc = pretty.empty()

    for line in code:gmatch("[^\n]+") do
        for token in line:gmatch("%S+") do
            doc = pretty.concat(doc, pretty.text(token, colors.red), pretty.space())
        end
        doc = pretty.concat(doc, pretty.line())
    end

    return pretty.render(doc)
end

return LuaLang